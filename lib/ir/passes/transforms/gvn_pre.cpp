#include "../../../../include/ir/passes/transforms/gvn_pre.hpp"

#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <algorithm>
#include <deque>

namespace IR {

using ValueKind = size_t;

class Expr {
public:
    enum class ExprOp {
        Add, Sub, Mul, Div, Rem,
        And, Or, Mod,
        Eq, Ne, Gt, Lt, Ge, Le,
        Gep,
        UNEXPECTED
    };
private:
    std::vector<ValueKind> opreands;
    ExprOp op{ExprOp::UNEXPECTED};

public:
    Expr(ExprOp op, std::vector<ValueKind> operands_)
    : op(op), opreands(std::move(operands_)) {}

    static ExprOp makeOP(OP op) {
        switch (op) {
        case OP::ADD:
        case OP::FADD:
            return ExprOp::Add;
        case OP::SUB:
        case OP::FSUB:
            return ExprOp::Sub;
        case OP::MUL:
        case OP::FMUL:
            return ExprOp::Mul;
        case OP::DIV:
        case OP::FDIV:
            return ExprOp::Div;
        case OP::REM:
        case OP::FREM:
            return ExprOp::Rem;
        case OP::AND:
            return ExprOp::And;
        case OP::OR:
            return ExprOp::Or;
        default:
            Err::unreachable("Unknown OP");
        }
        return ExprOp::UNEXPECTED;
    }

    static ExprOp makeOP(ICMPOP icmpop) {
        switch (icmpop) {
        case ICMPOP::eq:
            return ExprOp::Eq;
        case ICMPOP::ne:
            return ExprOp::Ne;
        case ICMPOP::sgt:
            return ExprOp::Gt;
        case ICMPOP::sge:
            return ExprOp::Ge;
        case ICMPOP::slt:
            return ExprOp::Lt;
        case ICMPOP::sle:
            return ExprOp::Le;
        }
        Err::unreachable("Unknown ICMPOP");
        return ExprOp::UNEXPECTED;
    }

    static ExprOp makeOP(FCMPOP fcmpop) {
        switch (fcmpop) {
        case FCMPOP::oeq:
            return ExprOp::Eq;
        case FCMPOP::one:
            return ExprOp::Ne;
        case FCMPOP::ogt:
            return ExprOp::Gt;
        case FCMPOP::oge:
            return ExprOp::Ge;
        case FCMPOP::olt:
            return ExprOp::Lt;
        case FCMPOP::ole:
            return ExprOp::Le;
        default:
            Err::unreachable("Unknown FCMPOP");
        }
        Err::unreachable("Unknown FCMPOP");
        return ExprOp::UNEXPECTED;
    }

    bool operator==(const Expr& rhs) const {
        return op == rhs.op && opreands == rhs.opreands;
    }
};

class NumberTable {
    using ValType = ValueKind;

    std::map<std::shared_ptr<Value>, ValueKind> value_table;
    std::map<std::shared_ptr<Expr>, ValueKind> expr_table;

    ValueKind kind_cnt = 0;

    // Values are held by BasicBlock and ConstantPool.
    // So make Expr held by a ExprPool.
    std::vector<std::shared_ptr<Expr>> expr_pool;

public:
    ValueKind getKind(const std::shared_ptr<Value>& value) {
        auto value_it = value_table.find(value);
        if (value_it != value_table.end())
            return value_it->second;

        if (value->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
            auto expr = getExpr(std::dynamic_pointer_cast<Instruction>(value));
            auto expr_it = expr_table.find(expr);
            if (expr_it != expr_table.end()) {
                value_table[value] = expr_it->second;
                return expr_it->second;
            }
            value_table[value] = kind_cnt;
            expr_table[expr] = kind_cnt;
            return kind_cnt++;
        }
        // Constant or PHI
        value_table[value] = kind_cnt;
        return kind_cnt++;
    }
private:
    std::shared_ptr<Expr> getExpr(const std::shared_ptr<Instruction>& inst) {
        std::shared_ptr<Expr> expr;
        const auto& raw_operands = inst->getOperands();
        std::vector<ValueKind> operands;

        std::transform(raw_operands.begin(), raw_operands.end(),
            std::back_inserter(operands),
            [this](const auto& use) { return getKind(use->getValue()); });

        if (auto binary = std::dynamic_pointer_cast<BinaryInst>(inst))
            expr = std::make_shared<Expr>(Expr::makeOP(binary->getOpcode()), std::move(operands));
        else if (auto icmp = std::dynamic_pointer_cast<ICMPInst>(inst))
            expr = std::make_shared<Expr>(Expr::makeOP(icmp->getCond()), std::move(operands));
        else if (auto fcmp = std::dynamic_pointer_cast<FCMPInst>(inst))
            expr = std::make_shared<Expr>(Expr::makeOP(fcmp->getCond()), std::move(operands));
        else if (auto gep = std::dynamic_pointer_cast<GEPInst>(inst))
            expr = std::make_shared<Expr>(Expr::ExprOp::Gep, std::move(operands));
        else
            Err::unreachable("NumberTable::makeExpr(): Unknown Instruction");

        for (const auto& r : expr_pool) {
            if (*r == *expr)
                return r;
        }

        expr_pool.emplace_back(expr);
        return expr;
    }
};

// Value-wise SET
// AVAIL_IN, AVAIL_OUT, ANTIC_IN, ANTIC_OUT, EXP_GEN, PHI_GEN
class ValueSet {
    friend ValueSet intersect(const ValueSet& a, const ValueSet& b);
    std::map<ValueKind, std::shared_ptr<Value>> values;
    public:
    using const_iterator = decltype(values)::const_iterator;
    using iterator = decltype(values)::iterator;

