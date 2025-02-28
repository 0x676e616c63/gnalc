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

template <typename SubPattern> struct OneUseMatch {
    SubPattern sub_pattern;

    explicit OneUseMatch(const SubPattern &sub_pattern_) : sub_pattern(sub_pattern_) {}

    template <typename T>
    bool match(const T &v) const {
        auto cast = PatternMatch::detail::ptrCast<Value>(v);
        return cast && cast->getUseCount() == 1 && sub_pattern.match(cast);
    }
};

template <typename T>
auto one_use(const T& sub_pattern) {
    return OneUseMatch(sub_pattern);
}

inline auto value_ci1() { return ClassMatch<ConstantI1>{}; }
inline auto value_ci8() { return ClassMatch<ConstantI8>{}; }
inline auto value_ci32() { return ClassMatch<ConstantInt>{}; }
inline auto value_cf32() { return ClassMatch<ConstantFloat>{}; }
inline auto value_constant() {
    return ClassesMatch<ConstantI1, ConstantI8, ConstantInt, ConstantFloat>{};
}

template <typename T>
struct ConstantProj {
    template <typename U>
    T operator()(const U &u) {
        return u.getVal();
    }
};

inline auto value_ci1(bool &a) {
    return ClassMatchBind<ConstantI1, bool, ConstantProj<bool>>{a};
}

inline auto value_ci8(char &a) {
    return ClassMatchBind<ConstantI8, char, ConstantProj<char>>{a};
}

inline auto value_ci32(int &a) {
    return ClassMatchBind<ConstantInt, int, ConstantProj<int>>{a};
}

inline auto value_cf32(float &a) {
    return ClassMatchBind<ConstantFloat, float, ConstantProj<float>>{a};
}

inline auto value_ci1(bool a) {
    return ClassMatchIf<ConstantI1>{[a](const ConstantI1 &b) {
        return a == b.getVal();
    }};
}

inline auto value_ci8(char a) {
    return ClassMatchIf<ConstantI8>{[a](const ConstantI8 &b) {
        return a == b.getVal();
    }};
}

inline auto value_ci32(int a) {
    return ClassMatchIf<ConstantInt>{[a](const ConstantInt &b) {
        return a == b.getVal();
    }};
}

inline auto value_cf32(float a) {
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

MAKE_INST_MATCH2(inst_ret, RET, 0, 1)
MAKE_INST_MATCH2(inst_br, BR, 1, 2)
MAKE_INST_MATCH(inst_fneg, FNEG, 1)
MAKE_INST_MATCH(inst_add, ADD, 2)
MAKE_INST_MATCH(inst_fadd, FADD, 2)
MAKE_INST_MATCH(inst_sub, SUB, 2)
MAKE_INST_MATCH(inst_fsub, FSUB, 2)
MAKE_INST_MATCH(inst_mul, MUL, 2)
MAKE_INST_MATCH(inst_fmul, FMUL, 2)
MAKE_INST_MATCH(inst_div, DIV, 2)
MAKE_INST_MATCH(inst_fdiv, FDIV, 2)
MAKE_INST_MATCH(inst_rem, REM, 2)
MAKE_INST_MATCH(inst_frem, FREM, 2)
MAKE_INST_MATCH(inst_alloca, ALLOCA, 0)
MAKE_INST_MATCH(inst_load, LOAD, 2)
MAKE_INST_MATCH(inst_store, STORE, 2)
MAKE_INST_MATCH_ANY(inst_gep, GEP)
MAKE_INST_MATCH(inst_fptosi, FPTOSI, 1)
MAKE_INST_MATCH(inst_sitosf, SITOFP, 1)
MAKE_INST_MATCH(inst_zext, ZEXT, 1)
MAKE_INST_MATCH(inst_bitcast, BITCAST, 1)
MAKE_INST_MATCH(inst_icmp, ICMP, 2)
MAKE_INST_MATCH(inst_fcmp, FCMP, 2)
MAKE_INST_MATCH_ANY(inst_phi, PHI)
MAKE_INST_MATCH_ANY(inst_call, CALL)

#undef MAKE_INST_MATCH
#undef MAKE_INST_MATCH2
#undef MAKE_INST_MATCH_ANY

} // namespace IR::M
#endif // GNALC_IR_PATTERN_PATTERN_MATCH_HPP
