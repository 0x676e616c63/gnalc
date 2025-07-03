// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/analysis/live_analysis.hpp"
#include "ir/base.hpp"
#include "ir/instructions/control.hpp"
#include "utils/logger.hpp"

#include <string>

namespace IR {
PM::UniqueKey LiveAnalysis::Key;

Liveness LiveAnalysis::run(Function &f, FAM &fam) {
    liveness.reset();
    while (processFunc(&f))
        ;
    return liveness;
}

bool LiveAnalysis::processFunc(const Function *func) {
    auto dfvisitor = func->getDFVisitor();
    bool updated = false;
    for (const auto &bb : dfvisitor) {
        for (const auto &nxtbb : bb->succs())
            for (auto &livevar : liveness.getLiveIn(nxtbb.get()))
                if (liveness.getLiveOut(bb.get()).insert(livevar).second)
                    updated = true;
        if (processBB(bb.get()))
            updated = true;
    }
    return updated;
}

// 返回值为LiveIn是否更新了
bool LiveAnalysis::processBB(const BasicBlock *bb) {
    // Logger::logDebug("Copying LiveOut from bb to insts");
    auto all = bb->getAllInsts();
    liveness.getLiveOut(all.back().get()) = liveness.getLiveOut(bb);
    bool updated = false;
    // Logger::logDebug("Processing insts in bb");
    for (auto it = all.rbegin(); it != all.rend(); ++it) {
        if (processInst((*it).get())) {
            updated = true;
            // Logger::logDebug("LiveAnalyser: Updated insts " + (*it)->getName() + " in bb");
            if (std::next(it) != all.rend()) {
                liveness.getLiveOut(std::next(it)->get()) = liveness.getLiveIn(it->get());
            } else {
                break;
            }
        }
    }
    // Logger::logDebug("Processing insts in bb done");
    liveness.getLiveIn(bb) = liveness.getLiveIn(all.front().get());
    // Logger::logDebug("Copied LiveIn");
    return updated;
}

// 返回值为LiveIn是否更新了
bool LiveAnalysis::processInst(const Instruction *inst) {
    // Logger::logDebug("Processing Instruction: " + inst->getName());
    bool updated = false;
    // inst->getLiveIn().insert(std::make_shared<ConstantInt>(1));
    switch (inst->getOpcode()) {
    case OP::ADD:
    case OP::FADD:
    case OP::SUB:
    case OP::FSUB:
    case OP::MUL:
    case OP::FMUL:
    case OP::DIV:
    case OP::FDIV:
    case OP::SREM:
    case OP::UREM:
    case OP::FREM:
    case OP::SHL:
    case OP::LSHR:
    case OP::ASHR:
    case OP::AND:
    case OP::OR:
    case OP::XOR:
    case OP::ICMP:
    case OP::FCMP:
    case OP::FNEG:
    case OP::FPTOSI:
    case OP::SITOFP:
    case OP::ZEXT:
    case OP::SEXT:
    case OP::BITCAST:
    case OP::LOAD:
    case OP::GEP:
    case OP::SELECT:

        for (auto &use : inst->getOperands())
            if (use->getValue()->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                if (liveness.getLiveIn(inst).insert(use->getValue().get()).second) {
                    // Logger::logDebug("Added live-in: " +
                    // use->getValue()->getName());
                    updated = true;
                }
        for (auto &val : liveness.getLiveOut(inst))
            if (val != inst)
                if (liveness.getLiveIn(inst).insert(val).second)
                    updated = true;
        break;
    case OP::RET: {
        auto cinst = inst->as_raw<RETInst>();
        Err::gassert(cinst != nullptr, "Liveana::processInst: RETInst cast failed.");
        if (!cinst->isVoid())
            if (cinst->getRetVal()->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                if (liveness.getLiveIn(cinst).insert(cinst->getRetVal().get()).second)
                    updated = true;
        break;
    }
    case OP::BR: {
        auto cinst = inst->as_raw<BRInst>();
        Err::gassert(cinst != nullptr, "Liveana::processInst: BRInst cast failed.");
        if (cinst->isConditional())
            if (cinst->getCond()->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                if (liveness.getLiveIn(cinst).insert(cinst->getCond().get()).second)
                    updated = true;
        for (auto &val : liveness.getLiveOut(inst))
            if (liveness.getLiveIn(inst).insert(val).second)
                updated = true;
        break;
    }
    case OP::CALL: {
        auto cinst = inst->as_raw<CALLInst>();
        Err::gassert(cinst != nullptr, "Liveana::processInst: CALLInst cast failed.");
        for (auto &val : cinst->getArgs())
            if (val->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                if (liveness.getLiveIn(inst).insert(val.get()).second)
                    updated = true;
        for (auto &val : liveness.getLiveOut(inst))
            if (cinst->isVoid() || val != inst)
                if (liveness.getLiveIn(inst).insert(val).second)
                    updated = true;
        break;
    }
    case OP::ALLOCA:
        // 默认为 static_allocation, 此情况无 LiveUse
        // Logger::logDebug("processInst: alloca");
        for (auto &val : liveness.getLiveOut(inst))
            if (val != inst)
                if (liveness.getLiveIn(inst).insert(val).second)
                    updated = true;
        break;
    case OP::STORE:
        for (auto &use : inst->getOperands())
            if (use->getValue()->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                if (liveness.getLiveIn(inst).insert(use->getValue().get()).second)
                    updated = true;
        for (auto &val : liveness.getLiveOut(inst))
            if (liveness.getLiveIn(inst).insert(val).second)
                updated = true;
        break;
    case OP::PHI:
        for (auto &use : inst->getOperands())
            if (use->getValue()->getVTrait() == ValueTrait::ORDINARY_VARIABLE)
                if (liveness.getLiveIn(inst).insert(use->getValue().get()).second)
                    updated = true;
        for (auto &val : liveness.getLiveOut(inst))
            if (val != inst)
                if (liveness.getLiveIn(inst).insert(val).second)
                    updated = true;
        break;
    case OP::HELPER:
    default:
        Err::not_implemented("LiveAnalyser::processInst");
        break;
    }
    // Logger::logDebug("processed");
    return updated;
}
} // namespace IR