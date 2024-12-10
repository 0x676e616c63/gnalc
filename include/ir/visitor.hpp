/**
 * @brief 访问者模式实现的抽象基类IRVisitor
 */

#pragma once
#ifndef GNALC_IR_VISITOR_HPP
#define GNALC_IR_VISITOR_HPP

#include "basic_block.hpp"
#include "constant.hpp"
#include "function.hpp"
#include "global_var.hpp"
#include "instruction.hpp"
#include "module.hpp"
#include "instructions/binary.hpp"
#include "instructions/compare.hpp"
#include "instructions/control.hpp"
#include "instructions/converse.hpp"
#include "instructions/helper.hpp"
#include "instructions/memory.hpp"
#include "instructions/phi.hpp"

namespace IR {

class IRVisitor {
public:
    // virtual void visit(example& node) {}
    virtual void visit(Module& node) {}
    virtual void visit(GlobalVariable& node) {}
    virtual void visit(Function& node) {}
    virtual void visit(BasicBlock& node) {}
    virtual void visit(Instruction& node) {}
    virtual void visit(ConstantInt& node) {}
    virtual void visit(ConstantFloat& node) {}
    virtual void visit(BinaryInst& node) {}
    virtual void visit(FNEGInst& node) {}
    virtual void visit(ICMPInst& node) {}
    virtual void visit(FCMPInst& node) {}
    virtual void visit(RETInst& node) {}
    virtual void visit(BRInst& node) {}
    virtual void visit(CALLInst& node) {}
    virtual void visit(FPTOSIInst& node) {}
    virtual void visit(SITOFPInst& node) {}
    virtual void visit(IFBEntry& node) {}
    virtual void visit(IFBEnd& node) {}
    virtual void visit(ELSEBEntry& node) {}
    virtual void visit(ELSEBEnd& node) {}
    virtual void visit(WHILEBEntry& node) {}
    virtual void visit(WHILEBEnd& node) {}
    virtual void visit(ALLOCAInst& node) {}
    virtual void visit(LOADInst& node) {}
    virtual void visit(STOREInst& node) {}
    virtual void visit(GEPInst& node) {}
    virtual void visit(PHIInst& node) {}

    virtual ~IRVisitor() = default;
};

}

#endif