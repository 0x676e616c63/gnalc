#pragma once
#ifndef GNALC_PASSES_PASS_HPP
#define GNALC_PASSES_PASS_HPP

#include "../ir/visitor.hpp"

#include <vector>
#include <algorithm>

namespace IR {

class Pass {
public:
  virtual ~Pass() = default;
};

class ModulePass : public Pass {
public:
  virtual void runOnModule(Module&) = 0;
  virtual void afterRunCleanup(Module&) {}
};

// TODO:
// FunctionPass
// CGSCCPass
// LoopPass
// RegionPass
}
#endif