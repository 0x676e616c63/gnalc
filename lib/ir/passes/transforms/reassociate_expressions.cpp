//
// Created by edragain on 2/12/25.
//
#include "../../../../include/ir/passes/transforms/reassociate_expressions.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <algorithm>
#include <limits>

namespace IR {
using Rank = ReassociateExpressionsPass::Rank;
using ValueRank = ReassociateExpressionsPass::ValueRank;
using PairMapValue = ReassociateExpressionsPass::PairMapValue;

std::shared_ptr<BinaryInst> isOneUseBinary(const std::shared_ptr<Value> &v, OP opcode) {
    auto binary = std::dynamic_pointer_cast<BinaryInst>(v);
    if (binary && binary->getUseCount() == 1 && binary->getOpcode() == opcode)
        return binary;
    return nullptr;
}

std::shared_ptr<BinaryInst> isOneUseOp(const std::shared_ptr<Value> &v, OP opcode1, OP opcode2) {
    auto binary = std::dynamic_pointer_cast<BinaryInst>(v);
    if (binary && binary->getUseCount() == 1 && (binary->getOpcode() == opcode1 || binary->getOpcode() == opcode2))
        return binary;
    return nullptr;
}

bool isBinaryNeg(const std::shared_ptr<BinaryInst> &binary) {
    auto lhs = binary->getLHS();

    auto ci = std::dynamic_pointer_cast<ConstantInt>(lhs);
    auto cf = std::dynamic_pointer_cast<ConstantFloat>(lhs);

    if (binary->getOpcode() == OP::SUB && ci && ci->getVal() == 0)
        return true;

    if (binary->getOpcode() == OP::FSUB && cf && cf->getVal() == 0.0f)
        return true;

    return false;
}

bool isNeg(const std::shared_ptr<Value> &v) {
    if (auto inst = std::dynamic_pointer_cast<Instruction>(v)) {
        if (inst->getOpcode() == OP::FNEG)
            return true;
        if (auto binary = std::dynamic_pointer_cast<BinaryInst>(inst))
            return isBinaryNeg(binary);
        return false;
    }
    return false;
}

std::shared_ptr<BinaryInst> ReassociateExpressionsPass::neg2Mul(const std::shared_ptr<Instruction> &neg) {
    // sub 0 x -> mul x -1
    // fneg x -> fmul x -1.0f
    Err::gassert(isNeg(neg));
    std::shared_ptr<BinaryInst> result = nullptr;
    if (auto fneg = std::dynamic_pointer_cast<FNEGInst>(neg)) {
        result = std::make_shared<BinaryInst>("%reass.fn2m" + std::to_string(name_cnt++),
                                             OP::FMUL, fneg->getVal(), func->getConstantPool().getConst(-1.0f));
    }
    else {
        auto sub = std::dynamic_pointer_cast<BinaryInst>(neg);
        result = std::make_shared<BinaryInst>("%reass.n2m" + std::to_string(name_cnt++),
                                              OP::MUL, sub->getRHS(), func->getConstantPool().getConst(-1));
    }
    result->getParent()->addInst(neg->index, result);
    neg->replaceSelf(result);
    return result;
}

Rank findIndexInOperands(const std::vector<ValueRank> &ops, Rank i, const std::shared_ptr<Value> &x) {
    Rank xRank = ops[i].rank;
    Rank e = ops.size();
    // forward
    for (Rank j = i + 1; j != e && ops[i].rank == xRank; ++j) {
        if (ops[j].op == x)
            return j;
        auto i1 = std::dynamic_pointer_cast<Instruction>(ops[j].op);
        auto i2 = std::dynamic_pointer_cast<Instruction>(x);
        if (!i1 && !i2)
            return j;
    }
    // backforward
    for (Rank j = i - 1; j != ReassociateExpressionsPass::NotRank && ops[j].rank == xRank; --j) {
        if (ops[j].op == x)
            return j;
        auto i1 = std::dynamic_pointer_cast<Instruction>(ops[j].op);
        auto i2 = std::dynamic_pointer_cast<Instruction>(x);
        if (!i1 && !i2)
            return j;
    }
    return i;
}

void getSingleUseFactor(const std::shared_ptr<Value> &v, std::vector<std::shared_ptr<Value>> &factors) {

    if (auto binary = isOneUseOp(v, OP::MUL, OP::FMUL)) {
        getSingleUseFactor(binary->getRHS(), factors);
        getSingleUseFactor(binary->getLHS(), factors);
    } else {
        factors.emplace_back(v);
        return;
    }
}

std::shared_ptr<Value> makeAddTree(std::vector<std::weak_ptr<Value>> &ops, OP opcode, Rank index, const std::shared_ptr<BasicBlock> &bb) {
    if (ops.size() == 1)
        return ops.back().lock();
    auto lhs = ops.back().lock();
    ops.pop_back();
    auto rhs = makeAddTree(ops, opcode, index, bb);
    auto binary = std::make_shared<BinaryInst>("%reass.mkaddtree", opcode, lhs, rhs);
    bb->addInst(index, binary);
    return binary;
}

Rank ReassociateExpressionsPass::getRank(const std::shared_ptr<Value> &v) {
    auto inst = std::dynamic_pointer_cast<Instruction>(v);
    if (!inst) {
        if (auto params = std::dynamic_pointer_cast<FormalParam>(v))
            return valueRankMap[v]; //function params
        return 0;                   //constant
    }
    if (auto Rank = valueRankMap[inst])
        return Rank;
    Rank rank = 0;
    Rank maxRank = bbRankMap[inst->getParent()];
    for (Rank i = 0; i != inst->getOperands().size() && rank != maxRank; ++i) {
        rank = std::max(rank, getRank(inst->getOperand(i)->getValue()));
    }
    return valueRankMap[inst] = rank;
}

bool ReassociateExpressionsPass::linearizeExprTree(
    const std::shared_ptr<BinaryInst> &root,
    std::vector<LinearizedNode> &ops) {
    using Weight = LinearizedNode::WeightT;
    auto root_op = root->getOpcode();
    std::vector<std::pair<std::shared_ptr<BinaryInst>, Weight>>
        work_list{ std::make_pair(root, 1) };
    std::map<std::shared_ptr<Value>, Weight> leaf_map;
    std::vector<std::shared_ptr<Value>> leaf;

    bool changed = false;
    while (!work_list.empty()) {
        auto [inst, weight] = work_list.back();
        work_list.pop_back();

        for (const auto &use : inst->getOperands()) {
            auto operand = use->getValue();
            if (std::shared_ptr<BinaryInst> binary = isOneUseBinary(operand, root_op)) {
                work_list.emplace_back(binary, weight);
                continue;
            }

            auto it = leaf_map.find(operand);
            if (it == leaf_map.end()) {
                // Untracked use, mark it as a leaf
                if (operand->getUseCount() != 1) {
                    leaf.emplace_back(operand);
                    leaf_map[operand] = weight;
                    continue;
                }
            } else {
                it->second += weight;
                if (operand->getUseCount() != 1)
                    continue;
                weight = it->second;
                leaf_map.erase(it);
            }

            if (root_op == OP::FMUL || root_op == OP::MUL) {
                if (isNeg(operand)) {
                    auto oper_inst = std::dynamic_pointer_cast<Instruction>(operand);
                    auto mul = neg2Mul(oper_inst);
                    work_list.emplace_back(mul, weight);
                    for (const auto &inner_use : mul->getUseList()) {
                        auto user = inner_use->getUser();
                        if (auto binary = std::dynamic_pointer_cast<BinaryInst>(user))
                            redoList.insert(binary);
                    }
                    redoList.insert(oper_inst);
                    changed = true;
                    continue;
                }
            }
            leaf.emplace_back(operand);
            leaf_map[operand] = weight;
        }
    }

    for (const auto &v : leaf) {
        auto it = leaf_map.find(v);
        if (it == leaf_map.end()) {
            Err::unreachable();
            continue;
        }
        Weight weight = it->second;
        it->second = 0;
        ops.emplace_back(LinearizedNode{ v, weight });
    }

    if (ops.empty()) {
        // to deal with 2bitwidth additions
        // add 0
        // fadd -0.0f
        switch (root_op) {
        case OP::ADD: {
            auto identityAdd = func->getConstantPool().getConst(0);
            ops.emplace_back(LinearizedNode{ identityAdd, 1 });
            break;
        }
        case OP::FADD: {
            auto identityFadd = func->getConstantPool().getConst(-0.0f);
            ops.emplace_back(LinearizedNode{ identityFadd, 1 });
            break;
        }
        default:
            break;
        }
    }
        return changed;
}

void ReassociateExpressionsPass::rewriteExpr(
    const std::shared_ptr<BinaryInst> &binary,
    std::vector<ValueRank> &ops) {
    auto opcode = binary->getOpcode();
    std::vector<std::shared_ptr<BinaryInst>> node2rewrite;

    std::set<std::shared_ptr<Value>> notRewritable;
    for (const auto &op : ops)
        notRewritable.insert(op.op);

    std::shared_ptr<BinaryInst> exprChangedStart = nullptr;
    std::shared_ptr<BinaryInst> exprChangedEnd = nullptr;

    std::shared_ptr<BinaryInst> curr = binary;
    for (Rank i = 0;; ++i) {
        if (i + 2 == ops.size()) {
            auto newlhs = ops[i].op;
            auto newrhs = ops[i + 1].op;
            auto oldlhs = curr->getLHS();
            auto oldrhs = curr->getRHS();
            if (newlhs == oldlhs && newrhs == oldrhs)
                break;
            if (newlhs == oldrhs && newrhs == oldlhs) {
                curr->swapLHSRHS();
                optModified = true;
                break;
            }
            if (newlhs != oldlhs) {
                auto binaryinst = isOneUseBinary(oldlhs, opcode);
                if (binaryinst && notRewritable.find(binaryinst) == notRewritable.end())
                    node2rewrite.emplace_back(binaryinst);
                curr->setLHS(newlhs);
            }
            if (newrhs != oldrhs) {
                auto binaryinst = isOneUseBinary(oldrhs, opcode);
                if (binaryinst && notRewritable.find(binaryinst) == notRewritable.end())
                    node2rewrite.emplace_back(binaryinst);
                curr->setRHS(newrhs);
            }
            exprChangedStart = curr;
            if (!exprChangedEnd)
                exprChangedEnd = curr;
            optModified = true;
            break;
        }
        auto newrhs = ops[i].op;
        if (newrhs != curr->getRHS()) {
            if (newrhs == curr->getLHS()) {
                curr->swapLHSRHS();
            } else {
                auto bo = isOneUseBinary(curr->getRHS(), opcode);
                if (bo && notRewritable.find(bo) == notRewritable.end())

                    node2rewrite.emplace_back(bo);
                curr->setRHS(newrhs);
                exprChangedStart = curr;
                if (!exprChangedEnd)
                    exprChangedEnd = curr;
                optModified = true;
            }
        }
        if (auto binaryinst = isOneUseBinary(curr->getLHS(), opcode)) {
            if (notRewritable.find(binaryinst) == notRewritable.end())
                curr = binaryinst;
            continue;
        }
        std::shared_ptr<BinaryInst> newInst;
        if (node2rewrite.empty()) {
            // TODO poison position
        } else {
            newInst = *node2rewrite.rbegin();
            node2rewrite.pop_back();
        }
        curr->setLHS(newInst);
        exprChangedStart = curr;
        if (!exprChangedEnd)
            exprChangedEnd = curr;
        optModified = true;
        curr = newInst;
    }
    if (exprChangedStart) {
        do {
            if (exprChangedStart == binary)
                break;
            //todo add e into BB
            exprChangedStart = std::dynamic_pointer_cast<BinaryInst>((*exprChangedStart->getUseList().begin())->getUser());
        } while (true);
    }
    for (const auto &binaryinst : node2rewrite) {
        redoList.insert(binaryinst);
    }
}

std::shared_ptr<Value> ReassociateExpressionsPass::removeFactorFromExpression(const std::shared_ptr<Value> &v, const std::shared_ptr<Value> &factor) {
    auto binaryInst = isOneUseOp(v, OP::MUL, OP::FMUL);
    if (!binaryInst)
        return nullptr;
    std::vector<LinearizedNode> tree;
    optModified |= linearizeExprTree(binaryInst, tree);
    std::vector<ValueRank> factors;
    factors.reserve(tree.size());
    for (const auto &t : tree) {
        factors.insert(factors.end(), t.weight, ValueRank(getRank(t.value), t.value));
    }
    bool canFactor = false;
    bool isNegate = false;
    bool isInt = false;
    for (Rank i = 0; i < factors.size(); ++i) {
        if (factors[i].op == factor) {
            canFactor = true;
            factors.erase(factors.begin() + i);
        }
        auto constInt1 = std::dynamic_pointer_cast<ConstantInt>(factor);
        auto constInt2 = std::dynamic_pointer_cast<ConstantInt>(factors[i].op);
        if (constInt1 && constInt2 && constInt1->getVal() == -constInt2->getVal()) {
            canFactor = isNegate = isInt = true;
            factors.erase(factors.begin() + i);
            break;
        }
        auto constFp1 = std::dynamic_pointer_cast<ConstantFloat>(factor);
        auto constFp2 = std::dynamic_pointer_cast<ConstantFloat>(factors[i].op);
        if (constFp1 && constFp2 && constFp1->getVal() == -constFp2->getVal()) {
            canFactor = isNegate = true;
            factors.erase(factors.begin() + i);
            break;
        }
    }
    if (!canFactor) {
        rewriteExpr(binaryInst, factors);
        return nullptr;
    }

    auto ret = v;
    if (factors.size() == 1) {
        redoList.insert(binaryInst);
        ret = factors[0].op;
    } else {
        rewriteExpr(binaryInst, factors);
        ret = binaryInst;
    }

    if (isNegate) {
        if (isInt) {
            auto neg = std::make_shared<BinaryInst>("%reass.neg" + std::to_string(name_cnt++),
                                                    OP::SUB, func->getConstantPool().getConst(0), v);
            binaryInst->getParent()->addInst(binaryInst->index + 1, neg);
        } else {
            auto fneg = std::make_shared<FNEGInst>("%reass.fneg" + std::to_string(name_cnt++), v);
            binaryInst->getParent()->addInst(binaryInst->index + 1, fneg);
        }
    }

    return v;
}

std::shared_ptr<Value> ReassociateExpressionsPass::optExpr(const std::shared_ptr<BinaryInst> &binary, std::vector<ValueRank> &ops) {
    auto opcode = binary->getOpcode();
    //TODO constant fold
    Rank num = ops.size();
    switch (opcode) {
    case OP::ADD:
    case OP::FADD:
        if (auto result = optAdd(binary, ops))
            return result;
        break;
    case OP::MUL:
    case OP::FMUL:
        if (auto result = optMul(binary, ops))
            return result;
        break;
    default:
        break;
    }
    if (ops.size() != num)
        return optExpr(binary, ops);
    return nullptr;
}

std::shared_ptr<Value> ReassociateExpressionsPass::optAdd(const std::shared_ptr<BinaryInst> &binary, std::vector<ValueRank> &ops) {
    // try to opt add to mul
    // for example Y + Y + Y + Z -> 3 * Y + Z
    for (Rank i = 0, e = ops.size(); i != e; ++i) {
        auto currOp = ops[i].op;
        if (i + 1 != ops.size() && ops[i + 1].op == currOp) {
            int repeatnumber = 0;
            do {
                ops.erase(ops.begin() + i);
                ++repeatnumber;
            } while (i != ops.size() && ops[i].op == currOp);
            std::shared_ptr<BinaryInst> mul = nullptr;
            if (std::dynamic_pointer_cast<BType>(currOp->getType())->getInner() == IRBTYPE::FLOAT) {
                mul = std::make_shared<BinaryInst>("%reass.a2m" + std::to_string(name_cnt++),
                                                   OP::MUL, currOp,
                                                   func->getConstantPool().getConst(static_cast<float>(repeatnumber)));
            } else {
                mul = std::make_shared<BinaryInst>("%reass.a2fm" + std::to_string(name_cnt++),
                                                   OP::FMUL, currOp, func->getConstantPool().getConst(repeatnumber));
            }
            //insert mul before binary
            binary->getParent()->addInst(binary->index - 1, mul);

            redoList.insert(mul);

            if (ops.empty())
                return mul;
            ops.insert(ops.begin(), ValueRank(getRank(mul), mul));
            --i;
            e = ops.size();
            continue;
        }
        // remove x + (-x)
        if (std::dynamic_pointer_cast<FNEGInst>(currOp) ||
            (std::dynamic_pointer_cast<BinaryInst>(currOp)->getOpcode() == OP::SUB && std::dynamic_pointer_cast<BinaryInst>(currOp)->getLHS() == func->getConstantPool().getConst(0))) {
            Rank index = findIndexInOperands(ops, i, currOp);
            if (index == i)
                continue;
            if (ops.size() == 2)
                return toBType(currOp->getType())->getInner() == IRBTYPE::FLOAT ? std::shared_ptr<Value>(func->getConstantPool().getConst(0.0f)) : std::shared_ptr<Value>(func->getConstantPool().getConst(0));
            ops.erase(ops.begin() + i);
            if (i < index)
                --index;
            else
                --i;
            ops.erase(ops.begin() + index);
            --i;
            e -= 2;
        } else
            continue;
    }
    //try to make A*A+A*B*C->A*(A+B+C)
    std::map<std::shared_ptr<Value>, Rank> factorOccurrTimes;
    Rank maxOccurrtime = 0;
    std::shared_ptr<Value> maxOccurrVal = nullptr;
    for (const auto &op : ops) {

        if (auto bin = isOneUseOp(op.op, OP::MUL, OP::FMUL)) {
            std::vector<std::shared_ptr<Value>> Factors;
            getSingleUseFactor(binary, Factors);
            std::set<std::shared_ptr<Value>> Duplicates;
            for (auto &factor : Factors) {
                if (!Duplicates.insert(factor).second)
                    continue;
                Rank occur = ++factorOccurrTimes[factor];
                if (occur > maxOccurrtime) {
                    maxOccurrtime = occur;
                    maxOccurrVal = factor;
                }
                if (factor->getVTrait() == ValueTrait::CONSTANT_LITERAL) {
                    auto constantInt = std::dynamic_pointer_cast<ConstantInt>(factor);
                    auto constFloat = std::dynamic_pointer_cast<ConstantFloat>(factor);
                    //TODO check factor is not min number
                    if (constantInt && constantInt->getVal() < 0) {
                        factor = func->getConstantPool().getConst(-constantInt->getVal());
                    } else if (constFloat && constFloat->getVal() < 0.0f) {
                        factor = func->getConstantPool().getConst(-constFloat->getVal());
                    }

                    if (!Duplicates.insert(factor).second)
                        continue;
                    Rank occur = ++factorOccurrTimes[factor];
                    if (occur > maxOccurrtime) {
                        maxOccurrtime = occur;
                        maxOccurrVal = factor;
                    }
                }
            }
        } else
            continue;
    }
    if (maxOccurrtime > 1) {

        auto dummyInst = toBType(binary->getType())->getInner() == IRBTYPE::FLOAT
                             ? std::make_shared<BinaryInst>("%reass.fa" + std::to_string(name_cnt++),
                                                            OP::FADD, maxOccurrVal, maxOccurrVal)
                             : std::make_shared<BinaryInst>("%reass.fa" + std::to_string(name_cnt++),
                                                            OP::ADD, maxOccurrVal, maxOccurrVal);
        //ensure maxOcurrVal is used twise to avoid removefact
        std::vector<std::weak_ptr<Value>> newMulOps;
        bool isInt = false;
        for (Rank i = 0; i < ops.size(); ++i) {
            auto binaryOp = isOneUseOp(ops[i].op, OP::MUL, OP::FMUL);
            if (!binaryOp)
                continue;
            if (!isInt && binaryOp->getOpcode() == OP::ADD)
                isInt = true;

            if (auto value = removeFactorFromExpression(ops[i].op, maxOccurrVal)) {
                for (Rank j = ops.size(); j != i;) {
                    --j;
                    if (ops[j].op == ops[i].op) {
                        newMulOps.emplace_back(ops[i].op);
                        ops.erase(ops.begin() + j);
                    }
                }
                --i;
            }
        }
        //todo dummy->delete
        std::shared_ptr<Value> v;
        if (isInt)
            v = makeAddTree(newMulOps, OP::ADD, binary->index - 1, binary->getParent());
        else
            v = makeAddTree(newMulOps, OP::FADD, binary->index - 1, binary->getParent());
        //try to deal with A*A*B+A*A*C->A*(A*B+A*C)->A*(A*(B+C)
        if (auto inst = std::dynamic_pointer_cast<Instruction>(v)) {
            redoList.insert(inst);
        }
        std::shared_ptr<BinaryInst> mul;

        if (isInt)
            mul = std::make_shared<BinaryInst>("%reass.m" + std::to_string(name_cnt++),
                                               OP::MUL, v, maxOccurrVal);
        else
            mul = std::make_shared<BinaryInst>("%reass.fm" + std::to_string(name_cnt++),
                                               OP::FMUL, v, maxOccurrVal);
        //insert mul into bb
        binary->getParent()->addInst(binary->index - 1, mul);
        redoList.insert(mul);
        if (ops.empty())
            return mul;
        ops.insert(ops.begin(), ValueRank(getRank(mul), mul));
    }
    return nullptr;
}

std::shared_ptr<Value> ReassociateExpressionsPass::optMul(
    const std::shared_ptr<BinaryInst> &binary, std::vector<ValueRank> &ops) {
    return nullptr;
}

void analyzeNegatible(const std::shared_ptr<Value> &v, std::vector<std::shared_ptr<BinaryInst>> &result) {
    if (v->getUseCount() != 1 || !std::dynamic_pointer_cast<Instruction>(v))
        return;
    auto binary = std::dynamic_pointer_cast<BinaryInst>(v);
    auto lhs = binary->getLHS();
    auto rhs = binary->getRHS();
    switch (binary->getOpcode()) {
    case OP::FMUL:
        // Skip non-canonical
        if (lhs->getVTrait() == ValueTrait::CONSTANT_LITERAL)
            break;
        if (std::dynamic_pointer_cast<ConstantFloat>(rhs)->getVal() < 0.0f)
            result.emplace_back(binary);
        analyzeNegatible(lhs, result);
        analyzeNegatible(rhs, result);
        break;
    case OP::FDIV:
        if (lhs->getVTrait() == ValueTrait::CONSTANT_LITERAL && rhs->getVTrait() == ValueTrait::CONSTANT_LITERAL)
            break;
        if (std::dynamic_pointer_cast<ConstantFloat>(lhs)->getVal() < 0.0f || std::dynamic_pointer_cast<ConstantFloat>(rhs)->getVal() < 0.0f)
            result.emplace_back(binary);

        analyzeNegatible(lhs, result);
        analyzeNegatible(rhs, result);
        break;
    default:
        break;
    }
}

std::shared_ptr<BinaryInst> ReassociateExpressionsPass::canonNegFPImpl(const std::shared_ptr<BinaryInst> &binary,
                                                                       const std::shared_ptr<BinaryInst> &subtree, const std::shared_ptr<Value> &v) {
    if (binary->getOpcode() != OP::FADD && binary->getOpcode() != OP::FSUB)
        return binary;

    // Ensure subtree is rhs
    Err::gassert(binary->getRHS() == subtree || (binary->getLHS() == subtree && binary->getOpcode() == OP::FADD));

    // Collect negative constants
    std::vector<std::shared_ptr<BinaryInst>> negatibles;
    analyzeNegatible(subtree, negatibles);
    if (negatibles.empty())
        return binary;

    for (const auto &candidate : negatibles) {
        auto lcf = std::dynamic_pointer_cast<ConstantFloat>(candidate->getLHS());
        auto rcf = std::dynamic_pointer_cast<ConstantFloat>(candidate->getRHS());
        if (lcf && !rcf) {
            candidate->setLHS(func->getConstantPool().getConst(-lcf->getVal()));
            optModified = true;
        } else if (rcf && !lcf) {
            candidate->setRHS(func->getConstantPool().getConst(-rcf->getVal()));
            optModified = true;
        } else
            Err::unreachable();
    }

    if (negatibles.size() % 2 == 0)
        return binary;

    // v op subtree
    // <negate subtree>
    // v -op subtree
    std::shared_ptr<BinaryInst> newInst;
    if (binary->getOpcode() == OP::FADD) {
        newInst = std::make_shared<BinaryInst>("%reass.fs" + std::to_string(name_cnt++),
                                               OP::FSUB, v, subtree);
    } else {
        newInst = std::make_shared<BinaryInst>("%reass.fa" + std::to_string(name_cnt++),
                                               OP::FADD, v, subtree);
    }
    redoList.insert(binary);
    binary->getParent()->addInst(binary->index, newInst);
    binary->replaceSelf(newInst);
    return newInst;
}

std::shared_ptr<BinaryInst> ReassociateExpressionsPass::canonNegFP(const std::shared_ptr<BinaryInst> &binary) {
    if (binary == nullptr)
        return nullptr;

    auto lhs = binary->getLHS();
    auto rhs = binary->getRHS();

    auto lsubtree = std::dynamic_pointer_cast<BinaryInst>(lhs);
    auto rsubtree = std::dynamic_pointer_cast<BinaryInst>(rhs);

    // Keep subtree the rhs.
    if (binary->getOpcode() == OP::FADD) {
        if (rsubtree && rsubtree->getUseCount() == 0)
            return canonNegFPImpl(binary, rsubtree, lhs);
        if (lsubtree && lsubtree->getUseCount() == 0)
            return canonNegFPImpl(binary, rsubtree, lhs);
    } else if (binary->getOpcode() == OP::FSUB) {
        if (rsubtree && rsubtree->getUseCount() == 0)
            return canonNegFPImpl(binary, rsubtree, lhs);
    }
    return binary;
}

std::shared_ptr<Instruction> ReassociateExpressionsPass::canonInst(const std::shared_ptr<Instruction> &inst) {
    switch (inst->getOpcode()) {
    case OP::ADD:
    case OP::FADD:
    case OP::MUL:
    case OP::FMUL:
    case OP::AND:
    case OP::OR:
        auto bin = std::dynamic_pointer_cast<BinaryInst>(inst);
        const auto &lhs = bin->getLHS();
        const auto &rhs = bin->getLHS();
        if (lhs == rhs || rhs->getVTrait() == ValueTrait::CONSTANT_LITERAL)
            break;
        if (lhs->getVTrait() == ValueTrait::CONSTANT_LITERAL || getRank(rhs) < getRank(lhs))
            bin->swapLHSRHS();
        break;
    default:
        break;
    }

    if (auto neg = canonNegFP(std::dynamic_pointer_cast<BinaryInst>(inst)))
        return neg;
    return inst;
}

void ReassociateExpressionsPass::optInst(const std::shared_ptr<Instruction> &raw_inst) {
    // DO NOT reassociate ICMP/FCMP for better codegen
    if (!std::dynamic_pointer_cast<FNEGInst>(raw_inst) && !std::dynamic_pointer_cast<BinaryInst>(raw_inst))
        return;

    auto candidate = raw_inst;

    candidate = canonInst(candidate);

    auto binary = std::dynamic_pointer_cast<BinaryInst>(candidate);

    if (candidate->getOpcode() == OP::SUB) {
        if (isBinaryNeg(binary)) {
            // 0 - x * x
            if (isOneUseBinary(binary->getRHS(), OP::MUL) // operand is a multiply tree
                &&
                // Not a multiply tree's child
                (binary->getUseCount() != 1
                    || !isOneUseBinary(binary->getUseList().back()->getUser(), OP::MUL))) {
                auto negInst = neg2Mul(binary);
                auto use_list = binary->getUseList();
                for (const auto &use : use_list) {
                    if (auto binary_user = std::dynamic_pointer_cast<BinaryInst>(use->getUser()))
                        redoList.insert(binary_user);
                }
                redoList.insert(candidate);
                optModified = true;
                candidate = negInst;
            }
        }
    }

    // check candidate is associative
    if (candidate->getOpcode() != OP::MUL
        && candidate->getOpcode() != OP::ADD
        && candidate->getOpcode() != OP::FMUL
        && candidate->getOpcode() != OP::FADD)
        return;

    // Candidate may have changed, update binary
    binary = std::dynamic_pointer_cast<BinaryInst>(candidate);

    auto opcode = binary->getOpcode();
    auto lastUserInst = std::dynamic_pointer_cast<Instruction>(binary->getUseList().back()->getUser());
    if (binary->getUseCount() == 1 && lastUserInst->getOpcode() == opcode) {
        if (lastUserInst != binary && binary->getParent() == lastUserInst->getParent())
            redoList.insert(lastUserInst);
        return;
    }

    if (binary->getUseCount() == 1 && binary->getOpcode() == OP::ADD && lastUserInst->getOpcode() == OP::SUB)
        return;
    if (binary->getUseCount() == 1 && binary->getOpcode() == OP::FADD && lastUserInst->getOpcode() == OP::FSUB)
        return;

    reassociateExpression(binary);
}

void ReassociateExpressionsPass::reassociateExpression(const std::shared_ptr<BinaryInst> &inst) {
    std::vector<std::pair<std::shared_ptr<Value>, Rank>> tree;
    optModified |= linearizeExprTree(inst, tree);
    std::vector<ValueRank> ops;
    ops.reserve(tree.size());
    for (const auto &t : tree) {
        ops.insert(ops.end(), t.second, ValueRank(getRank(t.first), t.first));
    }
    std::sort(ops.begin(), ops.end());
    if (auto v = optExpr(inst, ops)) {
        if (inst == v)
            return;
        inst->replaceSelf(v);
        redoList.insert(inst);
        return;
    }
    // for example (-X) * Y + Z -> Z - X+Y
    if (inst->getUseCount() == 1) {
        auto lastUserInstOpcode = std::dynamic_pointer_cast<Instruction>((*inst->getUseList().end())->getValue())->getOpcode();
        if (inst->getOpcode() == OP::MUL &&
            lastUserInstOpcode == OP::ADD && std::dynamic_pointer_cast<ConstantInt>(ops.back().op)->getVal() == -1) {
            ValueRank temp = ops.back();
            ops.pop_back();
            ops.insert(ops.begin(), temp);
        } else if (inst->getOpcode() == OP::FMUL && lastUserInstOpcode == OP::FADD && std::dynamic_pointer_cast<ConstantFloat>(ops.back().op)->getVal() == -1.0f) {
            ValueRank temp = ops.back();
            ops.pop_back();
            ops.insert(ops.begin(), temp);
        }
    }
    if (ops.size() == 1) {
        if (ops[0].op == inst)
            return;
        //self reference
        inst->replaceSelf(ops[0].op);
        redoList.insert(inst);
        return;
    }
    //TODO pair map for CSE
    rewriteExpr(inst, ops);
}

void ReassociateExpressionsPass::eraseInst(const std::shared_ptr<Instruction> &inst) {
    //remove trivially dead
    std::vector<std::shared_ptr<Value>> ops;
    for (const auto &op : inst->getOperands()) {
        ops.emplace_back(op->getValue());
    }
    valueRankMap.erase(inst);
    redoList.erase(inst);
    auto bb = inst->getParent();
    bb->delFirstOfInst(inst); //the  inst is no used
    std::set<std::shared_ptr<Instruction>> visit;
    for (const auto &v : ops) {
        if (auto v2inst = std::dynamic_pointer_cast<Instruction>(v)) {
            auto opcode = v2inst->getOpcode();
            while (v2inst->getUseCount() == 1 && std::dynamic_pointer_cast<Instruction>(v2inst->getUseList().back()->getUser())->getOpcode() == opcode && visit.insert(v2inst).second)
                v2inst = std::dynamic_pointer_cast<Instruction>(v2inst->getUseList().back()->getUser());
            if (valueRankMap.find(v2inst) != valueRankMap.end())
                redoList.insert(v2inst);
        }
    }
    optModified = true;
}

void ReassociateExpressionsPass::recursivelyEraseDeadInsts(const std::shared_ptr<Instruction> &inst, std::set<std::shared_ptr<Instruction>> &insts) {
    std::vector<std::shared_ptr<Value>> ops;
    for (auto &i : inst->getOperands()) {
        ops.emplace_back(i->getValue());
    }
    insts.erase(inst);
    redoList.erase(inst);
    valueRankMap.erase(inst);
    auto bb = inst->getParent();
    bb->delInst(inst);
    for (const auto &op : ops) {
        if (auto op2inst = std::dynamic_pointer_cast<Instruction>(op)) {
            if (op2inst->getUseList().empty())
                insts.insert(op2inst);
        }
    }
}

PM::PreservedAnalyses ReassociateExpressionsPass::run(Function &function, FAM &manager) {
    bool reassociate_inst_modified = false;
    func = &function;

    // Build Rank Map
    // assign different rank to params
    Rank rank = 2;
    for (const auto &param : function.getParams())
        valueRankMap[param] = ++rank;

    auto rpov = function.getDFVisitor(Util::DFVOrder::ReversePostOrder);
    for (const auto &node : rpov) {
        // << 16 to avoid collision with other block
        Rank bbRank = bbRankMap[node] = ++rank << 16;
        for (const auto &phi : node->getPhiInsts())
            valueRankMap[phi] = ++bbRank;
        for (const auto &inst : *node) {
            if (std::dynamic_pointer_cast<BinaryInst>(inst) == nullptr && inst->getOpcode() != OP::GEP)
                valueRankMap[inst] = ++bbRank;
        }
    }

    // Optimize Instructions
    for (const auto &bb : function) {
        for (auto &inst : *bb) {
            optModified = false;
            optInst(inst);
            reassociate_inst_modified |= optModified;
        }
    }

    valueRankMap.clear();
    bbRankMap.clear();
    redoList.clear();
    func = nullptr;
    optModified = false;
    name_cnt = 0;

    if (!reassociate_inst_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        pa.preserve<PostDomTreeAnalysis>();
        return pa;
    }

    // TODO: Redo

    if (reassociate_inst_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        pa.preserve<PostDomTreeAnalysis>();
        return pa;
    }

    return PM::PreservedAnalyses::all();
}
} // namespace IR