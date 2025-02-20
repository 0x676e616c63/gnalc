#include "../../../../include/ir/passes/transforms/inline.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <deque>

namespace IR {
bool InlinePass::canInline(const Function &vFunc, const Function &uFunc) {
    bool flag = false;
    for (const auto &param : vFunc.getParams()) {
        if (toPtrType(param->getType())) {
            flag = true;
            break;
        }
    }
    if (vFunc.getName() != uFunc.getName())
        flag &= true;
    if (inlineCount[vFunc] <= 30)
        flag = true;
    if (funcInstCount[vFunc] + funcInstCount[uFunc] <= 200)
        flag = true;
    return flag;
}
void InlinePass::funcInline(Function & vFunc, Function &uFunc, std::shared_ptr<BasicBlock> &bb,std::shared_ptr<Instruction> &inst) {
    //todo 分割基本块，连接基本块
    //跳到新基本块再跳回来
    //alloca insert
    //BR insert
    //处理ret和phi函数

    //divide bb
    auto newBlock=std::make_shared<BasicBlock>("divide block");
    std::set<std::shared_ptr<Instruction>> removeList;
    for (auto iter1=bb->begin();iter1!=bb->end();++iter1) {
        auto iter2=iter1;
        if (*iter1==inst) {
            for ( ;iter2!=bb->end();++iter2) {
                newBlock->addInst(*iter2);
                removeList.insert(*iter2);
            }
        }
    }
    //move nextbb of bb to newblock
    for (const auto &next:bb->getNextBB()) {
        linkBB(newBlock,next);
        unlinkBB(bb,next);
    }
    uFunc.addBlock(newBlock);
    //delete inst in bb which move to newblock already
    for (auto i:*bb) {
        bb->delInstIf([&] {
            return removeList.find(i)!=removeList.end();
        });
    }
    removeList.clear();
    //copy blocks of vFunc

    //replace params with call args


}

PM::PreservedAnalyses InlinePass::run(Function &function, FAM &fam) {
    bool inline_cfg_modified = false;

    std::vector<std::shared_ptr<CALLInst>> workList;

    auto dfVisitor = function.getDFVisitor();
    //collect callinst
    for (const auto &bb : dfVisitor) {
        for (const auto &inst : *bb) {
            if (auto callInst = std::dynamic_pointer_cast<CALLInst>(inst))
                workList.emplace_back(callInst);
        }
    }
    //calculate func inst numbers
    for (const auto &call : workList) {
        if (auto func=std::dynamic_pointer_cast<Function>(call->getFunc())) {
            for (const auto &bb : func->getDFVisitor()) {
                funcInstCount[*func] += bb->getInsts().size();
            }
        }
    }
    //check for callinst can inline
    //and make function inline
    for (const auto &call : workList) {
       if (auto func=std::dynamic_pointer_cast<Function>(call->getFunc())) {
           if (canInline(*func, function)) {
               auto bb=call->getParent();
               std::shared_ptr<Instruction> inst=call;
               //TODO
               funcInline(*func,function,bb,inst);
               inline_cfg_modified=true;
               inlineCount[*func] += 1;
               funcInstCount[function] += funcInstCount[*func];
           }
       }
    }

    inlineCount.clear();
    funcInstCount.clear();
    if (inline_cfg_modified)
        return PM::PreservedAnalyses::none();

    return PM::PreservedAnalyses::all();
}

} // namespace IR