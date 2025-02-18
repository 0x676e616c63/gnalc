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
class ReassociatePass : public PM::PassInfo<ReassociatePass> {
public:
    using Rank = unsigned int;
    static constexpr Rank NotRank = std::numeric_limits<Rank>::max();
    struct ValueEntry {
        std::shared_ptr<Value> op;
        Rank rank;
    };

    struct ExprTreeNode {
        using WeightT = size_t;
        std::shared_ptr<Value> value;
        WeightT weight;
    };
private:
    std::map<std::shared_ptr<Value>, Rank> valueRankMap;
    std::map<std::shared_ptr<BasicBlock>, Rank> bbRankMap;
    std::set<std::shared_ptr<Instruction>> redoSet;
    Function *func{};
    bool optModified{};
    size_t name_cnt = 0;

    Rank getRank(const std::shared_ptr<Value> &v);

    std::shared_ptr<Value> removeFactor(const std::shared_ptr<Value> &v, const std::shared_ptr<Value> &factor);

    std::shared_ptr<Value> optMul(const std::shared_ptr<BinaryInst> &binary,
                              std::vector<ValueEntry> &ops);

    std::shared_ptr<Value> optAdd(const std::shared_ptr<BinaryInst> &root,
                                  std::vector<ValueEntry> &ops);

    std::shared_ptr<Value> optExpr(const std::shared_ptr<BinaryInst> &root,
                               std::vector<ValueEntry> &ops);

    void rewriteExpr(const std::shared_ptr<BinaryInst> &root, std::vector<ValueEntry> &ops);

    std::vector<ExprTreeNode> analyzeExprTree(const std::shared_ptr<BinaryInst> &root);

    void reassociateExpression(const std::shared_ptr<BinaryInst> &inst);

    std::shared_ptr<BinaryInst> neg2mul(const std::shared_ptr<Instruction> &neg);

    std::shared_ptr<BinaryInst> canonNegFPImpl(const std::shared_ptr<BinaryInst> &inst,
    const std::shared_ptr<BinaryInst> &subtree, const std::shared_ptr<Value> &v);

    std::shared_ptr<BinaryInst> canonNegFP(const std::shared_ptr<BinaryInst> &binary);

    std::shared_ptr<Instruction> canonInst(const std::shared_ptr<Instruction>& inst);

    void optInst(const std::shared_ptr<Instruction> &inst);

    void reset();
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};
} // namespace IR
#endif //GNALC_IR_PASSES_TRANSFORMS_REASSOCIATE_EXPRESSIONS_HPP