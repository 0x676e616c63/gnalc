#include "ir/passes/transforms/reassociate.hpp"

#include "ir/irbuilder.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"
#include "ir/passes/helpers/constant_fold.hpp"
#include "ir/match.hpp"

#include <algorithm>


namespace IR {
using Rank = ReassociatePass::Rank;
using ValueEntry = ReassociatePass::ValueEntry;
using ExprTreeNode = ReassociatePass::ExprTreeNode;

pBinary isOneUseBinary(const pVal &v, OP opcode) {
    auto binary = v->as<BinaryInst>();
    if (binary && binary->getUseCount() == 1 && binary->getOpcode() == opcode)
        return binary;
    return nullptr;
}

pBinary isOneUseOp(const pVal &v, OP opcode) {
    auto binary = v->as<BinaryInst>();
    if (binary && binary->getUseCount() == 1 && (binary->getOpcode() == opcode))
        return binary;
    return nullptr;
}

bool isIntBinaryNeg(const pBinary &binary) {
    auto lhs = binary->getLHS();
    auto ci = lhs->as<ConstantInt>();
    if (binary->getOpcode() == OP::SUB && ci && ci->getVal() == 0)
        return true;
    return false;
}

pBinary ReassociatePass::neg2mul(const pInst &neg) {
    // sub 0 x -> mul x -1
    auto binary = neg->as<BinaryInst>();
    Err::gassert(binary && isIntBinaryNeg(binary));
    auto result = std::make_shared<BinaryInst>("%reass.n2m" + std::to_string(name_cnt++), OP::MUL, binary->getRHS(),
                                               func->getConst(-1));
    result->getParent()->addInst(neg->getIndex(), result);
    neg->replaceSelf(result);
    modified_in_opt = true;
    return result;
}

void extractOneUseFactors(const pVal &v, std::vector<pVal> &factors) {
    if (auto binary = isOneUseOp(v, OP::MUL)) {
        extractOneUseFactors(binary->getRHS(), factors);
        extractOneUseFactors(binary->getLHS(), factors);
    } else
        factors.emplace_back(v);
}

pVal makeAddTree(std::vector<pVal> &ops, OP opcode, const pInst &before, size_t &name_cnt) {
    if (ops.size() == 1)
        return ops[0];
    auto lhs = ops.back();
    ops.pop_back();
    auto rhs = makeAddTree(ops, opcode, before, name_cnt);
    auto binary = std::make_shared<BinaryInst>("%re.mkat" + std::to_string(name_cnt++), opcode, lhs, rhs);
    before->getParent()->addInst(before->getIndex(), binary);
    return binary;
}

Rank ReassociatePass::getRank(const pVal &v) {
    if (v->getVTrait() == ValueTrait::CONSTANT_LITERAL)
        return 0;
    if (v->getVTrait() == ValueTrait::FORMAL_PARAMETER)
        return value_rank_map[v];

    auto it = value_rank_map.find(v);
    if (it != value_rank_map.end())
        return it->second;

    auto inst = v->as<Instruction>();
    Err::gassert(inst != nullptr);
    Rank maxRank = block_rank_map[inst->getParent()];
    Rank rank = 0;
    for (size_t i = 0; i != inst->getOperands().size() && rank != maxRank; ++i)
        rank = std::max(rank, getRank(inst->getOperand(i)->getValue()));
    return value_rank_map[inst] = rank;
}

std::vector<ExprTreeNode> ReassociatePass::analyzeExprTree(const pBinary &root) {
    using Freq = ExprTreeNode::FreqT;
    auto root_op = root->getOpcode();
    std::vector<std::pair<pBinary, Freq>> work_list{std::make_pair(root, 1)};

    std::unordered_map<pVal, Freq> freq_map;
    std::vector<pVal> nodes;

    while (!work_list.empty()) {
        auto [inst, freq] = work_list.back();
        work_list.pop_back();

        for (const auto &operand : inst->operands()) {
            if (auto binary = isOneUseBinary(operand, root_op)) {
                work_list.emplace_back(binary, freq);
                continue;
            }

            auto it = freq_map.find(operand);
            if (it == freq_map.end()) {
                nodes.emplace_back(operand);
                freq_map[operand] = freq;
            } else
                it->second += freq;
        }
    }

    std::vector<ExprTreeNode> tree;
    for (const auto &n : nodes) {
        auto it = freq_map.find(n);
        Err::gassert(it != freq_map.end());
        tree.emplace_back(ExprTreeNode{n, it->second});
    }
    return tree;
}

void ReassociatePass::rewriteExpr(const pBinary &root, std::vector<ValueEntry> &ops) {
    auto opcode = root->getOpcode();
    std::vector<pBinary> avail_nodes;
    std::unordered_set<pVal> skip_list; // Skip all leafs, rewriting them is not safe
    for (const auto &op : ops)
        skip_list.insert(op.operand);
    pInst rewrite_beg = nullptr;
    pBinary curr = root;

    for (size_t i = 0;; ++i) {
        // The last operation (which is earliest BinaryInst in the IR)'s operands might all come from ops.
        if (i + 2 == ops.size()) {
            auto new_lhs = ops[i].operand;
            auto new_rhs = ops[i + 1].operand;
            auto old_lhs = curr->getLHS();
            auto old_rhs = curr->getRHS();
            // Trivial case
            if (new_lhs == old_lhs && new_rhs == old_rhs)
                break;
            if (new_lhs == old_rhs && new_rhs == old_lhs) {
                curr->swapLHSRHS();
                modified_in_opt = true;
                break;
            }
            // Needs rewrite
            if (old_lhs != new_lhs) {
                auto sub_bin = isOneUseBinary(old_lhs, opcode);
                if (sub_bin && skip_list.find(sub_bin) == skip_list.end())
                    avail_nodes.emplace_back(sub_bin);
                curr->setLHS(new_lhs);
            }
            if (old_rhs != new_rhs) {
                auto sub_bin = isOneUseBinary(old_rhs, opcode);
                if (sub_bin && skip_list.find(sub_bin) == skip_list.end())
                    avail_nodes.emplace_back(sub_bin);
                curr->setRHS(new_rhs);
            }
            modified_in_opt = true;
            rewrite_beg = curr;
            break;
        }
        // While others, the LHS is a subtree and the RHS is op[i]
        // 1. RHS
        auto new_rhs = ops[i].operand;
        if (new_rhs != curr->getRHS()) {
            if (new_rhs == curr->getLHS())
                curr->swapLHSRHS();
            else {
                auto subBinary = isOneUseBinary(curr->getRHS(), opcode);
                if (subBinary && skip_list.find(subBinary) == skip_list.end())
                    avail_nodes.emplace_back(subBinary);
                curr->setRHS(new_rhs);
                modified_in_opt = true;
            }
        }

        // 2. LHS
        if (auto sub_bin = isOneUseBinary(curr->getLHS(), opcode)) {
            if (skip_list.find(sub_bin) == skip_list.end())
                curr = sub_bin;
            continue;
        }

        if (!avail_nodes.empty()) {
            auto new_inst = avail_nodes.back();
            avail_nodes.pop_back();
            curr->setLHS(new_inst);
            curr = new_inst;
        } else {
            // There is no node left available, and we've made an unwise choice.
            // Just get one from air.
            auto zero = func->getConst(0);
            auto dummy = std::make_shared<BinaryInst>("%reass.new" + std::to_string(name_cnt++), opcode, zero, zero);
            root->getParent()->addInst(root->getIndex(), dummy);
            curr->setLHS(dummy);
            curr = dummy;
            Logger::logWarning("[Reassoc]: No nodes left available. Generating one for rewriting.");
        }

        rewrite_beg = curr;
        modified_in_opt = true;
    }

    // Move what we've rewritten to ensure any user dominate all its uses.
    if (rewrite_beg != nullptr) {
        auto bb = root->getParent();
        auto it = root->getIter();
        while (true) {
            if (rewrite_beg == root)
                break;
            rewrite_beg->getParent()->delFirstOfInst(rewrite_beg);
            bb->addInst(it, rewrite_beg);
            rewrite_beg = rewrite_beg->getUseList().front()->getUser()->as<Instruction>();
            Err::gassert(rewrite_beg != nullptr);
        }
    }
}

pVal ReassociatePass::removeFactor(const pVal &v, const pVal &factor) {
    auto mul = isOneUseOp(v, OP::MUL);
    if (!mul)
        return nullptr;

    auto tree = analyzeExprTree(mul);
    std::vector<ValueEntry> factors;
    factors.reserve(tree.size());

    for (const auto &t : tree)
        factors.insert(factors.end(), t.freq, ValueEntry{t.value, getRank(t.value)});

    bool found_factor = false;
    bool needs_negate = false;
    for (size_t i = 0; i < factors.size(); ++i) {
        if (factors[i].operand == factor) {
            found_factor = true;
            factors.erase(factors.begin() + i);
            break;
        }
        auto ci1 = factor->as<ConstantInt>();
        auto ci2 = factors[i].operand->as<ConstantInt>();
        if (ci1 && ci2 && ci1->getVal() == -ci2->getVal()) {
            found_factor = needs_negate = true;
            factors.erase(factors.begin() + i);
            break;
        }
    }

    if (!found_factor) {
        rewriteExpr(mul, factors);
        return nullptr;
    }

    IRBuilder builder("%re.rf", mul->getParent(), ++mul->getIter());

    auto ret = v;
    if (factors.size() == 1)
        ret = factors[0].operand;
    else {
        rewriteExpr(mul, factors);
        ret = mul;
    }

    if (needs_negate)
        return builder.makeSub(func->getConst(0), ret);

    return ret;
}

pVal ReassociatePass::optAdd(const pBinary &root, std::vector<ValueEntry> &ops) {
    IRBuilder builder("%re.oa", root->getParent(), root->getIter());
    for (size_t i = 0, e = ops.size(); i != e; ++i) {
        // lambda captured structured bindings are a C++20 extension [-Wc++20-extensions]
        auto curr = ops[i].operand;
        auto curr_rank = ops[i].rank;

        // Fold add to mul
        // Y + Y + Y + Z -> 3 * Y + Z
        if (i + 1 != ops.size() && ops[i + 1].operand == curr) {
            int freq = 0;
            do {
                ops.erase(ops.begin() + i);
                ++freq;
            } while (i != ops.size() && ops[i].operand == curr);

            auto mul = builder.makeMul(curr, func->getConst(freq));
            Logger::logDebug("[Reassoc]: Folded add to mul for '", mul->getName(), "'.");

            // Redo it later since the factoring can happen multiple times.
            // (a * 2) + (a * 2) -> (a * 6)
            redo_list.insert(mul);
            modified_in_opt = true;

            // Fully folded
            if (ops.empty())
                return mul;

            ops.insert(ops.begin(), ValueEntry{mul, getRank(mul)});
            --i;
            e = ops.size();
            continue;
        }

        // Find A + -A
        if (pVal neg_curr; match(curr, M::Sub(M::Is(0), M::Bind(neg_curr)))) {
            // Note that A and -A get the same Rank
            auto neg_pos = [&]() -> size_t {
                for (size_t j = i + 1; j != e && ops[j].rank == curr_rank; ++j) {
                    if (ops[j].operand == neg_curr)
                        return j;
                }
                for (int j = i - 1; j >= 0 && ops[j].rank == curr_rank; --j) {
                    if (ops[j].operand == neg_curr)
                        return j;
                }
                return i;
            }();
            if (neg_pos != i) {
                Logger::logDebug("[Reassoc]: Folded A + -A.");
                // Remove A and -A
                if (ops.size() == 2)
                    return func->getConst(0);

                ops.erase(ops.begin() + i);

                // Fix up indices after erase
                if (i < neg_pos)
                    --neg_pos;
                else
                    --i;
                ops.erase(ops.begin() + neg_pos);

                --i;
                e -= 2;
            }
        }
    }

    // Factor out common term
    // A * A + A * B * C -> A * (A + B + C)
    std::unordered_map<pVal, size_t> freq_map;
    size_t max_freq = 0;
    pVal max_freq_factor = nullptr;
    for (const auto &op : ops) {
        if (auto mul = isOneUseOp(op.operand, OP::MUL)) {
            std::vector<pVal> factors;
            extractOneUseFactors(mul, factors);
            std::unordered_set<pVal> visited;
            for (const auto &factor : factors) {
                if (!visited.insert(factor).second)
                    continue;
                size_t cnt = ++freq_map[factor];
                if (cnt > max_freq) {
                    max_freq = cnt;
                    max_freq_factor = factor;
                }
            }
        }
    }
    if (max_freq > 1) {
        std::vector<pVal> new_mul_ops;
        // Explicitly use max_freq_factor twice to ensure it won't
        // suddenly become oneUse due to removing
        auto dummy = std::make_shared<BinaryInst>("", OP::ADD, max_freq_factor, max_freq_factor);

        for (size_t i = 0; i < ops.size(); ++i) {
            if (!isOneUseOp(ops[i].operand, OP::MUL))
                continue;
            if (auto value = removeFactor(ops[i].operand, max_freq_factor)) {
                for (size_t j = ops.size(); j != i;) {
                    --j;
                    if (ops[j].operand == ops[i].operand) {
                        new_mul_ops.emplace_back(value);
                        ops.erase(ops.begin() + j);
                    }
                }
                --i;
            }
        }

        // Release the use
        dummy.reset();

        auto add_tree = makeAddTree(new_mul_ops, OP::ADD, root, name_cnt);

        Logger::logDebug("[Reassoc]: Factor out common term for '", add_tree->getName(), "'.");

        // Redo it to find:
        // A * A * B + A * A * C -> A * (A * B + A * C) -> A * (A * (B + C)))
        if (auto inst = add_tree->as<Instruction>())
            redo_list.insert(inst);

        auto mul = builder.makeMul(add_tree, max_freq_factor);
        redo_list.insert(mul);
        modified_in_opt = true;
        if (ops.empty())
            return mul;
        ops.insert(ops.begin(), ValueEntry{mul, getRank(mul)});
    }
    return nullptr;
}

pVal ReassociatePass::optMul(const pBinary &root, std::vector<ValueEntry> &ops) { return nullptr; }

pVal ReassociatePass::optExpr(const pBinary &root, std::vector<ValueEntry> &ops) {
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

pInst ReassociatePass::canonInst(const pInst &inst) {
    switch (inst->getOpcode()) {
    case OP::ADD:
    case OP::MUL:
    case OP::AND:
    case OP::OR: {
        auto bin = inst->as<BinaryInst>();
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

void ReassociatePass::reassociate(const pBinary &inst) {
    auto tree = analyzeExprTree(inst);

    std::vector<ValueEntry> ops;
    ops.reserve(tree.size());
    for (const auto &t : tree)
        ops.insert(ops.end(), t.freq, ValueEntry{t.value, getRank(t.value)});

    std::stable_sort(ops.begin(), ops.end(), [](auto &&a, auto &&b) { return a.rank > b.rank; }); // high rank first

    if (auto v = optExpr(inst, ops)) {
        // Skip self reference
        if (inst == v)
            return;
        inst->replaceSelf(v);
        modified_in_opt = true;
        return;
    }

    if (ops.size() == 1) {
        // Skip self reference
        if (ops[0].operand == inst)
            return;

        inst->replaceSelf(ops[0].operand);
        modified_in_opt = true;
        return;
    }

    std::stable_sort(ops.begin(), ops.end(), [](auto &&a, auto &&b) { return a.rank > b.rank; }); // high rank first

    // FIXME: Not always needs rewriting
    rewriteExpr(inst, ops);
}

void ReassociatePass::optInst(const pInst &raw_inst) {
    if (!raw_inst->is<BinaryInst>() || !raw_inst->getType()->isInteger())
        return;

    auto candidate = canonInst(raw_inst);

    auto binary = candidate->as<BinaryInst>();
    if (binary->getOpcode() == OP::SUB) {
        if (isIntBinaryNeg(binary)) {
            // 0 - x * x
            if (isOneUseBinary(binary->getRHS(), OP::MUL) // operand is a multiply tree
                &&
                // Not a multiply tree's child
                (binary->getUseCount() != 1 || !isOneUseBinary(binary->getSingleUser(), OP::MUL))) {
                auto negInst = neg2mul(binary);
                for (const auto &user : binary->users()) {
                    if (auto binary_user = user->as<BinaryInst>())
                        redo_list.insert(binary_user);
                }
                redo_list.insert(candidate);
                modified_in_opt = true;
                candidate = negInst;
            }
        }
    }

    // check candidate is associative
    if (candidate->getOpcode() != OP::MUL && candidate->getOpcode() != OP::ADD && candidate->getOpcode() != OP::AND &&
        candidate->getOpcode() != OP::OR)
        return;

    // Candidate may have changed, update binary
    binary = candidate->as<BinaryInst>();

    // For non-root instructions, skip some cases to speed up.
    if (auto single_user = binary->getSingleUser()) {
        auto user_inst = single_user->as<Instruction>();
        Err::gassert(user_inst != nullptr);

        // If this is a node of a tree, ignore it until we get the root.
        if (user_inst->getOpcode() == binary->getOpcode()) {
            if (user_inst != binary && binary->getParent() == user_inst->getParent())
                redo_list.insert(user_inst);
            return;
        }

        // If this is an add tree in a sub tree, ignore it when we get the sub tree.
        if (binary->getOpcode() == OP::ADD && user_inst->getOpcode() == OP::SUB)
            return;
    }

    reassociate(binary);
}

void ReassociatePass::reset() {
    value_rank_map.clear();
    block_rank_map.clear();
    redo_list.clear();
    func = nullptr;
    modified_in_opt = false;
    name_cnt = 0;
}

PM::PreservedAnalyses ReassociatePass::run(Function &function, FAM &manager) {
    bool reassociate_inst_modified = false;
    func = &function;

    // Build Rank Map
    // assign different rank to params
    Rank rank = 2;
    for (const auto &param : function.getParams())
        value_rank_map[param] = ++rank;

    auto rpov = function.getDFVisitor<Util::DFVOrder::ReversePostOrder>();
    for (const auto &node : rpov) {
        // << 16 to avoid collision with other block
        Rank bbRank = block_rank_map[node] = ++rank << 16;
        for (const auto &phi : node->phis())
            value_rank_map[phi] = ++bbRank;
        for (const auto &inst : *node) {
            if (!inst->is<BinaryInst>())
                value_rank_map[inst] = ++bbRank;
        }
    }

    // Optimize Instructions
    for (const auto &bb : function) {
        for (auto &inst : *bb) {
            modified_in_opt = false;
            optInst(inst);
            reassociate_inst_modified |= modified_in_opt;
            Err::gassert(inst->getParent() == bb);
        }
    }

    while (!redo_list.empty()) {
        auto curr = *redo_list.begin();
        redo_list.erase(redo_list.begin());
        if (curr->getUseCount() != 0) {
            modified_in_opt = false;
            optInst(curr);
            reassociate_inst_modified |= modified_in_opt;
        }
    }

    // Cleanup to release temporaries
    reset();

    return reassociate_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}
} // namespace IR