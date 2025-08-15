// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Scalar Evolution
// This implementation only handles integers.
// FIXME: Potential Overflow.
// See:
//   - "Fast Recognition of Scalar Evolutions on Three-Address SSA Code":
//       https://www.researchgate.net/profile/Georges-Andre-Silber/publication/267701684_Fast_Recognition_of_Scalar_Evolutions_on_Three-Address_SSA_Code/links/545e44ca0cf27487b44f08d0/Fast-Recognition-of-Scalar-Evolutions-on-Three-Address-SSA-Code.pdf
//   - "Induction Variable Analysis with Delayed Abstractions":
//       https://link.springer.com/content/pdf/10.1007/11587514_15.pdf
//   - "The SSA Representation Framework: Semantics, Analyses and GCC Implementation."
//       https://theses.hal.science/pastel-00002281/
//   - "Scalar evolution技术与i^n求和优化"
//       https://www.cnblogs.com/gnuemacs/p/14167695.html
#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_SCEV_HPP
#define GNALC_IR_PASSES_ANALYSIS_SCEV_HPP

#include "domtree_analysis.hpp"
#include "ir/irbuilder.hpp"
#include "ir/passes/pass_manager.hpp"
#include "loop_analysis.hpp"
#include "range_analysis.hpp"

#include <optional>
#include <utility>

namespace IR {
class SCEVHandle;
enum class SCEVExprType { Value, Binary, Select, Icmp };
class SCEVExpr {
    friend std::ostream &operator<<(std::ostream &os, const SCEVExpr &expr);

public:
    struct Binary {
        enum class Op { Add, Sub, Mul, Div, AShr, LShr, Shl, And, Or, Xor, Pow };
        Op op;
        SCEVExpr *lhs;
        SCEVExpr *rhs;

        bool operator==(const Binary &other) const { return op == other.op && lhs == other.lhs && rhs == other.rhs; }
    };

    struct Icmp {
        ICMPOP cond;
        SCEVExpr *lhs;
        SCEVExpr *rhs;

        bool operator==(const Icmp &other) const { return cond == other.cond && lhs == other.lhs && rhs == other.rhs; }
    };

    struct Select {
        SCEVExpr *cond;
        SCEVExpr *lhs;
        SCEVExpr *rhs;

        bool operator==(const Select &other) const {
            return cond == other.cond && lhs == other.lhs && rhs == other.rhs;
        }
    };

private:
    std::variant<Value *, Binary, Icmp, Select> value;
    SCEVExprType type;

public:
    bool operator==(const SCEVExpr &other) const { return type == other.type && value == other.value; }
    explicit SCEVExpr(Value *ir_val) : value(ir_val), type(SCEVExprType::Value) { Err::gassert(ir_val != nullptr); }
    explicit SCEVExpr(Binary::Op op, SCEVExpr *lhs, SCEVExpr *rhs)
        : type(SCEVExprType::Binary), value(Binary{op, lhs, rhs}) {
        Err::gassert(lhs != nullptr && rhs != nullptr);
    }

    explicit SCEVExpr(ICMPOP cond, SCEVExpr *lhs, SCEVExpr *rhs)
        : type(SCEVExprType::Icmp), value(Icmp{cond, lhs, rhs}) {
        Err::gassert(lhs != nullptr && rhs != nullptr);
    }

    explicit SCEVExpr(SCEVExpr *cond, SCEVExpr *lhs, SCEVExpr *rhs)
        : type(SCEVExprType::Select), value(Select{cond, lhs, rhs}) {
        Err::gassert(cond != nullptr && lhs != nullptr && rhs != nullptr);
    }

    bool isIRValue() const { return type == SCEVExprType::Value; }
    bool isBinary() const { return type == SCEVExprType::Binary; }
    bool isSelect() const { return type == SCEVExprType::Select; }
    bool isIcmp() const { return type == SCEVExprType::Icmp; }

    Value *getRawIRValue() const { return std::get<Value *>(value); }
    pVal getIRValue() const { return std::get<Value *>(value)->as<Value>(); }

