#pragma once
#ifndef GNALC_ARMV8_MIR_PASSES_TRANSFORMS_POSTRALEGALILZE_HPP
#define GNALC_ARMV8_MIR_PASSES_TRANSFORMS_POSTRALEGALILZE_HPP

#include "mir/passes/pass_manager.hpp"

namespace MIR_new {

class PostRAlegalize : public PM::PassInfo<PostRAlegalize> {
public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

class PostRAlegalizeImpl {
private:
    MIRFunction *mfunc;

public:
    void impl(MIRFunction &, FAM &);
    void runOnBlk(MIRBlk_p, CodeGenContext &ctx);
    void runOnInst(MIRInst_p, MIRInst_p_l, MIRInst_p_l::iterator, CodeGenContext &ctx);
};

}; // namespace MIR_new

#endif