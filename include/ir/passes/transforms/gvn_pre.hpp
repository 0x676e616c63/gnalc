// GVN-PRE
//
// Note:
//       In our IR implementation, values, registers, and instructions form equivalent entities
//       through SSA form. In other words, a value and the register it is stored in are equivalent.
//
//             instruction == value == register
//
//       We have no `mov` in IR, and in fact we have no temporaries mentioned in the paper.
//       All the instructions are treated as expressions or blackbox registers.
//       Consequently, in this implementation, the TMP_GEN and PHI_GEN
//       mentioned in the paper are intentionally omitted.
//       (This is based on my own understanding. While initial testing shows correct redundancy elimination,
//        I am not very sure the correctness.)
//
// See:
//     - Thomas VanDrunen and Antony L. Hosking "Value-based Partial Redundancy Elimination":
//           https://link.springer.com/content/pdf/10.1007/978-3-540-24723-4_12.pdf
//           https://hosking.github.io/links/VanDrunen+2004CC.pdf  (same but with higher resolution)
//     - Optimizing SSA Code: GVN-PRE
//           blogpost: https://medium.com/@mikn/optimizing-ssa-code-gvn-pre-69de83e3be29
//           source: https://github.com/I-mikan-I/ssa-compiler
//     - LLVM:
//           GVN.cpp: https://github.com/llvm/llvm-project/blob/main/llvm/lib/Transforms/Scalar/GVN.cpp#L2911
//     - GCC:
//           GCC Wiki: https://gcc.gnu.org/wiki/GVN-PRE
//           tree-ssa-pre.cc: https://github.com/gcc-mirror/gcc/blob/master/gcc/tree-ssa-pre.cc
//
// TODO: Restrictions should be applied on hoisting to avoid excessive register pressure
// TODO: Load elimination? https://blog.llvm.org/2009/12/introduction-to-load-elimination-in-gvn.html
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_GVN_PRE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_GVN_PRE_HPP

#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../analysis/domtree_analysis.hpp"
#include "../pass_manager.hpp"

#include <algorithm>
#include <limits>

namespace IR {
class GVNPREPass : public PM::PassInfo<GVNPREPass> {
    using ValueKind = size_t;

    class Expr {
        friend std::ostream &operator<<(std::ostream &os, const Expr &expr);

    public:
        enum class ExprOp {
            // Binary
            Add,
            Sub,
            Mul,
            Div,
            Rem,

            // Cmp,
            // I was not sure whether we do this pass to cmp is effective or not.
            // Also, it might influence codegen.
            // Eq, Ne, Gt, Lt, Ge, Le,

            // Cast
            Fptosi,
            Sitofp,
            Zext,
            Bitcast,

            // Call
            PureFuncCall,

            // Getelementptr
            Gep,

            // Constant, GlobalVariable, FormalParam, Local array ALLOCAInst
            // They are available in all basic blocks.
            GlobalTemp,

            // Non-pure Function calls, Load
            // They can only be used in blocks where they are available.
            LocalTemp,

            // PHIInst, their ValueKind might be designated to its operands when inserting
            Phi,
        };

    private:
        pVal ir_value;
        std::vector<ValueKind> operands;
        ExprOp op;

    public:
        Expr(pVal irv, ExprOp op, std::vector<ValueKind> operands_ = {})
            : ir_value(std::move(irv)), op(op), operands(std::move(operands_)) {}

        void canon();

        ExprOp getExprOpcode() const;
        const std::vector<ValueKind> &getExprOperands() const;

        bool isGlobalTemp() const;
        bool isLocalTemp() const;
        bool isPhi() const;

        pVal getIRVal() const;

        static ExprOp makeOP(OP op);

        // static ExprOp makeOP(ICMPOP icmpop);
        //
        // static ExprOp makeOP(FCMPOP fcmpop);

        bool operator==(const Expr &rhs) const;
    };

    // For getKindOrInsert's error
    static constexpr ValueKind NotValueKind = std::numeric_limits<ValueKind>::max();

    class KindIRValSet {
        friend std::ostream &operator<<(std::ostream &os, const KindIRValSet &set);

        std::map<ValueKind, pVal> values;

    public:
        using const_iterator = decltype(values)::const_iterator;
        using iterator = decltype(values)::iterator;

        bool insert(ValueKind kind, const pVal &value) {
            Err::gassert(kind != NotValueKind);
            auto [it, inserted] = values.insert(std::make_pair(kind, value));
            return inserted;
        }

        bool update(ValueKind kind, const pVal &value) {
            bool modified = (values.find(kind) == values.end() || values[kind] != value);
            values[kind] = value;
            return modified;
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

        pVal getValue(ValueKind kind) const {
            Err::gassert(kind != NotValueKind);
            auto it = values.find(kind);
            if (it == values.end())
                return nullptr;
            return it->second;
        }

        const_iterator begin() const { return values.begin(); }
        const_iterator end() const { return values.end(); }
        iterator begin() { return values.begin(); }
        iterator end() { return values.end(); }
        const_iterator cbegin() const { return values.cbegin(); }
        const_iterator cend() const { return values.cend(); }
        auto size() const { return values.size(); }
        bool empty() const { return values.empty(); }

        bool operator==(const KindIRValSet &other) const {
            if (values.size() != other.values.size())
                return false;
            for (auto it1 = values.begin(), it2 = other.values.begin();
                 it1 != values.end() && it2 != other.values.end(); ++it1, ++it2) {
                if (it1->first != it2->first)
                    return false;
            }
            return true;
        }
        bool operator!=(const KindIRValSet &other) const { return !(*this == other); }
    };

