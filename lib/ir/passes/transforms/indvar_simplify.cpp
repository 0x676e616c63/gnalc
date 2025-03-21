#include "../../../../include/ir/passes/transforms/indvar_simplify.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/passes/analysis/scev.hpp"

namespace IR {
PM::PreservedAnalyses IndVarSimplifyPass::run(Function &function, FAM &fam) {
    bool iv_simplify_inst_modified = false;

    // SCEV Debug
    auto scev = fam.getResult<SCEVAnalysis>(function);
    auto loop_info = fam.getResult<LoopAnalysis>(function);
    std::cout << "SCEV Debug: " << std::endl;
    for (const auto& top_level : loop_info) {
        auto ldfv = top_level->getDFVisitor();
        for (const auto& loop : ldfv) {
            for (const auto& bb : loop->blocks()) {
                for (const auto& inst : bb->all_insts()) {
                    auto s = scev.analyzeEvolution(loop.get(), inst.get());
                    std::cout << inst->getName() << ": " << *s << std::endl;
                }
            }
            auto trip_cnt = scev.getTripCount(loop.get());
            if (trip_cnt && trip_cnt->isIRValue())
                std::cout << "Trip Count: " << trip_cnt->getIRValue()->getName() << std::endl;
            std::cout << "Trip Count: failed :(" << std::endl;
        }
    }
    return iv_simplify_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR