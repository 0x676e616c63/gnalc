#include "ir/passes/analysis/range_analysis.hpp"

#include "ir/base.hpp"
#include "ir/instructions/control.hpp"
#include "ir/passes/analysis/live_analysis.hpp"
#include "utils/logger.hpp"

#include <string>

namespace IR {
PM::UniqueKey RangeAnalysis::Key;

RangeResult RangeAnalysis::run(Function &func, FAM &fam) {
    return RangeResult{};
}
} // namespace IR