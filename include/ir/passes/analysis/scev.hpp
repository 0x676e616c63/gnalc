// Scalar Evolution
// This implementation only handles integers.
// See:
//   - "Fast Recognition of Scalar Evolutions on Three-Address SSA Code":
//       https://www.researchgate.net/profile/Georges-Andre-Silber/publication/267701684_Fast_Recognition_of_Scalar_Evolutions_on_Three-Address_SSA_Code/links/545e44ca0cf27487b44f08d0/Fast-Recognition-of-Scalar-Evolutions-on-Three-Address-SSA-Code.pdf
//   - "Induction Variable Analysis with Delayed Abstractions":
//       https://link.springer.com/content/pdf/10.1007/11587514_15.pdf
//   - "The SSA Representation Framework: Semantics, Analyses and GCC Implementation."
//       https://theses.hal.science/pastel-00002281/#:~:text=From%20a%20practical%20point%20of%20view%2C%20we%20present,an%20industrial%20compiler%3A%20the%20GNU%20Compiler%20Collection%20%28GCC%29.
//   - "Scalar evolution技术与i^n求和优化"
//       https://www.cnblogs.com/gnuemacs/p/14167695.html
#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_SCEV_HPP
#define GNALC_IR_PASSES_ANALYSIS_SCEV_HPP

#include "../../pattern_match.hpp"
#include "../pass_manager.hpp"
#include "domtree_analysis.hpp"
#include "loop_analysis.hpp"

#include <optional>

namespace IR {
class SCEVHandle;
enum class SCEVExprType { Value, Binary };
class SCEVExpr {
    friend std::ostream &operator<<(std::ostream &os, const SCEVExpr &expr);

public:
    struct Binary {
        enum class Op { Add, Sub, Mul };
        Op op;
        SCEVExpr *lhs;
        SCEVExpr *rhs;

        bool operator==(const Binary &other) const { return op == other.op && lhs == other.lhs && rhs == other.rhs; }
    };

private:
    std::variant<Value *, Binary> value;
    SCEVExprType type;

public:
    bool operator==(const SCEVExpr &other) const { return type == other.type && value == other.value; }
    explicit SCEVExpr(Value *ir_val) : value(ir_val), type(SCEVExprType::Value) {}
    explicit SCEVExpr(Binary::Op op, SCEVExpr *lhs, SCEVExpr *rhs)
        : type(SCEVExprType::Binary), value(Binary{op, lhs, rhs}) {}

    void setIRValue(Value *ir_val) { value = ir_val; }
    bool isIRValue() const { return type == SCEVExprType::Value; }
    bool isBinary() const { return type == SCEVExprType::Binary; }
    Value *getRawIRValue() const { return std::get<Value *>(value); }
    pVal getIRValue() const { return std::get<Value *>(value)->as<Value>(); }
    SCEVExpr *getLHS() const { return std::get<Binary>(value).lhs; }
    SCEVExpr *getRHS() const { return std::get<Binary>(value).rhs; }
    Binary::Op getOp() const { return std::get<Binary>(value).op; }
};
enum class TRECType { AddRec, Peeled, Expr, Undefined, Untracked };
// Tree of Recurrences
// Note that we do not support Periodic Evolution.
class TREC {
    friend std::ostream &operator<<(std::ostream &os, const TREC &expr);

public:
    struct AddRec {
        TREC *base;
        TREC *step;
        const Loop *loop;

        bool operator==(const AddRec &other) const {
            return base == other.base && step == other.step && loop == other.loop;
        }
    };

    struct Peeled {
        SCEVExpr *first; // No evolution in loop
        TREC *rest;
        const Loop* loop;

        bool operator==(const Peeled &other) const {
            return first == other.first && rest == other.rest && loop == other.loop;
        }
    };

private:
    TRECType type;
    std::variant<std::monostate, SCEVExpr *, AddRec, Peeled> value;

public:
    explicit TREC(TRECType type_) : type(type_) { Err::gassert(type != TRECType::Expr); }
    explicit TREC(SCEVExpr *scev_expr) : value(scev_expr), type(TRECType::Expr) {}

    explicit TREC(AddRec rec) : value(rec), type(TRECType::AddRec) {}
    explicit TREC(Peeled rec) : value(rec), type(TRECType::Peeled) {}

    static TREC undef() { return TREC(TRECType::Undefined); }
    static TREC untracked() { return TREC(TRECType::Untracked); }
    static TREC expr(SCEVExpr *i) { return TREC(i); }

