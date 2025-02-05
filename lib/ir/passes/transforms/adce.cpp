#include "../../../../include/ir/passes/transforms/adce.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <deque>

namespace IR {
PM::PreservedAnalyses ADCEPass::run(Function &function, FAM &fam) {
    DT=fam.getResult<DomTreeAnalysis>(function);

    std::deque<std::shared_ptr<Instruction>> worklist;
    std::set<std::shared_ptr<Instruction>> liveInst;
    std::set<std::shared_ptr<BasicBlock>> liveBB;

    function.updateBBIndex();

for (const auto & block:function) {
    for ( const auto & inst:block->getInsts()) {
        //TODO setblockID? but wedont use this
        if (inst->getOpcode()==OP::STORE||inst->getOpcode()==OP::CALL||inst->getOpcode()==OP::RET) {
            worklist.push_back(inst);
        }
        //TODO
    }
}
    while (!worklist.empty()) {
        auto inst=worklist.front();
        worklist.pop_front();
        if (liveInst.find(inst)!=liveInst.end()) {
            continue;
        }
        liveInst.insert(inst);
        auto parentBB=inst->getParent();

        liveBB.insert(parentBB);
        if (auto phiInst=std::dynamic_pointer_cast<PHIInst>(inst)) {
            for (const auto& phi:phiInst->getPhiOpers()) {
                auto val=phi->getValue();
                auto block=phi->getBlock();
                auto lastInst=getLastInst(function,block->index);
                if (liveInst.find(lastInst) ==liveInst.end()) {
                    worklist.push_front(lastInst);
                    liveBB.insert(block);
                }
            }
        }
    }



for (const auto & block:function) {
    auto lastInst=getLastInst(function,block->index);
    auto insts=block->getInsts();
    for (const auto& delInst:block->getInsts()) {
        block->delInst(delInst);
    }
    for (const auto& live:insts) {
        if (liveInst.find(live)==liveInst.end()) {
            if (lastInst==live) {
                //TODO post dom tree
            }
        }
        block->addInst(live);
    }
}

    return PM::PreservedAnalyses::none();
}
std::shared_ptr<Instruction> ADCEPass::getLastInst(Function &function, unsigned index) {
    auto block=function.getBlocks()[index];
    return block->getInsts().back();
}



} // namespace IR