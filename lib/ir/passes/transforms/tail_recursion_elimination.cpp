//
// Created by edragain on 2/9/25.
//
#include "../../../../include/ir/passes/transforms/tail_recursion_elimination.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/memory.hpp"

namespace IR {
PM::PreservedAnalyses MarkTailCallPass::run(Function &function, FAM &manager) {
    auto dfVisitor = function.getDFVisitor();
    std::vector<std::pair<std::shared_ptr<CALLInst>, std::shared_ptr<RETInst> > > worklist;
    for (const auto &block : dfVisitor) {
        for (auto iter = block->begin(); std::next(iter) != block->end(); ++iter) {
            auto call = std::dynamic_pointer_cast<CALLInst>(*iter);
            auto ret = std::dynamic_pointer_cast<RETInst>(*std::next(iter));
            if (call != nullptr && ret != nullptr && ((call->isVoid() && ret->isVoid()) || ret->getRetVal() == call)) {
                //if call->func=function tail recursive
                //else tail call
                if (call->getFuncName() == function.getName())
                    worklist.emplace_back(call, ret);
                else
                    call->setTailCall();
            }
        }
    }
    if (!worklist.empty()) {
        //if entry block have alloca inst we divide entry block into two blocks
        //else we create a new block as new entry block
        auto entryBlock = *function.begin();
        std::shared_ptr<ALLOCAInst> lastAllocaInst = nullptr;

        for (const auto &inst : *entryBlock) {
            if (auto allocaInst = std::dynamic_pointer_cast<ALLOCAInst>(inst)) {
                lastAllocaInst = allocaInst;
            } else
                break;
        }
        std::shared_ptr<BasicBlock> newEntryBlock = nullptr;
        if (lastAllocaInst == nullptr) {
            newEntryBlock = std::make_shared<BasicBlock>("noalloca");
        } else {
            newEntryBlock = std::make_shared<BasicBlock>("havealloca");
            for (const auto &inst : entryBlock) {
                newEntryBlock->addInst(inst);
                entryBlock->delInst(inst);
                if (std::dynamic_pointer_cast<ALLOCAInst>(inst) == lastAllocaInst) {
                    break;
                }
            }
        }
        newEntryBlock->addInst(std::dynamic_pointer_cast<Instruction>(std::make_shared<BRInst>(entryBlock)));
        linkBB(newEntryBlock, entryBlock);
        function.addBlock(newEntryBlock);

        // replace params with PHI
        auto &params = function.getParams();
        std::vector<std::shared_ptr<PHIInst> > phivector;
        for (auto &param : params) {
            auto phiInst = std::make_shared<PHIInst>(param->getName(), param->getType());
            param->replaceSelf(phiInst);
            phiInst->addPhiOper(param, newEntryBlock);
            phivector.push_back(phiInst);
        }
        for (const auto &[call,ret] : worklist) {
            auto bb = call->getParent();
            int i = 0;
            for (const auto &arg : call->getArgs()) {
                phivector[i]->addPhiOper(arg, bb);
                ++i;
            }
            i = 0;
            bb->delInst(call);
            bb->delInst(ret);
            //entry block is used for jump
            bb->addInst(std::dynamic_pointer_cast<Instruction>(std::make_shared<BRInst>(entryBlock)));
        }


        for (const auto &phi : phivector) {
            entryBlock->addPhiInst(phi);
        }
    }

    return PM::PreservedAnalyses::all();
}

}