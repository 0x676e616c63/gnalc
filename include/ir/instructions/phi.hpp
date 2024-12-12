/**
 * @brief phi
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_PHI_HPP
#define GNALC_IR_INSTRUCTIONS_PHI_HPP

#include "../instruction.hpp"

namespace IR {

class PHIInst : public Instruction {
public:
    void accept(IRVisitor& visitor) override;
};

}

#endif