    void insert(ValueKind kind, const std::shared_ptr<Value>& value) {
        values.emplace(kind, value);
    }

    bool contains(ValueKind kind) const {
        return values.find(kind) == values.end();
    }

    bool erase(ValueKind kind) {
        auto it = values.find(kind);
        if (it == values.end())
            return false;
        values.erase(it);
        return true;
    }

    const_iterator cbegin() const { return values.cbegin(); }
    const_iterator cend() const { return values.cend(); }
    iterator begin() { return values.begin(); }
    iterator end() { return values.end(); }
};

ValueSet intersect(const ValueSet& a, const ValueSet& b) {
    ValueSet ret;

    // std::map's key type is const, and the pair's copy assignment operator is implicitly deleted in Clang.
    // See: https://stackoverflow.com/questions/52639887/clang-copy-assignment-operator-is-getting-deleted-while-using-stdmap-in-libc
    // std::set_intersection(a.cbegin(), a.cend(),
    // b.cbegin(), b.cend(), ret.begin(),
    // [](const auto& lhs, const auto& rhs) { return lhs.first < rhs.first; });

    // https://en.cppreference.com/w/cpp/algorithm/set_intersection
    auto it1 = a.cbegin(), it2 = b.cbegin();
    while (it1 != a.cend() && it2 != b.cend())
    {
        if (it1->first < it2->first)
            ++it1;
        else
        {
            if (it2->first >= it1->first)
                ret.insert(it1->first, it1->second); // it1->first and it2->first are equivalent.
            ++it2;
        }
    }
    return ret;
}

// Not Value-wise Vector
// TMP_GEN
class ValueVec {
    std::map<std::shared_ptr<Value>, ValueKind> values;
public:
    using const_iterator = decltype(values)::const_iterator;
    using iterator = decltype(values)::iterator;

    void insert(ValueKind kind, const std::shared_ptr<Value>& value) {
        values[value] = kind;
    }
    bool contains(ValueKind target) const {
        for (const auto& [_val, kind] : values) {
            if (target == kind)
                return true;
        }
        return false;
    }

