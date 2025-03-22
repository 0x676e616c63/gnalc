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
            auto trip_cnt = scev.getNumberOfLatchExecutions(loop.get());
            if (trip_cnt && trip_cnt->isIRValue())
                std::cout << "Latch Execution Count: " << trip_cnt->getIRValue()->getName() << std::endl;
            else
                std::cout << "Latch Execution Count: failed :(" << std::endl;
        }
    }
    for (const auto& bb : function) {
        for (const auto& inst : bb->all_insts()) {
            if (isSameType(inst->getType(), makeBType(IRBTYPE::I32))) {
                auto loop = loop_info.getLoopFor(inst->getParent().get());
                while (loop != nullptr) {
                    auto s = scev.getSCEVAtScope(inst.get(), nullptr);
                    std::cout << inst->getName() << " at depth " << loop->getLoopDepth()
                        << ": ";
                    if (s)
                        std::cout << *s;
                    else
                        std::cout << "<null>";
                    std::cout << std::endl;
                    loop = loop->getParent();
                }
                auto s = scev.getSCEVAtScope(inst.get(), nullptr);
                std::cout << inst->getName() << " at global: ";
                if (s)
                    std::cout << *s;
                else
                    std::cout << "<null>";
                std::cout << std::endl;
            }
        }
    }
    return iv_simplify_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR