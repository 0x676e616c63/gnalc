// Implementation of GVN-PRE
// See:
//     - Thomas VanDrunen and Antony L. Hosking "Value-based Partial Redundancy Elimination":
//           https://link.springer.com/content/pdf/10.1007/978-3-540-24723-4_12.pdf
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_GVN_PRE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_GVN_PRE_HPP

#include "../pass_manager.hpp"

namespace IR {
class GVNPREPass : public PM::PassInfo<GVNPREPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
