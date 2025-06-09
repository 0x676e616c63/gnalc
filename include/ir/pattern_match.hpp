#pragma once
#ifndef GNALC_IR_PATTERN_PATTERN_MATCH_HPP
#define GNALC_IR_PATTERN_PATTERN_MATCH_HPP

#include "base.hpp"
#include "constant.hpp"
#include "instructions/binary.hpp"
#include "instructions/control.hpp"
#include "instructions/converse.hpp"
#include "instructions/memory.hpp"
#include "instructions/vector.hpp"
#include "pattern_match/pattern_match.hpp"

using namespace PatternMatch;
namespace IR::M {
inline auto Val() { return ClassMatch<Value>{}; }

inline auto Bind(Value *&v) { return ClassMatchBind<Value, Value *>{v}; }

inline auto Bind(pVal &v) { return ClassMatchBind<Value, pVal>{v}; }

inline auto Inst() { return ClassMatch<Instruction>{}; }

inline auto Bind(Instruction *&v) { return ClassMatchBind<Instruction, Instruction *>{v}; }

inline auto Bind(pInst &v) { return ClassMatchBind<Instruction, pInst>{v}; }

inline auto Block() { return ClassMatch<BasicBlock>{}; }

inline auto Bind(BasicBlock *&v) { return ClassMatchBind<BasicBlock, BasicBlock *>{v}; }

inline auto Bind(pBlock &v) { return ClassMatchBind<BasicBlock, pBlock>{v}; }

template <typename SubPattern> struct OneUseMatch {
    SubPattern sub_pattern;

    explicit OneUseMatch(const SubPattern &sub_pattern_) : sub_pattern(sub_pattern_) {}

    template <typename T> bool match(const T &v) const {
        auto cast = PatternMatch::detail::ptrCast<Value>(v);
        return cast && cast->getUseCount() == 1 && sub_pattern.match(cast);
    }
};

template <typename T> auto OneUse(const T &sub_pattern) { return OneUseMatch(sub_pattern); }

inline auto I1() { return ClassMatch<ConstantI1>{}; }
inline auto I8() { return ClassMatch<ConstantI8>{}; }
inline auto I32() { return ClassMatch<ConstantInt>{}; }
inline auto F32() { return ClassMatch<ConstantFloat>{}; }
inline auto Const() { return ClassesMatch<ConstantI1, ConstantI8, ConstantInt, ConstantFloat>{}; }

template <typename T> struct ConstantProj {
    template <typename U> T operator()(const U &u) { return u->getVal(); }
};

inline auto Bind(bool &a) { return ClassMatchBind<ConstantI1, bool, ConstantProj<bool>>{a}; }

inline auto Bind(char &a) { return ClassMatchBind<ConstantI8, char, ConstantProj<char>>{a}; }

inline auto Bind(int &a) { return ClassMatchBind<ConstantInt, int, ConstantProj<int>>{a}; }

inline auto Bind(float &a) { return ClassMatchBind<ConstantFloat, float, ConstantProj<float>>{a}; }

// Imagine something like
//
//   match(inst, M::Sub(M::Bind(x), M::Is(x))
//
// Though the evaluation order in C++ is undefined, and the `M::Is` can be invoked first,
// that doesn't matter. Because the Binding (`M::VBind`) and predicate (`M::Is`) expressions
// are evaluated lazily. The actual pattern matching occurs when `match()` is invoked,
// not during expression construction.
//
// Also, in `InstMatch`, parameters are matched in the order they appear in the `match()` expression,
// which guarantees `M::Bind` operations execute before dependent `M::Is` checks.
// This, however, requires the `M::Is` to take a reference as its parameter
// and transfer that reference to the predicate. Thus, when `M::Is`'s predicate is invoked
// by `InstMatch::match`, the desired value has already been bound by reference in `M::Bind`.
inline auto Is(const Value *&v) {
    return ClassMatchIf<Value>{[&v](const Value &b) { return v == &b; }};
}

inline auto Is(const pVal &v) {
    return ClassMatchIf<Value>{[&v](const Value &b) { return v.get() == &b; }};
}

inline auto Is(const Instruction *&v) {
    return ClassMatchIf<Instruction>{[&v](const Value &b) { return v == &b; }};
}

inline auto Is(const pInst &v) {
    return ClassMatchIf<Instruction>{[&v](const Value &b) { return v.get() == &b; }};
}

inline auto Is(const bool &a) {
    return ClassMatchIf<ConstantI1>{[&a](const ConstantI1 &b) { return a == b.getVal(); }};
}

inline auto Is(const char &a) {
    return ClassMatchIf<ConstantI8>{[&a](const ConstantI8 &b) { return a == b.getVal(); }};
}

inline auto Is(const int &a) {
    return ClassMatchIf<ConstantInt>{[&a](const ConstantInt &b) { return a == b.getVal(); }};
}

inline auto Is(const float &a) {
    return ClassMatchIf<ConstantFloat>{[&a](const ConstantFloat &b) { return a == b.getVal(); }};
}

struct IRInstInfo {
    using InstType = Instruction;
    using OpcodeType = OP;
    struct NumOperandsGetter {
        size_t operator()(const Instruction &inst) { return inst.getNumOperands(); }
    };
    struct OperandGetter {
        auto operator()(const Instruction &inst, size_t idx) { return inst.getOperand(idx)->getValue(); }
    };
    struct OpcodeGetter {
        OP operator()(const Instruction &inst) { return inst.getOpcode(); }
    };
};

// Match Inst and Operand, with compile-time checks for instruction operand patterns.
#define MAKE_INST_MATCH2(pattern_name, opcode, num0, num1)                                                             \
    template <typename... OperandPatterns> auto pattern_name(OperandPatterns &&...ops) {                               \
        static_assert(sizeof...(OperandPatterns) == (num0) || sizeof...(OperandPatterns) == (num1),                    \
                      "Number of operands mismatched");                                                                \
        return InstMatch<IRInstInfo, OP::opcode, OperandPatterns...>(std::forward<OperandPatterns>(ops)...);           \
    }

#define MAKE_INST_MATCH(pattern_name, opcode, num0) MAKE_INST_MATCH2(pattern_name, opcode, num0, num0)

#define MAKE_INST_MATCH_ANY(pattern_name, opcode)                                                                      \
    template <typename... OperandPatterns> auto pattern_name(OperandPatterns &&...ops) {                               \
        return InstMatch<IRInstInfo, OP::opcode, OperandPatterns...>(std::forward<OperandPatterns>(ops)...);           \
    }

MAKE_INST_MATCH2(Ret, RET, 0, 1)
MAKE_INST_MATCH2(Br, BR, 1, 2)
MAKE_INST_MATCH(Fneg, FNEG, 1)
MAKE_INST_MATCH(Add, ADD, 2)
MAKE_INST_MATCH(Fadd, FADD, 2)
MAKE_INST_MATCH(Sub, SUB, 2)
MAKE_INST_MATCH(Fsub, FSUB, 2)
MAKE_INST_MATCH(Mul, MUL, 2)
MAKE_INST_MATCH(Fmul, FMUL, 2)
MAKE_INST_MATCH(Div, DIV, 2)
MAKE_INST_MATCH(Fdiv, FDIV, 2)
MAKE_INST_MATCH(Rem, SREM, 2)
MAKE_INST_MATCH(Frem, FREM, 2)
MAKE_INST_MATCH(Alloca, ALLOCA, 0)
MAKE_INST_MATCH(Load, LOAD, 1)
MAKE_INST_MATCH(Store, STORE, 2)
MAKE_INST_MATCH_ANY(Gep, GEP)
MAKE_INST_MATCH(Fptosi, FPTOSI, 1)
MAKE_INST_MATCH(Sitofp, SITOFP, 1)
MAKE_INST_MATCH(Zext, ZEXT, 1)
MAKE_INST_MATCH(Bitcast, BITCAST, 1)
MAKE_INST_MATCH(Icmp, ICMP, 2)
MAKE_INST_MATCH(Fcmp, FCMP, 2)
MAKE_INST_MATCH(Extract, EXTRACT, 2)
MAKE_INST_MATCH(Insert, INSERT, 3)
MAKE_INST_MATCH(Shuffle, SHUFFLE, 3)
MAKE_INST_MATCH(Select, SELECT, 3)
MAKE_INST_MATCH_ANY(Phi, PHI)
MAKE_INST_MATCH_ANY(Call, CALL)

#undef MAKE_INST_MATCH
#undef MAKE_INST_MATCH2
#undef MAKE_INST_MATCH_ANY
} // namespace IR::M
#endif // GNALC_IR_PATTERN_PATTERN_MATCH_HPP
