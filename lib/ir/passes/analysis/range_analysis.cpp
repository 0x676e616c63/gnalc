#include "ir/passes/analysis/range_analysis.hpp"

#include "ir/base.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/vector.hpp"
#include "ir/passes/analysis/live_analysis.hpp"
#include "utils/logger.hpp"

#include <string>

namespace IR {
PM::UniqueKey RangeAnalysis::Key;

RangeResult RangeAnalysis::run(Function &func, FAM &fam) {
    RangeResult res;
    // Initialize Range
    auto bbdfv = func.getDFVisitor();

    // Argument
    for (const auto &inst_user : func.inst_users()) {
        auto call = inst_user->as<CALLInst>();
        Err::gassert(call != nullptr);
        auto caller_func = call->getParent()->getParent();
        if (caller_func.get() != &func) {
            const auto caller_res = fam.getResult<RangeAnalysis>(*caller_func);
            auto actual_args = call->getArgs();
            for (const auto &fp : func.getParams()) {
                if (fp->getType()->is<BType>()) {
                    auto btype = fp->getType()->as<BType>()->getInner();
                    if (btype == IRBTYPE::I32)
                        res.update(fp, caller_res.getIntRange(actual_args[fp->getIndex()]));
                    else if (btype == IRBTYPE::FLOAT)
                        res.update(fp, caller_res.getFloatRange(actual_args[fp->getIndex()]));
                    else
                        Err::unreachable();
                }
            }
        }
    }

    // Instructions
    for (const auto &bb : bbdfv) {
        for (const auto &inst : *bb) {
            bool is_btype = inst->getType()->is<BType>();
            bool is_int = is_btype && inst->getType()->as<BType>()->getInner() == IRBTYPE::I32;

            if (auto binary = inst->as<BinaryInst>()) {
                if (is_int) {
                    auto lrng = res.getIntRange(binary->getLHS());
                    auto rrng = res.getIntRange(binary->getRHS());
                    if (binary->getOpcode() == OP::ADD)
                        res.update(binary, lrng + rrng);
                    else if (binary->getOpcode() == OP::SUB)
                        res.update(binary, lrng - rrng);
                    else if (binary->getOpcode() == OP::MUL)
                        res.update(binary, lrng * rrng);
                    else if (binary->getOpcode() == OP::DIV)
                        res.update(binary, lrng / rrng);
                    else if (binary->getOpcode() == OP::REM)
                        res.update(binary, lrng % rrng);
                    else
                        Err::unreachable();
                } else {
                    auto lrng = res.getFloatRange(binary->getLHS());
                    auto rrng = res.getFloatRange(binary->getRHS());
                    if (binary->getOpcode() == OP::FADD)
                        res.update(binary, lrng + rrng);
                    else if (binary->getOpcode() == OP::FSUB)
                        res.update(binary, lrng - rrng);
                    else if (binary->getOpcode() == OP::FMUL)
                        res.update(binary, lrng * rrng);
                    else if (binary->getOpcode() == OP::FDIV)
                        res.update(binary, lrng / rrng);
                    else if (binary->getOpcode() == OP::FREM)
                        res.update(binary, lrng % rrng);
                    else
                        Err::unreachable();
                }
            } else if (auto fneg = inst->as<FNEGInst>()) {
                const auto &vrng = res.getFloatRange(fneg->getVal());
                res.update(fneg, -vrng);
            } else if (auto fptosi = inst->as<FPTOSIInst>()) {
                const auto &vrng = res.getFloatRange(fptosi->getOVal());
                res.update(fptosi, Range(static_cast<int>(vrng.min), static_cast<int>(vrng.max)));
            } else if (auto sitofp = inst->as<SITOFPInst>()) {
                const auto &vrng = res.getIntRange(sitofp->getOVal());
                res.update(sitofp, Range(static_cast<float>(vrng.min), static_cast<float>(vrng.max)));
            } else if (auto zext = inst->as<ZEXTInst>()) {
                // TODO: I8 Range?
                const auto &vrng = res.getIntRange(zext->getOVal());
                res.update(zext, vrng);
            } else if (auto phi = inst->as<PHIInst>()) {
                auto phi_opers = phi->getPhiOpers();
                if (is_int) {
                    auto base = res.getIntRange(phi_opers[0].value);
                    for (size_t i = 1; i < phi_opers.size(); i++)
                        base = merge(base, res.getIntRange(phi_opers[i].value));
                    res.update(phi, base);
                } else {
                    auto base = res.getFloatRange(phi_opers[0].value);
                    for (size_t i = 1; i < phi_opers.size(); i++)
                        base = merge(base, res.getFloatRange(phi_opers[i].value));
                    res.update(phi, base);
                }
            } else if (auto select = inst->as<SELECTInst>()) {
                if (is_int) {
                    auto trng = res.getIntRange(select->getTrueVal());
                    auto frng = res.getIntRange(select->getFalseVal());
                    res.update(select, merge(trng, frng));
                } else {
                    auto trng = res.getFloatRange(select->getTrueVal());
                    auto frng = res.getFloatRange(select->getFalseVal());
                    res.update(select, merge(trng, frng));
                }
            } else if (auto call = inst->as<CALLInst>()) {
                if (is_int && call->getFunc()->hasAttr(FuncAttr::PromoteFromChar))
                    res.update(call, Range<int>(0, 256));
                else {
                    if (is_int)
                        res.update(call, Range<int>());
                    else
                        res.update(call, Range<float>());
                }
            } else if (auto gep = inst->as<GEPInst>()) {
                auto idxs = gep->getIdxs();
                pType curr_type = gep->getBaseType();
                for (const auto &idx : idxs) {
                    auto irng = res.getIntRange(idx);
                    auto max_v = static_cast<int>(curr_type->as<ArrayType>()->getArraySize());
                    res.update(idx, intersect(irng, Range(0, max_v)));
                }
            } else if (inst->is<ICMPInst, FCMPInst>())
                res.update(inst, Range<int>(0, 1));
            else if (inst->is<LOADInst, EXTRACTInst>()) {
                if (is_btype) {
                    if (is_int)
                        res.update(inst, Range<int>());
                    else
                        res.update(inst, Range<float>());
                }
            }
        }
    }

    // Analyze Constraints
    return RangeResult{};
}
} // namespace IR