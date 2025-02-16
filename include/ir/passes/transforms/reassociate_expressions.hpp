// Reference:
// https://llvm.org/doxygen/classllvm_1_1ReassociatePass.html
// https://llvm.org/doxygen/Reassociate_8cpp.html
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_REASSOCIATE_EXPRESSIONS_HPP
#define GNALC_IR_PASSES_TRANSFORMS_REASSOCIATE_EXPRESSIONS_HPP

#include "../pass_manager.hpp"
#include "../../../../include/ir/instructions/binary.hpp"


namespace IR {
struct ValueRank {
    std::shared_ptr<Value> op;
    unsigned rank;

    ValueRank(unsigned r, const std::shared_ptr<Value> &v): rank(r), op(v) {
    }
};

inline bool operator<(const ValueRank &lhs, const ValueRank &rhs) {
    return lhs.rank > rhs.rank;
}

struct Factor {
    std::shared_ptr<Value> base;
    unsigned power;

    Factor(const std::shared_ptr<Value> &b, unsigned p) : base(b), power(p) {
    }
};

class ReassociateExpressionsPass : public PM::PassInfo<ReassociateExpressionsPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);

    std::map<std::shared_ptr<Value>, unsigned> valueRankMap;
    std::map<std::shared_ptr<BasicBlock>, unsigned> RankMap;
    std::set<std::shared_ptr<Instruction> > redoList;

    struct PairMapValue {
        std::weak_ptr<Value> value1;
        std::weak_ptr<Value> value2;
        unsigned score;
        // bool isVaild() const{return value1!==nullptr&&value2!=nullptr;}
    };

    bool MadeChange;

    std::shared_ptr<BinaryInst> Neg2Mul(const std::shared_ptr<Instruction> &neg);

private:
    Function *func;

    unsigned getRank(const std::shared_ptr<Value> &v);

    void canonicalizeOperands(const std::shared_ptr<Instruction> &inst);

    void ReassociateExpression(std::shared_ptr<BinaryInst> &inst);

    void RewriteExpr(const std::shared_ptr<BinaryInst> &binary,
                     std::vector<ValueRank> &ops);

    void eraseInst(std::shared_ptr<Instruction> &inst);

    void RecursivelyEraseDeadInsts(std::shared_ptr<Instruction> &inst, std::set<std::shared_ptr<Instruction> > &insts);

    void optInst(std::shared_ptr<Instruction> &inst);
    void getNegInsts(std::shared_ptr<Value>& v,std::vector<std::shared_ptr<Instruction>>& candi);


    std::shared_ptr<Value> optExpr(std::shared_ptr<BinaryInst> &binary,
                                   std::vector<ValueRank> &ops);

    std::shared_ptr<Value> optAdd(const std::shared_ptr<BinaryInst> &binary,
                                  std::vector<ValueRank> &ops);

    std::shared_ptr<Value> optMul(std::shared_ptr<BinaryInst> &binary,
                                  std::vector<ValueRank> &ops);

    std::shared_ptr<Value> removeFactorFromExpression(std::shared_ptr<Value> &v, const std::shared_ptr<Value> &factor);

    std::shared_ptr<Value> negVal(const std::shared_ptr<Value> &v, std::shared_ptr<BinaryInst> &binary, std::set<std::shared_ptr<Instruction> > &redo);


    std::shared_ptr<Instruction> canonicalizeNegFloat(std::shared_ptr<Instruction> &inst);

    std::shared_ptr<Instruction> canonicalizeNegFloatOp(std::shared_ptr<Instruction> &inst, std::shared_ptr<Instruction> &op, std::shared_ptr<Value> &v);

    bool canSub2Add(const std::shared_ptr<BinaryInst> &inst);

    bool isNeg(const std::shared_ptr<BinaryInst> &binary) const;

    bool linearizeExprTree(const std::shared_ptr<Instruction> &inst, std::vector<std::pair<std::shared_ptr<Value>, unsigned> > &ops, std::set<std::shared_ptr<Instruction> > &redo);

    std::shared_ptr<BinaryInst> Sub2Add(std::shared_ptr<BinaryInst> &sub, std::set<std::shared_ptr<Instruction> > &redo);


};
}
#endif //GNALC_IR_PASSES_TRANSFORMS_REASSOCIATE_EXPRESSIONS_HPP