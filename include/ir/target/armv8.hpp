#pragma once
#ifndef GNALC_IR_TARGET_ARMv8_HPP
#define GNALC_IR_TARGET_ARMv8_HPP

#include "ir/base.hpp"
#include "ir/instruction.hpp"
#include "target.hpp"

namespace IR {
class ARMv8TargetInfo : public TargetInfo {
public:
    bool isInstSupported(OP op) override {
        return true;
    }
    bool isTypeSupported(const pType& type) override {
        if (type->isI128())
            return false;
        return true;
    }
    bool isLibCallSupported(const std::string &lib_fn_name) override {
        return true;
    }
};
}
#endif //TARGET_HPP
