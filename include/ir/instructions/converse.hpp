/**
 * @brief Conversion Operations
 * @brief fptosi, sitofp
 */


#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_CONVERSE_HPP
#define GNALC_IR_INSTRUCTIONS_CONVERSE_HPP

#include "../instruction.hpp"
#include "../constant.hpp"
#include <memory>

namespace IR {

// %Y = fptosi float 1.0E-247 to i32
// 默认全为float to i32
class FPTOSIInst : public Instruction {
private:
    // std::shared_ptr<BType> origin_type = makeBType(IRBTYPE::FLOAT);
public:
    FPTOSIInst(NameRef name, std::shared_ptr<Value> origin_val);

    std::shared_ptr<Value> getOVal() const;
    IRBTYPE getOType() const; // ORIGINAL TYPE FLOAT
    IRBTYPE getTType() const; // TARGET TYPE I32
    std::shared_ptr<Type> getOTypePtr() const;
    std::shared_ptr<Type> getTTypePtr() const;

    void accept(IRVisitor& visitor) override;
};

// <result> = sitofp <ty> <value> to <ty2>
class SITOFPInst : public Instruction {
private:
    // std::shared_ptr<BType> origin_type = makeBType(IRBTYPE::I32);
public:
    SITOFPInst(NameRef name, std::shared_ptr<Value> origin_val);

    std::shared_ptr<Value> getOVal() const;
    IRBTYPE getOType() const; // ORIGINAL TYPE I32
    IRBTYPE getTType() const; // TARGET TYPE FLOAT
    std::shared_ptr<Type> getOTypePtr() const;
    std::shared_ptr<Type> getTTypePtr() const;

    void accept(IRVisitor& visitor) override;
};

}

#endif