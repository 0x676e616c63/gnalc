//
// Created by edragain on 2/12/25.
//
#include "../../../../include/ir/passes/transforms/reassociate_expressions.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <limits>
#include <algorithm>


namespace IR {
std::shared_ptr<BinaryInst> getReassociableOp(const std::shared_ptr<Value> &v, OP opcode) {
    auto binary = std::dynamic_pointer_cast<BinaryInst>(v);
    if (binary && binary->getUseList().size() == 1 && binary->getOpcode() == opcode)
        return binary;
    return nullptr;
}

std::shared_ptr<BinaryInst> getReassociableOp(const std::shared_ptr<Value> &v, OP opcode1, OP opcode2) {
    auto binary = std::dynamic_pointer_cast<BinaryInst>(v);
    if (binary && binary->getUseList().size() == 1 && (binary->getOpcode() == opcode1 || binary->getOpcode() == opcode2))
        return binary;
    return nullptr;
}

std::shared_ptr<BinaryInst> ReassociateExpressionsPass::neg2Mul(const std::shared_ptr<Instruction> &neg) {
    // sub 0 x -> mul x -1
    //fneg x -> fmul x -1.0f
    std::shared_ptr<BinaryInst> result = nullptr;
    if (auto fneg = std::dynamic_pointer_cast<FNEGInst>(neg))
        result = std::make_shared<BinaryInst>(fneg->getName(), OP::FMUL, fneg->getVal(), func->getConstantPool().getConst(-1.0f));
    else {
        auto sub = std::dynamic_pointer_cast<BinaryInst>(neg);
        result = std::make_shared<BinaryInst>(sub->getName(), OP::MUL, sub->getRHS(), func->getConstantPool().getConst(-1));
    }
    neg->replaceSelf(result);
    return result;
}

unsigned findIndexInOperands(const std::vector<ValueRank> &ops, unsigned i, const std::shared_ptr<Value> &x) {
    unsigned xRank = ops[i].rank;
    unsigned e = ops.size();
    //forward
    for (unsigned j = i + 1; j != e && ops[i].rank == xRank; ++j) {
        if (ops[j].op == x)
            return j;
        auto i1 = std::dynamic_pointer_cast<Instruction>(ops[j].op);
        auto i2 = std::dynamic_pointer_cast<Instruction>(x);
        if (!i1 && !i2)
            return j;
    }
    //backforward
    for (unsigned j = i - 1; j != std::numeric_limits<unsigned>::max() && ops[j].rank == xRank; --j) {
        if (ops[j].op == x)
            return j;
        auto i1 = std::dynamic_pointer_cast<Instruction>(ops[j].op);
        auto i2 = std::dynamic_pointer_cast<Instruction>(x);
        if (!i1 && !i2)
            return j;
    }
    return i;
}

void getSingleUseFactor(const std::shared_ptr<Value> &v, std::vector<std::shared_ptr<Value> > &factors) {

    if (auto binary = getReassociableOp(v, OP::MUL, OP::FMUL)) {
        getSingleUseFactor(binary->getRHS(), factors);
        getSingleUseFactor(binary->getLHS(), factors);
    } else {
        factors.emplace_back(v);
        return;
    }
}

std::shared_ptr<Value> makeAddTree(std::vector<std::weak_ptr<Value> > &ops, OP opcode, unsigned index, const std::shared_ptr<BasicBlock> &bb) {
    if (ops.size() == 1)
        return ops.back().lock();
    auto lhs = ops.back().lock();
    ops.pop_back();
    auto rhs = makeAddTree(ops, opcode, index, bb);
    auto binary = std::make_shared<BinaryInst>("makeAddTree", opcode, lhs, rhs);
    bb->addInst(index, binary);
    return binary;
}

PM::PreservedAnalyses ReassociateExpressionsPass::run(Function &function, FAM &manager) {
    func = &function;

    // buildRankMap
    // assign different rank to params
    unsigned rank = 2;
    for (const auto &param : function.getParams())
        valueRankMap[param] = ++rank;

    auto rpov = function.getDFVisitor(Util::DFVOrder::ReversePostOrder);
    for (const auto &node : rpov) {
        // << 16 to avoid collision with other block
        unsigned bbRank = bbRankMap[node] = ++rank << 16;
        for (const auto &phi : node->getPhiInsts())
            valueRankMap[phi] = ++bbRank;
        for (const auto &inst : *node) {
            if (std::dynamic_pointer_cast<BinaryInst>(inst) == nullptr
                && inst->getOpcode() != OP::GEP)
                valueRankMap[inst] = ++bbRank;
        }
    }

    if (madeChange) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        pa.preserve<PostDomTreeAnalysis>();
        return pa;
    }

