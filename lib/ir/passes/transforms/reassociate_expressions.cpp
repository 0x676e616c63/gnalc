//
// Created by edragain on 2/12/25.
//
#include "../../../../include/ir/passes/transforms/reassociate_expressions.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <limits>


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

std::shared_ptr<BinaryInst> ReassociateExpressionsPass::Neg2Mul(const std::shared_ptr<Instruction> &neg) {
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

std::shared_ptr<Value> makeAddTree(std::vector<std::weak_ptr<Value> > &ops, OP opcode,unsigned index,const std::shared_ptr<BasicBlock>& bb) {
    if (ops.size() == 1)
        return ops.back().lock();
    auto lhs = ops.back().lock();
    ops.pop_back();
    auto rhs = makeAddTree(ops, opcode,index,bb);
    auto binary=std::make_shared<BinaryInst>("makeAddTree", opcode, lhs, rhs);
    bb->addInst(index,binary);
    return binary;
}

PM::PreservedAnalyses ReassociateExpressionsPass::run(Function &function, FAM &manager) {
    func = &function;
    auto postDomTree = manager.getResult<PostDomTreeAnalysis>(function);
    auto DFVisitor = postDomTree.getDFVisitor();
    //buildRankMap
    //assign different rank to params
    unsigned Rank = 2;
    for (const auto &param : function.getParams()) {
        valueRankMap[std::static_pointer_cast<Value>(param)] = ++Rank;
    }
    for (const auto &node : DFVisitor) {
        unsigned BBRank = RankMap[std::shared_ptr<BasicBlock>(node->bb)] = ++Rank << 16;
        for (const auto &inst : *node->bb) {

            if (inst->getOpcode() == OP::PHI || inst->getOpcode() == OP::CALL || inst->getOpcode() == OP::LOAD || inst->getOpcode() == OP::STORE || inst->getOpcode() == OP::RET)
                valueRankMap[inst] = ++BBRank;
        }
    }
    //TODO
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
    unsigned maxRank = RankMap[inst->getParent()];
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

bool ReassociateExpressionsPass::linearizeExprTree(const std::shared_ptr<Instruction> &inst, std::vector<std::pair<std::shared_ptr<Value>, unsigned> > &ops, std::vector<std::shared_ptr<Instruction> > &redo) {
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
                auto mul = Neg2Mul(neg);
                workList.emplace_back(mul, Weight);
                for (const auto &USE : mul->getUseList()) {
                    auto user = USE->getUser();
                    if (auto binary = std::dynamic_pointer_cast<BinaryInst>(user))
                        redo.emplace_back(binary);
                }
                redo.emplace_back(neg);
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

void ReassociateExpressionsPass::RewriteExpr(const std::shared_ptr<BinaryInst> &binary, std::vector<ValueRank> &ops) {
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
                MadeChange = true;
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
            MadeChange = true;
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
                MadeChange = true;
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
        MadeChange = true;
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
        redoList.emplace_back(binaryinst);
    }
}

std::shared_ptr<Value> ReassociateExpressionsPass::removeFactorFromExpression(std::shared_ptr<Value> &v, const std::shared_ptr<Value> &factor) {
    auto binaryInst = getReassociableOp(v, OP::MUL, OP::FMUL);
    if (!binaryInst)
        return nullptr;
    std::vector<std::pair<std::shared_ptr<Value>, unsigned> > tree;
    MadeChange |= linearizeExprTree(binaryInst, tree, redoList);
    std::vector<ValueRank> Factors;
    Factors.reserve(tree.size());
    for (const auto &t : tree) {
        Factors.insert(Factors.end(), t.second, ValueRank(getRank(t.first), t.first));
    }
    bool canFactor = false;
    for (unsigned i = 0; i < Factors.size(); ++i) {
        if (Factors[i].op == factor) {
            canFactor = true;
            Factors.erase(Factors.begin() + i);
        }

    }
    //todo remove negative version
    if (!canFactor) {
        RewriteExpr(binaryInst, Factors);
        return nullptr;
    }
    if (Factors.size() == 1) {
        redoList.emplace_back(binaryInst);
        v = Factors[0].op;
    } else {
        RewriteExpr(binaryInst, Factors);
        v = binaryInst;
    }
    //todo support negative
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
                mul = std::make_shared<BinaryInst>("add2mul", OP::MUL, currOp, func->getConstantPool().getConst(float(repeatnumber)));
            } else
                mul = std::make_shared<BinaryInst>("add2fmul", OP::FMUL, currOp, func->getConstantPool().getConst(repeatnumber));
            //insert mul before binary
            binary->getParent()->addInst(binary->index - 1, mul);

            redoList.emplace_back(mul);

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
    for (const auto &op:ops) {

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
            v = makeAddTree(newMulOps, OP::ADD,binary->index-1,binary->getParent());
        else
            v = makeAddTree(newMulOps, OP::FADD,binary->index-1,binary->getParent());
        //try to deal with A*A*B+A*A*C->A*(A*B+A*C)->A*(A*(B+C)
        if (auto inst = std::dynamic_pointer_cast<Instruction>(v)) {
            redoList.emplace_back(inst);
        }
        std::shared_ptr<BinaryInst> mul;

        if (isInt)
            mul = std::make_shared<BinaryInst>("mul inst", OP::MUL, v, maxOccurrVal);
        else
            mul = std::make_shared<BinaryInst>("fmul inst", OP::FMUL, v, maxOccurrVal);
        //insert mul into bb
        binary->getParent()->addInst(binary->index-1,mul);
        redoList.emplace_back(mul);
        if (ops.empty())
            return mul;
        ops.insert(ops.begin(), ValueRank(getRank(mul), mul));
    }
    return nullptr;
}

std::shared_ptr<Value> ReassociateExpressionsPass::optMul(std::shared_ptr<BinaryInst> &binary, std::vector<ValueRank> &ops) {
    return nullptr;
}
void ReassociateExpressionsPass::ReassociateExpression(std::shared_ptr<BinaryInst> inst) {
    //TODO

}

}