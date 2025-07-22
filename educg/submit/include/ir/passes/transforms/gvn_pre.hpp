// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// GVN-PRE
//
// Note:
//       In our IR implementation, values, registers, and instructions form equivalent entities
//       through SSA form. In other words, a value and the register it is stored in are equivalent.
//
//             instruction == value == register
//
//       We have no `mov` in IR, all the instructions are treated as expressions or blackbox registers.
//       Consequently, in this implementation, the TMP_GEN and PHI_GEN mentioned in the paper
//       are intentionally omitted.
//
// See:
//     - Thomas VanDrunen and Antony L. Hosking "Value-based Partial Redundancy Elimination":
//           https://link.springer.com/content/pdf/10.1007/978-3-540-24723-4_12.pdf
//           https://hosking.github.io/links/VanDrunen+2004CC.pdf  (same but with higher resolution)
//     - Optimizing SSA Code: GVN-PRE
//           blogpost: https://medium.com/@mikn/optimizing-ssa-code-gvn-pre-69de83e3be29
//           source: https://github.com/I-mikan-I/ssa-compiler
//     - LLVM:
//           GVN.cpp: https://github.com/llvm/llvm-project/blob/main/llvm/lib/Transforms/Scalar/GVN.cpp
//     - GCC:
//           GCC Wiki: https://gcc.gnu.org/wiki/GVN-PRE
//
// TODO: Restrictions should be applied on hoisting to avoid excessive register pressure
// TODO: Load elimination? https://blog.llvm.org/2009/12/introduction-to-load-elimination-in-gvn.html
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_GVN_PRE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_GVN_PRE_HPP

#include "../../instructions/binary.hpp"
#include "../../instructions/compare.hpp"
#include "../../instructions/control.hpp"
#include "../analysis/domtree_analysis.hpp"
#include "../pass_manager.hpp"

#include <algorithm>
#include <limits>

namespace IR {
class GVNPREPass : public PM::PassInfo<GVNPREPass> {
    using ValueKind = size_t;

    class NumberTable;
    class Expr {
        friend class NumberTable;
        friend std::ostream &operator<<(std::ostream &os, const Expr &expr);

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
            Xor,
            Shl,
            LShr,
            AShr,

            // Cmp,
            // I was not sure whether we do this pass to cmp is effective or not.
            // Also, it might influence codegen.
            // Eq, Ne, Gt, Lt, Ge, Le,

            // Cast
            Fptosi,
            Sitofp,
            Zext,
            Sext,
            Bitcast,
            IntToPtr,
            PtrToInt,

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

            // PHIInst
            Phi,
        };

    private:
        Value *ir_value;
        std::vector<ValueKind> operands;
        ExprOp op;

    public:
        Expr(Value *irv, ExprOp op, std::vector<ValueKind> operands_ = {})
            : ir_value(std::move(irv)), op(op), operands(std::move(operands_)) {}

        void canon();

        ExprOp getExprOpcode() const;
        const std::vector<ValueKind> &getExprOperands() const;

        bool isGlobalTemp() const;
        bool isLocalTemp() const;
        bool isPhi() const;

        Value *getIRVal() const;

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

        std::unordered_map<ValueKind, Value *> values;

    public:
        using const_iterator = decltype(values)::const_iterator;
        using iterator = decltype(values)::iterator;

        bool insert(ValueKind kind, Value *value) {
            Err::gassert(kind != NotValueKind);
            auto [it, inserted] = values.insert(std::make_pair(kind, value));
            return inserted;
        }

