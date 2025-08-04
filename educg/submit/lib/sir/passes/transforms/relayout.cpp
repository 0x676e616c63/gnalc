// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/sir/passes/transforms/relayout.hpp"

#include "../../../../include/config/config.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/match.hpp"
#include "../../../../include/sir/passes/analysis/affine_alias_analysis.hpp"
#include "../../../../include/sir/utils.hpp"
#include "../../../../include/sir/visitor.hpp"

namespace SIR {

struct AccessInst {
    Instruction *inst;
    IList *ilist;
    LInstIter iter;
    ArrayAccess access;
};

struct TransposeCandidate {
    pVal base;
    std::vector<AccessInst> access_insts;
    int cost{}; // negative cost for profitable
    bool untracked{};
};

struct TransposeVisitor : ContextVisitor {
    using TransposeCandidates = std::unordered_map<Value *, TransposeCandidate>;
    TransposeCandidates *candidates;
    bool analyze_failed = false;

    MAM *mam{};
    AffineAAResult *affine_aa{};
    LinearFunction *func{};

    TransposeVisitor(TransposeCandidates *candidates_, MAM *mam_) : candidates(candidates_), mam(mam_) {}

    static int calculateCost(const ArrayAccess &access) {
        Err::gassert(access.indices.size() == 2, "Transpose what?");
        int cost = 0;

        const auto &outer = access.indices[0];
        const auto &inner = access.indices[1];

        // Assume i is the outer iv
        // a[i][j] -> cost = - 1 * 1 + 1 * 2 = 1
        // a[j][i] -> cost = - 1 * 2 + 1 * 1 = -1 (profitable)

        // For inner index, the lower iv depth, the faster the iv got changed, the less cost
        for (const auto &[ind, coe] : inner.coeffs)
            cost += coe * (ind->getDepth() + 1);

        for (const auto &[ind, coe] : outer.coeffs)
            cost -= coe * (ind->getDepth() + 1);

        return cost;
    }

    static void mergeCandidateInto(TransposeCandidate &dst, const TransposeCandidate &src) {
        Err::gassert(dst.base == src.base, "Merge what?");
        dst.cost += src.cost;
        dst.untracked |= src.untracked;
        dst.access_insts.insert(dst.access_insts.end(), src.access_insts.begin(), src.access_insts.end());
    }

    static bool isTransposable(Value *base) {
        pType type;
        if (auto gv = base->as<GlobalVariable>())
            type = gv->getVarType();
        else if (auto alloc = base->as<ALLOCAInst>())
            type = alloc->getBaseType();
        // Treat formal parameters as transposable since they won't
        // get transposed by themselves, but by merging into other bases.
        else if (auto fp = base->as<FormalParam>())
            return true;

        if (auto outer = type->as<ArrayType>()) {
            if (auto inner = outer->getElmType()->as<ArrayType>())
                return outer->getArraySize() == inner->getArraySize() && inner->getElmType()->is<BType>();
        }

        return false;
    }

    void visit(Context ctx, Instruction &inst) override {
        if (analyze_failed)
            return;

        if (inst.is<LOADInst, STOREInst>()) {
            const auto &aa = affine_aa->queryPointer(getMemLocation(&inst));
            if (!aa) {
                analyze_failed = true;
                return;
            }

            if (aa->isArray()) {
                auto &candidate = (*candidates)[aa->array().base];
                if (!isTransposable(aa->array().base) || aa->array().indices.size() != 2)
                    candidate.untracked = true;
                else {
                    candidate.access_insts.emplace_back(AccessInst{&inst, ctx.iList(), ctx.iter, aa->array()});
                    candidate.cost += calculateCost(aa->array());
                }
            }
        } else if (auto call = inst.as<CALLInst>()) {
            auto call_args = call->getArgs();
            auto callee_def = call->getFunc()->as<LinearFunction>().get();

            if (callee_def) {
                const auto &formal_params = callee_def->getParams();
                for (size_t i = 0; i < call_args.size(); i++) {
                    if (call_args[i]->getType()->is<PtrType>()) {
                        auto aa = affine_aa->queryPointer(call_args[i]);
                        if (!aa) {
                            analyze_failed = true;
                            return;
                        }
                        if (aa->isArray()) {
                            mergeCandidateInto((*candidates)[aa->array().base], (*candidates)[formal_params[i].get()]);
                        }
                    }
                }
            }
            // If not defined or recursive and not intrinsic, set them untracked.
            // Since we can't transpose all its uses.
            else if (!call->getFunc()->isIntrinsic()) {
                for (auto &arg : call_args) {
                    if (arg->getType()->is<PtrType>()) {
                        auto aa = affine_aa->queryPointer(arg);
                        if (!aa) {
                            analyze_failed = true;
                            return;
                        }
                        if (aa->isArray())
                            (*candidates)[aa->array().base].untracked = true;
                    }
                }
            }
        }

        ContextVisitor::visit(ctx, inst);
    }

    void visit(Module &module) {
        for (const auto &lfn : module.getLinearFunctions()) {
            func = lfn.get();
            auto &proxy = mam->getResult<LFAMProxy>(module);
            affine_aa = &proxy.getManager().getResult<AffineAliasAnalysis>(*func);
            func->accept(*this);
        }
        func = nullptr;
    }
};

// TODO: Tiling
struct TilingCandidate {};
struct TilingVisitor : ContextVisitor {};

PM::PreservedAnalyses RelayoutPass::run(Module &module, MAM &mam) {
    TransposeVisitor::TransposeCandidates candidates;
    TransposeVisitor visitor(&candidates, &mam);
    visitor.visit(module);

    if (visitor.analyze_failed || candidates.empty())
        return PreserveAll();

    AccessSynthesizer synthesizer(&module.getConstantPool());
    for (auto &[base, candidate] : candidates) {
        // Formal params are merged into caller's candidates
        if (candidate.untracked || base->is<FormalParam>())
            continue;

        if (candidate.cost >= -Config::SIR::RELAYOUT_TRANSPOSE_COST_THRESHOLD) {
            Logger::logDebug("[Relayout]: Canceled transposing '", base->getName(), "' due to the cost is too high. (",
                             candidate.cost, ").");
            continue;
        }

        for (auto &[inst, ilist, iter, access] : candidate.access_insts) {
            Err::gassert(access.indices.size() == 2, "Transpose what?");

            std::swap(access.indices[0], access.indices[1]);
            synthesizer.setInsertPoint(ilist, iter);
            auto gep = synthesizer.synthesize(access);
            if (auto ld = inst->as<LOADInst>())
                ld->setPtr(gep);
            else if (auto str = inst->as<STOREInst>())
                str->setPtr(gep);
            else
                Err::unreachable();
        }

        base->attr().getOrAdd<RelayoutAttrs>(RelayoutAttrs{RelayoutAttr::Transpose});
        Logger::logDebug("[Relayout]: Transposed '", base->getName(), "' with cost (", candidate.cost, ").");
    }

    return PreserveNone();
}

} // namespace SIR