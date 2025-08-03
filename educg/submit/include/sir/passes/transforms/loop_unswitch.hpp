// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Loop Unswitch
#pragma once
#ifndef GNALC_SIR_PASSES_TRANSFORMS_LOOP_UNSWITCH_HPP
#define GNALC_SIR_PASSES_TRANSFORMS_LOOP_UNSWITCH_HPP

#include "../pass_manager.hpp"

namespace SIR {
enum class UnswitchAttr {
    InvariantUnswitched = 1 << 1,
    Partitioned = 1 << 2,
};

GNALC_ENUM_OPERATOR(UnswitchAttr)
using UnswitchAttrs = Attr::BitFlagsAttr<UnswitchAttr>;

class LoopUnswitchPass : public PM::PassInfo<LoopUnswitchPass> {
public:
    PM::PreservedAnalyses run(LinearFunction &function, LFAM &lfam);

    explicit LoopUnswitchPass(bool enable_partition = false) : enable_partition(enable_partition) {}
private:
    bool enable_partition = true;
    size_t name_cnt = 0;
};

} // namespace SIR
#endif
