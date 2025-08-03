// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Loop Annotator
#pragma once
#ifndef GNALC_SIR_PASSES_TRANSFORMS_LOOP_ANNOTATOR_HPP
#define GNALC_SIR_PASSES_TRANSFORMS_LOOP_ANNOTATOR_HPP

#include "../pass_manager.hpp"
#include "../../../utils/enum_operator.hpp"

namespace SIR {
enum class LoopAttr {
    NoCarriedDependency,
};
GNALC_ENUM_OPERATOR(LoopAttr)
using LoopAttrs = Attr::BitFlagsAttr<LoopAttr>;

class LoopAnnotatorPass : public PM::PassInfo<LoopAnnotatorPass> {
public:
    PM::PreservedAnalyses run(LinearFunction &function, LFAM &lfam);
};

} // namespace SIR
#endif
