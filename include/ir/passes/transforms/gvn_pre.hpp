// Implementation of GVN-PRE
// See:
//     - Thomas VanDrunen and Antony L. Hosking "Value-based Partial Redundancy Elimination":
//           https://link.springer.com/content/pdf/10.1007/978-3-540-24723-4_12.pdf
//           https://hosking.github.io/links/VanDrunen+2004CC.pdf  (same but with higher resolution)
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_GVN_PRE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_GVN_PRE_HPP

#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../pass_manager.hpp"

#include <algorithm>

namespace IR {
class GVNPREPass : public PM::PassInfo<GVNPREPass> {
    using ValueKind = size_t;

    class Expr {
    public:
        enum class ExprOp {
            Add,
            Sub,
            Mul,
            Div,
            Rem,
            And,
            Or,
            Mod,
            Eq,
            Ne,
            Gt,
            Lt,
            Ge,
            Le,
            Gep,
            UNEXPECTED
        };

    private:
        std::vector<ValueKind> opreands;
        ExprOp op{ExprOp::UNEXPECTED};

    public:
        Expr(ExprOp op, std::vector<ValueKind> operands_)
            : op(op), opreands(std::move(operands_)) {}

        static ExprOp makeOP(OP op);

        static ExprOp makeOP(ICMPOP icmpop);

        static ExprOp makeOP(FCMPOP fcmpop);

        bool operator==(const Expr &rhs) const;
    };

    static bool isExpr(const std::shared_ptr<Value>& v);

    class NumberTable {
        std::map<std::shared_ptr<Value>, ValueKind> value_table;
        std::map<std::shared_ptr<Expr>, ValueKind> expr_table;

        ValueKind kind_cnt = 0;

        // Values are held by BasicBlock and ConstantPool.
        // So make Expr held by a ExprPool.
        std::vector<std::shared_ptr<Expr>> expr_pool;

    public:
        ValueKind getKind(const std::shared_ptr<Value>& value);

    private:
        std::shared_ptr<Expr> getExpr(const std::shared_ptr<Instruction>& inst);
    };

    // Value-wise SET
    class ValueSet {
        friend ValueSet intersect(const ValueSet& a, const ValueSet& b);
        // Use std::vector to keep the topological sort
        std::vector<std::pair<ValueKind, std::shared_ptr<Value>>> values;
    public:
        using const_iterator = decltype(values)::const_iterator;
        using iterator = decltype(values)::iterator;

        void insert(ValueKind kind, const std::shared_ptr<Value>& value) {
            values.emplace_back(kind, value);
        }

        bool contains(ValueKind kind) const {
            return std::any_of(values.begin(), values.end(),
                [kind](const auto& v) { return v.first == kind; });
        }

        bool erase(ValueKind kind) {
            for (auto it = values.begin(); it != values.end(); ++it) {
                if (it->first == kind) {
                    values.erase(it);
                    return true;
                }
            }
            return false;
        }

        std::shared_ptr<Value> getValue(ValueKind kind) const {
            for (const auto& v : values) {
                if (v.first == kind)
                    return v.second;
            }
            return nullptr;
        }

        const_iterator cbegin() const { return values.cbegin(); }
        const_iterator cend() const { return values.cend(); }
        iterator begin() { return values.begin(); }
        iterator end() { return values.end(); }
        auto size() const { return values.size(); }
    };

    static ValueSet intersect(const ValueSet& a, const ValueSet& b);

    // Not Value-wise Vector
    class ValueVec {
        std::vector<std::pair<ValueKind, std::shared_ptr<Value>>> values;
    public:
        using const_iterator = decltype(values)::const_iterator;
        using iterator = decltype(values)::iterator;

        void insert(ValueKind kind, const std::shared_ptr<Value>& value) {
            values.emplace_back(kind, value);
        }

        bool contains(ValueKind kind) const {
            return std::any_of(values.begin(), values.end(),
                [kind](const auto& v) { return v.first == kind; });
        }

        const_iterator cbegin() const { return values.cbegin(); }
        const_iterator cend() const { return values.cend(); }
        iterator begin() { return values.begin(); }
        iterator end() { return values.end(); }
    };

    using ValueSetMap = std::map<std::shared_ptr<BasicBlock>, ValueSet>;
    using ValueVecMap = std::map<std::shared_ptr<BasicBlock>, ValueVec>;

    NumberTable table;

    ValueSetMap avail_out_map, // = canon(AVAIL IN[b] ∪ PHI_GEN(b) ∪ TMP_GEN(b))
                antic_in_map,  // = clean(canon_expr(ANTIC_OUT[b] ∪ EXP_GEN[b] − TMP_GEN(b)))
                exp_gen_map;   // temporaries and non-simple
    ValueVecMap phi_gen_map,   // temporaries that are defined by a phi
                tmp_gen_map;   // temporaries that are defined by non-phi instructions

    std::tuple<ValueKind, std::shared_ptr<Value>> phi_translate(
    const std::shared_ptr<Value>& value,
    const std::shared_ptr<BasicBlock>& pred,
    const std::shared_ptr<BasicBlock>& succ);
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};
} // namespace IR
#endif