    // For expr
    SCEVExpr *getExpr() const;

    // For AddRec
    TREC *getBase() const;
    TREC *getStep() const;

    // For PeeledTREC
    SCEVExpr *getFirst() const;
    TREC *getRest() const;

    // For AddRec and PeeledTREC
    const Loop *getLoop() const;

    bool isExpr() const;
    bool isAddRec() const;
    bool isPeeled() const;
    bool isUntracked() const;
    bool isUndef() const;

    bool operator==(const TREC &other) const { return type == other.type && value == other.value; }

    std::optional<std::tuple<SCEVExpr *, SCEVExpr *>> getAffineAddRec() const;
    std::optional<std::tuple<int, int>> getConstantAffineAddRec() const;
};
class SCEVHandle {
    friend class TREC;

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
    TREC *getSCEVAtBlock(const pVal &val, const std::shared_ptr<BasicBlock> &block);

    SCEVExpr *getNumberOfLatchExecutions(const Loop *loop);
    SCEVExpr *getNumberOfLatchExecutions(const pLoop &loop);

private:
    // Get SCEV of val at within the given scope.
    // the outermost scope ---> 'loop == nullptr'
    // Note that this is less safe than `getSCEVAtBlock` since it
    // has no check for whether the value is available.
    // TODO: Not safe so set it private. Should this be public?
    TREC *getSCEVAtScope(Value *val, const Loop *loop);

    // Input: l the current loop, n the definition of an SSA name
    // Output: TREC for the variable defined by n within l
    TREC *analyzeEvolution(const Loop *loop, Value *val);

    TREC *eval(TREC *trec, const Loop *loop);

    // Input: h the halting loop-phi, n the definition of an SSA name
    // Output: (exist, update), exist is true if h has been reached,
    //         update is the reconstructed expression for the overall effect in the loop of h
    std::pair<bool, TREC *> buildUpdateExpr(const PHIInst *loop_phi, Value *val, const Loop *loop_phi_loop);

    SCEVExpr *apply(TREC *trec, SCEVExpr *trip_cnt);

    // Input: trec a symbolic TREC, l the instantiation loop
    // Output: an instantiation of trec
    TREC *instantiateEvolution(TREC *trec, const Loop *loop);
    TREC *instantiateEvolutionImpl(TREC *trec, const Loop *loop, std::unordered_set<TREC *> &instantiated);

    TREC *getTRECUndef() const;
    TREC *getTRECUntracked() const;
    TREC *getPoolTREC(const std::shared_ptr<TREC> &trec);
    TREC *getExprTREC(SCEVExpr *expr);
    // Convenient wrapper for getSCEVExprTREC(getSCEVExpr(x))
    TREC *getIRValTREC(Value *x);
    TREC *getAddRecTREC(const Loop *loop, TREC *base, TREC *step);
    TREC *getPeeledTREC(const Loop *loop, SCEVExpr *first, TREC *rest);
    TREC *getTRECAdd(TREC *x, TREC *y);
    TREC *getTRECSub(TREC *x, TREC *y);
    TREC *getTRECMul(TREC *x, TREC *y);
    TREC *getTRECNeg(TREC *x);
    TREC *unifyPeeledTREC(TREC *peeled);
    void foldTREC(TREC *trec);

    SCEVExpr *getPoolSCEV(const std::shared_ptr<SCEVExpr> &expr);
    SCEVExpr *getSCEVExprAdd(SCEVExpr *x, SCEVExpr *y);
    SCEVExpr *getSCEVExprSub(SCEVExpr *x, SCEVExpr *y);
    SCEVExpr *getSCEVExprMul(SCEVExpr *x, SCEVExpr *y);
    SCEVExpr *getSCEVExprNeg(SCEVExpr *x);
    SCEVExpr *getSCEVExpr(int x);
    SCEVExpr *getSCEVExpr(Value *x);
    void foldSCEVExpr(SCEVExpr *expr) const;

    Function *function;
    LoopInfo *loop_info;
    DomTree *domtree;

    // cache for analyzeEvolution
    std::map<const Value *, TREC *> evolution;
    // cache for getSCEVAtScope
    std::map<const Loop *, std::map<const Value *, TREC *>> scoped_evolution;

    // We reserve 2 slots to get Undef/Untracked quickly
    // [0] for Undef, [1] for Untracked
    std::vector<std::shared_ptr<TREC>> trec_pool;

    std::vector<std::shared_ptr<SCEVExpr>> expr_pool;
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
