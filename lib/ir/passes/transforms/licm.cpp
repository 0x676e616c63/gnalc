#include "../../../../include/ir/passes/transforms/licm.hpp"

#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/converse.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"


namespace IR {
PM::PreservedAnalyses LICMPass::run(Function &function, FAM &fam) {
    auto dom = fam.getResult<DomTreeAnalysis>(function);
    auto loops = fam.getResult<LoopAnalysis>(function);
    auto alias = fam.getResult<AliasAnalysis>(function);
    auto rpo = fam.getResult<PostDomTreeAnalysis>(function);
    this->fam = &fam;
    this->func = &function;

    bool licm_inst_modified = false;

    for (auto loop : loops) {
        licm_inst_modified |= runOnLoop(loop, alias, dom);
    }
    return licm_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

bool LICMPass::runOnLoop(std::shared_ptr<Loop> &loop, AliasAnalysisResult &alias, DomTree &dom) {

    bool licm_loop_modified = false;

    if (loop->hasDedicatedExits())
        licm_loop_modified |= sinkInst(loop, alias, dom);

    // if loop has preheader ,we can hoaist inst to preheader from the loop
    if (loop->getPreHeader())
        licm_loop_modified |= hoistInst(loop, alias, dom);

    return licm_loop_modified;
}

bool LICMPass::hoistInst(std::shared_ptr<Loop> &loop, AliasAnalysisResult &alias, DomTree &dom) {
    bool hoist_inst_move = false;
    auto preHead = loop->getPreHeader();
    auto basicBlocks = loop->getBlocks();

    auto subLoops = loop->getSubLoops();
    for (const auto &bb : basicBlocks) {
        // if the basic block is in subloop then we ignore it
        // so that we can avoid nest loop
        for (const auto &subLoop : subLoops) {
            if (subLoop->contains(bb))
                continue;
        }
        for (auto &inst : *bb) {
            if (canHoistOrSink(loop, inst, alias) && isAllOperandsInvariant(loop, inst) &&
                isDomExits(loop, inst, dom)) {

                auto newInst = std::dynamic_pointer_cast<Instruction>(inst->clone());
                newInst->setName("%licm" + std::to_string(name_cnt++));
                preHead->addInstBeforeTerminator(newInst);
                inst->replaceSelf(newInst);

                hoist_inst_move = true;
            }
        }
    }
    return hoist_inst_move;
}

bool LICMPass::isInvariant(std::shared_ptr<Loop> &loop, std::shared_ptr<Value> &value) {
    // use value here is for when checking inst operands is invariant or not in sink and hoist
    if (auto inst = std::dynamic_pointer_cast<Instruction>(value)) {
        const BasicBlock *bb = inst->getParent().get();
        return !loop->contains(bb);
    }
    return true;
}

bool LICMPass::isAllOperandsInvariant(std::shared_ptr<Loop> &loop, std::shared_ptr<Instruction> &inst) {
    auto operands = inst->getOperands();
    for (const auto &operand : operands) {
        auto value = operand->getValue();
        if (!isInvariant(loop, value))
            return false;
    }
    return true;
}

bool LICMPass::canHoistOrSink(std::shared_ptr<Loop> &loop, std::shared_ptr<Instruction> &inst,
                              AliasAnalysisResult &alias) {
    // Only these inst can be hoisted or sunk.
    // remrmber the cond has ! symbol
    if (!(std::dynamic_pointer_cast<BinaryInst>(inst) || std::dynamic_pointer_cast<FNEGInst>(inst)
          || std::dynamic_pointer_cast<ICMPInst>(inst) || std::dynamic_pointer_cast<FCMPInst>(inst)
          || std::dynamic_pointer_cast<CALLInst>(inst) || std::dynamic_pointer_cast<LOADInst>(inst)
          || std::dynamic_pointer_cast<STOREInst>(inst) || std::dynamic_pointer_cast<GEPInst>(inst)
          || std::dynamic_pointer_cast<CastInst>(inst))) {
        return false;
    }

    // traversal all insts in loop to check whether the load inst's ptr address is modified in loop
    // if so we can't hoist it
    if (auto load = std::dynamic_pointer_cast<LOADInst>(inst)) {
        auto blocks = loop->getBlocks();
        for (const auto &bb : blocks) {
            for (const auto &temp : *bb) {
                auto modref = alias.getInstModRefInfo(temp.get(), load->getPtr().get(), *fam);
                if (modref == ModRefInfo::Mod || modref == ModRefInfo::ModRef)
                    return false;
            }
        }
    }

    if (auto call = std::dynamic_pointer_cast<CALLInst>(inst)) {
        if (hasSideEffect(*fam, call.get()))
            return false;
    }

    if (auto store = std::dynamic_pointer_cast<STOREInst>(inst)) {
        return false;
    }

    if (auto gep = std::dynamic_pointer_cast<GEPInst>(inst)) {
        auto blocks = loop->getBlocks();
        for (const auto &bb : blocks) {
            for (const auto &temp : *bb) {
                auto modref = alias.getInstModRefInfo(temp.get(), gep->getPtr().get(), *fam);
                if (modref == ModRefInfo::Mod || modref == ModRefInfo::ModRef)
                    return false;
            }
        }
    }
    return true;
}

bool LICMPass::sinkInst(std::shared_ptr<Loop> &loop, AliasAnalysisResult &alias, DomTree &dom) {
    //TODO reverse order so that we can visit children before parents
    bool sink_inst_move = false;
    auto subLoops = loop->getSubLoops();
    auto blocks = loop->getBlocks();
    for (const auto &bb : blocks) {
        for (const auto &subLoop : subLoops) {
            if (subLoop->contains(bb))
                continue;
        }

        for (auto iter = bb->rbegin(); iter != bb->rend(); ++iter) {

            if (!std::dynamic_pointer_cast<LOADInst>(*iter) && !std::dynamic_pointer_cast<STOREInst>(*iter) &&
                !std::dynamic_pointer_cast<CALLInst>(*iter) && isUserOutsideLoop(loop, *iter)
                && canHoistOrSink(loop, *iter, alias)) {
                auto useList = (*iter)->getUseList();

                std::map<std::shared_ptr<BasicBlock>, std::shared_ptr<Instruction> > replaceMap;

                for (const auto &use : useList) {
                    auto phi = std::dynamic_pointer_cast<PHIInst>(use->getUser());
                    Err::gassert(phi == nullptr);
                    if (loop->contains(phi->getParent().get()))
                        continue;
                    std::shared_ptr<Instruction> newInst;
                    if (replaceMap.find(phi->getParent()) != replaceMap.end()) {
                        newInst = replaceMap[phi->getParent()];
                    } else {
                        newInst = std::dynamic_pointer_cast<Instruction>((*iter)->clone());
                        newInst->setName((*iter)->getName() + ".licm" + std::to_string(name_cnt++));
                        phi->getParent()->addInstAfterPhi(newInst);
                        replaceMap[phi->getParent()] = newInst;
                    }
                    phi->replaceSelf(newInst);
                    sink_inst_move = true;
                }
            }
        }
    }
    return sink_inst_move;
}

bool LICMPass::isUserOutsideLoop(std::shared_ptr<Loop> &loop, std::shared_ptr<Instruction> &inst) {
    auto useLists = inst->getUseList();
    for (const auto &use : useLists) {
        auto user = use->getUser();
        if (auto i = std::dynamic_pointer_cast<Instruction>(user)) {
            if (loop->contains(i->getParent().get())) {
                return false;
            }
        }
    }
    return true;
}

bool LICMPass::isDomExits(std::shared_ptr<Loop> &loop, std::shared_ptr<Instruction> &inst, DomTree &dom) {
    auto exits = loop->getExitBlocks();
    auto parent = inst->getParent();
    for (const auto &exit : exits) {
        if (!dom.ADomB(parent.get(), exit))
            return false;
    }
    return true;
}


} // namespace IR