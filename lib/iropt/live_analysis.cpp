#include "../../include/iropt/live_analysis.hpp"

#include <variant>

#include "../../include/utils/logger.hpp"

namespace IR {
    void LiveAnalyser::genDFSStack(const std::shared_ptr<BasicBlock>& bb) {
        bb_stack.spush(bb);
        for (auto& nextbb : bb->getNextBB()) {
            if (!bb_stack.visited(nextbb)) {
                genDFSStack(nextbb);
            }
        }
    }

    void LiveAnalyser::processModule(const Module& module) {
        for (auto& func : module.getFunctions()) {
            bb_stack.reset();
            genDFSStack(func->getBlocks().front());
            while(processFunc(func));
        }
    }

    bool LiveAnalyser::processFunc(const std::shared_ptr<Function>& func) {
        bb_stack.restore();
        bool updated = false;
        while (!bb_stack.empty()) {
            auto bb = bb_stack.pop();
            for (auto& nxtbb : bb->getNextBB())
                for (auto& livevar : nxtbb->getLiveIn())
                    if (bb->getLiveOut().insert(livevar).second)
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
    bool LiveAnalyser::processBB(const std::shared_ptr<BasicBlock>& bb) {
        // Logger::logDebug("Copying LiveOut from bb to insts");
        bb->getInsts().back()->getLiveOut() = bb->getLiveOut();
        bool updated = false;
        // Logger::logDebug("Processing insts in bb");
        for (auto it = bb->getInsts().rbegin(); it != bb->getInsts().rend(); ++it) {
            if (processInst(*it)) {
                updated = true;
                Logger::logDebug("LiveAnalyser: Updated insts " + (*it)->getName() + " in bb");
                if (std::next(it) != bb->getInsts().rend()){
                    (*std::next(it))->getLiveOut() = (*it)->getLiveIn();
                } else {
                    break;
                }
            }
        }
        // Logger::logDebug("Processing insts in bb done");
        bb->getLiveIn() = bb->getInsts().front()->getLiveIn();
        // Logger::logDebug("Copied LiveIn");
        return updated;
    }

    // 返回值为LiveIn是否更新了
    bool LiveAnalyser::processInst(const std::shared_ptr<Instruction>& inst) {
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
            case OP::LOAD:
            case OP::GEP:
                for (auto& use : inst->getOperands())
                    if (use->getValue()->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                        if (inst->getLiveIn().insert(use->getValue()).second) {
                            // Logger::logDebug("Added live-in: " + use->getValue()->getName());
                            updated = true;
                        }
                for (auto& val : inst->getLiveOut())
                    if (val != inst)
                        if (inst->getLiveIn().insert(val).second)
                            updated = true;
                break;
            case OP::RET:
            {
                auto cinst = std::dynamic_pointer_cast<RETInst>(inst);
                Err::gassert(cinst != nullptr, "Liveana::processInst: RETInst cast failed.");
                if (!cinst->isVoid())
                    if (cinst->getRetVal()->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                        if (cinst->getLiveIn().insert(cinst->getRetVal()).second)
                            updated = true;
                break;
            }
            case OP::BR:
            {
                auto cinst = std::dynamic_pointer_cast<BRInst>(inst);
                Err::gassert(cinst != nullptr, "Liveana::processInst: BRInst cast failed.");
                if (cinst->isConditional())
                    if (cinst->getCond()->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                        if (cinst->getLiveIn().insert(cinst->getCond()).second)
                            updated = true;
                for (auto& val : inst->getLiveOut())
                    if (inst->getLiveIn().insert(val).second)
                        updated = true;
                break;
            }
            case OP::CALL:
            {
                auto cinst = std::dynamic_pointer_cast<CALLInst>(inst);
                Err::gassert(cinst != nullptr, "Liveana::processInst: CALLInst cast failed.");
                for (auto& val : cinst->getArgs()) 
                    if (val->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                        if (inst->getLiveIn().insert(val).second)
                            updated = true;
                for (auto& val : inst->getLiveOut())
                    if (cinst->isVoid() || val != inst)
                        if (inst->getLiveIn().insert(val).second)
                            updated = true;
                break;
            }
            case OP::ALLOCA:
                // 默认为 static_allocation, 此情况无 LiveUse
                // Logger::logDebug("processInst: alloca");
                for (auto& val : inst->getLiveOut())
                    if (val != inst)
                        if (inst->getLiveIn().insert(val).second)
                            updated = true;
                break;
            case OP::STORE:
                for (auto& use : inst->getOperands())
                    if (use->getValue()->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                        if (inst->getLiveIn().insert(use->getValue()).second)
                            updated = true;
                for (auto& val : inst->getLiveOut())
                        if (inst->getLiveIn().insert(val).second)
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

    void LiveAnalyser::cleanLiveInfo(const Module& module) {
        for (auto& func : module.getFunctions()) {
            for (auto& bb : func->getBlocks()) {
                bb->getLiveIn().clear();
                bb->getLiveOut().clear();
                for (auto& inst : bb->getInsts()) {
                    inst->getLiveIn().clear();
                    inst->getLiveOut().clear();
                }
            }
        }
    }
}