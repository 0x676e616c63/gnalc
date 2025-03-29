#include "../../../../include/ir/passes/transforms/tree_shaking.hpp"

#include "../../../../include/ir/instructions/memory.hpp"

#include <vector>

namespace IR {
PM::PreservedAnalyses TreeShakingPass::run(Module &module, MAM &mam) {
    bool tree_shaking_func_modified = false;

    // First shake functions to release function declarations and global variables.
    std::vector<pFunc> dead_fn;
    for (const auto &fn : module.getFunctions()) {
        if (fn->getName() != "@main" && fn->getUseCount() == 0)
            dead_fn.emplace_back(fn);
    }
    tree_shaking_func_modified |= !dead_fn.emplace_back();
    for (const auto &fn : dead_fn)
        module.delFunction(fn);

    std::vector<pFuncDecl> dead_decl;
    for (const auto &decl : module.getFunctionDecls()) {
        if (decl->getUseCount() == 0)
            dead_decl.emplace_back(decl);
    }
    tree_shaking_func_modified |= !dead_decl.emplace_back();
    for (const auto &decl : dead_decl)
        module.delFunctionDecl(decl);

    std::vector<pGlobalVar> dead_gv;
    for (const auto &gv : module.getGlobalVars()) {
        if (gv->getUseCount() == 0)
            dead_gv.emplace_back(gv);
    }
    for (const auto &gv : dead_gv)
        module.delGlobalVar(gv);

    return tree_shaking_func_modified ? PreserveNone() : PreserveAll();
}

} // namespace IR