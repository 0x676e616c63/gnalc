// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../include/sir/passes/pass_manager.hpp"

namespace PM {
template class AnalysisManager<IR::LinearFunction>;
template class PassManager<IR::LinearFunction>;
template class InnerAnalysisManagerProxy<AnalysisManager<IR::LinearFunction>, IR::Module>;
} // namespace PM
