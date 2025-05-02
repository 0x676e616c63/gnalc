#include "mir/passes/transforms/PreRAlegalize.hpp"

using namespace MIR_new;

PM::PreservedAnalyses PreRAlegalize::run(MIRFunction &mfunc, FAM &fam) {
    preLegalizeFuncImpl(mfunc, mfunc.CodeGenContext());

    return PM::PreservedAnalyses::all();
}

void MIR_new::preLegalizeFuncImpl(MIRFunction &mfunc, CodeGenContext &ctx) {

    for (auto &mblk : mfunc.blks()) {

        auto minsts = mblk->Insts();
        for (auto iter = minsts.begin(); iter != minsts.end(); ++iter) {
            InstLegalizeContext _ctx{*iter, minsts, iter, ctx};
            ctx.iselInfo.preLegalizeInst(_ctx);
        }
    }
}
