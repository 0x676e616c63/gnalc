#pragma once
#ifndef GNALC_MIR_PASSES_TRANSFORMS_LEGALIZE_HPP
#define GNALC_MIR_PASSES_TRANSFORMS_LEGALIZE_HPP

#include "../../SIMDinstruction/memory.hpp"
#include "../../instructions/memory.hpp"
#include "../pass_manager.hpp"

namespace MIR {

/// @brief 探测ldr, str(0 ~ 4095), vldr, vstr(0 ~ 1020)中超过范围的立即数
class PreRALegalize : public PM::PassInfo<PreRALegalize> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);

private:
    Function &func;
    VarPool &varpool;

    void runOnBlk(const BlkP &);
    void runOnInst(const BlkP &, const InstP &);

    void addInstBefore(const BlkP &, const std::shared_ptr<ldrInst> &);
    void addInstBefore(const BlkP &, const std::shared_ptr<strInst> &);
    void addInstBefore(const BlkP &, const std::shared_ptr<Vldr> &);
    void addInstBefore(const BlkP &, const std::shared_ptr<Vstr> &);
};

} // namespace MIR
#endif