        bool update(ValueKind kind, Value *value) {
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

        Value *getValue(ValueKind kind) const {
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
        std::unordered_set<ValueKind> kindset;

    public:
        using const_iterator = decltype(values)::const_iterator;
        using iterator = decltype(values)::iterator;

        bool insert(ValueKind kind, Expr *e) {
            Err::gassert(kind != NotValueKind);
            if (kindset.count(kind))
                return false;
            kindset.insert(kind);
            values.emplace_back(kind, e);
            return true;
        }

        bool contains(ValueKind kind) const {
            Err::gassert(kind != NotValueKind);
            return kindset.count(kind);
        }

        bool erase(ValueKind kind) {
            Err::gassert(kind != NotValueKind);
            if (!kindset.count(kind))
                return false;
            kindset.erase(kind);
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
        struct ExprHasher {
            size_t operator()(const std::shared_ptr<Expr> &expr) const { return Util::vectorHash(expr->operands); }
        };
        struct ExprCmp {
            bool operator()(const std::shared_ptr<Expr> &a, const std::shared_ptr<Expr> &b) const { return *a == *b; }
        };
        std::unordered_set<std::shared_ptr<Expr>, ExprHasher, ExprCmp> expr_pool;
        std::unordered_map<Value *, Expr *> get_expr_cache;
        std::unordered_map<Expr *, ValueKind> expr_table;
        ValueKind kind_cnt = 0;
        bool too_deeply_nested_expr_detected = false;
        FAM *fam;

    public:
        NumberTable() = default;
        bool shouldQuitForTooDeeplyNestedExpr() const { return too_deeply_nested_expr_detected; }

        void clear() {
            expr_table.clear();
            expr_pool.clear();
            get_expr_cache.clear();
            kind_cnt = 0;
            too_deeply_nested_expr_detected = false;
            fam = nullptr;
        }

        void setFAM(FAM *fam_) { fam = fam_; }

        ValueKind getKindOrInsert(Expr *expr);

        ValueKind getKindOrInsert(Value *value, KindExprSet &exp_gen, size_t nested_expr_cnt = 0);
        ValueKind getKindOrInsert(Value *value, size_t nested_expr_cnt = 0);
        Expr *getExprOrInsert(Value *inst, KindExprSet &exp_gen, size_t nested_expr_cnt = 0);
        Expr *getExprOrInsert(Value *inst, size_t nested_expr_cnt = 0);

        void setPhiKind(PHIInst *phi, ValueKind kind);

        bool empty() const { return expr_table.empty(); }

        void invalidateExprCache(Value *v);

    private:
        Expr *getExprFromPool(const std::shared_ptr<Expr> &item);
    };

    using LeaderSet = KindIRValSet;
    using AntiLeaderSet = KindExprSet;

    NumberTable table;

    // Since we won't delete or add blocks, use BasicBlock* is ok.

    // AVAIL_OUT = canon(AVAIL IN[b] ∪ PHI_GEN(b) ∪ TMP_GEN(b))
    std::unordered_map<BasicBlock *, LeaderSet> avail_out_map;

    // ANTIC_IN = clean(canon_expr(ANTIC_OUT[b] ∪ EXP_GEN[b] − TMP_GEN(b)))
    std::unordered_map<BasicBlock *, AntiLeaderSet> antic_in_map;

    // ANTIC_OUT
    std::unordered_map<BasicBlock *, AntiLeaderSet> antic_out_map;

    // EXP_GEN: temporaries and non-simple
    std::unordered_map<BasicBlock *, KindExprSet> exp_gen_map;

    // NEW_SET when inserting
    std::unordered_map<BasicBlock *, KindIRValSet> new_set_map;

    size_t name_cnt = 0;

    FAM *fam;
    DomTree *domtree;
    PostDomTree *postdomtree;

    std::unordered_map<BasicBlock *, KindIRValSet> phi_translate_map;
    using PhiTranslateKey = std::tuple<Expr *, BasicBlock *, BasicBlock *>;
    struct PhiTranslateKeyHasher {
        size_t operator()(const PhiTranslateKey &key) const {
            return std::hash<Expr *>()(std::get<0>(key)) ^ std::hash<BasicBlock *>()(std::get<1>(key)) ^
                   std::hash<BasicBlock *>()(std::get<2>(key));
        }
    };
    std::unordered_map<PhiTranslateKey, Value *, PhiTranslateKeyHasher> phi_translate_cache;
    void invalidatePhiTranslateCache();
    // Extend the lifetime of the temporaries generated by phiTranslate
    std::vector<pVal> phi_translate_gen;
    Value *phiTranslate(Expr *expr, BasicBlock *pred, BasicBlock *succ);

    void reset() {
        table.clear();
        avail_out_map.clear();
        antic_in_map.clear();
        antic_out_map.clear();
        exp_gen_map.clear();
        new_set_map.clear();
        phi_translate_map.clear();
        phi_translate_cache.clear();
        phi_translate_gen.clear();
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

    bool disable_PRE_on_non_empty_loop_backedge;
    // Disable PRE on loop backedge:
    // PRE on a backegde can let a rotated loop exits in the body. (See comments in `loop_rotate.hpp`)

    bool enable_debug_output;
public:
    explicit GVNPREPass(bool disable_PRE_on_loop_backedge_ = true, bool enable_debug_output_ = false)
        : table(), fam(nullptr), domtree(nullptr), postdomtree(nullptr),
          disable_PRE_on_non_empty_loop_backedge(disable_PRE_on_loop_backedge_), enable_debug_output(enable_debug_output_) {}
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};
} // namespace IR
#endif
