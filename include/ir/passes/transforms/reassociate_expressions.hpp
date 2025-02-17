// Reassociate commutative expressions
// Reference:
// https://llvm.org/doxygen/classllvm_1_1ReassociatePass.html
// https://llvm.org/doxygen/Reassociate_8cpp.html
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_REASSOCIATE_EXPRESSIONS_HPP
#define GNALC_IR_PASSES_TRANSFORMS_REASSOCIATE_EXPRESSIONS_HPP

#include "../../../../include/ir/instructions/binary.hpp"
#include "../pass_manager.hpp"

#include <limits>

namespace IR {
class ReassociateExpressionsPass : public PM::PassInfo<ReassociateExpressionsPass> {
public:
    using Rank = unsigned int;
    static constexpr Rank NotRank = std::numeric_limits<Rank>::max();
    struct ValueRank {
        std::shared_ptr<Value> op;
        Rank rank;

        ValueRank(Rank r, const std::shared_ptr<Value> &v) : rank(r), op(v) {}
    };

    bool operator<(const ValueRank &lhs, const ValueRank &rhs) {
        return lhs.rank > rhs.rank;
    }

    struct Factor {
        std::shared_ptr<Value> base;
        Rank power;

        Factor(const std::shared_ptr<Value> &b, Rank p) : base(b), power(p) {
        }
    };

    struct PairMapValue {
        std::weak_ptr<Value> value1;
        std::weak_ptr<Value> value2;
        Rank score;
        // bool isVaild() const{return value1!==nullptr&&value2!=nullptr;}
    };

    struct LinearizedNode {
        using WeightT = size_t;

        std::shared_ptr<Value> value;
        WeightT weight;
    };

private:
    std::map<std::shared_ptr<Value>, Rank> valueRankMap;
    std::map<std::shared_ptr<BasicBlock>, Rank> bbRankMap;
    std::set<std::shared_ptr<Instruction>> redoList;
    Function *func{};
    bool optModified{};
    size_t name_cnt = 0;

    std::shared_ptr<BinaryInst> canonNegFPImpl(const std::shared_ptr<BinaryInst> &inst,
        const std::shared_ptr<BinaryInst> &subtree, const std::shared_ptr<Value> &v);
    std::shared_ptr<BinaryInst> canonNegFP(const std::shared_ptr<BinaryInst> &binary);
    std::shared_ptr<Instruction> ReassociateExpressionsPass::canonInst(const std::shared_ptr<Instruction>& inst);

    std::shared_ptr<BinaryInst> neg2Mul(const std::shared_ptr<Instruction> &neg);

    Rank getRank(const std::shared_ptr<Value> &v);

    void reassociateExpression(const std::shared_ptr<BinaryInst> &inst);

    void rewriteExpr(const std::shared_ptr<BinaryInst> &binary,
                     std::vector<ValueRank> &ops);

    void eraseInst(const std::shared_ptr<Instruction> &inst);

    void recursivelyEraseDeadInsts(const std::shared_ptr<Instruction> &inst, std::set<std::shared_ptr<Instruction>> &insts);

    void optInst(const std::shared_ptr<Instruction> &inst);

    std::shared_ptr<Value> optExpr(const std::shared_ptr<BinaryInst> &binary,
                                   std::vector<ValueRank> &ops);

    std::shared_ptr<Value> optAdd(const std::shared_ptr<BinaryInst> &binary,
                                  std::vector<ValueRank> &ops);

    std::shared_ptr<Value> optMul(const std::shared_ptr<BinaryInst> &binary,
                                  std::vector<ValueRank> &ops);

    std::shared_ptr<Value> removeFactorFromExpression(const std::shared_ptr<Value> &v, const std::shared_ptr<Value> &factor);

    std::shared_ptr<Value> negate(const std::shared_ptr<Value> &v, const std::shared_ptr<BinaryInst> &neg_pos);

    bool linearizeExprTree(const std::shared_ptr<BinaryInst> &root, std::vector<LinearizedNode> &ops);

public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};
} // namespace IR
#endif //GNALC_IR_PASSES_TRANSFORMS_REASSOCIATE_EXPRESSIONS_HPP