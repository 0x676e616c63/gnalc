#pragma once
#ifndef GNALC_CODEGEN_BRAINFK_BFGEN_HPP
#define GNALC_CODEGEN_BRAINFK_BFGEN_HPP

#include <map>

#include "../../ir/visitor.hpp"
#include "bfmodule.hpp"

namespace BrainFk {
// This generates 32-bit brainfuck
class BF32Generator : public IR::IRVisitor {
public:
    struct Insts {
        std::vector<BFInstruction> insts;

        void addInst(BFInstruction inst) {
            insts.emplace_back(inst);
        }

        template<typename First, typename ...Rest>
        void addInst(First&& first, Rest&&... rest) {
            addInst(std::forward<First>(first));
            addInst(std::forward<Rest>(rest)...);
        }
    };
private:
    BFModule module;
    std::map<std::string, std::vector<BFInstruction>> trivial_funcs; // except main
    Insts curr_insts;
    std::map<size_t, size_t> cell_index;
    size_t curr_cell_pos;
    size_t avail_cell_pos;
public:
    BF32Generator() : curr_cell_pos(0), avail_cell_pos(0) {}
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

private:
    void to_cell(size_t pos);
    void set_cell(size_t pos, int32_t value);
    int get_cell_pos(const std::string& name);
};
}
#endif