    SCEVExpr *getLHS() const { return std::get<Binary>(value).lhs; }
    SCEVExpr *getRHS() const { return std::get<Binary>(value).rhs; }
    Binary::Op getOp() const { return std::get<Binary>(value).op; }

    SCEVExpr* getSelCond() const { return std::get<Select>(value).cond; }
    SCEVExpr* getSelLHS() const { return std::get<Select>(value).lhs; }
    SCEVExpr* getSelRHS() const { return std::get<Select>(value).rhs; }

    ICMPOP getCmpCond() const { return std::get<Icmp>(value).cond; }
    SCEVExpr* getCmpLHS() const { return std::get<Icmp>(value).lhs; }
    SCEVExpr* getCmpRHS() const { return std::get<Icmp>(value).rhs; }
};
enum class TRECType { AddRec, MulRec, DivRec, Peeled, Expr, Undefined, Untracked };
// Tree of Recurrences
// Note that we do not support Periodic Evolution.
class TREC {
    friend std::ostream &operator<<(std::ostream &os, const TREC &expr);

public:
    struct Rec {
        TREC *base;
        TREC *step;
        const Loop *loop;

        bool operator==(const Rec &other) const {
            return base == other.base && step == other.step && loop == other.loop;
        }
    };

    struct Peeled {
        SCEVExpr *first; // No evolution in loop
        TREC *rest;
        const Loop *loop;

        bool operator==(const Peeled &other) const {
            return first == other.first && rest == other.rest && loop == other.loop;
        }
    };

private:
    TRECType type;
    std::variant<std::monostate, SCEVExpr *, Rec, Peeled> value;

public:
    explicit TREC(TRECType type_) : type(type_) { Err::gassert(type != TRECType::Expr); }
    explicit TREC(SCEVExpr *scev_expr) : value(scev_expr), type(TRECType::Expr) {}

    explicit TREC(Rec rec, TRECType ty) : value(rec), type(ty) {
        Err::gassert(ty == TRECType::AddRec || ty == TRECType::MulRec || ty == TRECType::DivRec);
    }
    explicit TREC(Peeled rec) : value(rec), type(TRECType::Peeled) {}

    static TREC undef() { return TREC(TRECType::Undefined); }
    static TREC untracked() { return TREC(TRECType::Untracked); }
    static TREC expr(SCEVExpr *i) { return TREC(i); }

    // TODO: Refactor interface

    // For expr
    SCEVExpr *getExpr() const;

    // For Rec
    TREC *getBase() const;
    TREC *getStep() const;

    // For PeeledTREC
    SCEVExpr *getFirst() const;
    TREC *getRest() const;

    // For Rec and PeeledTREC
    const Loop *getLoop() const;

    bool isExpr() const;
    bool isAddRec() const;
    bool isMulRec() const;
    bool isDivRec() const;
    bool isRec() const;
    bool isPeeled() const;
    bool isUntracked() const;
    bool isUndef() const;

    TRECType getType() const { return type; }

    bool operator==(const TREC &other) const { return type == other.type && value == other.value; }

    std::optional<std::tuple<SCEVExpr *, SCEVExpr *>> getAffineAddRec() const;
    std::optional<std::tuple<int, int>> getConstantAffineAddRec() const;
};
class SCEVHandle {
    friend class TREC;
    friend class SCEVSynthesizer;

public:
    SCEVHandle(Function *func, LoopInfo *loop_info_, DomTree *dom_tree)
        : function(func), loop_info(loop_info_), domtree(dom_tree) {
        // We reserve 2 slots to get Undef/Untracked quickly
        // [0] for Undef, [1] for Untracked
        trec_pool.emplace_back(std::make_shared<TREC>(TREC::undef()));
        trec_pool.emplace_back(std::make_shared<TREC>(TREC::untracked()));
    }

    // Get SCEV of val at the given block.
    // Note that if the value is not available at that block, nullptr will be returned.
    TREC *getSCEVAtBlock(Value *val, const BasicBlock *block);
    TREC *getSCEVAtBlock(const pVal &val, const pBlock &block);

