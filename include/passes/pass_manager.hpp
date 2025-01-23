#pragma once
#ifndef GNALC_PASSES_PASS_MANAGER_HPP
#define GNALC_PASSES_PASS_MANAGER_HPP

#include "pass.hpp"

#include <vector>

namespace IR
{
class PassManager {
  std::vector<ModulePass*> module_passes;
public:
  PassManager() = default;
  template<typename T, typename... Args>
  void registerModulePass(Args&& ...args) {
    module_passes.emplace_back(new T(std::forward<Args>(args)...));
  }

  void runOnModule(Module& module);

  ~PassManager();
  PassManager(const PassManager&) = delete;
  PassManager(PassManager&&) = delete;
  PassManager& operator=(const PassManager&) = delete;
};

struct OptInfo {
  bool mem2reg { false };
};

extern const OptInfo o1_opt_info;

void register_default_pass(PassManager&, OptInfo opt_info);
}
#endif