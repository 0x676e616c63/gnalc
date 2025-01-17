#pragma once
#ifndef GNALC_CODEGEN_BFGEN_HPP
#define GNALC_CODEGEN_BFGEN_HPP

#include "../../ir/visitor.hpp"
#include "bfmodule.hpp"

namespace BrainFk {
class BFGenerator : public IR::IRVisitor {
    BFModule module;
public:
    void visit(IR::Module& m) override;
    void visit(IR::Function& node) override;
    void visit(IR::BasicBlock& node) override;
    void visit(IR::Instruction& node) override;

    BFModule& getModule() { return module; }
};
}
#endif

