#include "../../include/passes/pass_manager.hpp"

// Analysis
#include "../../include/passes/analysis/live_analysis.hpp"

// Transforms
#include "../../include/passes/transforms/cfgbuilder.hpp"
#include "../../include/passes/transforms/mem2reg.hpp"
#include "../../include/passes/transforms/namenormalizer.hpp"

// Utilities
#include "../../include/passes/utilities/irprinter.hpp"

namespace IR {
void PassManager::runOnModule(Module& module) {
    for (const auto& pass : module_passes)
        pass->runOnModule(module);

    for (const auto& pass : module_passes)
        pass->afterRunCleanup(module);
}

PassManager::~PassManager() {
    for (const auto& pass : module_passes)
        delete pass;
}

const OptInfo o1_opt_info = {
    .mem2reg = true,
};

void register_default_pass(PassManager& pass_manager, OptInfo opt_info) {
    pass_manager.registerModulePass<CFGBuilder>();
    pass_manager.registerModulePass<LiveAnalyser>();
    pass_manager.registerModulePass<NameNormalizer>(true); // bb_rename: true

    if (opt_info.mem2reg)
    {
        // pass_manager.registerModulePass<Mem2reg>(some args here...);
    }
}
}