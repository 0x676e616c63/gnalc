#include "../../../../include/ir/passes/transforms/inline.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/memory.hpp"

#include <deque>

namespace IR {
bool InlinePass::canInline(const Function &calleeFn, const Function &callerFn) {
    bool flag = false;
    for (const auto &param : calleeFn.getParams()) {
        if (toPtrType(param->getType())) {
            flag = true;
            break;
        }
    }
    if (calleeFn.getName() != callerFn.getName())
        flag &= true;
    if (inlineCount[calleeFn] <= 30)
        flag = true;
    if (calleeFn.getInstCount() + callerFn.getInstCount() <= 200)
        flag = true;
    return flag;
}

void InlinePass::funcInline(Function &calleeFn, Function &callerFn, std::shared_ptr<BasicBlock> &bb, std::shared_ptr<CALLInst> &call) {

    // divide bb
    auto newBlock = std::make_shared<BasicBlock>("%inline" + std::to_string(name_cnt++));
    std::set<std::shared_ptr<Instruction> > removeList;
    for (auto iter1 = bb->begin(); iter1 != bb->end(); ++iter1) {
        auto iter2 = iter1;
        if (*iter1 == call) {
            for (; iter2 != bb->end(); ++iter2) {
                newBlock->addInst(*iter2);
                removeList.insert(*iter2);
            }
        }
    }
    // move nextbb of bb to newblock
    for (const auto &next : bb->getNextBB()) {
        linkBB(newBlock, next);
        unlinkBB(bb, next);
    }
    callerFn.addBlock(newBlock);
    // delete inst in bb which move to newblock already
    for (auto i : *bb) {
        bb->delInstIf([&] {
            return removeList.find(i) != removeList.end();
        });
    }

    removeList.clear();

    // TODO copy blocks of vFunc
    std::vector<std::shared_ptr<BasicBlock> > copyBlocks;

    // TODO replace params with call args

    // move alloca insts to uFunc

    for (const auto &i : **copyBlocks.begin()) {
        if (auto alloca = std::dynamic_pointer_cast<ALLOCAInst>(i)) {
            (*callerFn.getBlocks().begin())->addInstAfterPhi(i); //insert alloca inst to first block
            removeList.insert(i); //remove alloca inst
        }
    }

    for (auto deleteInst : removeList) {
        (*copyBlocks.begin())->delInstIf([&] {
            return removeList.find(deleteInst) != removeList.end();
        });
    }
    removeList.clear();
    // insert BR into bb
    auto BR = std::make_shared<BRInst>(*copyBlocks.begin());
    bb->addInst(BR);
    linkBB(bb, *copyBlocks.begin());

    if (call->isVoid()) {
        //deal with ret
        for (const auto &copyBlock : copyBlocks) {
            auto lastInst = copyBlock->getInsts().back();
            if (auto ret = std::dynamic_pointer_cast<RETInst>(lastInst)) {
                ;
                auto br = std::make_shared<BRInst>(newBlock);
                linkBB(copyBlock, newBlock);

                copyBlock->delFirstOfInst(lastInst);
                copyBlock->addInst(br);
            }
        }
    } else {
        // deal with phi
        //TODO phi operand.size==1
        auto phi = std::make_shared<PHIInst>("%inline" + name_cnt++, call->getType());
        for (const auto &copyBlock : copyBlocks) {
            auto lastInst = copyBlock->getInsts().back();
            if (auto ret = std::dynamic_pointer_cast<RETInst>(lastInst)) {
                phi->addPhiOper(ret->getRetVal(), copyBlock);

                auto br = std::make_shared<BRInst>(newBlock);
                linkBB(copyBlock, newBlock);

                copyBlock->delFirstOfInst(lastInst);
                copyBlock->addInst(br);
            }
        }
        call->replaceSelf(phi);
        newBlock->addPhiInst(phi);
    }
    newBlock->delFirstOfInst(call); // delete call inst
}

PM::PreservedAnalyses InlinePass::run(Function &function, FAM &fam) {
    bool inline_cfg_modified = false;

    std::vector<std::shared_ptr<CALLInst> > workList;

    auto dfVisitor = function.getDFVisitor();
    //collect callinst
    for (const auto &bb : dfVisitor) {
        for (const auto &inst : *bb) {
            if (auto callInst = std::dynamic_pointer_cast<CALLInst>(inst))
                workList.emplace_back(callInst);
        }
    }

    //check for callinst can inline
    //and make function inline
    for (const auto &call : workList) {
        if (auto func = std::dynamic_pointer_cast<Function>(call->getFunc())) {
            if (canInline(*func, function)) {

                auto bb = call->getParent();
                auto inst = call;

                funcInline(*func, function, bb, inst);

                inline_cfg_modified = true;

                inlineCount[*func] += 1;
            }
        }
    }

    inlineCount.clear();
    if (inline_cfg_modified)
        return PM::PreservedAnalyses::none();

    return PM::PreservedAnalyses::all();
}

} // namespace IR