    return PM::PreservedAnalyses::all();
}

unsigned ReassociateExpressionsPass::getRank(const std::shared_ptr<Value> &v) {
    auto inst = std::dynamic_pointer_cast<Instruction>(v);
    if (!inst) {
        if (auto params = std::dynamic_pointer_cast<FormalParam>(v))
            return valueRankMap[v]; //function params
        return 0; //constant
    }
    if (auto Rank = valueRankMap[inst])
        return Rank;
    unsigned Rank = 0;
    unsigned maxRank = bbRankMap[inst->getParent()];
    for (unsigned i = 0; i != inst->getOperands().size() && Rank != maxRank; ++i) {
        Rank = std::max(Rank, getRank(inst->getOperand(i)->getValue()));
    }
    return valueRankMap[inst] = Rank;
}

void ReassociateExpressionsPass::canonicalizeOperands(const std::shared_ptr<Instruction> &inst) {
    auto lhs = std::dynamic_pointer_cast<BinaryInst>(inst)->getLHS();
    auto rhs = std::dynamic_pointer_cast<BinaryInst>(inst)->getRHS();
    if (lhs == rhs || rhs->getVTrait() == ValueTrait::CONSTANT_LITERAL)
        return;
    if (lhs->getVTrait() == ValueTrait::CONSTANT_LITERAL || getRank(rhs) < getRank(lhs)) {
        std::dynamic_pointer_cast<BinaryInst>(inst)->swapLHSRHS();
    }
}

bool ReassociateExpressionsPass::linearizeExprTree(const std::shared_ptr<Instruction> &inst, std::vector<std::pair<std::shared_ptr<Value>, unsigned> > &ops, std::set<std::shared_ptr<Instruction> > &redo) {
    std::vector<std::pair<std::shared_ptr<Instruction>, unsigned> > workList;
    auto opcode = inst->getOpcode();
    workList.emplace_back(inst, 1);
    bool changed = false;
    std::map<std::shared_ptr<Value>, unsigned> leafMap;
    std::vector<std::shared_ptr<Value> > leaf;

    while (!workList.empty()) {
        auto [Inst,Weight] = *workList.rbegin();
        workList.pop_back();
        for (const auto &use : Inst->getOperands()) {
            auto op = use->getValue();
            if (std::shared_ptr<BinaryInst> binary = getReassociableOp(op, opcode)) {
                workList.emplace_back(binary, Weight);
                continue;
            }
            if (leafMap.find(op) == leafMap.end()) {
                if (op->getUseList().size() != 1) {
                    leaf.emplace_back(op);
                    leafMap[op] = Weight;
                    continue;
                }
            } else {
                leafMap.find(op)->second += Weight;
                if (op->getUseList().size() != 1) {
                    continue;
                }
                Weight = leafMap.find(op)->second;
                leafMap.erase(leafMap.find(op));
            }

            std::shared_ptr<Instruction> neg = std::dynamic_pointer_cast<Instruction>(op);
            if (neg && (opcode == OP::FMUL && std::dynamic_pointer_cast<FNEGInst>(op)) ||
                (opcode == OP::MUL && std::dynamic_pointer_cast<BinaryInst>(op)->getOpcode() == OP::SUB && std::dynamic_pointer_cast<BinaryInst>(op)->getLHS() == func->getConstantPool().getConst(0))) {
                auto mul = neg2Mul(neg);
                workList.emplace_back(mul, Weight);
                for (const auto &USE : mul->getUseList()) {
                    auto user = USE->getUser();
                    if (auto binary = std::dynamic_pointer_cast<BinaryInst>(user))
                        redo.insert(binary);
                }
                redo.insert(neg);
                changed = true;
                continue;
            }
            leaf.emplace_back(op);
            leafMap[op] = Weight;
        }
    }
    for (const auto &v : leaf) {
        if (leafMap.find(v) == leafMap.end())
            continue;
        auto Weight = leafMap.find(v)->second;
        leafMap.find(v)->second = 0;
        ops.emplace_back(v, Weight);
    }
    if (ops.empty()) {
        //to deal with 2bitwidth additions
        //add 0
        //fadd -0.0f
        switch (opcode) {
        case OP::ADD: {
            auto identityAdd = func->getConstantPool().getConst(0);
            ops.emplace_back(identityAdd, 1);
            break;
        }
        case OP::FADD: {
            auto identityFadd = func->getConstantPool().getConst(-0.0f);
            ops.emplace_back(identityFadd, 1);
            break;
        }
        default:
            break;
        }
    }
    return changed;
}

