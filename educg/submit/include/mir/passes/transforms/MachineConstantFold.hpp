// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#include "../../info.hpp"
#include <cstdint>
#include <utility>
#ifndef GNALC_MIR_TRANSFORMS_MACHINECONSTANTFOLD_HPP
#define GNALC_MIR_TRANSFORMS_MACHINECONSTANTFOLD_HPP

#include "../pass_manager.hpp"
#include <vector>

namespace MIR {

/// @note this pass is meant to fold add chains (with constant as op2)
/// @note generate when lowering geps which were used to get many dimension array addresses
/// @note so it will look like a cross-blks peephole
/// @note and with out use-def and SSA, this maybe tricky

class MachineConstantFold : public PM::PassManager<MachineConstantFold> {

public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

class MachineConstantFoldImpl {
private:
    FAM &fam;
    MIRFunction &mfunc;
    CodeGenContext &ctx;

    struct info {
        std::vector<MIRInst_p_l::iterator> iters;
        MIROperand_p chain_begin;
        MIROperand_p chain_end;
        std::vector<uint64_t> constants;

        info(MIRInst_p_l::iterator &_iter, MIROperand_p _begin, MIROperand_p _end, uint64_t _const)
            : chain_begin(std::move(_begin)), chain_end(std::move(_end)) {
            iters.emplace_back(_iter);
            constants.emplace_back(_const);
        }
    };

    std::list<info> infos;

    unsigned last_folded = 0;
    unsigned folded = 0;

public:
    MachineConstantFoldImpl(MIRFunction &_mfunc, FAM &_fam) : mfunc(_mfunc), fam(_fam), ctx(_mfunc.Context()) {}
    void Impl();

private:
    void clear();
    void runOnBlk(MIRBlk_p &);
    void match(MIRInst_p_l::iterator &);
    bool apply_fold();
};

} // namespace MIR
#endif