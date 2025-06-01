#include "sir/passes/pass_builder.hpp"

// IR
#include "ir/passes/pass_manager.hpp"

// Transforms
#include "../../../include/ir/cfgbuilder.hpp"
#include "sir/passes/transforms/while2for.hpp"

#include <algorithm>

namespace SIR {
template <typename PM, typename Pass>
void registerPassForOptInfo(PM &lfpm, bool enable, Pass &&pass) {
    if (enable) {
        lfpm.addPass(std::forward<Pass>(pass));
    } else
        Logger::logDebug("[PB]: '", Pass::name(), "' disabled.");
}

template <typename PM, typename First, typename... Rest>
void registerPassForOptInfo(PM &lfpm, bool enable, First &&first, Rest &&...rest) {
    registerPassForOptInfo(lfpm, enable, std::forward<First>(first));
    registerPassForOptInfo(lfpm, enable, std::forward<Rest>(rest)...);
}

LFPM LinearPassBuilder::buildFunctionFixedPointPipeline(PMOptions options) {
#define FUNCTION_TRANSFORM(name, ...)                                                                                  \
    registerPassForOptInfo(lfpm, options.name, __VA_ARGS__);

    LFPM lfpm;

#undef FUNCTION_TRANSFORM
    return lfpm;
}

MPM LinearPassBuilder::buildModuleFixedPointPipeline(PMOptions options) {
    MPM mpm;
    mpm.addPass(makeLinearModulePass(buildFunctionFixedPointPipeline(options)));
    return mpm;
}

LFPM LinearPassBuilder::buildFunctionPipeline(PMOptions opt_info) {
    LFPM lfpm;

#define FUNCTION_TRANSFORM(name, ...)                                                                                  \
    registerPassForOptInfo(lfpm, opt_info.name, __VA_ARGS__);

#undef FUNCTION_TRANSFORM

    return lfpm;
}

MPM LinearPassBuilder::buildModulePipeline(PMOptions opt_info) {
    MPM mpm;
    mpm.addPass(makeLinearModulePass(buildFunctionPipeline(opt_info)));
    return mpm;
}

LFPM LinearPassBuilder::buildFunctionDebugPipeline() {
    LFPM lfpm;
    lfpm.addPass(While2ForPass());
    return lfpm;
}

MPM LinearPassBuilder::buildModuleDebugPipeline() {
    MPM mpm;
    mpm.addPass(makeLinearModulePass(buildFunctionDebugPipeline()));
    return mpm;
}

void LinearPassBuilder::registerProxies(LFAM &lfam, MAM &mam) {
    mam.registerPass([&] { return LFAMProxy(lfam); });
}

void LinearPassBuilder::registerFunctionAnalyses(LFAM &lfam) {
#define FUNCTION_ANALYSIS(CREATE_PASS) lfam.registerPass([&] { return CREATE_PASS; });

#undef FUNCTION_ANALYSIS
}

void LinearPassBuilder::registerModuleAnalyses(MAM &) {}

} // namespace IR