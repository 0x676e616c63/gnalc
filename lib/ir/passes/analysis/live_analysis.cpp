#include "../../../../include/ir/passes/analysis/live_analysis.hpp"
#include "../../../../include/utils/logger.hpp"

#include <variant>

namespace IR {
    PM::UniqueKey LiveAnalyser::Key;

    void LiveAnalyser::genDFSStack(const BasicBlock* bb) {
        bb_stack.spush(bb);
        for (auto& nextbb : bb->getNextBB()) {
            if (!bb_stack.visited(nextbb.get())) {
                genDFSStack(nextbb.get());
            }
        }
    }

    Liveness LiveAnalyser::run(Function& f, FAM& fpm) {
        liveness.reset();
        bb_stack.reset();
        genDFSStack(f.getBlocks().front().get());

        while(processFunc(&f))
            ;

        return liveness;
    }

    bool LiveAnalyser::processFunc(const Function* func) {
        bb_stack.restore();
        bool updated = false;
        while (!bb_stack.empty()) {
            auto bb = bb_stack.pop();
            for (auto& nxtbb : bb->getNextBB())
                for (auto& livevar : liveness.getLiveIn(nxtbb.get()))
                    if (liveness.getLiveOut(bb).insert(livevar).second)
                        updated = true;
            if (processBB(bb))
                updated = true;
        }
        return updated;

        // // just for one BB
        // processBB(func->getBlocks().front());
        // return false;
    }

    // 返回值为LiveIn是否更新了
    bool LiveAnalyser::processBB(const BasicBlock* bb) {
        // Logger::logDebug("Copying LiveOut from bb to insts");
        liveness.getLiveOut(bb->getInsts().back().get()) = liveness.getLiveOut(bb);
        bool updated = false;
        // Logger::logDebug("Processing insts in bb");
        for (auto it = bb->getInsts().rbegin(); it != bb->getInsts().rend(); ++it) {
            if (processInst((*it).get())) {
                updated = true;
                Logger::logDebug("LiveAnalyser: Updated insts " + (*it)->getName() + " in bb");
                if (std::next(it) != bb->getInsts().rend()){
                    liveness.getLiveOut(std::next(it)->get()) = liveness.getLiveIn(it->get());
                } else {
                    break;
                }
            }
        }
        // Logger::logDebug("Processing insts in bb done");
        liveness.getLiveIn(bb) = liveness.getLiveIn( bb->getInsts().front().get());
        // Logger::logDebug("Copied LiveIn");
        return updated;
    }

    // 返回值为LiveIn是否更新了
    bool LiveAnalyser::processInst(const Instruction* inst) {
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
            case OP::REM:
            case OP::FREM:
            case OP::AND:
            case OP::OR:
            case OP::ICMP:
            case OP::FCMP:
            case OP::FNEG:
            case OP::FPTOSI:
            case OP::SITOFP:
            case OP::ZEXT:
            case OP::BITCAST:
            case OP::LOAD:
            case OP::GEP:

                for (auto& use : inst->getOperands())
                    if (use->getValue()->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                        if (liveness.getLiveIn(inst).insert(use->getValue().get()).second) {
                            // Logger::logDebug("Added live-in: " + use->getValue()->getName());
                            updated = true;
                        }
                for (auto& val : liveness.getLiveOut(inst))
                    if (val != inst)
                        if (liveness.getLiveIn(inst).insert(val).second)
                            updated = true;
                break;
            case OP::RET:
            {
                auto cinst = dynamic_cast<const RETInst*>(inst);
                Err::gassert(cinst != nullptr, "Liveana::processInst: RETInst cast failed.");
                if (!cinst->isVoid())
                    if (cinst->getRetVal()->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                        if (liveness.getLiveIn(cinst).insert(cinst->getRetVal().get()).second)
                            updated = true;
                break;
            }
            case OP::BR:
            {
                auto cinst = dynamic_cast<const BRInst*>(inst);
                Err::gassert(cinst != nullptr, "Liveana::processInst: BRInst cast failed.");
                if (cinst->isConditional())
                    if (cinst->getCond()->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                        if (liveness.getLiveIn(cinst).insert(cinst->getCond().get()).second)
                            updated = true;
                for (auto& val : liveness.getLiveOut(inst))
                    if (liveness.getLiveIn(inst).insert(val).second)
                        updated = true;
                break;
            }
            case OP::CALL:
            {
                auto cinst = dynamic_cast<const CALLInst*>(inst);
                Err::gassert(cinst != nullptr, "Liveana::processInst: CALLInst cast failed.");
                for (auto& val : cinst->getArgs()) 
                    if (val->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                        if (liveness.getLiveIn(inst).insert(val.get()).second)
                            updated = true;
                for (auto& val : liveness.getLiveOut(inst))
                    if (cinst->isVoid() || val != inst)
                        if (liveness.getLiveIn(inst).insert(val).second)
                            updated = true;
                break;
            }
            case OP::ALLOCA:
                // 默认为 static_allocation, 此情况无 LiveUse
                // Logger::logDebug("processInst: alloca");
                for (auto& val : liveness.getLiveOut(inst))
                    if (val != inst)
                        if (liveness.getLiveIn(inst).insert(val).second)
                            updated = true;
                break;
            case OP::STORE:
                for (auto& use : inst->getOperands())
                    if (use->getValue()->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                        if (liveness.getLiveIn(inst).insert(use->getValue().get()).second)
                            updated = true;
                for (auto& val : liveness.getLiveOut(inst))
                        if (liveness.getLiveIn(inst).insert(val).second)
                            updated = true;
                break;
            case OP::PHI:
                Err::todo("phiinst liveana need to do");
                break;
            case OP::HELPER:
            default:
                Err::not_implemented("LiveAnalyser::processInst");
                break;
        }
        // Logger::logDebug("processed");
        return updated;
    }
}