#include "mir/passes/pass_builder.hpp"
#include "mir/passes/pass_manager.hpp"

// Analysis
#include "mir/passes/analysis/liveanalysis.hpp"

// Transforms
#include "mir/passes/transforms/CFGsimplify.hpp"
#include "mir/passes/transforms/ICF_TailDup.hpp"
#include "mir/passes/transforms/PostRAlegalize.hpp"
#include "mir/passes/transforms/PostRAscheduling.hpp"
#include "mir/passes/transforms/PreRAlegalize.hpp"
#include "mir/passes/transforms/PreRAscheduling.hpp"
#include "mir/passes/transforms/RA.hpp"
#include "mir/passes/transforms/codelayout.hpp"
#include "mir/passes/transforms/dce.hpp"
#include "mir/passes/transforms/isel.hpp"
#include "mir/passes/transforms/lowering.hpp"
#include "mir/passes/transforms/peephole.hpp"
#include "mir/passes/transforms/registercoalesce.hpp"
#include "mir/passes/transforms/stackgenerate.hpp"
#include "mir/passes/transforms/tro.hpp"

namespace MIR_new {

FPM PassBuilder::buildFunctionPipeline(OptInfo opt_info) {
    FPM fpm;

    ///@todo opt pipeline

    // lowering
    fpm.addPass(ISel());
    fpm.addPass(PreRAlegalize());
    fpm.addPass(RegisterAlloc());
    fpm.addPass(StackGenerate());
    fpm.addPass(PostRAlegalize());
    // fpm.addPass(GenericPeephole());

    return fpm;
}

MPM PassBuilder::buildModulePipeline(OptInfo opt_info) {
    MPM mpm;

    mpm.addPass(makeModulePass(buildFunctionPipeline(opt_info)));
    return mpm;
}

void PassBuilder::registerProxies(FAM &fam, MAM &mam) {
    mam.registerPass([&] { return FAMProxy(fam); });
}

void PassBuilder::registerFunctionAnalyses(FAM &fam) {
#define FUNCTION_ANALYSIS(CREATE_PASS) fam.registerPass([&] { return CREATE_PASS; });

    FUNCTION_ANALYSIS(LiveAnalysis())
    // FUNCTION_ANALYSIS(DomTreeAnalysis())
    // ...

#undef FUNCTION_ANALYSIS
}

void PassBuilder::registerModuleAnalyses(MAM &) {}

}; // namespace MIR_new
