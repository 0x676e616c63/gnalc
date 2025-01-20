#pragma once
#ifndef GNALC_CODEGEN_BRAINFK_BFGEN_HPP
#define GNALC_CODEGEN_BRAINFK_BFGEN_HPP

#include "../../config/config.hpp"
#if GNALC_EXTENSION_BRAINFK

#include <map>

#include "../../ir/visitor.hpp"
#include "bfmodule.hpp"

namespace BrainFk {
// This generates 3 tape 32-bit brainfuck
// Tape 1: IR virtual register
// Tape 2: Memory
// Tape 3: Temp value
// Tape 2 is for memory, so the pos of it is a bit complicated, its pos is store in [0] in tape 1.
class BF3t32bGen : public IR::IRVisitor {
public:
    struct Insts {
        std::vector<BF3tInst> insts;

        void addInst(BF3tInst inst) {
            insts.emplace_back(inst);
        }

        template<typename First, typename ...Rest>
        void addInst(First&& first, Rest&&... rest) {
            addInst(std::forward<First>(first));
            addInst(std::forward<Rest>(rest)...);
        }
    };
private:
    BF3tModule module;
    std::map<std::string, std::vector<BF3tInst>> trivial_funcs; // except main
    Insts curr_insts;
    std::map<size_t, size_t> reg_index; // Tape 1
    size_t tape1_pos;
    size_t tape3_pos;
    size_t tape1_avail_pos;
    size_t tape2_avail_pos;
    size_t tape3_avail_pos;
public:
    BF3t32bGen()
    : tape1_pos(0), tape3_pos(0),
    tape1_avail_pos(1), tape2_avail_pos(0), tape3_avail_pos(0) {}

    void visit(IR::Module& node) override;
    void visit(IR::GlobalVariable& node) override;
    void visit(IR::Function& node) override;
    void visit(IR::FunctionDecl& node) override;
    void visit(IR::BasicBlock& node) override;
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
    void visit(IR::BITCASTInst& node) override;
    void visit(IR::ALLOCAInst& node) override;
    void visit(IR::LOADInst& node) override;
    void visit(IR::STOREInst& node) override;
    void visit(IR::GEPInst& node) override;
    void visit(IR::PHIInst& node) override;

    BF3tModule& getModule() { return module; }

private:
    void tape1_to(size_t pos);
    void tape3_to(size_t pos);

    void tape2_to_tape1ptr(size_t pos);

    void tape1_set(size_t pos, int32_t value);
    void tape3_set(size_t pos, int32_t value);

    size_t get_reg_pos(const std::string& name); // Tape 1

    void tape1_copy(size_t src, size_t dest);
};
}
#endif
#endif
