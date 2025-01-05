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

namespace IR
{
class IRVisitor {
public:
    // virtual void visit(example& node) {}
    virtual void visit(Module& node) { Err::not_implemented("IRVisitor::visit(Module&)"); }
    virtual void visit(GlobalVariable& node) { Err::not_implemented("IRVisitor::visit(GlobalVariable&)"); }
    virtual void visit(Function& node) { Err::not_implemented("IRVisitor::visit(Function&)"); }
    virtual void visit(FunctionDecl& node) { Err::not_implemented("IRVisitor::visit(FunctionDecl&)"); }
    virtual void visit(BasicBlock& node) { Err::not_implemented("IRVisitor::visit(BasicBlock&)"); }
    virtual void visit(Instruction& node) { Err::not_implemented("IRVisitor::visit(Instruction&)"); }
    virtual void visit(ConstantInt& node) { Err::not_implemented("IRVisitor::visit(ConstantInt&)"); }
    virtual void visit(ConstantFloat& node) { Err::not_implemented("IRVisitor::visit(ConstantFloat&)"); }
    virtual void visit(ConstantI1& node) { Err::not_implemented("IRVisitor::visit(ConstantI1&)"); }
    virtual void visit(BinaryInst& node) { Err::not_implemented("IRVisitor::visit(BinaryInst&)"); }
    virtual void visit(FNEGInst& node) { Err::not_implemented("IRVisitor::visit(FNEGInst&)"); }
    virtual void visit(ICMPInst& node) { Err::not_implemented("IRVisitor::visit(ICMPInst&)"); }
    virtual void visit(FCMPInst& node) { Err::not_implemented("IRVisitor::visit(FCMPInst&)"); }
    virtual void visit(RETInst& node) { Err::not_implemented("IRVisitor::visit(RETInst&)"); }
    virtual void visit(BRInst& node) { Err::not_implemented("IRVisitor::visit(BRInst&)"); }
    virtual void visit(CALLInst& node) { Err::not_implemented("IRVisitor::visit(CALLInst&)"); }
    virtual void visit(FPTOSIInst& node) { Err::not_implemented("IRVisitor::visit(FPTOSIInst&)"); }
    virtual void visit(SITOFPInst& node) { Err::not_implemented("IRVisitor::visit(SITOFPInst&)"); }
    virtual void visit(ZEXTInst& node) { Err::not_implemented("IRVisitor::visit(ZEXTInst&)"); }
    virtual void visit(IFInst& node) { Err::not_implemented("IRVisitor::visit(IFInst&)"); }
    virtual void visit(WHILEInst& node) { Err::not_implemented("IRVisitor::visit(WHILEInst&)"); }
    virtual void visit(BREAKInst& node) { Err::not_implemented("IRVisitor::visit(BREAKInst&)"); }
    virtual void visit(CONTINUEInst& node) { Err::not_implemented("IRVisitor::visit(CONTINUEInst&)"); }
    virtual void visit(ALLOCAInst& node) { Err::not_implemented("IRVisitor::visit(ALLOCAInst&)"); }
    virtual void visit(LOADInst& node) { Err::not_implemented("IRVisitor::visit(LOADInst&)"); }
    virtual void visit(STOREInst& node) { Err::not_implemented("IRVisitor::visit(STOREInst&)"); }
    virtual void visit(GEPInst& node) { Err::not_implemented("IRVisitor::visit(GEPInst&)"); }
    virtual void visit(PHIInst& node) { Err::not_implemented("IRVisitor::visit(PHIInst&)"); }

    virtual ~IRVisitor() = default;
};
}

#endif
