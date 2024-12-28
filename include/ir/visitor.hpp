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
    virtual void visit(Module& node) { Err::unreachable(); }
    virtual void visit(GlobalVariable& node) { Err::unreachable(); }
    virtual void visit(Function& node) { Err::unreachable(); }
    virtual void visit(BasicBlock& node) { Err::unreachable(); }
    virtual void visit(Instruction& node) { Err::unreachable(); }
    virtual void visit(ConstantInt& node) { Err::unreachable(); }
    virtual void visit(ConstantFloat& node) { Err::unreachable(); }
    virtual void visit(BinaryInst& node) { Err::unreachable(); }
    virtual void visit(FNEGInst& node) { Err::unreachable(); }
    virtual void visit(ICMPInst& node) { Err::unreachable(); }
    virtual void visit(FCMPInst& node) { Err::unreachable(); }
    virtual void visit(RETInst& node) { Err::unreachable(); }
    virtual void visit(BRInst& node) { Err::unreachable(); }
    virtual void visit(CALLInst& node) { Err::unreachable(); }
    virtual void visit(FPTOSIInst& node) { Err::unreachable(); }
    virtual void visit(SITOFPInst& node) { Err::unreachable(); }
    virtual void visit(IFBEntry& node) { Err::unreachable(); }
    virtual void visit(IFBEnd& node) { Err::unreachable(); }
    virtual void visit(ELSEBEntry& node) { Err::unreachable(); }
    virtual void visit(ELSEBEnd& node) { Err::unreachable(); }
    virtual void visit(WHILEBEntry& node) { Err::unreachable(); }
    virtual void visit(WHILEBEnd& node) { Err::unreachable(); }
    virtual void visit(ALLOCAInst& node) { Err::unreachable(); }
    virtual void visit(LOADInst& node) { Err::unreachable(); }
    virtual void visit(STOREInst& node) { Err::unreachable(); }
    virtual void visit(GEPInst& node) { Err::unreachable(); }
    virtual void visit(PHIInst& node) { Err::unreachable(); }

    virtual ~IRVisitor() = default;
};
}

#endif