    class KindExprSet;
    class KindExprSet {
        friend std::ostream &operator<<(std::ostream &os, const KindExprSet &set);
        std::vector<std::pair<ValueKind, Expr *>> values; // vector to keep topological sort
    public:
        using const_iterator = decltype(values)::const_iterator;
        using iterator = decltype(values)::iterator;

        bool insert(ValueKind kind, Expr *e) {
            Err::gassert(kind != NotValueKind);
            auto it = std::find_if(values.begin(), values.end(), [&kind](const auto &p) { return p.first == kind; });
            if (it == values.end()) {
                values.emplace_back(kind, e);
                return true;
            }
            return false;
        }

        bool contains(ValueKind kind) const {
            Err::gassert(kind != NotValueKind);
            return std::any_of(values.begin(), values.end(), [kind](const auto &v) { return v.first == kind; });
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
        bool empty() const { return values.empty(); }
        const_iterator begin() const { return values.begin(); }
        const_iterator end() const { return values.end(); }
        iterator begin() { return values.begin(); }
        iterator end() { return values.end(); }
        const_iterator cbegin() const { return values.cbegin(); }
        const_iterator cend() const { return values.cend(); }

        bool operator==(const KindExprSet &other) const {
            return std::is_permutation(values.begin(), values.end(), other.values.begin(), other.values.end(),
                                       [](const auto &a, const auto &b) { return a.first == b.first; });
        }
        bool operator!=(const KindExprSet &other) const { return !(*this == other); }
    };

    class NumberTable {
        friend std::ostream &operator<<(std::ostream &os, const NumberTable &table);
        std::vector<std::shared_ptr<Expr>> expr_pool;
        std::map<Expr *, ValueKind> expr_table;
        ValueKind kind_cnt = 0;
        bool too_deeply_nested_expr_detected = false;
        FAM* fam;

    public:
        bool should_quit_for_too_deeply_nested_expr() const { return too_deeply_nested_expr_detected; }

        void clear() {
            expr_table.clear();
            expr_pool.clear();
            kind_cnt = 0;
            too_deeply_nested_expr_detected = false;
            fam = nullptr;
        }

        void setFAM(FAM* fam_) {
            fam = fam_;
        }

        ValueKind getKindOrInsert(Expr *expr);

        ValueKind getKindOrInsert(const pVal &value, KindExprSet &exp_gen, size_t nested_expr_cnt = 0);
        Expr *getExprOrInsert(const pVal &inst, KindExprSet &exp_gen, size_t nested_expr_cnt = 0);

        void setPhiKind(const pPhi &inst, ValueKind kind);

        bool empty() const { return expr_table.empty(); }

    private:
        Expr *getExprFromPool(const std::shared_ptr<Expr> &item);
    };

    using LeaderSet = KindIRValSet;
    using AntiLeaderSet = KindExprSet;

    NumberTable table;

    // Since we won't delete or add blocks, use BasicBlock* is ok.

    // AVAIL_OUT = canon(AVAIL IN[b] ∪ PHI_GEN(b) ∪ TMP_GEN(b))
    std::map<BasicBlock *, LeaderSet> avail_out_map;

    // ANTIC_IN = clean(canon_expr(ANTIC_OUT[b] ∪ EXP_GEN[b] − TMP_GEN(b)))
    std::map<BasicBlock *, AntiLeaderSet> antic_in_map;

    // ANTIC_OUT
    std::map<BasicBlock *, AntiLeaderSet> antic_out_map;

    // EXP_GEN: temporaries and non-simple
    std::map<BasicBlock *, KindExprSet> exp_gen_map;

    // NEW_SET when inserting
    std::map<BasicBlock *, KindIRValSet> new_set_map;

    size_t name_cnt = 0;

    FAM* fam;
    DomTree* domtree;
    PostDomTree* postdomtree;

    std::map<BasicBlock *, KindIRValSet> phi_translate_map;
    pVal phi_translate(Expr *expr, BasicBlock *pred, BasicBlock *succ);

    void reset() {
        table.clear();
        avail_out_map.clear();
        antic_in_map.clear();
        antic_out_map.clear();
        exp_gen_map.clear();
        new_set_map.clear();
        phi_translate_map.clear();
        name_cnt = 0;
        fam = nullptr;
        domtree = nullptr;
        postdomtree = nullptr;
    }

    // For debug
    friend std::ostream &operator<<(std::ostream &os, const Expr &expr);
    friend std::ostream &operator<<(std::ostream &os, const NumberTable &table);
    friend std::ostream &operator<<(std::ostream &os, const KindIRValSet &set);
    friend std::ostream &operator<<(std::ostream &os, const KindExprSet &set);
    friend std::ostream &operator<<(std::ostream &os, const GVNPREPass &gvnpre);

public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};
} // namespace IR
#endif
