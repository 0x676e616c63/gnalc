// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/analysis/instdom_analysis.hpp"

#include "graph/domtree.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/match.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"

#include "match/match.hpp"
#include "sir/base.hpp"

namespace SIR {
PM::UniqueKey InstDomAnalysis::Key;

bool InstDomTree::ADomB(Instruction *a, Instruction *b) const {
    if (a == b)
        return true;

    auto bb1 = cfg.getBlock(a);
    auto bb2 = cfg.getBlock(b);
    if (bb1 == bb2)
        return bb1->inst_idx.at(a) < bb2->inst_idx.at(b);
    return domtree.ADomB(bb1, bb2);
}

bool InstDomTree::ADomB(const pInst &a, const pInst &b) const { return ADomB(a.get(), b.get()); }
bool InstDomTree::isReachableFromEntry(Instruction *a) const { return cfg.inst_map.count(a); }
bool InstDomTree::isReachableFromEntry(const pInst &a) const { return cfg.inst_map.count(a.get()); }

void linkBlock(PseudoBlock *blk, PseudoBlock *succ) {
    blk->succs.push_back(succ);
    succ->preds.push_back(blk);
}

// Adapted from CFGBuilder
class PseudoCFGBuilder {
private:
    PseudoCFG cfg;
    LinearFunction *cur_func{};
    PseudoBlock *cur_blk{};
    std::stack<PseudoBlock *> _while_cond_for_continue;
    std::stack<PseudoBlock *> _while_end_for_break;

    void newIf(const pIfInst &ifinst) {
        const bool el = ifinst->hasElse();

        auto ifthen = cfg.newBlock();
        auto ifelse = cfg.newBlock();
        auto ifend = cfg.newBlock();

        if (el)
            addCondBr(ifinst->getCond(), ifthen, ifelse);
        else
            addCondBr(ifinst->getCond(), ifthen, ifend);

        cur_blk = ifthen;
        auto it = ifinst->getBodyInsts().cbegin();
        if (!adder(it, ifinst->getBodyInsts().cend(), true))
            linkBlock(cur_blk, ifend);

        if (el) {
            cur_blk = ifelse;
            it = ifinst->getElseInsts().begin();
            if (!adder(it, ifinst->getElseInsts().cend(), true))
                linkBlock(cur_blk, ifend);
        }

        cur_blk = ifend;
    }

    void newWh(const pWhileInst &whinst) {
        auto whcond = cfg.newBlock();
        auto whbody = cfg.newBlock();
        auto whend = cfg.newBlock();
        _while_cond_for_continue.push(whcond);
        _while_end_for_break.push(whend);

        linkBlock(cur_blk, whcond);

        cur_blk = whcond;
        for (auto &cond : whinst->getCondInsts())
            cfg.addInst(cur_blk, cond.get());

        addCondBr(whinst->getCond(), whbody, whend);

        cur_blk = whbody;
        if (auto it = whinst->getBodyInsts().cbegin(); !adder(it, whinst->getBodyInsts().cend(), true))
            linkBlock(cur_blk, whcond);

        cur_blk = whend;

        _while_cond_for_continue.pop();
        _while_end_for_break.pop();
    }

    void newFor(const pForInst &for_inst) {
        auto for_cond = cfg.newBlock();
        auto for_body = cfg.newBlock();
        auto for_end = cfg.newBlock();

        auto for_preheader = cur_blk;
        linkBlock(for_preheader, for_cond);

        cur_blk = for_body;
        if (auto it = for_inst->getBodyInsts().cbegin(); !adder(it, for_inst->getBodyInsts().cend(), false))
            linkBlock(cur_blk, for_cond);
    }

