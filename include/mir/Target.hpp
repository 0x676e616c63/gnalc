#pragma once
#ifndef GNALC_ARMV8_MIR_TARGET_HPP
#define GNALC_ARMV8_MIR_TARGET_HPP

#include "ir/instructions/control.hpp"
#include <string>

namespace MIR_new {
using string = std::string;

struct DataLayOut {
    enum class Endian { little, big } endian;
    const unsigned builtInAlignment;
    const unsigned pointerSize;
    const unsigned codeAlignment;
    const unsigned storeAlignment;
};

class Target {
public:
    const DataLayOut dataLayOut;
};

class LoweringContext; // defined in lowering.hpp
class MIRFunction;
class MIROperand;

class TargetFrameInfo {
public:
    TargetFrameInfo() = default;
    ~TargetFrameInfo() = default;

    void emitCall(IR::pCall, LoweringContext &) const;
    void emitPrologue(std::shared_ptr<MIRFunction>, LoweringContext &) const;
    void emitReturn(IR::pRet, LoweringContext &) const;

    bool isCallerSaved(const MIROperand &op) const;
    bool isCalleeSaved(const MIROperand &op) const;

    size_t getStackPointerAlignment() const;
};

struct CodeGenContext {
    const Target &target;

    const TargetFrameInfo &frameInfo;

    unsigned idx = 0;
    unsigned nextId() { return ++idx; }

    unsigned idx_l = 0;
    string nextBlkLable(const string &func_name) {
        return func_name + "_blk_" + std::to_string(idx_l++); //
    }
};
}; // namespace MIR_new

#endif