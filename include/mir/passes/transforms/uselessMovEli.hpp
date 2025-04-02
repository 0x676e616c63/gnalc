#pragma once
#ifndef GNALC_MIR_PASSES_TRANSFORMS_USELESSMOVELI_HPP
#define GNALC_MIR_PASSES_TRANSFORMS_USELESSMOVELI_HPP

#include "../pass_manager.hpp"
#include "registeralloc.hpp"

namespace MIR {

///@note 主要扫描 COPY/mov/vmov 是否是无用的移动指令

class uselessMovEli : public PM::PassInfo<uselessMovEli> {
public:
    PM::PreservedAnalyses run(Function &func, FAM &fam);

    friend class RAPass;

private:
    Function *function;

    void impl(Function &);

    static bool isUseless(const InstP &);
};

}; // namespace MIR

#endif