void ReassociateExpressionsPass::rewriteExpr(const std::shared_ptr<BinaryInst> &binary, std::vector<ValueRank> &ops) {
    std::vector<std::shared_ptr<BinaryInst> > node2rewrite;
    auto opcode = binary->getOpcode();
    std::shared_ptr<BinaryInst> Inst = binary;
    std::set<std::shared_ptr<Value> > not2rewrite;
    for (const auto &op : ops) {
        not2rewrite.insert(op.op);
    }
    std::shared_ptr<BinaryInst> exprChangedStart = nullptr;
    std::shared_ptr<BinaryInst> exprChangedEnd = nullptr;
    for (unsigned i = 0;; ++i) {
        if (i + 2 == ops.size()) {
            auto newlhs = ops[i].op;
            auto newrhs = ops[i + 1].op;
            auto oldlhs = Inst->getLHS();
            auto oldrhs = Inst->getRHS();
            if (newlhs == oldlhs && newrhs == oldrhs)
                break;
            if (newlhs == oldrhs && newrhs == oldlhs) {
                Inst->swapLHSRHS();
                madeChange = true;
                break;
            }
            if (newlhs != oldlhs) {
                auto binaryinst = getReassociableOp(oldlhs, opcode);
                if (binaryinst && not2rewrite.find(binaryinst) == not2rewrite.end())
                    node2rewrite.emplace_back(binaryinst);
                Inst->setLHS(newlhs);
            }
            if (newrhs != oldrhs) {
                auto binaryinst = getReassociableOp(oldrhs, opcode);
                if (binaryinst && not2rewrite.find(binaryinst) == not2rewrite.end())
                    node2rewrite.emplace_back(binaryinst);
                Inst->setRHS(newrhs);
            }
            exprChangedStart = Inst;
            if (!exprChangedEnd)
                exprChangedEnd = Inst;
            madeChange = true;
            break;
        }
        auto newrhs = ops[i].op;
        if (newrhs != Inst->getRHS()) {
            if (newrhs == Inst->getLHS()) {
                Inst->swapLHSRHS();
            } else {
                auto bo = getReassociableOp(Inst->getRHS(), opcode);
                if (bo && not2rewrite.find(bo) == not2rewrite.end())

                    node2rewrite.emplace_back(bo);
                Inst->setRHS(newrhs);
                exprChangedStart = Inst;
                if (!exprChangedEnd)
                    exprChangedEnd = Inst;
                madeChange = true;
            }
        }
        if (auto binaryinst = getReassociableOp(Inst->getLHS(), opcode)) {
            if (not2rewrite.find(binaryinst) == not2rewrite.end())
                Inst = binaryinst;
            continue;
        }
        std::shared_ptr<BinaryInst> newInst;
        if (node2rewrite.empty()) {
            // TODO poison position
        } else {
            newInst = *node2rewrite.rbegin();
            node2rewrite.pop_back();
        }
        Inst->setLHS(newInst);
        exprChangedStart = Inst;
        if (!exprChangedEnd)
            exprChangedEnd = Inst;
        madeChange = true;
        Inst = newInst;
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

std::shared_ptr<Value> ReassociateExpressionsPass::removeFactorFromExpression(std::shared_ptr<Value> &v, const std::shared_ptr<Value> &factor) {
    auto binaryInst = getReassociableOp(v, OP::MUL, OP::FMUL);
    if (!binaryInst)
        return nullptr;
    std::vector<std::pair<std::shared_ptr<Value>, unsigned> > tree;
    madeChange |= linearizeExprTree(binaryInst, tree, redoList);
    std::vector<ValueRank> Factors;
    Factors.reserve(tree.size());
    for (const auto &t : tree) {
        Factors.insert(Factors.end(), t.second, ValueRank(getRank(t.first), t.first));
    }
    bool canFactor = false;
    bool isNegate = false;
    bool isInt = false;
    for (unsigned i = 0; i < Factors.size(); ++i) {
        if (Factors[i].op == factor) {
            canFactor = true;
            Factors.erase(Factors.begin() + i);
        }
        auto constInt1 = std::dynamic_pointer_cast<ConstantInt>(factor);
        auto constInt2 = std::dynamic_pointer_cast<ConstantInt>(Factors[i].op);
        if (constInt1 && constInt2 && constInt1->getVal() == -constInt2->getVal()) {
            canFactor = isNegate = isInt = true;
            Factors.erase(Factors.begin() + i);
            break;
        }
        auto constFp1 = std::dynamic_pointer_cast<ConstantFloat>(factor);
        auto constFp2 = std::dynamic_pointer_cast<ConstantFloat>(Factors[i].op);
        if (constFp1 && constFp2 && constFp1->getVal() == -constFp2->getVal()) {
            canFactor = isNegate = true;
            Factors.erase(Factors.begin() + i);
            break;
        }
    }
    if (!canFactor) {
        rewriteExpr(binaryInst, Factors);
        return nullptr;
    }
    if (Factors.size() == 1) {
        redoList.insert(binaryInst);
        v = Factors[0].op;
    } else {
        rewriteExpr(binaryInst, Factors);
        v = binaryInst;
    }
    if (isNegate) {
        if (isInt) {
            auto neg = std::make_shared<BinaryInst>("neg", OP::SUB, func->getConstantPool().getConst(0), v);
            binaryInst->getParent()->addInst(binaryInst->index + 1, neg);
        } else {
            auto fneg = std::make_shared<FNEGInst>("fneg", v);
            binaryInst->getParent()->addInst(binaryInst->index + 1, fneg);
        }
    }

    return v;
}

std::shared_ptr<Value> ReassociateExpressionsPass::optExpr(std::shared_ptr<BinaryInst> &binary, std::vector<ValueRank> &ops) {
    auto opcode = binary->getOpcode();
    //TODO constant fold
    unsigned num = ops.size();
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
    //try to opt add to mul
    //for example Y+Y+Y+Z -> 3*Y+Z
    for (unsigned i = 0, e = ops.size(); i != e; ++i) {
        auto currOp = ops[i].op;
        if (i + 1 != ops.size() && ops[i + 1].op == currOp) {
            int repeatnumber = 0;
            do {
                ops.erase(ops.begin() + i);
                ++repeatnumber;
            } while (i != ops.size() && ops[i].op == currOp);
            std::shared_ptr<BinaryInst> mul = nullptr;
            if (std::dynamic_pointer_cast<BType>(currOp->getType())->getInner() == IRBTYPE::FLOAT) {
                mul = std::make_shared<BinaryInst>("add2mul", OP::MUL, currOp, func->getConstantPool().getConst(static_cast<float>(repeatnumber)));
            } else
                mul = std::make_shared<BinaryInst>("add2fmul", OP::FMUL, currOp, func->getConstantPool().getConst(repeatnumber));
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
            (std::dynamic_pointer_cast<BinaryInst>(currOp)->getOpcode() == OP::SUB
             && std::dynamic_pointer_cast<BinaryInst>(currOp)->getLHS() == func->getConstantPool().getConst(0))) {
            unsigned index = findIndexInOperands(ops, i, currOp);
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
    std::map<std::shared_ptr<Value>, unsigned> factorOccurrTimes;
    unsigned maxOccurrtime = 0;
    std::shared_ptr<Value> maxOccurrVal = nullptr;
    for (const auto &op : ops) {

        if (auto bin = getReassociableOp(op.op, OP::MUL, OP::FMUL)) {
            std::vector<std::shared_ptr<Value> > Factors;
            getSingleUseFactor(binary, Factors);
            std::set<std::shared_ptr<Value> > Duplicates;
            for (auto &factor : Factors) {
                if (!Duplicates.insert(factor).second)
                    continue;
                unsigned occur = ++factorOccurrTimes[factor];
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
                    unsigned occur = ++factorOccurrTimes[factor];
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
                             ? std::make_shared<BinaryInst>("twisemaxOccurrVal", OP::FADD, maxOccurrVal, maxOccurrVal)
                             : std::make_shared<BinaryInst>("twisemaxOccurrVal", OP::ADD, maxOccurrVal, maxOccurrVal);
        //ensure maxOcurrVal is used twise to avoid removefact
        std::vector<std::weak_ptr<Value> > newMulOps;
        bool isInt = false;
        for (unsigned i = 0; i < ops.size(); ++i) {
            auto binaryOp = getReassociableOp(ops[i].op, OP::MUL, OP::FMUL);
            if (!binaryOp)
                continue;
            if (!isInt && binaryOp->getOpcode() == OP::ADD)
                isInt = true;

            if (auto value = removeFactorFromExpression(ops[i].op, maxOccurrVal)) {
                for (unsigned j = ops.size(); j != i;) {
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
            mul = std::make_shared<BinaryInst>("mul inst", OP::MUL, v, maxOccurrVal);
        else
            mul = std::make_shared<BinaryInst>("fmul inst", OP::FMUL, v, maxOccurrVal);
        //insert mul into bb
        binary->getParent()->addInst(binary->index - 1, mul);
        redoList.insert(mul);
        if (ops.empty())
            return mul;
        ops.insert(ops.begin(), ValueRank(getRank(mul), mul));
    }
    return nullptr;
}

std::shared_ptr<Value> ReassociateExpressionsPass::optMul(std::shared_ptr<BinaryInst> &binary, std::vector<ValueRank> &ops) {
    return nullptr;
}

void ReassociateExpressionsPass::optInst(std::shared_ptr<Instruction> &inst) {
    if (!std::dynamic_pointer_cast<FNEGInst>(inst) && !std::dynamic_pointer_cast<BinaryInst>(inst))
        return;
    //check inst is commutative
    switch (inst->getOpcode()) {
    case OP::ADD:
    case OP::FADD:
    case OP::MUL:
    case OP::FMUL:
        canonicalizeOperands(inst);
        break;
    default:
        break;
    }
    //fixme:inst is commutative also have: and or icmp fcmp
    // for now we just condider add mul

    if (auto result = canonicalizeNegFloat(inst))
        inst = result;

    auto binary = std::dynamic_pointer_cast<BinaryInst>(inst);

    if (inst->getOpcode() == OP::SUB) {
        if (canSub2Add(binary)) {
            auto negInst = sub2Add(binary, redoList);
            redoList.insert(inst);
            madeChange = true;
            inst = negInst;
        } else if (isNeg(std::dynamic_pointer_cast<BinaryInst>(inst))) {
            if (getReassociableOp(binary->getRHS(), OP::MUL) && binary->getUseList().size() != 1 || !getReassociableOp(std::dynamic_pointer_cast<BinaryInst>(binary->getUseList().back()->getUser()), OP::MUL)) {
                auto negInst = neg2Mul(binary);
                for (const auto &use : binary->getUseList()) {
                    auto user = use->getUser();
                    if (auto user2binary = std::dynamic_pointer_cast<BinaryInst>(user))
                        redoList.insert(user2binary);
                }
                redoList.insert(inst);
                madeChange = true;
                inst = negInst;
            }
        }
    } else if (inst->getOpcode() == OP::FNEG || inst->getOpcode() == OP::FSUB) {
        if (canSub2Add(binary)) {
            auto negInst = sub2Add(binary, redoList);
            redoList.insert(inst);
            madeChange = true;
            inst = negInst;
        } else if (inst->getOpcode() == OP::FNEG) {
            auto lastUser = inst->getUseList().back()->getUser();
            if (getReassociableOp(std::dynamic_pointer_cast<FNEGInst>(inst)->getVal(), OP::FMUL) && inst->getUseList().size() != 1 || !getReassociableOp(lastUser, OP::FMUL)) {
                auto negInst = neg2Mul(inst);
                for (const auto &use : negInst->getUseList()) {
                    auto user = use->getUser();
                    if (auto user2binary = std::dynamic_pointer_cast<BinaryInst>(user)) {
                        redoList.insert(user2binary);
                    }
                }
                redoList.insert(inst);
                madeChange = true;
                inst = negInst;
            }
        }
    }

    // check inst is associative
    switch (inst->getOpcode()) {
    case OP::ADD:
    case OP::FADD:
    case OP::MUL:
    case OP::FMUL:
        return;
    default:
        break;
    }

    auto binaryInst = std::dynamic_pointer_cast<BinaryInst>(inst);
    auto opcode = binaryInst->getOpcode();
    auto lastUserInst = std::dynamic_pointer_cast<Instruction>(binaryInst->getUseList().back()->getUser());
    if (binaryInst->getUseList().size() == 1 && lastUserInst && lastUserInst->getOpcode() == opcode) {
        if (lastUserInst != binaryInst && binaryInst->getParent() == lastUserInst->getParent())
            redoList.insert(lastUserInst);
        return;
    }
    if (binaryInst->getUseList().size() == 1 && lastUserInst && binaryInst->getOpcode() == OP::ADD && lastUserInst->getOpcode() == OP::SUB)
        return;
    if (binaryInst->getUseList().size() == 1 && lastUserInst && binaryInst->getOpcode() == OP::FADD && lastUserInst->getOpcode() == OP::FSUB)
        return;
    reassociateExpression(binaryInst);
}

void ReassociateExpressionsPass::reassociateExpression(std::shared_ptr<BinaryInst> &inst) {
    std::vector<std::pair<std::shared_ptr<Value>, unsigned> > tree;
    madeChange |= linearizeExprTree(inst, tree, redoList);
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
    if (inst->getUseList().size() == 1) {
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

void ReassociateExpressionsPass::eraseInst(std::shared_ptr<Instruction> &inst) {
    //remove trivially dead
    std::vector<std::shared_ptr<Value> > ops;
    for (const auto &op : inst->getOperands()) {
        ops.emplace_back(op->getValue());
    }
    valueRankMap.erase(inst);
    redoList.erase(inst);
    auto bb = inst->getParent();
    bb->delFirstOfInst(inst); //the  inst is no used
    std::set<std::shared_ptr<Instruction> > visit;
    for (const auto &v : ops) {
        if (auto v2inst = std::dynamic_pointer_cast<Instruction>(v)) {
            auto opcode = v2inst->getOpcode();
            while (v2inst->getUseList().size() == 1 && std::dynamic_pointer_cast<Instruction>(v2inst->getUseList().back()->getUser())->getOpcode() == opcode && visit.insert(v2inst).second)
                v2inst = std::dynamic_pointer_cast<Instruction>(v2inst->getUseList().back()->getUser());
            if (valueRankMap.find(v2inst) != valueRankMap.end())
                redoList.insert(v2inst);
        }
    }
    madeChange = true;
}

void ReassociateExpressionsPass::recursivelyEraseDeadInsts(std::shared_ptr<Instruction> &inst, std::set<std::shared_ptr<Instruction> > &insts) {
    std::vector<std::shared_ptr<Value> > ops;
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

std::shared_ptr<Instruction> ReassociateExpressionsPass::canonicalizeNegFloat(std::shared_ptr<Instruction> &inst) {
    if (auto binary = std::dynamic_pointer_cast<BinaryInst>(inst)) {
        auto lhs = binary->getLHS();
        auto rhs = binary->getRHS();
        auto lhs2Inst = std::dynamic_pointer_cast<Instruction>(lhs);
        auto rhs2Inst = std::dynamic_pointer_cast<Instruction>(rhs);
        if (binary->getOpcode() == OP::FADD && rhs->getUseList().size() == 1) {
            //otherOp + subtree
            if (auto result = canonicalizeNegFloatOp(inst, rhs2Inst, lhs)) {
                inst = result;
            }
        } else if (binary->getOpcode() == OP::FADD && lhs->getUseList().size() == 1) {
            //subtree + otherOp
            if (auto result = canonicalizeNegFloatOp(inst, lhs2Inst, rhs)) {
                inst = result;
            }
        } else if (binary->getOpcode() == OP::FSUB && rhs->getUseList().size() == 1) {
            //othOp - subtree
            if (auto result = canonicalizeNegFloatOp(inst, rhs2Inst, lhs)) {
                inst = result;
            }
        }
    }
    return inst;
}

std::shared_ptr<Instruction> ReassociateExpressionsPass::canonicalizeNegFloatOp(std::shared_ptr<Instruction> &inst, std::shared_ptr<Instruction> &op, std::shared_ptr<Value> &v) {

    std::vector<std::shared_ptr<Instruction> > candi;

    std::shared_ptr<Value> i = op;
    getNegInsts(i, candi);
    if (candi.empty()) {
        return nullptr;
    }
    for (const auto &negFP : candi) {
        auto binary = std::dynamic_pointer_cast<BinaryInst>(negFP);
        auto lhs = binary->getLHS();
        auto rhs = binary->getRHS();
        if (lhs->getVTrait() == ValueTrait::CONSTANT_LITERAL && std::dynamic_pointer_cast<ConstantFloat>(lhs)->getVal() < 0.0f && rhs->getVTrait() != ValueTrait::CONSTANT_LITERAL) {
            binary->setLHS(func->getConstantPool().getConst(-std::dynamic_pointer_cast<ConstantFloat>(lhs)->getVal()));
            madeChange = true;
        }
        if (rhs->getVTrait() == ValueTrait::CONSTANT_LITERAL && std::dynamic_pointer_cast<ConstantFloat>(rhs)->getVal() < 0.0f && lhs->getVTrait() != ValueTrait::CONSTANT_LITERAL) {
            binary->setRHS(func->getConstantPool().getConst(-std::dynamic_pointer_cast<ConstantFloat>(rhs)->getVal()));
            madeChange = true;
        }
    }
    if (candi.size() % 2 == 0)
        return inst;
    std::shared_ptr<BinaryInst> newInst = nullptr;
    if (inst->getOpcode() == OP::FSUB) {
        newInst = std::make_shared<BinaryInst>(inst->getName(), OP::FSUB, v, op);
    }
    if (inst->getOpcode() == OP::FADD) {
        newInst = std::make_shared<BinaryInst>(inst->getName(), OP::FADD, v, op);

    }
    inst->getParent()->addInst(inst->index, newInst);
    inst->replaceSelf(newInst);
    redoList.insert(inst);
    return newInst;
}

bool ReassociateExpressionsPass::canSub2Add(const std::shared_ptr<BinaryInst> &sub) {
    if (sub->getOpcode() == OP::SUB && sub->getLHS() == func->getConstantPool().getConst(0))
        return false;
    auto lhs = sub->getLHS();
    auto rhs = sub->getRHS();
    if (getReassociableOp(lhs, OP::ADD, OP::FADD) || getReassociableOp(lhs, OP::SUB, OP::FSUB))
        return true;
    if (getReassociableOp(rhs, OP::ADD, OP::FADD) || getReassociableOp(rhs, OP::SUB, OP::FSUB))
        return true;
    if (sub->getUseList().size() == 1) {
        auto lastUserInst = std::dynamic_pointer_cast<Instruction>(sub->getUseList().back()->getUser());
        if (getReassociableOp(lastUserInst, OP::ADD, OP::FADD) || getReassociableOp(lastUserInst, OP::SUB, OP::FSUB)) {
            return true;
        }
    }
    return false;
}

std::shared_ptr<BinaryInst> ReassociateExpressionsPass::sub2Add(std::shared_ptr<BinaryInst> &sub, std::set<std::shared_ptr<Instruction> > &redo) {
    std::shared_ptr<BinaryInst> add;
    auto neg = negVal(sub->getRHS(), sub, redo);

    if (sub->getOpcode() == OP::SUB) {
        add = std::make_shared<BinaryInst>(sub->getName(), OP::SUB, sub->getLHS(), neg);

        sub->setLHS(func->getConstantPool().getConst(0));
        sub->setRHS(func->getConstantPool().getConst(0));

    } else if (sub->getOpcode() == OP::FSUB) {
        add = std::make_shared<BinaryInst>(sub->getName(), OP::FSUB, sub->getLHS(), neg);

        sub->setLHS(func->getConstantPool().getConst(0.0f));
        sub->setRHS(func->getConstantPool().getConst(0.0f));
    }
    sub->replaceSelf(add);
    return add;
}

std::shared_ptr<Value> ReassociateExpressionsPass::negVal(const std::shared_ptr<Value> &v, std::shared_ptr<BinaryInst> &binary, std::set<std::shared_ptr<Instruction> > &redo) {
if (v->getVTrait()==ValueTrait::CONSTANT_LITERAL) {
    if (auto Fp=std::dynamic_pointer_cast<ConstantFloat>(v)) {
        return func->getConstantPool().getConst(-Fp->getVal());
    }
        if (auto Int=std::dynamic_pointer_cast<ConstantInt>(v)) {
            return func->getConstantPool().getConst(-Int->getVal());
        }

}
    //-(x+y+z+1) -> -x + -y + -z + -1

    if (const auto &add = getReassociableOp(binary, OP::ADD, OP::FADD)) {
        add->setLHS(negVal(add->getLHS(), binary, redo));
        add->setRHS(negVal(add->getRHS(), binary, redo));
        binary->getParent()->addInst(binary->index - 1, add);

        redo.insert(add);

        return add;
    }
    for (const auto &use : v->getUseList()) {
        auto user = use->getUser();
        if (!std::dynamic_pointer_cast<FNEGInst>(user) || !(isNeg(std::dynamic_pointer_cast<BinaryInst>(user))))
            continue;
        auto theNeg=std::dynamic_pointer_cast<Instruction>(user);
    if (!theNeg||theNeg->getParent()->getParent()!=binary->getParent()->getParent())
        continue;

        //TODO insert negative into function base on inst /non inst
        redo.insert(theNeg);
        return theNeg;
    }
}

bool ReassociateExpressionsPass::isNeg(const std::shared_ptr<BinaryInst> &binary) const {
    auto lhs = binary->getLHS();

    if (binary->getOpcode() == OP::SUB && std::dynamic_pointer_cast<ConstantInt>(lhs) == func->getConstantPool().getConst(0)) {
        return true;
    }
    if (binary->getOpcode() == OP::FSUB && std::dynamic_pointer_cast<ConstantFloat>(lhs) == func->getConstantPool().getConst(0.0f)) {
        return true;
    }
    return false;
}

void ReassociateExpressionsPass::getNegInsts(std::shared_ptr<Value> &v, std::vector<std::shared_ptr<Instruction> > &candi) {
    if (v->getUseList().size() != 1 || !std::dynamic_pointer_cast<Instruction>(v))
        return;
    auto binary = std::dynamic_pointer_cast<BinaryInst>(v);
    auto lhs = binary->getLHS();
    auto rhs = binary->getRHS();
    switch (binary->getOpcode()) {
    case OP::FMUL:
        if (lhs->getVTrait() == ValueTrait::CONSTANT_LITERAL)
            break;
        if (std::dynamic_pointer_cast<ConstantFloat>(rhs)->getVal() < 0.0f) {
            candi.emplace_back(binary);
        }
        getNegInsts(lhs, candi);
        getNegInsts(rhs, candi);
        break;
    case OP::FDIV:
        if (lhs->getVTrait() == ValueTrait::CONSTANT_LITERAL && rhs->getVTrait() == ValueTrait::CONSTANT_LITERAL)
            break;
        if (std::dynamic_pointer_cast<ConstantFloat>(lhs)->getVal() < 0.0f || std::dynamic_pointer_cast<ConstantFloat>(rhs)->getVal() < 0.0f) {
            candi.emplace_back(binary);
        }
        getNegInsts(lhs, candi);
        getNegInsts(rhs, candi);
        break;
    default:
        break;
    }
}
}