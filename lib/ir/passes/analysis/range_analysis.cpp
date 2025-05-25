#include "ir/passes/analysis/range_analysis.hpp"

#include "ir/base.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/vector.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "utils/logger.hpp"

#include <string>
#include <deque>

namespace IR {
PM::UniqueKey RangeAnalysis::Key;

struct InstBBPairHash {
    using InstBBPair = std::pair<Instruction *, BasicBlock *>;
    size_t operator()(const InstBBPair &a) const {
        size_t hash = std::hash<Instruction *>{}(a.first);
        Util::hashSeedCombine(hash, std::hash<BasicBlock *>{}(a.second));
        return hash;
    }
};

void RangeAnalysis::analyzeArgument() {
    for (const auto &inst_user : func->inst_users()) {
        auto call = inst_user->as<CALLInst>();
        Err::gassert(call != nullptr);
        auto caller_func = call->getParent()->getParent();
        if (caller_func.get() != func) {
            const auto caller_res = fam->getResult<RangeAnalysis>(*caller_func);
            auto actual_args = call->getArgs();
            for (const auto &fp : func->getParams()) {
                if (fp->getType()->is<BType>()) {
                    auto btype = fp->getType()->as<BType>()->getInner();
                    if (btype == IRBTYPE::I32)
                        res.update(fp.get(), caller_res.getIntRange(actual_args[fp->getIndex()]));
                    else if (btype == IRBTYPE::FLOAT)
                        res.update(fp.get(), caller_res.getFloatRange(actual_args[fp->getIndex()]));
                    else
                        Err::unreachable();
                }
            }
        }
    }
}

void RangeAnalysis::analyzeGlobal() {
    auto bbdfv = func->getDFVisitor();

    std::deque<Instruction *> worklist;
    std::unordered_set<Instruction *> in_worklist;

    for (const auto &bb : bbdfv) {
        for (const auto &inst : *bb) {
            worklist.emplace_back(inst.get());
            in_worklist.emplace(inst.get());
        }
    }

    auto propagateToUsers = [&] (const Instruction * inst){
        for (const auto& user : inst->inst_users()) {
            if (!in_worklist.count(user.get())) {
                worklist.push_back(user.get());
                in_worklist.emplace(user.get());
            }
        }
    };

    auto updateInt = [&](Instruction* inst, const Range<int> &rng) {
       if (res.update(inst, rng))
           propagateToUsers(inst);
    };

    auto updateFloat = [&](Instruction* inst, const Range<float> &rng) {
        if (res.update(inst, rng))
           propagateToUsers(inst);
    };
    // Instructions
    while (!worklist.empty()) {
        auto inst = worklist.front();
        worklist.pop_front();

        bool is_btype = inst->getType()->is<BType>();
        bool is_int = is_btype && inst->getType()->as<BType>()->getInner() == IRBTYPE::I32;

        if (auto binary = inst->as_raw<BinaryInst>()) {
            if (is_int) {
                auto lrng = res.getIntRange(binary->getLHS());
                auto rrng = res.getIntRange(binary->getRHS());
                if (binary->getOpcode() == OP::ADD)
                    updateInt(binary, lrng + rrng);
                else if (binary->getOpcode() == OP::SUB)
                    updateInt(binary, lrng - rrng);
                else if (binary->getOpcode() == OP::MUL)
                    updateInt(binary, lrng * rrng);
                else if (binary->getOpcode() == OP::DIV)
                    updateInt(binary, lrng / rrng);
                else if (binary->getOpcode() == OP::REM)
                    updateInt(binary, lrng % rrng);
                else
                    Err::unreachable();
            } else {
                auto lrng = res.getFloatRange(binary->getLHS());
                auto rrng = res.getFloatRange(binary->getRHS());
                if (binary->getOpcode() == OP::FADD)
                    updateFloat(binary, lrng + rrng);
                else if (binary->getOpcode() == OP::FSUB)
                    updateFloat(binary, lrng - rrng);
                else if (binary->getOpcode() == OP::FMUL)
                    updateFloat(binary, lrng * rrng);
                else if (binary->getOpcode() == OP::FDIV)
                    updateFloat(binary, lrng / rrng);
                else if (binary->getOpcode() == OP::FREM)
                    updateFloat(binary, lrng % rrng);
                else
                    Err::unreachable();
            }
        } else if (auto fneg = inst->as_raw<FNEGInst>()) {
            const auto &vrng = res.getFloatRange(fneg->getVal());
            updateFloat(fneg, -vrng);
        } else if (auto fptosi = inst->as_raw<FPTOSIInst>()) {
            const auto &vrng = res.getFloatRange(fptosi->getOVal());
            updateInt(fptosi, Range(static_cast<int>(vrng.min), static_cast<int>(vrng.max)));
        } else if (auto sitofp = inst->as_raw<SITOFPInst>()) {
            const auto &vrng = res.getIntRange(sitofp->getOVal());
            updateFloat(sitofp, Range(static_cast<float>(vrng.min), static_cast<float>(vrng.max)));
        } else if (auto zext = inst->as_raw<ZEXTInst>()) {
            const auto &vrng = res.getIntRange(zext->getOVal());
            updateInt(zext, vrng);
        } else if (auto phi = inst->as_raw<PHIInst>()) {
            auto phi_opers = phi->getPhiOpers();
            if (is_int) {
                auto base = res.getIntRange(phi_opers[0].value);
                for (size_t i = 1; i < phi_opers.size(); i++)
                    base = merge(base, res.getIntRange(phi_opers[i].value));
                updateInt(phi, base);
            } else {
                auto base = res.getFloatRange(phi_opers[0].value);
                for (size_t i = 1; i < phi_opers.size(); i++)
                    base = merge(base, res.getFloatRange(phi_opers[i].value));
                updateFloat(phi, base);
            }
        } else if (auto select = inst->as_raw<SELECTInst>()) {
            if (is_int) {
                auto trng = res.getIntRange(select->getTrueVal());
                auto frng = res.getIntRange(select->getFalseVal());
                updateInt(select, merge(trng, frng));
            } else {
                auto trng = res.getFloatRange(select->getTrueVal());
                auto frng = res.getFloatRange(select->getFalseVal());
                updateFloat(select, merge(trng, frng));
            }
        } else if (auto call = inst->as_raw<CALLInst>()) {
            if (is_int && call->getFunc()->hasAttr(FuncAttr::PromoteFromChar))
                updateInt(call, Range<int>(0, 256));
            else {
                if (is_int)
                    updateInt(call, Range<int>());
                else
                    updateFloat(call, Range<float>());
            }
        } else if (auto gep = inst->as_raw<GEPInst>()) {
            auto idxs = gep->getIdxs();
            pType curr_type = gep->getBaseType();
            for (const auto &idx : idxs) {
                auto irng = res.getIntRange(idx);
                auto max_v = static_cast<int>(curr_type->as<ArrayType>()->getArraySize());
                if (auto idx_i = idx->as_raw<Instruction>())
                    updateInt(idx_i, intersect(irng, Range(0, max_v)));
            }
        } else if (inst->is<ICMPInst, FCMPInst>())
            updateInt(inst, Range<int>(0, 1));
        else if (inst->is<LOADInst, EXTRACTInst>()) {
            if (is_btype) {
                if (is_int)
                    updateInt(inst, Range<int>());
                else
                    updateFloat(inst, Range<float>());
            }
        }
    }
}

void RangeAnalysis::analyzeContextual() {
    auto& domtree = fam->getResult<DomTreeAnalysis>(*func);
    auto& pdomtree = fam->getResult<PostDomTreeAnalysis>(*func);

    std::vector<std::pair<Instruction*, BasicBlock*>> worklist;
    std::unordered_set<std::pair<Instruction*, BasicBlock*>, InstBBPairHash> in_worklist;

    auto propagateToDomUsers = [&] (Instruction * inst, BasicBlock* bb){
        for (const auto& user : inst->inst_users()) {
            if (!domtree.ADomB(bb, user->getParent().get()))
                continue;

            auto key = std::make_pair(user.get(), bb);
            if (!in_worklist.count(key)) {
                worklist.emplace_back(key);
                in_worklist.emplace(key);
            }
        }
    };
    auto updateContextualInt = [&](Instruction* inst, BasicBlock* bb, const Range<int> &rng) {
        if (res.update(inst, rng, bb))
            propagateToDomUsers(inst, bb);
    };

    auto updateContextualFloat = [&](Instruction* inst, BasicBlock* bb, const Range<float> &rng) {
        if (res.update(inst, rng, bb))
            propagateToDomUsers(inst, bb);
    };

    for (const auto& bb : *func) {
        auto rdf = pdomtree.getDomFrontier(bb);
        std::map<Value*, Range<int>> int_predicates;
        std::map<Value*, Range<float>> float_predicates;
        for (const auto& rdf_bb : rdf) {
            auto rdf_br = rdf_bb->getBRInst();
            Err::gassert(rdf_br && rdf_br->isConditional());

        }
    }
}


RangeResult RangeAnalysis::run(Function &function, FAM &manager) {
    func = &function;
    fam = &manager;

    analyzeArgument();
    analyzeGlobal();
    analyzeContextual();

    return res;
}
} // namespace IR