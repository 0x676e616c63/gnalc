// Implementation of GVN-PRE
// See:
//     - Thomas VanDrunen and Antony L. Hosking "Value-based Partial Redundancy Elimination":
//           https://link.springer.com/content/pdf/10.1007/978-3-540-24723-4_12.pdf
//           https://hosking.github.io/links/VanDrunen+2004CC.pdf  (same but with higher resolution)
//    - Optimizing SSA Code: GVN-PRE
//           blogpost: https://medium.com/@mikn/optimizing-ssa-code-gvn-pre-69de83e3be29
//           source: https://github.com/I-mikan-I/ssa-compiler
//    - GCC
//           tree-ssa-pre.cc: https://github.com/gcc-mirror/gcc/blob/master/gcc/tree-ssa-pre.cc
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_GVN_PRE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_GVN_PRE_HPP

#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../pass_manager.hpp"

#include <algorithm>
#include <limits>

namespace IR {
class GVNPREPass : public PM::PassInfo<GVNPREPass> {
    using ValueKind = size_t;

    class Expr {
    public:
        enum class ExprOp {
            // Binary
            Add,
            Sub,
            Mul,
            Div,
            Rem,
            And,
            Or,
            Mod,
            // // Cmp
            // Eq,
            // Ne,
            // Gt,
            // Lt,
            // Ge,
            // Le,
            // Others
            Gep,
            Constant,
            Phi,
            UntrackedIRVal,
            // Unexpected
            UNEXPECTED
        };

    private:
        std::shared_ptr<Value> ir_value;
        std::vector<ValueKind> opreands;
        ExprOp op{ExprOp::UNEXPECTED};

    public:
        Expr(std::shared_ptr<Value> irv, ExprOp op, std::vector<ValueKind> operands_ = {})
            : ir_value(std::move(irv)), op(op), opreands(std::move(operands_)) {}

        void canon();

        const std::vector<ValueKind> &getOpers() const;

        bool isUntracked() const;

        std::shared_ptr<Value> getIRVal() const;

        static ExprOp makeOP(OP op);

        // static ExprOp makeOP(ICMPOP icmpop);
        //
        // static ExprOp makeOP(FCMPOP fcmpop);

        bool operator==(const Expr &rhs) const;
    };

    // For getKindOrInsert's error
    static constexpr ValueKind NotValueKind = std::numeric_limits<ValueKind>::max();

    class NumberTable {
        std::vector<std::shared_ptr<Expr>> expr_pool;
        std::map<Expr *, ValueKind> expr_table;
        ValueKind kind_cnt = 0;

    public:
        void clear();

        ValueKind getKindOrInsert(const std::shared_ptr<Value> &value);

        ValueKind getKindOrInsert(Expr *expr);

        Expr *getExprOrInsert(const std::shared_ptr<Value> &inst);
    };

    class KindTempSet {
        std::map<ValueKind, std::shared_ptr<Value>> values;

    public:
        using const_iterator = decltype(values)::const_iterator;
        using iterator = decltype(values)::iterator;

        bool insert(ValueKind kind, const std::shared_ptr<Value> &value) {
            Err::gassert(kind != NotValueKind);
            auto [it, inserted] = values.insert(std::make_pair(kind, value));
            return inserted;
        }

        bool contains(ValueKind kind) const {
            Err::gassert(kind != NotValueKind);
            return values.find(kind) != values.end();
        }

        bool erase(ValueKind kind) {
            Err::gassert(kind != NotValueKind);
            auto it = values.find(kind);
            if (it == values.end())
                return false;
            values.erase(it);
            return true;
        }

        std::shared_ptr<Value> getValue(ValueKind kind) const {
            Err::gassert(kind != NotValueKind);
            auto it = values.find(kind);
            if (it == values.end())
                return nullptr;
            return it->second;
        }

        const_iterator cbegin() const { return values.cbegin(); }
        const_iterator cend() const { return values.cend(); }
        iterator begin() { return values.begin(); }
        iterator end() { return values.end(); }
        auto size() const { return values.size(); }
    };

    class KindExprSet;
    static KindExprSet intersect(const KindExprSet &a, const KindExprSet &b);
    class KindExprSet {
        friend KindExprSet GVNPREPass::intersect(const KindExprSet &a, const KindExprSet &b);
        std::vector<std::pair<ValueKind, Expr*>> values; // vector to keep topological sort
    public:
        using const_iterator = decltype(values)::const_iterator;
        using iterator = decltype(values)::iterator;

        bool insert(ValueKind kind, Expr* e) {
            Err::gassert(kind != NotValueKind);
            auto it = std::find_if(values.begin(), values.end(),
                                   [&kind](const auto &p) { return p.first == kind; });
            if (it == values.end()) {
                values.emplace_back(kind, e);
                return true;
            }
            return false;
        }

        bool contains(ValueKind kind) const {
            Err::gassert(kind != NotValueKind);
            return std::any_of(values.begin(), values.end(),
                               [kind](const auto &v) { return v.first == kind; });
        }

        bool erase(ValueKind kind) {
            Err::gassert(kind != NotValueKind);
            for (auto it = values.begin(); it != values.end(); ++it) {
                if (it->first == kind) {
                    values.erase(it);
                    return true;
                }
            }
            return false;
        }

        size_t size() const { return values.size(); }

        const_iterator cbegin() const { return values.cbegin(); }
        const_iterator cend() const { return values.cend(); }
        iterator begin() { return values.begin(); }
        iterator end() { return values.end(); }
    };

    using LeaderSet = KindTempSet;
    using AntiLeaderSet = KindExprSet;
    using TempSet = std::set<std::shared_ptr<Value>>;

    NumberTable table;

    // Since we won't delete or add blocks, use BasicBlock* is ok.

    // AVAIL_OUT = canon(AVAIL IN[b] ∪ PHI_GEN(b) ∪ TMP_GEN(b))
    std::map<BasicBlock*, LeaderSet> avail_out_map;

    // ANTIC_IN = clean(canon_expr(ANTIC_OUT[b] ∪ EXP_GEN[b] − TMP_GEN(b)))
    std::map<BasicBlock*, AntiLeaderSet> antic_in_map;

    // PHI_GEN: temporaries that are defined by a phi
    std::map<BasicBlock*, KindTempSet> phi_gen_map;

    // EXP_GEN: temporaries and non-simple
    std::map<BasicBlock*, KindExprSet> exp_gen_map;

    // TMP_GEN: temporaries that are defined by non-phi instructions
    std::map<BasicBlock*, TempSet> tmp_gen_map;

    Expr* phi_translate(
        Expr* expr,
        BasicBlock* pred,
        BasicBlock* succ);

public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};
} // namespace IR
#endif
