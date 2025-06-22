#ifndef GNALC_MIR_PASSES_PRERALEGALIZE_HPP
#define GNALC_MIR_PASSES_PRERALEGALIZE_HPP

#include "mir/passes/pass_manager.hpp"

namespace MIR {

class PreRAlegalize : public PM::PassInfo<PreRAlegalize> {

public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

///@todo need put in a fam
void preLegalizeFuncImpl(MIRFunction &, CodeGenContext &);

}; // namespace MIR_new

#endif