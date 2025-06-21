#include "ir/passes/transforms/range_aware_simplify.hpp"

#include "ir/block_utils.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/passes/analysis/range_analysis.hpp"
#include "ir/pattern_match.hpp"
#include "pattern_match/pattern_match.hpp"

#include <vector>
using namespace PatternMatch;
namespace IR {
PM::PreservedAnalyses RangeAwareSimplifyPass::run(Function &function, FAM &fam) {
    bool rng_cfg_modified = false;
    bool rng_inst_modified = false;
    auto ranges = fam.getResult<RangeAnalysis>(function);

    std::vector<pInst> eliminated;
    std::vector<pInst> users;
    for (auto &block : function) {
        for (auto &inst : *block) {
            if (inst->getType()->isI32()) {
                auto inst_rng = ranges.getIntRange(inst);
                if (auto exact = inst_rng.getExact()) {
                    inst->replaceSelf(function.getConst(*exact));
                    Logger::logDebug("[RngSimplify]: Replaced int '", inst->getName(), "' with '", *exact, "'.");
                    rng_inst_modified = true;
                    continue;
                }
            } else if (isSameType(inst->getType(), makeBType(IRBTYPE::FLOAT))) {
                auto inst_rng = ranges.getFloatRange(inst);
                if (auto exact = inst_rng.getExact()) {
                    inst->replaceSelf(function.getConst(*exact));
                    Logger::logDebug("[RngSimplify]: Replaced float '", inst->getName(), "' with '", *exact, "'.");
                    rng_inst_modified = true;
                    continue;
                }
            }

            if (auto icmp = inst->as<ICMPInst>()) {
                auto lrng = ranges.getIntRange(icmp->getLHS(), icmp->getParent());
                auto rrng = ranges.getIntRange(icmp->getRHS(), icmp->getParent());
                auto icmp_res = [&]() -> std::optional<bool> {
                    switch (icmp->getCond()) {
                    case ICMPOP::eq:
                        if (!lrng.overlaps(rrng))
                            return false;
                        if (lrng.getExact().has_value() && rrng.getExact().has_value()) {
                            if (*lrng.getExact() == *rrng.getExact())
                                return true;
                            return false;
                        }
                        break;
                    case ICMPOP::ne:
                        if (!lrng.overlaps(rrng))
                            return true;
                        if (lrng.getExact().has_value() && rrng.getExact().has_value()) {
                            if (*lrng.getExact() == *rrng.getExact())
                                return false;
                            return true;
                        }
                        break;
                    case ICMPOP::slt:
                        // lhs < rhs
                        if (lrng.max < rrng.min)
                            return true;
                        // lhs >= rhs
                        if (lrng.min >= rrng.max)
                            return false;
                        break;
                    case ICMPOP::sle:
                        // lhs <= rhs
                        if (lrng.max <= rrng.min)
                            return true;
                        // lhs > rhs
                        if (lrng.min > rrng.max)
                            return false;
                        break;
                    case ICMPOP::sgt:
                        // lhs > rhs
                        if (lrng.min > rrng.max)
                            return true;
                        // lhs <= rhs
                        if (lrng.max <= rrng.min)
                            return false;
                        break;
                    case ICMPOP::sge:
                        // lhs >= rhs
                        if (lrng.min >= rrng.max)
                            return true;
                        // lhs < rhs
                        if (lrng.max < rrng.min)
                            return false;
                        break;
                    default:
                        Err::unreachable();
                    }
                    return std::nullopt;
                }();

                if (icmp_res.has_value()) {
                    for (const auto &inst_user : icmp->inst_users())
                        users.emplace_back(inst_user);
                    eliminated.emplace_back(icmp);
                    icmp->replaceSelf(function.getConst(*icmp_res));
                    rng_inst_modified = true;
                    Logger::logDebug("[RngSimplify]: Replaced ICMPInst '", icmp->getName(), "' with '",
                                     *icmp_res ? "true" : "false", "'.");
                }
            } else if (auto fcmp = inst->as<FCMPInst>()) {
                auto lrng = ranges.getIntRange(fcmp->getLHS(), fcmp->getParent());
                auto rrng = ranges.getIntRange(fcmp->getRHS(), fcmp->getParent());
                auto fcmp_res = [&]() -> std::optional<bool> {
                    switch (fcmp->getCond()) {
                    case FCMPOP::oeq:
                        if (!lrng.overlaps(rrng))
                            return false;
                        if (lrng.getExact().has_value() && rrng.getExact().has_value()) {
                            if (*lrng.getExact() == *rrng.getExact())
                                return true;
                            return false;
                        }
                        break;
                    case FCMPOP::one:
                        if (!lrng.overlaps(rrng))
                            return true;
                        if (lrng.getExact().has_value() && rrng.getExact().has_value()) {
                            if (*lrng.getExact() == *rrng.getExact())
                                return false;
                            return true;
                        }
                        break;
                    case FCMPOP::olt:
                        // lhs < rhs
                        if (lrng.max < rrng.min)
                            return true;
                        // lhs >= rhs
                        if (lrng.min >= rrng.max)
                            return false;
                        break;
                    case FCMPOP::ole:
                        // lhs <= rhs
                        if (lrng.max <= rrng.min)
                            return true;
                        // lhs > rhs
                        if (lrng.min > rrng.max)
                            return false;
                        break;
                    case FCMPOP::ogt:
                        // lhs > rhs
                        if (lrng.min > rrng.max)
                            return true;
                        // lhs <= rhs
                        if (lrng.max <= rrng.min)
                            return false;
                        break;
                    case FCMPOP::oge:
                        // lhs >= rhs
                        if (lrng.min >= rrng.max)
                            return true;
                        // lhs < rhs
                        if (lrng.max < rrng.min)
                            return false;
                        break;
                    default:
                        Err::unreachable();
                    }
                    return std::nullopt;
                }();

                if (fcmp_res.has_value()) {
                    for (const auto &inst_user : fcmp->inst_users())
                        users.emplace_back(inst_user);
                    eliminated.emplace_back(fcmp);
                    fcmp->replaceSelf(function.getConst(*fcmp_res));
                    rng_inst_modified = true;
                    Logger::logDebug("[ RngSimplify]: Replaced FCMPInst '", fcmp->getName(), "' with '",
                                     *fcmp_res ? "true" : "false", "'.");
                }
            }
        }
    }

    std::set<pPhi> dead_phis;
    for (const auto &inst : users) {
        if (auto br_inst = inst->as<BRInst>()) {
            if (match(br_inst->getCond(), M::Is(true))) {
                safeUnlinkBB(br_inst->getParent(), br_inst->getFalseDest(), dead_phis);
                rng_cfg_modified = true;
            } else if (match(br_inst->getCond(), M::Is(false))) {
                safeUnlinkBB(br_inst->getParent(), br_inst->getTrueDest(), dead_phis);
                rng_cfg_modified = true;
            }
        } else if (auto select = inst->as<SELECTInst>()) {
            if (match(select->getCond(), M::Is(true))) {
                select->replaceSelf(select->getTrueVal());
                eliminated.emplace_back(select);
                rng_inst_modified = true;
            } else if (match(select->getCond(), M::Is(false))) {
                select->replaceSelf(select->getFalseVal());
                eliminated.emplace_back(select);
                rng_inst_modified = true;
            }
        }
    }

    for (const auto &i : eliminated)
        i->getParent()->delFirstOfInst(i);

    // Same as SCCP
    auto dfv = function.getDFVisitor();
    std::unordered_set live(dfv.begin(), dfv.end());
    for (const auto &block : function) {
        if (live.find(block) == live.end()) {
            auto succs = block->getNextBB();
            for (const auto &succ : succs)
                safeUnlinkBB(block, succ, dead_phis);
        }
    }

    rng_cfg_modified |= function.delBlockIf([&live](const auto &bb) { return live.find(bb) == live.end(); });

    for (auto &block : function) {
        block->delInstIf(
            [&dead_phis](const auto &p) { return dead_phis.find(p->template as<PHIInst>()) != dead_phis.end(); },
            BasicBlock::DEL_MODE::PHI);
    }

    if (rng_cfg_modified)
        return PreserveNone();

    if (rng_inst_modified)
        return PreserveCFGAnalyses();

    return PreserveAll();
}
} // namespace IR