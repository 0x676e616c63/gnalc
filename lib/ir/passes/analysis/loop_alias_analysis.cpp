#include "ir/passes/analysis/loop_alias_analysis.hpp"

namespace IR {
PM::UniqueKey LoopAliasAnalysis::Key;

bool LoopAAResult::overlap(const LocationSet &lhs, const LocationSet &rhs) const {

}

AliasInfo LoopAAResult::getAliasInfo(Value *v1, Value *v2) const {

}

AliasInfo LoopAAResult::getAliasInfo(const pVal &v1, const pVal &v2) const {

}

ModRefInfo LoopAAResult::getInstModRefInfo(Instruction *inst, Value *location, FAM &fam) const {

}

ModRefInfo LoopAAResult::getInstModRefInfo(const pInst &inst, const pVal &location, FAM &fam) const {

}

LoopAAResult LoopAliasAnalysis::run(Function &func, FAM &fam) {
    LoopAAResult res;
    auto& scev = fam.getResult<SCEVAnalysis>(func);

    return res;
}
} // namespace IR
