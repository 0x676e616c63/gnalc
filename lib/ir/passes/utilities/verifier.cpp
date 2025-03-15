#include "../../../../include/ir/passes/utilities/verifier.hpp"

#include "../../../../include/config/config.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/utils/logger.hpp"

#include <algorithm>
#include <string>
#include <vector>

namespace IR {
PM::PreservedAnalyses VerifyPass::run(Function &function, FAM &fam) {
    size_t fatal_error_cnt = 0;
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

            auto ruselist = inst->getRUseList();
            for (const auto &weak_use : ruselist) {
                if (weak_use.expired()) {
                    Logger::logCritical("[VerifierPass]: Expired use detected in '", inst->getName(),
                                        "' This should be deleted by its user.");
                    ++fatal_error_cnt;
                }
            }
            auto operands = inst->getOperands();
            for (const auto &operand : operands) {
                if (operand->getValue() == nullptr) {
                    Logger::logCritical("[VerifyPass]: Operand got destroyed while its user '", inst->getName(),
                                        "' is alive.");
                    ++fatal_error_cnt;
                    continue;
                }

                auto oper_uselist = operand->getValue()->getRUseList();
                bool found_curr_use = false;
                for (const auto &weak_use : oper_uselist) {
                    if (!weak_use.expired() && weak_use.lock() == operand) {
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
        std::set<std::shared_ptr<BasicBlock>> reachable_blocks{fndfv.begin(), fndfv.end()};
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
                auto br = std::dynamic_pointer_cast<BRInst>(term);
                std::vector<std::shared_ptr<BasicBlock>> real_succs;
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

                std::shared_ptr<Value> common_value = phi_opers[0].value;
                for (const auto &[val, phi_incoming_bb] : phi_opers) {
                    if (std::find(bb->pred_begin(), bb->pred_end(), phi_incoming_bb) == bb->pred_end()) {
                        Logger::logCritical("[VerifyPass]: PHIInst '", phi_inst->getName(), "' has wrong operand '[ ",
                                            val->getName(), ", ", bb->getName(), " ]'.");
                        ++fatal_error_cnt;
                    }
                    if (val != common_value)
                        common_value = nullptr;
                }
                if (common_value != nullptr) {
                    Logger::logWarning("[VerifyPass]: PHIInst '", phi_inst->getName(), "' has identical operands.");
                }
            }
        }
    } else
        Logger::logWarning("[VerifyPass]: Skipped some check due to previous fatal error(s).");

    if (fatal_error_cnt == 0) {
        auto domtree = fam.getResult<DomTreeAnalysis>(function);
        for (const auto &bb : function) {
            for (const auto &inst : bb->all_insts()) {
                for (const auto &user : inst->inst_users()) {
                    if (user->getOpcode() != OP::PHI) {
                        if ((bb == user->getParent() && inst->getIndex() > user->getIndex()) ||
                            !domtree.ADomB(bb.get(), user->getParent().get())) {
                            Logger::logCritical("[VerifyPass]: Instruction '", inst->getName(),
                                                "' does not dominate its use in '", user->getName(), "'.");
                            ++fatal_error_cnt;
                        }
                    }
                }
            }
        }
    } else
        Logger::logWarning("[VerifyPass]: Skipped some check due to previous fatal error(s).");

    if (fatal_error_cnt != 0) {
        Logger::logCritical("[VerifyPass] on '", function.getName(), "': Found ", fatal_error_cnt, " fatal error(s).");
        if (abort_when_verify_failed)
            std::abort();
    }

    return PM::PreservedAnalyses::all();
}
} // namespace IR
