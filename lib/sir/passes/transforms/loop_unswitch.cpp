#include "sir/passes/transforms/loop_unswitch.hpp"
#include "sir/base.hpp"

namespace SIR {
PM::PreservedAnalyses LoopUnswitchPass::run(LinearFunction &function, LFAM &manager) {
    bool loop_unswitch_modified = false;



    return loop_unswitch_modified ? PreserveNone() : PreserveAll();
}
} // namespace IR