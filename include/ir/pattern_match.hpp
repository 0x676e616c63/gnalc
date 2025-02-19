#pragma once
#ifndef GNALC_IR_PATTERN_PATTERN_MATCH_HPP
#define GNALC_IR_PATTERN_PATTERN_MATCH_HPP

#include "base.hpp"
#include "constant.hpp"
#include "instructions/binary.hpp"
#include "instructions/compare.hpp"
#include "instructions/control.hpp"
#include "instructions/converse.hpp"
#include "instructions/memory.hpp"
#include "instructions/phi.hpp"
#include "../pattern_match/pattern_match.hpp"

using namespace PatternMatch;
namespace IR::M {
inline auto value() { return ClassMatch<Value>{}; }

inline auto value(Value*& v) {
  return ClassMatchBind<Value, Value*>{v};
}

inline auto value(std::shared_ptr<Value>& v) {
  return ClassMatchBind<Value, std::shared_ptr<Value>>{v};
}

inline auto ci1() { return ClassMatch<ConstantI1>{}; }
inline auto ci8() { return ClassMatch<ConstantI8>{}; }
inline auto ci32() { return ClassMatch<ConstantInt>{}; }
inline auto cf32() { return ClassMatch<ConstantFloat>{}; }
inline auto constant() {
  return ClassesMatch<ConstantI1, ConstantI8, ConstantInt, ConstantFloat>{};
}

template <typename T>
struct ConstantProj {
  template <typename U>
  T operator()(const U& u) {
    return u.getVal();
  }
};

inline auto ci1(bool& a) {
  return ClassMatchBind<ConstantI1, bool, ConstantProj<bool>>{ a };
}

inline auto ci8(char& a) {
  return ClassMatchBind<ConstantI8, char, ConstantProj<char>>{ a };
}

inline auto ci32(int& a) {
  return ClassMatchBind<ConstantInt, int, ConstantProj<int>>{ a };
}

inline auto cf32(float& a) {
  return ClassMatchBind<ConstantFloat, float, ConstantProj<float>>{ a };
}

inline auto ci1(bool a) {
  return ClassMatchIf<ConstantI1>{[a](const ConstantI1& b) {
    return a == b.getVal();
  }};
}

inline auto ci8(char a) {
  return ClassMatchIf<ConstantI8>{[a](const ConstantI8& b) {
    return a == b.getVal();
  }};
}

inline auto ci32(int a) {
  return ClassMatchIf<ConstantInt>{[a](const ConstantInt& b) {
    return a == b.getVal();
  }};
}

inline auto cf32(float a) {
  return ClassMatchIf<ConstantFloat>{[a](const ConstantFloat& b) {
    return a == b.getVal();
  }};
}

struct IRInstInfo {
  using InstType = Instruction;
  using OpcodeType = OP;
  struct NumOperandsGetter {
    size_t operator()(const Instruction& inst) {
      return inst.getNumOperands();
    }
  };
  struct OperandGetter {
    auto operator()(const Instruction& inst, size_t idx) {
      return inst.getOperand(idx)->getValue();
    }
  };
  struct OpcodeGetter {
    OP operator()(const Instruction& inst) {
      return inst.getOpcode();
    }
  };
};

#define MAKE_INST_MATCH(pattern_name, opcode) \
template <typename... OperandPatterns> \
inline auto pattern_name(OperandPatterns &&...ops) { \
  return InstMatch<IRInstInfo, OP::opcode, OperandPatterns...>(std::forward<OperandPatterns>(ops)...); \
}

MAKE_INST_MATCH(ret, RET)
MAKE_INST_MATCH(br, BR)
MAKE_INST_MATCH(fneg, FNEG)
MAKE_INST_MATCH(add, ADD)
MAKE_INST_MATCH(fadd, FADD)
MAKE_INST_MATCH(sub, SUB)
MAKE_INST_MATCH(fsub, FSUB)
MAKE_INST_MATCH(mul, MUL)
MAKE_INST_MATCH(fmul, FMUL)
MAKE_INST_MATCH(div, DIV)
MAKE_INST_MATCH(fdiv, FDIV)
MAKE_INST_MATCH(rem, REM)
MAKE_INST_MATCH(frem, FREM)
MAKE_INST_MATCH(logical_and, AND) // Avoid conflict with C++ keyword `and`
MAKE_INST_MATCH(logical_or, OR) // Avoid conflict with C++ keyword `or`
MAKE_INST_MATCH(allocate, ALLOCA) // Avoid conflict with marco `alloca`
MAKE_INST_MATCH(load, LOAD)
MAKE_INST_MATCH(store, STORE)
MAKE_INST_MATCH(gep, GEP)
MAKE_INST_MATCH(fptosi, FPTOSI)
MAKE_INST_MATCH(sitosf, SITOFP)
MAKE_INST_MATCH(zext, ZEXT)
MAKE_INST_MATCH(bitcast, BITCAST)
MAKE_INST_MATCH(icmp, ICMP)
MAKE_INST_MATCH(fcmp, FCMP)
MAKE_INST_MATCH(phi, PHI)
MAKE_INST_MATCH(call, CALL)

#undef MAKE_INST_MATCH

} // namespace IR::M
#endif // GNALC_IR_PATTERN_PATTERN_MATCH_HPP
