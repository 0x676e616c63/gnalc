#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_ADCE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_ADCE_HPP

#include "../pass_manager.hpp"

namespace IR {
class ADCEPass : public PM::PassInfo<ADCEPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
