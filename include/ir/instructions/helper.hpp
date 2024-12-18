/**
 * @brief 由于采取的IR生成策略是先生成指令流，再划分基本块，故定义一些LLVM IR中没有的指令用于辅助标记
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_HELPER_HPP
#define GNALC_IR_INSTRUCTIONS_HELPER_HPP

#include "../instruction.hpp"

namespace IR {

enum class HELPERTY {
    IFBEntry,
    IFBEnd,
    ELSEBEntry,
    ELSEBEnd,
    WHILEBEntry,
    WHILEBEnd
};

class HELPERInst : public Instruction {
private:
    HELPERTY hlp_type;
public:
    HELPERInst(HELPERTY _hlp_ty) : Instruction(OP::HELPER, "__HELPER", IRTYPE::UNDEFINED), hlp_type(_hlp_ty) {}
    HELPERTY getHlpType() { return hlp_type; }
    virtual void accept(IRVisitor& visitor) override = 0;
};

// IF Block Entry
class IFBEntry : public HELPERInst {
public:
    IFBEntry() : HELPERInst(HELPERTY::IFBEntry) {}
    void accept(IRVisitor& visitor) override;
};

class IFBEnd : public HELPERInst {
public:
    IFBEnd() : HELPERInst(HELPERTY::IFBEnd) {}
    void accept(IRVisitor& visitor) override;
};

class ELSEBEntry : public HELPERInst {
public:
    ELSEBEntry() : HELPERInst(HELPERTY::ELSEBEntry) {}
    void accept(IRVisitor& visitor) override;
};

class ELSEBEnd : public HELPERInst {
public:
    ELSEBEnd() : HELPERInst(HELPERTY::ELSEBEnd) {}
    void accept(IRVisitor& visitor) override;
};

class WHILEBEntry : public HELPERInst {
public:
    WHILEBEntry() : HELPERInst(HELPERTY::WHILEBEntry) {}
    void accept(IRVisitor& visitor) override;
};

class WHILEBEnd : public HELPERInst {
public:
    WHILEBEnd() : HELPERInst(HELPERTY::WHILEBEnd) {}
    void accept(IRVisitor& visitor) override;
};

}

#endif