//
// Created by edragain on 2/12/25.
//
#include "../../../../include/ir/passes/transforms/reassociate_expressions.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

namespace IR {
std::shared_ptr<BinaryInst> isReassociableOp(const std::shared_ptr<Value>& v, OP opcode) {
    auto binary = std::dynamic_pointer_cast<BinaryInst>(v);
    if (binary && binary->getUseList().size() == 1 && binary->getOpcode() == opcode)
        //TODO float examine
        return binary;
    return nullptr;
}

std::shared_ptr<BinaryInst> isReassociableOp(const std::shared_ptr<Value>& v, OP opcode1, OP opcode2) {
    auto binary = std::dynamic_pointer_cast<BinaryInst>(v);
    if (binary && binary->getUseList().size() == 1 && (binary->getOpcode() == opcode1 || binary->getOpcode() == opcode2))
        //TODO float examine
        return binary;
    return nullptr;
}

PM::PreservedAnalyses ReassociateExpressionsPass::run(Function &function, FAM &manager) {

    auto postDomTree = manager.getResult<PostDomTreeAnalysis>(function);
    auto DFVisitor = postDomTree.getDFVisitor();
    auto FuncDFVisitor = function.getDFVisitor();
    //buildRankMap
    //assign different rank to params
    unsigned Rank = 2;
    for (const auto &param : function.getParams()) {
        valueRankMap[std::static_pointer_cast<Value>(param)] = ++Rank;
    }
    for (const auto &node : DFVisitor) {
        unsigned BBRank = RankMap[std::shared_ptr<BasicBlock>(node->bb)] = ++Rank << 16;
        for (const auto &inst : *node->bb) {

            if (inst->getOpcode() == OP::PHI || inst->getOpcode() == OP::CALL || inst->getOpcode() == OP::LOAD || inst->getOpcode() == OP::STORE || inst->getOpcode() == OP::STORE)
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
        Rank = std::max(Rank, getRank(inst->getOperands()[i]->getValue()));
    }
    return valueRankMap[inst] = Rank;
}

void ReassociateExpressionsPass::canonicalizeOperands(const std::shared_ptr<Instruction>& inst) {
    auto lhs = std::dynamic_pointer_cast<BinaryInst>(inst)->getLHS();
    auto rhs = std::dynamic_pointer_cast<BinaryInst>(inst)->getRHS();
    if (lhs == rhs || rhs->getVTrait() == ValueTrait::CONSTANT_LITERAL)
        return;
    if (lhs->getVTrait() == ValueTrait::CONSTANT_LITERAL || getRank(rhs) < getRank(lhs)) {
        std::dynamic_pointer_cast<BinaryInst>(inst)->swapLHSRHS();
    }
}

bool linearizeExprTree(const std::shared_ptr<Instruction>& inst, std::vector<std::pair<std::shared_ptr<Value>, unsigned> > &ops, std::vector<std::shared_ptr<Instruction> > &redo) {
    std::vector<std::pair<std::shared_ptr<Instruction>, unsigned> > worklist;
    auto opcode = inst->getOpcode();
    worklist.emplace_back(inst, 1);
    bool changed = false;
    std::map<std::shared_ptr<Value>, unsigned> leafMap;
    std::vector<std::shared_ptr<Value> > leaf;

    while (!worklist.empty()) {
        auto [Inst,Weight] = *worklist.rbegin();
        worklist.pop_back();
        for (const auto & use:Inst->getOperands()) {
            auto op = use->getValue();
            if (std::shared_ptr<BinaryInst> binary = isReassociableOp(op, opcode)) {
                worklist.emplace_back(std::static_pointer_cast<Instruction>(binary), Weight);
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
            //TODO suppurt negative
            leaf.emplace_back(op);
            leafMap[op] = Weight;
        }
    }
    for (const auto& v : leaf) {
        if (leafMap.find(v) == leafMap.end())
            continue;
        auto Weight = leafMap.find(v)->second;
        leafMap.find(v)->second = 0;
        ops.emplace_back(v, Weight);
    }
    if (ops.empty()) {
        //todo add identity
        //for example add/fadd identity ->0
        //mul/ful identity ->1
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
            auto  newlhs = ops[i].op;
            auto  newrhs = ops[i + 1].op;
           auto  oldlhs = Inst->getLHS();
            auto  oldrhs = Inst->getRHS();
            if (newlhs == oldlhs && newrhs == oldrhs)
                break;
            if (newlhs == oldrhs && newrhs == oldlhs) {
                Inst->swapLHSRHS();
                MadeChange = true;
                break;
            }
            if (newlhs != oldlhs) {
                auto binaryinst = isReassociableOp(oldlhs, opcode);
                if (binaryinst && not2rewrite.find(binaryinst) == not2rewrite.end())
                    node2rewrite.emplace_back(binaryinst);
                Inst->setLHS(newlhs);
            }
            if (newrhs != oldrhs) {
                auto binaryinst = isReassociableOp(oldrhs, opcode);
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
        if (newrhs != Inst->getRHS())
            if (newrhs == Inst->getLHS()) {
                Inst->swapLHSRHS();
            } else {
                auto bo = isReassociableOp(Inst->getRHS(), opcode);
                if (bo && not2rewrite.find(bo) == not2rewrite.end())

                    node2rewrite.emplace_back(bo);
                Inst->setRHS(newrhs);
                exprChangedStart = Inst;
                if (!exprChangedEnd)
                    exprChangedEnd = Inst;
                MadeChange = true;
            }
        if (auto binaryinst = isReassociableOp(Inst->getLHS(), opcode)) {
            if (not2rewrite.find(binaryinst) == not2rewrite.end())
                Inst = binaryinst;
            continue;
        }


        if (node2rewrite.empty()) {
            std::shared_ptr<BinaryInst> newInst;
            // create newbInst=std::make_shared<BinaryInst>(opcode,,)
            //TODO suppurt fpmath
            newInst = *node2rewrite.rbegin();
            node2rewrite.pop_back();
            Inst->setLHS(newInst);
            exprChangedStart = Inst;
            if (!exprChangedEnd)
                exprChangedEnd = Inst;
            MadeChange = true;
            Inst = newInst;
        }
        //TODO clean data
        for (const auto & binaryinst : node2rewrite) {
            redoList.emplace_back(binaryinst);
        }
    }
}
std::shared_ptr<Value> ReassociateExpressionsPass::removeFactorFromExpression(std::shared_ptr<Value>& v, const std::shared_ptr<Value>& factor) {
    auto binaryinst=isReassociableOp(v,OP::MUL,OP::FMUL);
    if (!binaryinst)
        return nullptr;
    std::vector<std::pair<std::shared_ptr<Value>,unsigned>> tree;
    MadeChange|=linearizeExprTree(binaryinst,tree,redoList);
    std::vector<ValueRank> Factors;
    Factors.reserve(tree.size());
    for (const auto& t:tree) {
        Factors.insert(Factors.end(),t.second,ValueRank(getRank(t.first),t.first));
    }
    bool canFactor=false;
    for (unsigned i=0;i<Factors.size();++i) {
        if (Factors[i].op==factor) {
            canFactor=true;
            Factors.erase(Factors.begin()+i);
        }

    }
    //todo remove negative version
    if (!canFactor) {
        RewriteExpr(binaryinst,Factors);
        return nullptr;
    }
    if (Factors.size()==1) {
        redoList.emplace_back(binaryinst);
        v=Factors[0].op;
    }
    else {
        RewriteExpr(binaryinst,Factors);
        v=binaryinst;
    }
    //todo support negative
    return v;
}
std::shared_ptr<Value> ReassociateExpressionsPass::optExpr(std::shared_ptr<BinaryInst> binary, std::vector<ValueRank> &ops) {
   //TODO
}
std::shared_ptr<Value> ReassociateExpressionsPass::optAdd(std::shared_ptr<Instruction> inst, std::vector<ValueRank> &ops) {
   //TODO
}
std::shared_ptr<Value> ReassociateExpressionsPass::optMul(std::shared_ptr<BinaryInst> binary, std::vector<ValueRank> &ops) {
    //TODO
}
}