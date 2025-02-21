#pragma once
#ifndef GNALC_IR_PATTERN_PATTERN_MATCH_HPP
#define GNALC_IR_PATTERN_PATTERN_MATCH_HPP

#include "../pattern_match/pattern_match.hpp"
#include "base.hpp"
#include "constant.hpp"
#include "instructions/binary.hpp"
#include "instructions/compare.hpp"
#include "instructions/control.hpp"
#include "instructions/converse.hpp"
#include "instructions/memory.hpp"
#include "instructions/phi.hpp"

using namespace PatternMatch;
namespace IR::M {
inline auto value() { return ClassMatch<Value>{}; }

inline auto value(Value *&v) {
    return ClassMatchBind<Value, Value *>{v};
}

inline auto value(std::shared_ptr<Value> &v) {
    return ClassMatchBind<Value, std::shared_ptr<Value>>{v};
}

inline auto inst() { return ClassMatch<Instruction>{}; }

inline auto inst(Instruction *&v) {
    return ClassMatchBind<Instruction, Instruction *>{v};
}

inline auto inst(std::shared_ptr<Instruction> &v) {
    return ClassMatchBind<Instruction, std::shared_ptr<Instruction>>{v};
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
    T operator()(const U &u) {
        return u.getVal();
    }
};

inline auto ci1(bool &a) {
    return ClassMatchBind<ConstantI1, bool, ConstantProj<bool>>{a};
}

inline auto ci8(char &a) {
    return ClassMatchBind<ConstantI8, char, ConstantProj<char>>{a};
}

inline auto ci32(int &a) {
    return ClassMatchBind<ConstantInt, int, ConstantProj<int>>{a};
}

inline auto cf32(float &a) {
    return ClassMatchBind<ConstantFloat, float, ConstantProj<float>>{a};
}

inline auto ci1(bool a) {
    return ClassMatchIf<ConstantI1>{[a](const ConstantI1 &b) {
        return a == b.getVal();
    }};
}

inline auto ci8(char a) {
    return ClassMatchIf<ConstantI8>{[a](const ConstantI8 &b) {
        return a == b.getVal();
    }};
}

inline auto ci32(int a) {
    return ClassMatchIf<ConstantInt>{[a](const ConstantInt &b) {
        return a == b.getVal();
    }};
}

inline auto cf32(float a) {
    return ClassMatchIf<ConstantFloat>{[a](const ConstantFloat &b) {
        return a == b.getVal();
    }};
}

struct IRInstInfo {
    using InstType = Instruction;
    using OpcodeType = OP;
    struct NumOperandsGetter {
        size_t operator()(const Instruction &inst) {
            return inst.getNumOperands();
        }
    };
    struct OperandGetter {
        auto operator()(const Instruction &inst, size_t idx) {
            return inst.getOperand(idx)->getValue();
        }
    };
    struct OpcodeGetter {
        OP operator()(const Instruction &inst) {
            return inst.getOpcode();
        }
    };
};

struct SharedPtrValueProj {
    Value *operator()(const std::shared_ptr<Value> &u) {
        return u.get();
    }
};

template <size_t NumOperands>
auto same_operands(const std::shared_ptr<Value> &which = nullptr) {
    return IdenticalOperandInstMatch<IRInstInfo, NumOperands>{which};
}

template <size_t NumOperands>
auto same_operands(const Value *which) {
    return IdenticalOperandInstMatch<IRInstInfo, NumOperands, SharedPtrValueProj>{which};
}

template <OP opcode, size_t NumOperands>
auto same_operands(const std::shared_ptr<Value> &which = nullptr) {
    return IdenticalOperandInstMatchWithOp<IRInstInfo, opcode, NumOperands>{which};
}

template <OP opcode, size_t NumOperands>
auto same_operands(const Value *which) {
    return IdenticalOperandInstMatchWithOp<IRInstInfo, opcode, NumOperands, SharedPtrValueProj>{which};
}

// Match Inst and Operand
#define MAKE_INST_MATCH2(pattern_name, opcode, num0, num1)                                                   \
    template <typename... OperandPatterns>                                                                   \
    auto pattern_name(OperandPatterns &&...ops) {                                                            \
        static_assert(sizeof...(OperandPatterns) == (num0) || sizeof...(OperandPatterns) == (num1),          \
                      "Number of operands mismatched");                                                      \
        return InstMatch<IRInstInfo, OP::opcode, OperandPatterns...>(std::forward<OperandPatterns>(ops)...); \
    }

#define MAKE_INST_MATCH(pattern_name, opcode, num0) MAKE_INST_MATCH2(pattern_name, opcode, num0, num0)

#define MAKE_INST_MATCH_ANY(pattern_name, opcode)                                                            \
    template <typename... OperandPatterns>                                                                   \
    auto pattern_name(OperandPatterns &&...ops) {                                                            \
        return InstMatch<IRInstInfo, OP::opcode, OperandPatterns...>(std::forward<OperandPatterns>(ops)...); \
    }

MAKE_INST_MATCH2(ret, RET, 0, 1)
MAKE_INST_MATCH2(br, BR, 1, 2)
MAKE_INST_MATCH(fneg, FNEG, 1)
MAKE_INST_MATCH(add, ADD, 2)
MAKE_INST_MATCH(fadd, FADD, 2)
MAKE_INST_MATCH(sub, SUB, 2)
MAKE_INST_MATCH(fsub, FSUB, 2)
MAKE_INST_MATCH(mul, MUL, 2)
MAKE_INST_MATCH(fmul, FMUL, 2)
MAKE_INST_MATCH(div, DIV, 2)
MAKE_INST_MATCH(fdiv, FDIV, 2)
MAKE_INST_MATCH(rem, REM, 2)
MAKE_INST_MATCH(frem, FREM, 2)
MAKE_INST_MATCH(allocate, ALLOCA, 0) // Avoid conflict with marco `alloca`
MAKE_INST_MATCH(load, LOAD, 2)
MAKE_INST_MATCH(store, STORE, 2)
MAKE_INST_MATCH_ANY(gep, GEP)
MAKE_INST_MATCH(fptosi, FPTOSI, 1)
MAKE_INST_MATCH(sitosf, SITOFP, 1)
MAKE_INST_MATCH(zext, ZEXT, 1)
MAKE_INST_MATCH(bitcast, BITCAST, 1)
MAKE_INST_MATCH(icmp, ICMP, 2)
MAKE_INST_MATCH(fcmp, FCMP, 2)
MAKE_INST_MATCH_ANY(phi, PHI)
MAKE_INST_MATCH_ANY(call, CALL)

#undef MAKE_INST_MATCH
#undef MAKE_INST_MATCH2
#undef MAKE_INST_MATCH_ANY

} // namespace IR::M
#endif // GNALC_IR_PATTERN_PATTERN_MATCH_HPP
