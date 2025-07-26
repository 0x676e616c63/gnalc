// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "mir/passes/transforms/CopyPropagation.hpp"

#include "mir/passes/analysis/liveanalysis.hpp"

using namespace MIR;

// (dest, src)
struct CopyPair {
    unsigned dest;
    unsigned src;
    MIROperand_p src_mop;
    CopyPair(const MIROperand_p& dest_, const MIROperand_p& src_)
        : dest(dest_->reg()), src(src_->reg()), src_mop(src_) {}
};

// Attention: Compare register number rather than `MIROperand_p`
struct CopyCmp {
    bool operator()(CopyPair const &a, CopyPair const &b) const {
        return a.dest < b.dest|| (a.dest == b.dest && a.src < b.src);
    }
};
bool operator==(CopyPair const &a, CopyPair const &b) { return a.dest == b.dest && a.src == b.src; }

using CopySet = std::set<CopyPair, CopyCmp>;

using KillSet = std::set<unsigned>;

struct BBInfo {
    CopySet GEN, IN, OUT;
    KillSet KILL;
};

void dumpInfo(const BBInfo &info) {
    auto formatReg = [](unsigned reg) {
        if (isVirtualReg(reg))
            return "V(" + std::to_string(reg - VRegBegin) + ")";
        return "ISA(" + std::to_string(reg) + ")";
    };
    for (const auto &cp : info.IN)
        std::cerr << "  IN: " << formatReg(cp.dest) << " <- " << formatReg(cp.src) << "\n";
    for (const auto &cp : info.OUT)
        std::cerr << "  OUT: " << formatReg(cp.dest) << " <- " << formatReg(cp.src) << "\n";
    for (const auto &cp : info.GEN)
        std::cerr << "  GEN: " << formatReg(cp.dest) << " <- " << formatReg(cp.src) << "\n";
    for (const auto &cp : info.KILL)
        std::cerr << "  KILL: " << formatReg(cp) << "\n";
    std::cerr << "\n";
}

void removeFromSet(CopySet &S, unsigned dest) {
    for (auto it = S.begin(); it != S.end();) {
        if (it->dest == dest)
            it = S.erase(it);
        else
            ++it;
    }
}

bool isCopyInst(const MIRInst_p &minst) {
    // Take care of function call!
    // if (minst->isGeneric())
    //     return inSet(minst->opcode<OpC>(), OpC::InstCopy, OpC::InstCopyFromReg, OpC::InstCopyToReg);

    if (minst->isGeneric())
        return inSet(minst->opcode<OpC>(), OpC::InstCopy);

    // TODO: ARM/RV Copy
    return false;
}

void computeGenKill(const MIRBlk_p &bb, BBInfo &info) {
    for (const auto &inst : bb->Insts()) {
        if (const auto &dest = inst->getDef()) {
            if (dest->isReg()) {
                info.KILL.insert(dest->reg());
                removeFromSet(info.GEN, dest->reg());
                if (isCopyInst(inst)) {
                    const auto &src = inst->getOp(1);
                    info.GEN.emplace(dest, src);
                }
            }
        }
    }
}

void applyPropagation(const MIRBlk_p &bb, CopySet avail,
                      const std::unordered_map<MIRInst_p, std::unordered_set<MIROperand_p>> &instLiveout) {
    auto &ctx = bb->getFunction()->Context();
    MIRInst_p_l new_insts;
    auto &insts = bb->Insts();
    for (auto it = insts.begin(); it != insts.end(); ++it) {
        const auto &inst = *it;
        // skip def
        for (unsigned i = 1; i < inst->getOpNr(); ++i) {
            const auto &op = inst->getOp(i);
            if (op && op->isReg()) {
                for (const auto &cp : avail) {
                    if (cp.dest == op->reg()) {
                        auto orig = inst->dbgDump();

                        inst->replace(op, cp.src_mop, ctx);

                        inst->appendDbgData("CopyPropagation");
                        Logger::logDebug("[CopyPropagation] '", orig, "' -> '", inst->dbgDump(), "'.'");
                        break;
                    }
                }
            }
        }

        if (isCopyInst(inst)) {
            auto dest = inst->getOp(0);
            if (!instLiveout.at(inst).count(dest))
                continue;
        }
        new_insts.emplace_back(inst);

        // Update sets
        if (auto dest = inst->getDef()) {
            if (dest->isReg()) {
                removeFromSet(avail, dest->reg());
                if (isCopyInst(inst)) {
                    auto src = inst->getOp(1);
                    avail.emplace(dest, src);
                }
            }
        }
    }
    bb->replaceInsts(new_insts);
}

void processFunction(MIRFunction &func, Liveness &liveness) {
    std::unordered_map<MIRBlk_p, BBInfo> bbinfo;
    for (auto &bb : func.blks()) {
        computeGenKill(bb, bbinfo[bb]);

        // std::cerr << "Block: " << bb->getmSym() << "\n";;
        // dumpInfo(bbinfo[bb]);
    }


    // IN = ∩ OUT[preds]
    // OUT = GEN ∪ (IN - KILL)
    bool changed;
    do {
        changed = false;
        for (const auto &bb : func.blks()) {
            auto &info = bbinfo[bb];

            // IN = ∩ OUT[preds]
            CopySet new_IN;
            bool first = true;
            for (const auto &pred : bb->preds()) {
                if (first) {
                    new_IN = bbinfo[pred].OUT;
                    first = false;
                } else {
                    CopySet tmp;
                    std::set_intersection(new_IN.begin(), new_IN.end(), bbinfo[pred].OUT.begin(),
                                          bbinfo[pred].OUT.end(), std::inserter(tmp, tmp.begin()), CopyCmp{});
                    new_IN.swap(tmp);
                }
            }

            // OUT = GEN ∪ (IN − KILL)
            CopySet new_OUT = info.GEN;
            for (auto &cp : new_IN) {
                if (!info.KILL.count(cp.dest))
                    new_OUT.insert(cp);
            }

            if (new_IN != info.IN || new_OUT != info.OUT) {
                info.IN = std::move(new_IN);
                info.OUT = std::move(new_OUT);
                changed = true;
            }
        }
    } while (changed);

    // for (auto &bb : func.blks()) {
    //     std::cerr << "Block: " << bb->getmSym() << "\n";;
    //     dumpInfo(bbinfo[bb]);
    // }

    for (const auto &bb : func.blks())
        applyPropagation(bb, bbinfo[bb].IN, liveness.instLiveOut);
}

PM::PreservedAnalyses CopyPropagation::run(MIRFunction &func, FAM &fam) {
    auto &liveness = fam.getResult<LiveAnalysis>(func);
    processFunction(func, liveness);
    return PM::PreservedAnalyses::none();
}
