//
// Created by edragain on 2/12/25.
//
#include "../../../../include/ir/passes/transforms/reassociate.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/passes/helpers/constant_fold.hpp"

#include <algorithm>
#include <limits>

namespace IR {
using Rank = ReassociatePass::Rank;
using ValueEntry = ReassociatePass::ValueEntry;
using ExprTreeNode = ReassociatePass::ExprTreeNode;

std::shared_ptr<BinaryInst> isOneUseBinary(const std::shared_ptr<Value> &v, OP opcode) {
    auto binary = std::dynamic_pointer_cast<BinaryInst>(v);
    if (binary && binary->getUseCount() == 1 && binary->getOpcode() == opcode)
        return binary;
    return nullptr;
}

std::shared_ptr<BinaryInst> isOneUseOp(const std::shared_ptr<Value> &v, OP opcode) {
    auto binary = std::dynamic_pointer_cast<BinaryInst>(v);
    if (binary && binary->getUseCount() == 1 && (binary->getOpcode() == opcode))
        return binary;
    return nullptr;
}

bool isIntBinaryNeg(const std::shared_ptr<BinaryInst> &binary) {
    auto lhs = binary->getLHS();
    auto ci = std::dynamic_pointer_cast<ConstantInt>(lhs);
    if (binary->getOpcode() == OP::SUB && ci && ci->getVal() == 0)
        return true;
    return false;
}

std::shared_ptr<BinaryInst> ReassociatePass::neg2mul(const std::shared_ptr<Instruction> &neg) {
    // sub 0 x -> mul x -1
    auto binary = std::dynamic_pointer_cast<BinaryInst>(neg);
    Err::gassert(binary && isIntBinaryNeg(binary));
    auto result = std::make_shared<BinaryInst>("%reass.n2m" + std::to_string(name_cnt++),
    OP::MUL, binary->getRHS(), func->getConst(-1));
    result->getParent()->addInst(neg->getIndex(), result);
    neg->replaceSelf(result);
    optModified = true;
    return result;
}

void extractOneUseFactors(const std::shared_ptr<Value> &v, std::vector<std::shared_ptr<Value>> &factors) {
    if (auto binary = isOneUseOp(v, OP::MUL)) {
        extractOneUseFactors(binary->getRHS(), factors);
        extractOneUseFactors(binary->getLHS(), factors);
    } else
        factors.emplace_back(v);
}

std::shared_ptr<Value> makeAddTree(std::vector<std::shared_ptr<Value>> &ops,
    OP opcode, const std::shared_ptr<Instruction> & before, size_t& name_cnt) {
    if (ops.size() == 1)
        return ops[0];
    auto lhs = ops.back();
    ops.pop_back();
    auto rhs = makeAddTree(ops, opcode, before, name_cnt);
    auto binary = std::make_shared<BinaryInst>("%reass.mkat" + std::to_string(name_cnt++),
        opcode, lhs, rhs);
    before->getParent()->addInst(before->getIndex(), binary);
    return binary;
}

Rank ReassociatePass::getRank(const std::shared_ptr<Value> &v) {
    if (v->getVTrait() == ValueTrait::CONSTANT_LITERAL)
        return 0;
    if (v->getVTrait() == ValueTrait::FORMAL_PARAMETER)
        return valueRankMap[v];

    auto it = valueRankMap.find(v);
    if (it != valueRankMap.end())
        return it->second;

    auto inst = std::dynamic_pointer_cast<Instruction>(v);
    Err::gassert(inst != nullptr);
    Rank maxRank = bbRankMap[inst->getParent()];
    Rank rank = 0;
    for (size_t i = 0; i != inst->getOperands().size() && rank != maxRank; ++i)
        rank = std::max(rank, getRank(inst->getOperand(i)->getValue()));
    return valueRankMap[inst] = rank;
}

std::vector<ExprTreeNode> ReassociatePass::analyzeExprTree(const std::shared_ptr<BinaryInst> &root) {
    using Weight = ExprTreeNode::WeightT;
    auto root_op = root->getOpcode();
    std::vector<std::pair<std::shared_ptr<BinaryInst>, Weight>>
        work_list{std::make_pair(root, 1)};

    std::map<std::shared_ptr<Value>, Weight> weights;
    std::vector<std::shared_ptr<Value>> nodes;

    while (!work_list.empty()) {
        auto [inst, weight] = work_list.back();
        work_list.pop_back();

        for (const auto &use : inst->getOperands()) {
            auto operand = use->getValue();
            if (auto binary = isOneUseBinary(operand, root_op)) {
                work_list.emplace_back(binary, weight);
                continue;
            }

            auto it = weights.find(operand);
            if (it == weights.end()) {
                nodes.emplace_back(operand);
                weights[operand] = weight;
            } else
                it->second += weight;
        }
    }

    std::vector<ExprTreeNode> tree;
    for (const auto &n : nodes) {
        auto it = weights.find(n);
        Err::gassert(it != weights.end());
        tree.emplace_back(ExprTreeNode{n, it->second});
    }
    return tree;
}

void ReassociatePass::rewriteExpr(
    const std::shared_ptr<BinaryInst> &root,
    std::vector<ValueEntry> &ops) {
    auto opcode = root->getOpcode();
    std::vector<std::shared_ptr<BinaryInst>> availNodes;
    std::set<std::shared_ptr<Value>> skipList; // Skip all leafs, rewriting them is not safe
    for (const auto &op : ops)
        skipList.insert(op.op);
    std::shared_ptr<Instruction> rewriteBeg = nullptr;
    std::shared_ptr<BinaryInst> curr = root;

    for (size_t i = 0;; ++i) {
        // The last operation (which is earliest BinaryInst in the IR)'s operands might all come from ops.
        if (i + 2 == ops.size()) {
            auto newLHS = ops[i].op;
            auto newRHS = ops[i + 1].op;
            auto oldLHS = curr->getLHS();
            auto oldRHS = curr->getRHS();
            // Trivial case
            if (newLHS == oldLHS && newRHS == oldRHS)
                break;
            if (newLHS == oldRHS && newRHS == oldLHS) {
                curr->swapLHSRHS();
                optModified = true;
                break;
            }
            // Needs rewrite
            if (oldLHS != newLHS) {
                auto subBinary = isOneUseBinary(oldLHS, opcode);
                if (subBinary && skipList.find(subBinary) == skipList.end())
                    availNodes.emplace_back(subBinary);
                curr->setLHS(newLHS);
            }
            if (oldRHS != newRHS) {
                auto subBinary = isOneUseBinary(oldRHS, opcode);
                if (subBinary && skipList.find(subBinary) == skipList.end())
                    availNodes.emplace_back(subBinary);
                curr->setRHS(newRHS);
            }
            optModified = true;
            rewriteBeg = curr;
            break;
        }
        // While others, the LHS is a subtree and the RHS is op[i]
        // 1. RHS
        auto newRHS = ops[i].op;
        if (newRHS != curr->getRHS()) {
            if (newRHS == curr->getLHS())
                curr->swapLHSRHS();
            else {
                auto subBinary = isOneUseBinary(curr->getRHS(), opcode);
                if (subBinary && skipList.find(subBinary) == skipList.end())
                    availNodes.emplace_back(subBinary);
                curr->setRHS(newRHS);
                optModified = true;
            }
        }

        // 2. LHS
        if (auto subBinary = isOneUseBinary(curr->getLHS(), opcode)) {
            if (skipList.find(subBinary) == skipList.end())
                curr = subBinary;
            continue;
        }

        if (!availNodes.empty()) {
            auto newInst = availNodes.back();
            availNodes.pop_back();
            curr->setLHS(newInst);
            curr = newInst;
        }
        else {
            // There is no node left available, and we've made an unwise choice.
            // Just get one from air.
            auto zero = func->getConst(0);
            auto dummy = std::make_shared<BinaryInst>("%reass.oops" + std::to_string(name_cnt++),
                opcode, zero, zero);
            root->getParent()->addInst(root->getIndex(), dummy);
            curr->setLHS(dummy);
            curr = dummy;
            Logger::logWarning("[Reassociate]: Oops! No nodes left available. Generating one for rewriting.");
        }

        rewriteBeg = curr;
        optModified = true;
    }

    // Move what we've rewritten to ensure any user dominate all its uses.
    if (rewriteBeg != nullptr) {
        auto bb = root->getParent();
        auto it = root->getIter();
        while (true) {
            if (rewriteBeg == root)
                break;
            rewriteBeg->getParent()->delFirstOfInst(rewriteBeg);
            bb->addInst(it, rewriteBeg);
            rewriteBeg = std::dynamic_pointer_cast<Instruction>
                (rewriteBeg->getUseList().front()->getUser());
            Err::gassert(rewriteBeg != nullptr);
        }
    }
}

std::shared_ptr<Value> ReassociatePass::removeFactor
    (const std::shared_ptr<Value> &v, const std::shared_ptr<Value> &factor) {
    auto binaryInst = isOneUseOp(v, OP::MUL);
    if (!binaryInst)
        return nullptr;

    auto tree = analyzeExprTree(binaryInst);
    std::vector<ValueEntry> factors;
    factors.reserve(tree.size());

    for (const auto &t : tree)
        factors.insert(factors.end(), t.weight, ValueEntry{ t.value, getRank(t.value) });

    bool canRemove = false;
    bool needsNegate = false;
    for (size_t i = 0; i < factors.size(); ++i) {
        if (factors[i].op == factor) {
            canRemove = true;
            factors.erase(factors.begin() + i);
        }
        auto ci1 = std::dynamic_pointer_cast<ConstantInt>(factor);
        auto ci2 = std::dynamic_pointer_cast<ConstantInt>(factors[i].op);
        if (ci1 && ci2 && ci1->getVal() == -ci2->getVal()) {
            canRemove = needsNegate = true;
            factors.erase(factors.begin() + i);
            break;
        }
    }

    if (!canRemove) {
        rewriteExpr(binaryInst, factors);
        return nullptr;
    }

    auto ret = v;
    if (factors.size() == 1)
        ret = factors[0].op;
    else {
        rewriteExpr(binaryInst, factors);
        ret = binaryInst;
    }

    if (needsNegate) {
        auto neg = std::make_shared<BinaryInst>("%reass.neg" + std::to_string(name_cnt++),
                                                OP::SUB, func->getConst(0), ret);
        binaryInst->getParent()->addInst(binaryInst->getIndex(), neg);
    }

    return ret;
}

std::shared_ptr<Value> ReassociatePass::optAdd(
    const std::shared_ptr<BinaryInst> &root,
    std::vector<ValueEntry> &ops) {
    // Fold add to mul
    // Y + Y + Y + Z -> 3 * Y + Z
    for (size_t i = 0, e = ops.size(); i != e; ++i) {
        auto curr = ops[i].op;
        if (i + 1 != ops.size() && ops[i + 1].op == curr) {
            int repeatedTimes = 0;
            do {
                ops.erase(ops.begin() + i);
                ++repeatedTimes;
            } while (i != ops.size() && ops[i].op == curr);


            auto mul = std::make_shared<BinaryInst>("%reass.a2m" + std::to_string(name_cnt++),
                                   OP::MUL, curr,
                                   func->getConst(repeatedTimes));

            root->getParent()->addInst(root->getIndex(), mul);
            redoSet.insert(mul);
            optModified = true;
            if (ops.empty())
                return mul;

            ops.insert(ops.begin(), ValueEntry{ mul, getRank(mul) });
            --i;
            e = ops.size();
        }
    }

    // Factor out common term
    // A * A + A * B * C -> A * (A + B + C)
    std::map<std::shared_ptr<Value>, size_t> factorCnt;
    size_t maxCnt = 0;
    std::shared_ptr<Value> maxCntFactor = nullptr;
    for (const auto &op : ops) {
        if (auto mul = isOneUseOp(op.op, OP::MUL)) {
            std::vector<std::shared_ptr<Value>> factors;
            extractOneUseFactors(mul, factors);
            std::set<std::shared_ptr<Value>> dup;
            for (auto &factor : factors) {
                if (!dup.insert(factor).second)
                    continue;
                size_t cnt = ++factorCnt[factor];
                if (cnt > maxCnt) {
                    maxCnt = cnt;
                    maxCntFactor = factor;
                }
            }
        }
    }
    if (maxCnt > 1) {
        std::vector<std::shared_ptr<Value>> newMulOps;
        {
            // Explicitly use maxCntFactor twice to ensure it won't
            // suddenly become oneUse due to removing
            auto dummy = std::make_shared<BinaryInst>("%reass.fa" + std::to_string(name_cnt++),
                OP::ADD, maxCntFactor, maxCntFactor);
            for (size_t i = 0; i < ops.size(); ++i) {
                if (!isOneUseOp(ops[i].op, OP::MUL))
                    continue;
                if (auto value = removeFactor(ops[i].op, maxCntFactor)) {
                    for (size_t j = ops.size(); j != i;) {
                        --j;
                        if (ops[j].op == ops[i].op) {
                            newMulOps.emplace_back(value);
                            ops.erase(ops.begin() + j);
                        }
                    }
                    --i;
                }
            }
        }

        auto v = makeAddTree(newMulOps, OP::ADD, root, name_cnt);

        // Redo it to find:
        // A * A * B + A * A * C -> A * (A * B + A * C) -> A * (A * (B + C)))
        if (auto inst = std::dynamic_pointer_cast<Instruction>(v))
            redoSet.insert(inst);

        auto mul = std::make_shared<BinaryInst>("%reass.m" + std::to_string(name_cnt++),
                                               OP::MUL, v, maxCntFactor);
        root->getParent()->addInst(root->getIndex(), mul);
        redoSet.insert(mul);
        optModified = true;
        if (ops.empty())
            return mul;
        ops.insert(ops.begin(), ValueEntry{ mul, getRank(mul) });
    }
    return nullptr;
}

std::shared_ptr<Value> ReassociatePass::optMul(
    const std::shared_ptr<BinaryInst> &root, std::vector<ValueEntry> &ops) {
    return nullptr;
}

std::shared_ptr<Value> ReassociatePass::optExpr(
    const std::shared_ptr<BinaryInst> &root, std::vector<ValueEntry> &ops) {
    auto opcode = root->getOpcode();

    // Fold constant
    auto fold = foldConstant(func->getConstantPool(), root);
    if (fold != root)
        return fold;

    Rank old_size = ops.size();
    switch (opcode) {
    case OP::ADD:
        if (auto result = optAdd(root, ops))
            return result;
        break;
    case OP::MUL:
        if (auto result = optMul(root, ops))
            return result;
        break;
    default:
        break;
    }
    if (ops.size() != old_size)
        return optExpr(root, ops);
    return nullptr;
}

std::shared_ptr<Instruction> ReassociatePass::canonInst(const std::shared_ptr<Instruction> &inst) {
    switch (inst->getOpcode()) {
    case OP::ADD:
    case OP::MUL:
    case OP::AND:
    case OP::OR: {
        auto bin = std::dynamic_pointer_cast<BinaryInst>(inst);
        const auto &lhs = bin->getLHS();
        const auto &rhs = bin->getRHS();
        if (lhs == rhs || rhs->getVTrait() == ValueTrait::CONSTANT_LITERAL)
            break;
        if (lhs->getVTrait() == ValueTrait::CONSTANT_LITERAL || getRank(rhs) < getRank(lhs))
            bin->swapLHSRHS();

        break;
    }
    default:
        break;
    }
    return inst;
}

void ReassociatePass::reassociateExpression(const std::shared_ptr<BinaryInst> &inst) {
    auto tree = analyzeExprTree(inst);

    std::vector<ValueEntry> ops;
    ops.reserve(tree.size());
    for (const auto &t : tree)
        ops.insert(ops.end(), t.weight, ValueEntry{t.value, getRank(t.value) });

    std::stable_sort(ops.begin(), ops.end(),
        [](auto&& a, auto&& b) { return a.rank > b.rank; }); // high rank first

    if (auto v = optExpr(inst, ops)) {
        // Skip self reference
        if (inst == v)
            return;
        inst->replaceSelf(v);
        optModified = true;
        return;
    }

    if (ops.size() == 1) {
        // Skip self reference
        if (ops[0].op == inst)
            return;

        inst->replaceSelf(ops[0].op);
        optModified = true;
        return;
    }

    std::stable_sort(ops.begin(), ops.end(),
    [](auto&& a, auto&& b) { return a.rank > b.rank; }); // high rank first

    // FIXME: Not always needs rewriting
    rewriteExpr(inst, ops);
}

void ReassociatePass::optInst(const std::shared_ptr<Instruction> &raw_inst) {
    // DO NOT reassociate ICMP/FCMP for better codegen
    if (!std::dynamic_pointer_cast<BinaryInst>(raw_inst))
        return;

    if (toBType(raw_inst->getType())->getInner() == IRBTYPE::FLOAT)
        return;

    auto candidate = raw_inst;

    candidate = canonInst(candidate);

    auto binary = std::dynamic_pointer_cast<BinaryInst>(candidate);

    if (candidate->getOpcode() == OP::SUB) {
        if (isIntBinaryNeg(binary)) {
            // 0 - x * x
            if (isOneUseBinary(binary->getRHS(), OP::MUL) // operand is a multiply tree
                &&
                // Not a multiply tree's child
                (binary->getUseCount() != 1
                    || !isOneUseBinary(binary->getUseList().back()->getUser(), OP::MUL))) {
                auto negInst = neg2mul(binary);
                auto use_list = binary->getUseList();
                for (const auto &use : use_list) {
                    if (auto binary_user = std::dynamic_pointer_cast<BinaryInst>(use->getUser()))
                        redoSet.insert(binary_user);
                }
                redoSet.insert(candidate);
                optModified = true;
                candidate = negInst;
            }
        }
    }

    // check candidate is associative
    if (candidate->getOpcode() != OP::MUL
        && candidate->getOpcode() != OP::ADD
        && candidate->getOpcode() != OP::AND
        && candidate->getOpcode() != OP::OR)
        return;

    // Candidate may have changed, update binary
    binary = std::dynamic_pointer_cast<BinaryInst>(candidate);

    // If this is a node of a tree, ignore it until we get the root.
    auto opcode = binary->getOpcode();
    if (binary->getUseCount() == 1) {
        auto lastUser = std::dynamic_pointer_cast<Instruction>
            (binary->getUseList().back()->getUser());
        Err::gassert(lastUser != nullptr);
        if (lastUser->getOpcode() == opcode) {
            if (lastUser != binary && binary->getParent() == lastUser->getParent())
                redoSet.insert(lastUser);
            return;
        }

    if (binary->getOpcode() == OP::ADD && lastUser->getOpcode() == OP::SUB)
        return;
    }

    reassociateExpression(binary);
}

void ReassociatePass::reset() {
    valueRankMap.clear();
    bbRankMap.clear();
    redoSet.clear();
    func = nullptr;
    optModified = false;
    name_cnt = 0;
}

PM::PreservedAnalyses ReassociatePass::run(Function &function, FAM &manager) {
    bool reassociate_inst_modified = false;
    func = &function;

    // Build Rank Map
    // assign different rank to params
    Rank rank = 2;
    for (const auto &param : function.getParams())
        valueRankMap[param] = ++rank;

    auto rpov = function.getDFVisitor<Util::DFVOrder::ReversePostOrder>();
    for (const auto &node : rpov) {
        // << 16 to avoid collision with other block
        Rank bbRank = bbRankMap[node] = ++rank << 16;
        for (const auto &phi : node->getPhiInsts())
            valueRankMap[phi] = ++bbRank;
        for (const auto &inst : *node) {
            if (std::dynamic_pointer_cast<BinaryInst>(inst) == nullptr)
                valueRankMap[inst] = ++bbRank;
        }
    }

    // Optimize Instructions
    for (const auto &bb : function) {
        for (auto &inst : *bb) {
            optModified = false;
            optInst(inst);
            reassociate_inst_modified |= optModified;
            Err::gassert(inst->getParent() == bb);
        }
    }

    while (!redoSet.empty()) {
        auto curr = *redoSet.begin();
        redoSet.erase(redoSet.begin());
        if (curr->getUseCount() != 0) {
            optModified = false;
            optInst(curr);
            reassociate_inst_modified |= optModified;
        }
    }

    // Cleanup to release temporaries
    reset();

    if (!reassociate_inst_modified)
        return PM::PreservedAnalyses::all();

    PM::PreservedAnalyses pa;
    pa.preserve<DomTreeAnalysis>();
    pa.preserve<PostDomTreeAnalysis>();
    pa.preserve<LoopAnalysis>();
    return pa;
}
} // namespace IR