#pragma once
#ifndef GNALC_MIR_PASSES_TRANSFORMS_USELESSBLKELI_HPP
#define GNALC_MIR_PASSES_TRANSFORMS_USELESSBLKELI_HPP

#include "../pass_manager.hpp"

namespace MIR {
class uselessBlkEli : public PM::PassInfo<uselessBlkEli> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);

private:
    Function *func;

    void impl(); // 删除块的过程应该不会产生新的无用块
    bool isUseless(const BlkP &);
    void blkConsolidate(const BlkP &); // 合并
};
}; // namespace MIR

#endif