#pragma once
#ifndef GNALC_CODEGEN_BRAINFK_BFGEN_HPP
#define GNALC_CODEGEN_BRAINFK_BFGEN_HPP

#include "../../ir/visitor.hpp"
#include "bfmodule.hpp"

namespace BrainFk {
class BFGenerator : public IR::IRVisitor {
    BFModule module;
    std::vector<std::vector<BFInstruction>> trivial_funcs; // except main
public:
    void visit(IR::Module& node) override;
    void visit(IR::GlobalVariable& node) override;
    void visit(IR::Function& node) override;
    void visit(IR::FunctionDecl& node) override;
    void visit(IR::BasicBlock& node) override;
    void visit(IR::ConstantInt& node) override;
    void visit(IR::ConstantFloat& node) override;
    void visit(IR::ConstantI1& node) override;
    void visit(IR::ConstantI8& node) override;
    void visit(IR::BinaryInst& node) override;
    void visit(IR::FNEGInst& node) override;
    void visit(IR::ICMPInst& node) override;
    void visit(IR::FCMPInst& node) override;
    void visit(IR::RETInst& node) override;
    void visit(IR::BRInst& node) override;
    void visit(IR::CALLInst& node) override;
    void visit(IR::FPTOSIInst& node) override;
    void visit(IR::SITOFPInst& node) override;
    void visit(IR::ZEXTInst& node) override;
    void visit(IR::ALLOCAInst& node) override;
    void visit(IR::LOADInst& node) override;
    void visit(IR::STOREInst& node) override;
    void visit(IR::GEPInst& node) override;
    void visit(IR::PHIInst& node) override;

    BFModule& getModule() { return module; }
};
}
#endif