    // Get SCEV of val at within the given scope.
    // the outermost scope ---> 'loop == nullptr'
    // Note that this is less safe than `getSCEVAtBlock` since it
    // has no check for whether the value is available.
    TREC *getSCEVAtScope(Value *val, const Loop *loop);
    TREC *getSCEVAtScope(const pVal &val, const pLoop &loop);

    // Get the exact value of the single backegde taken count
    // Nullptr is returned if there are multiple backegdes.
    SCEVExpr *getBackEdgeTakenCount(const Loop *loop, RangeResult *ranges = nullptr);
    SCEVExpr *getBackEdgeTakenCount(const pLoop &loop, RangeResult *ranges = nullptr);

    // Get the exact value of a loop's trip count (the execution times of the header)
    SCEVExpr *getTripCount(const Loop *loop, RangeResult *ranges = nullptr);
    SCEVExpr *getTripCount(const pLoop &loop, RangeResult *ranges = nullptr);

    void forgetAll();

    TREC *getTRECUndef() const;
    TREC *getTRECUntracked() const;
    TREC *getExprTREC(SCEVExpr *expr);
    // Convenient wrapper for getSCEVExprTREC(getSCEVExpr(x))
    TREC *getIRValTREC(Value *x);
    TREC *getRecTREC(TRECType type, const Loop *loop, TREC *base, TREC *step);
    TREC *getAddRecTREC(const Loop *loop, TREC *base, TREC *step);
    TREC *getMulRecTREC(const Loop *loop, TREC *base, TREC *step);
    TREC *getDivRecTREC(const Loop *loop, TREC *base, TREC *step);
    TREC *getPeeledTREC(const Loop *loop, SCEVExpr *first, TREC *rest);
    TREC *getTRECAdd(TREC *x, TREC *y);
    TREC *getTRECSub(TREC *x, TREC *y);
    TREC *getTRECMul(TREC *x, TREC *y);
    TREC *getTRECDiv(TREC *x, TREC *y);
    TREC *getTRECNeg(TREC *x);
    [[nodiscard]] TREC *unifyPeeledTREC(TREC *peeled);
    [[nodiscard]] TREC *foldTREC(TREC *trec);

    SCEVExpr *getSCEVExprAdd(SCEVExpr *x, SCEVExpr *y);
    SCEVExpr *getSCEVExprSub(SCEVExpr *x, SCEVExpr *y);
    SCEVExpr *getSCEVExprMul(SCEVExpr *x, SCEVExpr *y);
    SCEVExpr *getSCEVExprDiv(SCEVExpr *x, SCEVExpr *y);
    SCEVExpr *getSCEVExprAShr(SCEVExpr *x, SCEVExpr *y);
    SCEVExpr *getSCEVExprLShr(SCEVExpr *x, SCEVExpr *y);
    SCEVExpr *getSCEVExprShl(SCEVExpr *x, SCEVExpr *y);
    SCEVExpr *getSCEVExprAnd(SCEVExpr *x, SCEVExpr *y);
    SCEVExpr *getSCEVExprOr(SCEVExpr *x, SCEVExpr *y);
    SCEVExpr *getSCEVExprXor(SCEVExpr *x, SCEVExpr *y);
    SCEVExpr *getSCEVExprPow(SCEVExpr *x, SCEVExpr *y);
    SCEVExpr *getSCEVExprNeg(SCEVExpr *x);
    SCEVExpr *getSCEVExprIcmp(ICMPOP cond, SCEVExpr *x, SCEVExpr *y);
    SCEVExpr *getSCEVExprSelect(SCEVExpr *cond, SCEVExpr *x, SCEVExpr *y);
    SCEVExpr *getSCEVExpr(int x);
    SCEVExpr *getSCEVExpr(Value *x);
    [[nodiscard]] SCEVExpr *swapOperands(SCEVExpr *x);
    [[nodiscard]] SCEVExpr *foldSCEVExpr(SCEVExpr *expr);

private:
    TREC *getSCEVAtScopeImpl(Value *val, const Loop *loop);

    // Input: l the current loop, n the definition of an SSA name
    // Output: TREC for the variable defined by n within l
    TREC *analyzeEvolution(const Loop *loop, Value *val);

