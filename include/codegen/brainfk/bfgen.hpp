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
// Tape 1:
//   0 - 31:   See below
//   > 31:     IR virtual register

// Tape 2: Memory
// Tape 3: Temp value

class BF3t32bGen : public IR::IRVisitor {
private:
    enum BFPos: size_t {
        BFP_MEM = 0,
        BFP_GOTO_TARGET = 1,
        BFP_GOTO_TMP1 = 2,
        BFP_GOTO_TMP2 = 3,
        BFP_DEBUG_TMP = 4,
    };
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
    bool curr_is_main;
    std::map<std::string, size_t> reg_index; // Tape 1
    std::map<std::string, size_t> block_index;
    size_t tape1_pos;
    size_t tape3_pos;
    size_t tape1_avail_pos;
    size_t tape2_avail_pos;
    size_t tape3_avail_pos;
public:
    BF3t32bGen()
    : tape1_pos(0), tape3_pos(0),
    tape1_avail_pos(32), tape2_avail_pos(0), tape3_avail_pos(1),
    curr_is_main(false) {}

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
    void tape1_alloca();
    void tape3_alloca();

    void tape1_to(size_t pos);
    void tape3_to(size_t pos);

    void tape2_to_tape1ptr(size_t pos);

    void tape1_set(size_t pos, uint32_t value);
    void tape3_set(size_t pos, uint32_t value);

    size_t get_reg_pos(const std::string& name); // Tape 1

    size_t get_blk_pos(const std::string& name);

    void tape1_copy(size_t src, size_t dest);

    void debug_output(int32_t);

    void debug_tape1_show(size_t);
};
}
#endif
#endif
