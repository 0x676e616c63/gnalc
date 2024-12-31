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
    virtual void visit(Module& node) { Err::not_implemented(); }
    virtual void visit(GlobalVariable& node) { Err::not_implemented(); }
    virtual void visit(Function& node) { Err::not_implemented(); }
    virtual void visit(FunctionDecl& node) { Err::not_implemented(); }
    virtual void visit(BasicBlock& node) { Err::not_implemented(); }
    virtual void visit(Instruction& node) { Err::not_implemented(); }
    virtual void visit(ConstantInt& node) { Err::not_implemented(); }
    virtual void visit(ConstantFloat& node) { Err::not_implemented(); }
    virtual void visit(BinaryInst& node) { Err::not_implemented(); }
    virtual void visit(FNEGInst& node) { Err::not_implemented(); }
    virtual void visit(ICMPInst& node) { Err::not_implemented(); }
    virtual void visit(FCMPInst& node) { Err::not_implemented(); }
    virtual void visit(RETInst& node) { Err::not_implemented(); }
    virtual void visit(BRInst& node) { Err::not_implemented(); }
    virtual void visit(CALLInst& node) { Err::not_implemented(); }
    virtual void visit(FPTOSIInst& node) { Err::not_implemented(); }
    virtual void visit(SITOFPInst& node) { Err::not_implemented(); }
    virtual void visit(IFBEntry& node) { Err::not_implemented(); }
    virtual void visit(IFBEnd& node) { Err::not_implemented(); }
    virtual void visit(ELSEBEntry& node) { Err::not_implemented(); }
    virtual void visit(ELSEBEnd& node) { Err::not_implemented(); }
    virtual void visit(WHILEBEntry& node) { Err::not_implemented(); }
    virtual void visit(WHILEBEnd& node) { Err::not_implemented(); }
    virtual void visit(ALLOCAInst& node) { Err::not_implemented(); }
    virtual void visit(LOADInst& node) { Err::not_implemented(); }
    virtual void visit(STOREInst& node) { Err::not_implemented(); }
    virtual void visit(GEPInst& node) { Err::not_implemented(); }
    virtual void visit(PHIInst& node) { Err::not_implemented(); }

    virtual ~IRVisitor() = default;
};
}

#endif
