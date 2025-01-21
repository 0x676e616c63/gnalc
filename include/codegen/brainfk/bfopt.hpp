#pragma once
#ifndef GNALC_CODEGEN_BRAINFK_BFOPT_HPP
#define GNALC_CODEGEN_BRAINFK_BFOPT_HPP

#include "../../config/config.hpp"
#if GNALC_EXTENSION_BRAINFK

#include "bfmodule.hpp"

namespace BrainFk {
class BFOpt {
private:
  BFModule module;
public:
  void visit(const BFModule& input_module);
  BFModule& getModule() { return module; }
};
}
#endif
#endif
