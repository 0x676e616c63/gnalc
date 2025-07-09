// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/utilities/irprinter.hpp"
#include "ir/formatter.hpp"
#include "ir/passes/analysis/live_analysis.hpp"
#include "ir/passes/analysis/loop_alias_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"
#include "ir/passes/analysis/range_analysis.hpp"
#include "ir/passes/analysis/scev.hpp"
#include "utils/logger.hpp"

namespace IR {
void IRPrinter::visit(GlobalVariable &node) { writeln(IRFormatter::formatGV(node)); }

void IRPrinter::visit(FunctionDecl &node) { write(IRFormatter::formatFuncDecl(node)); }

void IRPrinter::visit(Instruction &node) {
    if (withIndent) {
        // It seems there is no nested scope, so it is a fixed indent.
        write("  ");
    }

    auto inst_str = IRFormatter::formatInst(node);
    const auto& dbg = node.getDbgData();
    if (!dbg.empty()) {
        inst_str += "        ;" + dbg[0];
        for (size_t i = 1; i < dbg.size(); ++i)
            inst_str += ", " + dbg[i];
    }
    writeln(inst_str);
}

void IRPrinter::visit(Function &node) {
    write(IRFormatter::formatFunc(node));
    writeln(" {");

    for (auto &blk : node.getBlocks())
        blk->accept(*this);

    writeln("}");
}

void IRPrinter::visit(BasicBlock &node) {
    write(IRFormatter::formatBB(node));
    if (node.getNumPreds() != 0) {
        write(":        ;preds = ");
        std::string predstr;
        for (const auto &pred : node.getPreBB())
            predstr += pred->getName() + ", ";
        predstr.pop_back();
        predstr.pop_back();
        writeln(predstr);
    } else
        writeln(":");

    for (const auto &inst : node.phis())
        inst->Instruction::accept(*this);
    for (const auto &inst : node.getInsts())
        inst->Instruction::accept(*this);
    writeln("");
}

PM::PreservedAnalyses PrintFunctionPass::run(Function &func, FAM &fam) {
    func.accept(*this);
    return PreserveAll();
}

PM::PreservedAnalyses PrintModulePass::run(Module &module, MAM &mam) {
    module.accept(*this);
    return PreserveAll();
}

void PrintModulePass::visit(Module &module) {
    writeln("; Module: " + module.getName());
    writeln("");

    for (auto &gv : module.getGlobalVars())
        gv->accept(*this);

    writeln("");

    for (auto &func : module.getFunctions()) {
        func->accept(*this);
        writeln("");
    }

    for (auto &func_decl : module.getFunctionDecls()) {
        func_decl->accept(*this);
        writeln("");
    }
}

PM::PreservedAnalyses PrintLoopPass::run(Function &func, FAM &fam) {
    auto &loop_info = fam.getResult<LoopAnalysis>(func);
    const auto &top_levels = loop_info.getTopLevelLoops();

    auto print_loop = [this](const pLoop &loop) {
        writeln("Loop Depth: " + std::to_string(loop->getLoopDepth()));
        auto preheader = loop->getPreHeader();
        if (preheader) {
            writeln("PreHeader: ");
            preheader->accept(*this);
        }
        writeln("Header: ");
        loop->getHeader()->accept(*this);

        auto latches = loop->getLatches();
        for (const auto &latch : latches) {
            writeln("Latch: ");
            latch->accept(*this);
        }

        auto exits = loop->getExitBlocks();
        for (const auto &exit : exits) {
            writeln("Exit: ");
            exit->accept(*this);
        }
    };

    writeln("Printing Loops: ");
    for (const auto &loop : top_levels) {
        print_loop(loop);
        for (size_t i = 0; i < loop->getSubLoops().size(); ++i) {
            writeln("SubLoop " + std::to_string(i) + ": ");
            print_loop(loop->getSubLoops()[i]);
        }
        writeln("----------");
    }

    return PreserveAll();
}

PM::PreservedAnalyses PrintDebugMessagePass::run(Function &func, FAM &fam) {
    writeln("[Debug Message] at '", func.getName(), "': ", message);
    return PreserveAll();
}

PM::PreservedAnalyses PrintSCEVPass::run(Function &function, FAM &fam) {
    auto &scev = fam.getResult<SCEVAnalysis>(function);
    auto &loop_info = fam.getResult<LoopAnalysis>(function);
    // It seems the range analysis rarely enhances SCEV, but computing it is expensive.
    // auto &ranges = fam.getResult<RangeAnalysis>(function);
    writeln("SCEV Analysis Result: ");
    for (const auto &top_level : loop_info) {
        auto ldfv = top_level->getDFVisitor();
        for (const auto &loop : ldfv) {
            auto trip_cnt = scev.getTripCount(loop);
            if (trip_cnt)
                writeln("'", loop->getHeader()->getName(), "' Trip Count: ", *trip_cnt);
            else
                writeln("'", loop->getHeader()->getName(), "' Trip Count: <null> :(");
        }
    }
    const DomTree &domtree = fam.getResult<DomTreeAnalysis>(function);
    for (const auto &bb : function) {
        for (const auto &inst : bb->all_insts()) {
            if (!inst->getType()->isI32())
                continue;
            for (const auto &scev_block : function) {
                if (!domtree.ADomB(bb, scev_block))
                    continue;
                auto s = scev.getSCEVAtBlock(inst, scev_block);
                // Since we've ensured the value is available in this block,
                // getSCEVAtBlock should not return nullptr.
                Err::gassert(s != nullptr);
                // if (!s->isUntracked())
                writeln(inst->getName(), " at block '", scev_block->getName(), "': ", *s);
            }
        }
    }
    return PreserveAll();
}

PM::PreservedAnalyses PrintRangePass::run(Function &function, FAM &manager) {
    auto &ranges = manager.getResult<RangeAnalysis>(function);
    writeln("Range Analysis Result: ");
    writeln("Global Ranges: ");
    for (const auto &param : function.getParams()) {
        if (isSameType(param->getType(), makeBType(IRBTYPE::I32))) {
            auto r = ranges.getIntRange(param);
            writeln(param->getName(), ": ", r);
        } else if (isSameType(param->getType(), makeBType(IRBTYPE::FLOAT))) {
            auto r = ranges.getFloatRange(param);
            writeln(param->getName(), ": ", r);
        }
    }
    for (const auto &bb : function) {
        for (const auto &inst : bb->all_insts()) {
            if (inst->getType()->isI32()) {
                auto r = ranges.getIntRange(inst);
                writeln(inst->getName(), ": ", r);
            } else if (isSameType(inst->getType(), makeBType(IRBTYPE::FLOAT))) {
                auto r = ranges.getFloatRange(inst);
                writeln(inst->getName(), ": ", r);
            }
        }
    }

    const DomTree &domtree = manager.getResult<DomTreeAnalysis>(function);
    writeln("Contextual Ranges: ");
    for (const auto &bb : function) {
        for (const auto &inst : bb->all_insts()) {
            if (inst->getType()->isI32()) {
                for (const auto &range_block : function) {
                    if (!domtree.ADomB(bb, range_block))
                        continue;
                    auto context_r = ranges.getIntRange(inst, range_block);
                    auto r = ranges.getIntRange(inst);
                    if (r != context_r)
                        writeln(inst->getName(), " at block '", range_block->getName(), "': ", context_r);
                }
            } else if (isSameType(inst->getType(), makeBType(IRBTYPE::FLOAT))) {
                for (const auto &range_block : function) {
                    if (!domtree.ADomB(bb, range_block))
                        continue;
                    auto context_r = ranges.getFloatRange(inst, range_block);
                    auto r = ranges.getFloatRange(inst);
                    if (r != context_r)
                        writeln(inst->getName(), " at block '", range_block->getName(), "': ", context_r);
                }
            }
        }
    }
    return PreserveAll();
}

PM::PreservedAnalyses PrintLoopAAPass::run(Function &function, FAM &fam) {
    auto &loop_aa = fam.getResult<LoopAliasAnalysis>(function);
    writeln("Loop Oriented Alias Analysis Result: ");
    std::vector<pVal> pointers;
    for (const auto &bb : function) {
        for (const auto &inst : bb->all_insts()) {
            if (inst->getType()->getTrait() != IRCTYPE::PTR)
                continue;
            const auto& loc = loop_aa.getAccessSet(inst);
            if (loc.untracked)
                continue;

            pointers.emplace_back(inst);

            writeln(inst->getName(), ":");
            writeln("  base: ", loc.base->getName());
            writeln("  offset: ", loc.offset);
            writeln("  element size: ", loc.element_size);
            for (const auto &access : loc.accesses) {
                writeln("  access: ");
                writeln("    trip count: ",
                        (access.trip_count == AccessSet::Inf ? "Inf" : std::to_string(access.trip_count)));
                writeln("    stride: ", access.stride);
            }
            writeln("-----------------");
        }
    }

    std::vector<std::vector<pVal>> must_alias;
    for (const auto& ptr : pointers) {
        bool found = false;
        for (auto& group : must_alias) {
            auto alias_info = loop_aa.getAliasInfo(group[0], ptr);
            if (alias_info == AliasInfo::MustAlias) {
                group.emplace_back(ptr);
                found = true;
                break;
            }
        }
        if (!found)
            must_alias.emplace_back(std::vector{ptr});
    }
    writeln("Must Alias Group: ");
    for (const auto& group : must_alias) {
        write("  - ");
        for (const auto& ptr : group)
            write(ptr->getName(), "  ");
        writeln("");
    }
    return PreserveAll();
}

} // namespace IR