    const_iterator cbegin() const { return values.cbegin(); }
    const_iterator cend() const { return values.cend(); }
    iterator begin() { return values.begin(); }
    iterator end() { return values.end(); }
};

using ValueSetMap = std::map<std::shared_ptr<BasicBlock>, ValueSet>;
using ValueVecMap = std::map<std::shared_ptr<BasicBlock>, ValueVec>;

std::shared_ptr<Value> phi_translate(
    const std::shared_ptr<Value>& value,
    const std::shared_ptr<BasicBlock>& curr,
    const std::shared_ptr<BasicBlock>& succ) {
    // TODO
    Err::todo("phi_translate");
    return nullptr;
}

PM::PreservedAnalyses GVNPREPass::run(Function &function, FAM &fam) {
    NumberTable table;

    ValueSetMap avail_out_map, // = canon(AVAIL IN[b] ∪ PHI GEN(b) ∪ TMP GEN(b))
                antic_in_map,  // = clean(canon_expr(ANTIC OUT[b] ∪ EXP GEN[b] − TMP GEN(b)))
                exp_gen_map,   // temporaries and non-simple
                phi_gen_map;   // temporaries that are defined by a phi
    ValueVecMap tmp_gen_map;   // temporaries that are defined by non-phi instructions

    //
    // Step 1 - BuildSets
    //

    // 1. Topdown traversal of the dominator tree.
    // Build AVAIL_OUT, EXP_GEN, PHI_GEN and TMP_GEN
    auto domtree = fam.getResult<DomTreeAnalysis>(function);
    std::deque worklist{ domtree.root };
    std::set<std::shared_ptr<DomTree::Node>> visited;
    visited.insert(domtree.root);
    while (!worklist.empty()) {
        auto curr = worklist.front();
        worklist.pop_front();
        visited.insert(curr);

        auto& avail_out = avail_out_map[curr->bb];
        auto& exp_gen = exp_gen_map[curr->bb];
        auto& phi_gen = phi_gen_map[curr->bb];
        auto& tmp_gen = tmp_gen_map[curr->bb];

        // inherit expressions from the dominator
        if (curr->parent)
            avail_out = avail_out_map[curr->parent->bb];

        for (const auto& inst : *curr->bb) {
            // PHI_GEN
            if (auto phi = std::dynamic_pointer_cast<PHIInst>(inst)) {
                auto kind = table.getKind(phi);
                phi_gen.insert(kind, phi);
                avail_out.insert(kind, inst);
            }
            // EXP_GEN
            else if (
                std::dynamic_pointer_cast<BinaryInst>(inst)
                || inst->getOpcode() == OP::ICMP
                || inst->getOpcode() == OP::FCMP
                || inst->getOpcode() == OP::GEP)
            {
                auto kind = table.getKind(inst);
                exp_gen.insert(kind, inst);
                for (const auto& use : inst->getOperands()) {
                    auto op_kind = table.getKind(use->getValue());
                    exp_gen.insert(op_kind, use->getValue());
                }
            }
            // TMP_GEN
            else if (inst->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                auto kind = table.getKind(inst);
                tmp_gen.insert(kind, inst);
                avail_out.insert(kind, inst);
            }
        }

        for (const auto& child : curr->children)
        {
            if (visited.find(child) == visited.end())
                worklist.emplace_back(child);
        }
    }

    // 2. Calculates flow sets to determine the antileader sets
    //    and conducts the fixed-point iteration
    // Build ANTIC_IN

    // Perform top-down traversals of the post-dominator tree
    // to help fast convergence since information flows backward over the CFG.
    auto postdomtree = fam.getResult<PostDomTreeAnalysis>(function);
    bool modified = true;
    while (modified) {
        modified = false;
        worklist = { postdomtree.root };
        visited.clear();
        while (!worklist.empty()) {
            auto curr = worklist.front();
            worklist.pop_front();
            visited.insert(curr);

            // First build ANTIC_OUT
            ValueSet antic_out;
            auto succ = curr->bb->getNextBB();
            if (succ.size() == 2) {
                // {e|e ∈ ANTIC_IN[succ_0(b)] ∧ ∀ b' ∈ succ(b), ∃ e' ∈ ANTIC_IN[b'] | lookup(e) = lookup(e') }
                // Since BRInst at most have 2 destinations, it is equivalent to
                // {e|e ∈ ANTIC_IN[succ_0(b)] ∧ ∃ e' ∈ ANTIC_IN[succ_1(b)] | lookup(e) = lookup(e') }
                // where `lookup` is `getKind` in our implementation
                const auto& succ0 = succ.front();
                const auto& succ1 = succ.back();
                antic_out = intersect(antic_in_map[succ0], antic_in_map[succ1]);
            }
            else if (succ.size() == 1) {
                // phi translate(A[succ(b)], b, succ(b))
                for (const auto& r : antic_in_map[succ.front()]) {
                    auto v = phi_translate(r.second, curr->bb, succ.front());
                    antic_out.insert(table.getKind(v), v);
                }
            }
            else Err::unreachable();

            // Then build ANTIC_IN
            // clean(canone(ANTIC OUT[b] ∪ EXP GEN[b] − TMP GEN(b)))

            auto& antic_in = antic_in_map[curr->bb];
            auto& exp_gen = exp_gen_map[curr->bb];
            auto& tmp_gen = tmp_gen_map[curr->bb];

            for (const auto& [kind, val] : antic_out)
                antic_in.insert(kind, val);

            for (const auto& [kind, val] : exp_gen)
                antic_in.insert(kind, val);

            for (const auto& [_val, kind] : tmp_gen)
                antic_in.erase(kind);

            for (const auto& child : curr->children)
            {
                if (visited.find(child) == visited.end())
                    worklist.emplace_back(child);
            }
        }
    }


    //
    // Step 2 - Insert
    //


    //
    // Step 3 - Eliminate
    //

    return PM::PreservedAnalyses::none(); // FIXME, not always none
}
} // namespace IR