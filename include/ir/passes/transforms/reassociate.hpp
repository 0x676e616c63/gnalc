// Reassociate commutative expressions
// Warning: this pass won't reassociate float operations
// Reference:
// https://llvm.org/doxygen/classllvm_1_1ReassociatePass.html
// https://llvm.org/doxygen/Reassociate_8cpp.html
// TODO: make it converge and simpler
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_REASSOCIATE_EXPRESSIONS_HPP
#define GNALC_IR_PASSES_TRANSFORMS_REASSOCIATE_EXPRESSIONS_HPP

#include "ir/instructions/binary.hpp"
#include "ir/passes/pass_manager.hpp"
#include "utils/fast_set.hpp"

#include <limits>

namespace IR {
class ReassociatePass : public PM::PassInfo<ReassociatePass> {
public:
    using Rank = unsigned int;
    static constexpr Rank NotRank = std::numeric_limits<Rank>::max();
    struct ValueEntry {
        pVal operand;
        Rank rank;
    };

    struct ExprTreeNode {
        using FreqT = size_t;
        pVal value;
        FreqT freq; // how many times this leaf occurs in the tree
    };

private:
    std::unordered_map<pVal, Rank> value_rank_map;
    std::unordered_map<pBlock, Rank> block_rank_map;
    Util::FastSet<pInst> redo_list;
    Function *func{};
    bool modified_in_opt{};
    size_t name_cnt = 0;

    Rank getRank(const pVal &v);

    pVal removeFactor(const pVal &v, const pVal &factor);

    pVal optMul(const pBinary &binary, std::vector<ValueEntry> &ops);

    pVal optAdd(const pBinary &root, std::vector<ValueEntry> &ops);

    pVal optExpr(const pBinary &root, std::vector<ValueEntry> &ops);

    void rewriteExpr(const pBinary &root, std::vector<ValueEntry> &ops);

    std::vector<ExprTreeNode> analyzeExprTree(const pBinary &root);

    void reassociate(const pBinary &inst);

    pBinary neg2mul(const pInst &neg);

    pInst canonInst(const pInst &inst);

    void optInst(const pInst &raw_inst);

    void reset();

public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};
} // namespace IR
#endif //GNALC_IR_PASSES_TRANSFORMS_REASSOCIATE_EXPRESSIONS_HPP