    TREC *eval(TREC *trec, const Loop *loop);

    // Input: h the halting loop-phi, n the definition of an SSA name
    // Output: (exist, update), exist is true if h has been reached,
    //         update is the reconstructed expression for the overall effect in the loop of h
    enum class UpdateExprType { LoopPhi, Expr, Add, Mul, Div, Unknown };
    std::tuple<bool, TREC *, UpdateExprType> buildUpdateExpr(const PHIInst *loop_phi, Value *val,
                                                             const Loop *loop_phi_loop);

    SCEVExpr *computeSymbolicBinomialCoefficient(SCEVExpr *n, int p);
    SCEVExpr *apply(TREC *trec, SCEVExpr *trip_cnt);

    // Input: trec a symbolic TREC, l the instantiation loop
    // Output: an instantiation of trec
    TREC *instantiateEvolution(TREC *trec, const Loop *loop);
    TREC *instantiateEvolutionImpl(TREC *trec, const Loop *loop, std::vector<std::unordered_set<TREC *>> &instantiated);

    TREC *getPoolTREC(const std::shared_ptr<TREC> &trec);
    SCEVExpr *getPoolSCEV(const std::shared_ptr<SCEVExpr> &expr);

    Function *function;
    LoopInfo *loop_info;
    DomTree *domtree;
    RangeResult *ranges;

    // cache for analyzeEvolution
    std::map<const Value *, TREC *> evolution;
    // cache for getSCEVAtScope
    std::map<const Loop *, std::map<const Value *, TREC *>> scoped_evolution;

    // We reserve 2 slots to get Undef/Untracked quickly
    // [0] for Undef, [1] for Untracked
    std::vector<std::shared_ptr<TREC>> trec_pool;

    std::vector<std::shared_ptr<SCEVExpr>> expr_pool;
};

class SCEVSynthesizer {
private:
    SCEVHandle *scev{};
    pBlock block;
    BasicBlock::iterator insert_point;
    ConstantPool *cpool{};
    RangeResult* ranges{};
    bool insert_point_valid;
    bool unchecked = false;

public:
    SCEVSynthesizer(pBlock block_, BasicBlock::iterator insert_before, SCEVHandle *scev_, ConstantPool *cpool_)
        : scev(scev_), block(std::move(block_)), insert_point(insert_before), cpool(cpool_),
          insert_point_valid(true) {}

    SCEVSynthesizer(SCEVHandle *scev_, ConstantPool *cpool_)
        : scev(scev_), cpool(cpool_), insert_point_valid(false) {}

    void setInsertPoint(const pBlock &block_, BasicBlock::iterator insert_before);
    void disableCheck();
    void withRanges(RangeResult* ranges);

    // Synthesize the SCEV Expression. Returns the synthesized IR Value.
    // If the expression contains loop invariant values that are not available
    // at that block, (i.e. the block is not dominated by the invariant's define block)
    // nullptr will be returned.
    pVal synthesizeExpr(SCEVExpr *expr);

    // Synthesize a on Loop.
    pPhi synthesizeRec(TREC *rec);

    // Estimates the number of instructions that would be generated during SCEV synthesis.
    // std::nullopt will be returned if the synthesis is not possible.
    // Note: This is a conservative (over-approximated) estimation
    //       since GVN-PRE may eliminate some redundant instructions.
    std::optional<size_t> estimateCost(SCEVExpr *expr, const pBlock &block);
    std::optional<size_t> estimateCost(TREC *addrec);

private:
    pVal synthesizeExprImpl(SCEVExpr *expr, std::map<SCEVExpr *, pVal> &inserted);
    std::optional<size_t> estimateCostImpl(SCEVExpr *expr, const pBlock &block, std::set<SCEVExpr *> &visited);
};

class SCEVAnalysis : public PM::AnalysisInfo<SCEVAnalysis> {
public:
    SCEVHandle run(Function &func, FAM &fam);

    // For PassManager
public:
    using Result = SCEVHandle;

private:
    friend AnalysisInfo<SCEVAnalysis>;
    static PM::UniqueKey Key;
};
} // namespace IR

#endif
