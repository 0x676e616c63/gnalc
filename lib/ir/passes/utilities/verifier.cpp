#include "ir/passes/utilities/verifier.hpp"
#include "ir/instructions/control.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"
#include "utils/logger.hpp"

#include <algorithm>
#include <vector>

namespace IR {
PM::PreservedAnalyses VerifyPass::run(Function &function, FAM &fam) {
    size_t fatal_error_cnt = 0;
    size_t warning_cnt = 0;

    //
    // Critical
    //

    // Check use-def
    for (const auto &bb : function) {
        for (const auto &inst : bb->all_insts()) {
            if (inst->getParent() == nullptr) {
                Logger::logCritical("[VerifyPass]: Instruction '", inst->getName(),
                                    "''s parent pointer is nullptr. But it is in '", bb->getName(), "'.");
                ++fatal_error_cnt;
            } else if (inst->getParent() != bb) {
                Logger::logCritical("[VerifyPass]: Instruction '", inst->getName(), "''s parent pointer is ",
                                    inst->getParent()->getName(), ". But it is in '", bb->getName(), "'.");
                ++fatal_error_cnt;
            }

            for (const auto &operand : inst->operand_uses()) {
                if (operand->getValue() == nullptr) {
                    Logger::logCritical("[VerifyPass]: Operand got destroyed while its user '", inst->getName(),
                                        "' is alive.");
                    ++fatal_error_cnt;
                    continue;
                }

                bool found_curr_use = false;
                for (const auto &use : operand->getValue()->self_uses()) {
                    if (use == operand.get()) {
                        found_curr_use = true;
                        break;
                    }
                }
                if (!found_curr_use) {
                    Logger::logCritical("[VerifyPass]: Missing use in '", inst->getName(), "''s operand '",
                                        operand->getValue()->getName(), "'.");
                    ++fatal_error_cnt;
                }
            }
        }
    }

    // If there is no fatal error, do some extra check.
    // Otherwise, the compiler might abort during this check.
    if (fatal_error_cnt == 0) {
        // Check CFG
        auto fndfv = function.getDFVisitor();
        std::set<pBlock> reachable_blocks{fndfv.begin(), fndfv.end()};
        const auto &entry = function.getBlocks().front();
        if (entry->getNumPreds() != 0) {
            Logger::logCritical("[VerifyPass]: Entry BasicBlock '", entry->getName(), "' has predecessors.");
            ++fatal_error_cnt;
        }

        for (const auto &bb : function) {
            if (reachable_blocks.find(bb) == reachable_blocks.end()) {
                Logger::logCritical("[VerifyPass]: Unreachable BasicBlock '", bb->getName(), "' detected.");
                ++fatal_error_cnt;
            }

            const auto &insts = bb->getInsts();
            if (insts.empty()) {
                ++fatal_error_cnt;
                Logger::logCritical("[VerifyPass]: Empty BasicBlock '", bb->getName(), "' detected.");
                if (bb->getNumSuccs() != 0)
                    Logger::logCritical("[VerifyPass]: Empty BasicBlock '", bb->getName(), "' has successors.");
                continue;
            }
            auto term = insts.back();
            if (term->getOpcode() == OP::RET) {
                if (bb->getNumSuccs() != 0) {
                    Logger::logCritical("[VerifyPass]: Exit BasicBlock '", bb->getName(), "' has successors.");
                    ++fatal_error_cnt;
                }
            } else if (term->getOpcode() == OP::BR) {
                auto br = term->as<BRInst>();
                std::vector<pBlock> real_succs;
                if (br->isConditional()) {
                    if (bb->getNumSuccs() != 2) {
                        Logger::logCritical("[VerifyPass]: BasicBlock '", bb->getName(),
                                            "' terminated with conditional branch but has ", bb->getNumSuccs(),
                                            " successors.");
                        ++fatal_error_cnt;
                    }
                    real_succs = {br->getTrueDest(), br->getFalseDest()};
                } else {
                    if (bb->getNumSuccs() != 1) {
                        Logger::logCritical("[VerifyPass]: BasicBlock '", bb->getName(),
                                            "' terminated with unconditional branch but has ", bb->getNumSuccs(),
                                            " successors.");
                        ++fatal_error_cnt;
                    }
                    real_succs = {br->getDest()};
                }

                for (const auto &succ : real_succs) {
                    if (std::find(succ->pred_begin(), succ->pred_end(), bb) == succ->pred_end()) {
                        Logger::logCritical("[VerifyPass]: Missing predecessor in BasicBlock '", succ->getName(), "'.");
                        ++fatal_error_cnt;
                    }
                }

                for (const auto &succ : bb->succs()) {
                    if (std::find(real_succs.cbegin(), real_succs.cend(), succ) == real_succs.end()) {
                        Logger::logCritical("[VerifyPass]: BasicBlock '", bb->getName(), "' has wrong successor: '",
                                            succ->getName(), "'.");
                        ++fatal_error_cnt;
                    }
                }
            }
        }

        // Check PhiNode
        for (const auto &bb : function) {
            auto phi_insts = bb->phis();
            for (const auto &phi_inst : phi_insts) {
                auto phi_opers = phi_inst->getPhiOpers();
                if (phi_opers.empty()) {
                    Logger::logCritical("[VerifyPass]: Empty PhiInst '", phi_inst->getName(), "' detected.");
                    ++fatal_error_cnt;
                    continue;
                }

                if (phi_inst->getPhiOpers().size() != bb->getNumPreds()) {
                    Logger::logCritical("[VerifyPass]: PhiInst '", phi_inst->getName(),
                                        "' has wrong number of operands.");
                    ++fatal_error_cnt;
                }

                for (const auto &pre : bb->preds()) {
                    if (std::find_if(phi_opers.cbegin(), phi_opers.cend(), [&pre](const PHIInst::PhiOper &oper) {
                            return oper.block == pre;
                        }) == phi_opers.cend()) {
                        Logger::logCritical("[VerifyPass]: PHIInst '", phi_inst->getName(), "' misses an operand for '",
                                            pre->getName(), "'.");
                        ++fatal_error_cnt;
                    }
                }

                for (const auto &[v, b] : phi_opers) {
                    if (!isSameType(v->getType(), phi_inst->getType())) {
                        Logger::logCritical("[VerifyPass]: PHIInst '", phi_inst->getName(), "' has wrong operand type for '",
                                            v->getName(), "'.");
                        ++fatal_error_cnt;
                    }
                }
            }
        }
    }

    if (fatal_error_cnt == 0) {
        auto domtree = fam.getResult<DomTreeAnalysis>(function);
        for (const auto &bb : function) {
            for (const auto &inst : bb->all_insts()) {
                for (const auto &user : inst->inst_users()) {
                    if (user->getOpcode() != OP::PHI) {
                        if ((bb == user->getParent() && inst->getIndex() > user->getIndex()) ||
                            !domtree.ADomB(bb, user->getParent())) {
                            Logger::logCritical("[VerifyPass]: Instruction '", inst->getName(),
                                                "' does not dominate its use in '", user->getName(), "'.");
                            ++fatal_error_cnt;
                        }
                    }
                }
            }
        }
    }

    // Check loop info
    if (fatal_error_cnt == 0) {
        auto loop_info = fam.getResult<LoopAnalysis>(function);
        for (const auto &top_level : loop_info) {
            auto lpdfv = top_level->getDFVisitor();
            for (const auto &loop : lpdfv) {
                if (loop->getBlocks().size() != loop->getBlockSet().size()) {
                    Logger::logCritical("[VerifyPass]: Loop '", loop->getHeader()->getName(),
                                        "' has duplicate blocks.");
                }
                if (loop->getExitBlocks().empty()) {
                    Logger::logCritical("[VerifyPass]: Endless loop '", loop->getHeader()->getName(), "' detected.");
                    ++fatal_error_cnt;
                }
                for (const auto &bb : loop->blocks()) {
                    for (auto p = loop; p != nullptr; p = p->getParent()) {
                        if (!p->contains(bb)) {
                            Logger::logCritical("[VerifyPass]: BasicBlock '", bb->getName(), "' in '",
                                                loop->getHeader()->getName(), "'. But is not in loop '",
                                                p->getHeader()->getName(), "'.");
                        }
                    }
                }
            }
        }
    }

    if (fatal_error_cnt == 0) {
        if (function.getExitBBs().empty()) {
            Logger::logCritical("[VerifyPass]: Function '", function.getName(), "' has no exit block.");
            ++fatal_error_cnt;
        }
    }

    //
    // Warning
    //

    // See if every cond and BRInst are consecutive
    if (fatal_error_cnt == 0) {
        for (const auto &bb : function) {
            auto br = bb->getBRInst();
            if (!br || !br->isConditional())
                continue;
            if (auto cond_inst = br->getCond()->as<Instruction>()) {
                if (cond_inst->getParent() != bb) {
                    ++warning_cnt;
                    Logger::logWarning("[VerifyPass]: Cond '", cond_inst->getName(), "' and BRInst are in separate block.");
                }
                else if (std::next(cond_inst->getIter()) != br->getIter()) {
                    ++warning_cnt;
                    Logger::logWarning("[VerifyPass]: Cond '", cond_inst->getName(), "' and BRInst are not consecutive.");
                }
                else if (cond_inst->getUseCount() != 1) {
                    ++warning_cnt;
                    Logger::logWarning("Cond '", cond_inst->getName(), "' has multiple uses. (possibly more than one BRInst)");
                }
            }
        }
    }

    // See if every instruction has unique name
    if (fatal_error_cnt == 0) {
        std::unordered_set<std::string> discovered_names;
        for (const auto &bb : function) {
            for (const auto &inst : bb->all_insts()) {
                if (inst->getVTrait() != ValueTrait::ORDINARY_VARIABLE)
                    continue;
                if (inst->getName() == "") {
                    ++warning_cnt;
                    Logger::logWarning("[VerifyPass]: Instruction '", inst->getName(), "' has no name.");
                }
                else {
                    if (discovered_names.find(inst->getName()) != discovered_names.end()) {
                        ++warning_cnt;
                        Logger::logWarning("[VerifyPass]: Duplicated name '", inst->getName(), "' detected.");
                    }
                    else
                        discovered_names.insert(inst->getName());
                }
            }
        }
    }

    if (warning_cnt != 0) {
        Logger::logWarning("[VerifyPass] on '", function.getName(), "': Found ", warning_cnt, " warning(s).");
        if (abort_when_warning_raised && (!abort_when_verify_failed || fatal_error_cnt == 0))
            std::abort();
    }

    if (fatal_error_cnt != 0) {
        Logger::logCritical("[VerifyPass] on '", function.getName(), "': Found ", fatal_error_cnt, " fatal error(s).");
        if (abort_when_verify_failed)
            std::abort();
    }

    if (warning_cnt == 0 && fatal_error_cnt == 0) {
        Logger::logInfo("[VerifyPass] on '", function.getName(), "': No issues found.");
    }

    return PreserveAll();
}
} // namespace IR