    bool adder(std::list<pInst>::const_iterator &it, const std::list<pInst>::const_iterator &end,
               const bool allow_break) {
        bool inserted_terminator = false;
        for (; it != end && !inserted_terminator; ++it) {
            if ((*it)->getOpcode() == OP::HELPER) {
                switch (auto helper = (*it)->as<HELPERInst>(); helper->getHlpType()) {
                case HELPERTY::IF:
                    newIf(helper->as<IFInst>());
                    break;
                case HELPERTY::WHILE:
                    newWh(helper->as<WHILEInst>());
                    break;
                case HELPERTY::FOR:
                    newFor(helper->as<FORInst>());
                    break;
                case HELPERTY::BREAK:
                    Err::gassert(allow_break, "PseudoCFGBuilder: break in invalid block.");
                    Err::gassert(!_while_end_for_break.empty(),
                                 "PseudoCFGBuilder: stack while_end_for_break is empty!");
                    linkBlock(cur_blk, _while_end_for_break.top());
                    inserted_terminator = true;
                    break;
                case HELPERTY::CONTINUE:
                    Err::gassert(allow_break, "PseudoCFGBuilder: continue in invalid block.");
                    Err::gassert(!_while_cond_for_continue.empty(),
                                 "PseudoCFGBuilder: stack while_cond_for_continue is empty!");
                    linkBlock(cur_blk, _while_cond_for_continue.top());
                    inserted_terminator = true;
                    break;
                default:
                    Err::unreachable("adder: Invalid HELPERInst type");
                }
            } else {
                cfg.addInst(cur_blk, it->get());
                if ((*it)->getOpcode() == OP::RET)
                    inserted_terminator = true;
            }
        }
        return inserted_terminator;
    }

    void short_circuit_process(const pCondValue &cond, PseudoBlock *true_blk, PseudoBlock *false_blk) {
        if (cond->getCondType() == CONDTY::AND) {
            const auto land = cond->as<ANDValue>();
            auto landlt = cfg.newBlock();
            addCondBr(land->getLHS(), landlt, false_blk);
            cur_blk = landlt;
            for (const auto &rhsinst : land->getRHSInsts())
                cfg.addInst(cur_blk, rhsinst.get());
            addCondBr(land->getRHS(), true_blk, false_blk);
        } else if (cond->getCondType() == CONDTY::OR) {
            const auto lor = cond->as<ORValue>();
            auto lorlf = cfg.newBlock();
            addCondBr(lor->getLHS(), true_blk, lorlf);
            cur_blk = lorlf;
            for (const auto &rhsinst : lor->getRHSInsts())
                cfg.addInst(cur_blk, rhsinst.get());
            addCondBr(lor->getRHS(), true_blk, false_blk);
        } else {
            Err::unreachable("short_circuit_process: Invalid condition type.");
        }
    }

    void addCondBr(const pVal &cond, PseudoBlock *true_blk, PseudoBlock *false_blk) {
        if (cond->getVTrait() == ValueTrait::CONDHELPER) {
            const auto cond_value = cond->as<CONDValue>();
            Err::gassert(cond_value != nullptr, "addCondBr: CONDValue cast failed.");
            short_circuit_process(cond_value, true_blk, false_blk);
        } else {
            linkBlock(cur_blk, true_blk);
            linkBlock(cur_blk, false_blk);
        }
    }

    void divider() {
        cur_blk = cfg.newBlock();
        auto inst_it = cur_func->cbegin();
        adder(inst_it, cur_func->cend(), false);
    }

public:
    PseudoCFG build(LinearFunction *lfunc) {
        cur_func = lfunc;
        divider();
        return std::move(cfg);
    }
};

InstDomTree InstDomAnalysis::run(LinearFunction &f, LFAM &fam) {
    PseudoCFGBuilder cfg_builder;
    auto cfg = cfg_builder.build(&f);
    PseudoDomTreeBuilder dt_builder;
    dt_builder.entry = cfg.blocks.front().get();
    dt_builder.analyze();
    return InstDomTree(std::move(cfg), std::move(dt_builder.domtree));
}

} // namespace SIR
