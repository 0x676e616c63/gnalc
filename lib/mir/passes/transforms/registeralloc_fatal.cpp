#include "../../../../include/mir/SIMDinstruction/memory.hpp"
#include "../../../../include/mir/instructions/memory.hpp"
#include "../../../../include/mir/passes/transforms/registeralloc.hpp"
#include <random>
#include <utility>

using namespace MIR;

bool RAPass::isMoveInstruction(const InstP &inst) {
    auto use = std::dynamic_pointer_cast<BindOnVirOP>(inst->getSourceOP(1));
    auto def = inst->getTargetOP();

    if (use == nullptr)
        return false;

    if (inst->getOpCode().index() == 0) {
        if (std::get<OpCode>(inst->getOpCode()) == OpCode::MOV || std::get<OpCode>(inst->getOpCode()) == OpCode::MVN ||
            std::get<OpCode>(inst->getOpCode()) == OpCode::COPY) {
            if (use->getBank() == RegisterBank::gpr && use->getBank() == def->getBank())
                return true;
        }
    }

    return false;
}

RAPass::Nodes RAPass::getUse(const InstP &inst) {
    Nodes uses;

    if (inst->getOpCode().index() == 1) {
        auto nopcode = std::get<NeonOpCode>(inst->getOpCode());

        if (nopcode != NeonOpCode::VMOV)
            return uses;

        auto sourceop = inst->getSourceOP(1)->as<BindOnVirOP>();

        if (sourceop->getBank() == RegisterBank::gpr)
            uses.insert(sourceop);

        return uses;
    }

    if (std::get<OpCode>(inst->getOpCode()) == OpCode::BL || std::get<OpCode>(inst->getOpCode()) == OpCode::BLX) {
        auto &varpool = Func->editInfo().getPool();

        for (int rx = 0; rx < 4; ++rx) {
            uses.insert(varpool.getValue(static_cast<CoreRegister>(rx))); // r0, r1, r2, r3
        }

        if (Func->getInfo().hasCall)
            uses.insert(varpool.getValue(static_cast<CoreRegister>(14))); // lr

        return uses;
    }

    for (int i = 1; i < 5; ++i) {
        auto op = inst->getSourceOP(i);

        if (auto ptr = std::dynamic_pointer_cast<BaseADROP>(op)) {
            uses.insert(ptr->getBase()); // maybe itself
        } else if (auto vir = std::dynamic_pointer_cast<BindOnVirOP>(op) &&
                              std::dynamic_pointer_cast<BindOnVirOP>(op)->getBank() == RegisterBank::gpr)
            uses.insert(op);
    }

    return uses;
}

RAPass::Nodes RAPass::getDef(const InstP &inst) {
    Nodes defs;

    auto op = inst->getTargetOP(); // spr maybe

    if (!op)
        return defs;

    if (auto ptr = std::dynamic_pointer_cast<BaseADROP>(op)) {
        defs.insert(ptr->getBase()); // maybe itself
    } else if (std::dynamic_pointer_cast<BindOnVirOP>(op) &&
               std::dynamic_pointer_cast<BindOnVirOP>(op)->getBank() == RegisterBank::gpr)
        defs.insert(op);

    return defs;
}

OperP RAPass::heuristicSpill() {
    ///@note 实现的关键在于, 不要重复溢出上一次溢出得到的小区间操作数
    ///@note 优化的关键在于, 合理设置权重值

    ///@brief 炼丹中...
    const double Weight_IntervalLength = 2.5;
    const double Weight_Degree = 3;
    const double extra_Weight_ForNotPtr = +60; // origin: 60

    ///@note 计算溢出权重
    double weight_max = 0;
    OperP spilled = nullptr;
    for (const auto &op : spillWorkList) {
        double weight = 0;

        // if (liveinfo.intervalLengths.find(op) != liveinfo.intervalLengths.end())
        weight += liveinfo.intervalLengths[op] * Weight_IntervalLength; // narrowing convert here

        weight += degree[op] * Weight_Degree;
        // if (!std::dynamic_pointer_cast<BaseADROP>(op) && !varpool->isLoad(op))
        //     weight += extra_Weight_ForNotPtr;

        if (!std::dynamic_pointer_cast<BaseADROP>(op))
            weight += extra_Weight_ForNotPtr;

        if (weight >= weight_max) {
            spilled = op;
            weight_max = weight;
        }
    }
    Err::gassert(spilled != nullptr, "spilled is nullptr");
    return spilled;
}

RAPass::Nodes RAPass::spill_tryOpt(const OperP &op) {
    ++spilltimes;

    if (availableSRegisters->empty())
        return spill_classic(op);
    else
        return spill_opt(op);
}

RAPass::Nodes RAPass::spill_opt(const OperP &op) {
    Nodes stageValues;

    // 溢出的FPU寄存器
    auto fpu = *(availableSRegisters->begin()); // 尽量用caller saved
    availableSRegisters->erase(availableSRegisters->begin());

    auto fpuRegister = varpool->getValue(static_cast<FPURegister>(fpu));
    auto type_pair = std::make_pair(bitType::DEFAULT32, bitType::DEFAULT32);

    for (const auto &blk : Func->getBlocks()) {
        auto &insts = blk->getInsts();
        for (auto inst_it = insts.begin(); inst_it != insts.end();) {
            bool insert_before = false;
            bool insert_after = false;
            auto inst = *inst_it;

            if (auto ldr = std::dynamic_pointer_cast<ldrInst>(inst)) {
                auto def = ldr->getTargetOP();
                auto base = std::dynamic_pointer_cast<BaseADROP>(ldr->getSourceOP(1));
                auto index = ldr->getSourceOP(2);

                Err::gassert(base != nullptr, "base register is NULL");

                if (base->getBase() == op) { // 需要setBase()
                    insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    base->setBase(read_stage); // 弃用原基址寄存器(修改原指令)
                    stageValues.insert(read_stage);
                    auto vmov_new = std::make_shared<Vmov>(SourceOperandType::rr, read_stage, fpuRegister, type_pair);

                    insts.insert(inst_it, vmov_new);
                }

                if (index == op) { // maybe nullptr
                    insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    ldr->setIndexReg(read_stage); // 修改原指令
                    stageValues.insert(read_stage);
                    auto ldr_new = std::make_shared<Vmov>(SourceOperandType::rr, read_stage, fpuRegister, type_pair);

                    insts.insert(inst_it, ldr_new);
                }

                if (def == op) {
                    insert_after = true;

                    auto write_stage = varpool->addValue_anonymously(false);
                    ldr->addTargetOP(write_stage); // 修改原指令
                    stageValues.insert(write_stage);
                    auto str_new = std::make_shared<Vmov>(SourceOperandType::rr, fpuRegister, write_stage, type_pair);

                    insts.insert(std::next(inst_it), str_new);
                }

            } else if (auto str = std::dynamic_pointer_cast<strInst>(inst)) {
                auto use = str->getSourceOP(1);
                auto base = std::dynamic_pointer_cast<BaseADROP>(str->getSourceOP(2));
                auto index = str->getSourceOP(3);

                Err::gassert(base != nullptr, "base register is NULL");

                if (use == op) {
                    insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    str->setSourceOP(1, read_stage); // 修改原指令
                    stageValues.insert(read_stage);
                    auto vmov_new = std::make_shared<Vmov>(SourceOperandType::rr, read_stage, fpuRegister, type_pair);

                    insts.insert(inst_it, vmov_new);
                }

                if (base->getBase() == op) { // 需要setBase()
                    insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    base->setBase(read_stage); // 弃用原基址寄存器(修改原指令)
                    stageValues.insert(read_stage);
                    auto vmov_new = std::make_shared<Vmov>(SourceOperandType::rr, read_stage, fpuRegister, type_pair);

                    insts.insert(inst_it, vmov_new);
                }

                if (index == op) { // maybe nullptr
                    insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    str->setIndexReg(read_stage); // 修改原指令
                    stageValues.insert(read_stage);
                    auto vmov_new = std::make_shared<Vmov>(SourceOperandType::rr, read_stage, fpuRegister, type_pair);

                    insts.insert(inst_it, vmov_new);
                }

            } else if (auto vldr = std::dynamic_pointer_cast<Vldr>(inst)) {
                auto base = std::dynamic_pointer_cast<BaseADROP>(vldr->getSourceOP(1));
                auto index = vldr->getSourceOP(2);

                Err::gassert(base != nullptr, "base register is NULL");

                if (base->getBase() == op) { // 需要setBase()
                    insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    base->setBase(read_stage); // 弃用原基址寄存器(修改原指令)
                    stageValues.insert(read_stage);
                    auto vmov_new = std::make_shared<Vmov>(SourceOperandType::rr, read_stage, fpuRegister, type_pair);

                    insts.insert(inst_it, vmov_new);
                }

                if (index == op) { // maybe nullptr
                    insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    ldr->setIndexReg(read_stage); // 修改原指令
                    stageValues.insert(read_stage);
                    auto vmov_new = std::make_shared<Vmov>(SourceOperandType::rr, read_stage, fpuRegister, type_pair);

                    insts.insert(inst_it, vmov_new);
                }
            } else if (auto vstr = std::dynamic_pointer_cast<Vstr>(inst)) {
                auto base = std::dynamic_pointer_cast<BaseADROP>(str->getSourceOP(2));
                auto index = str->getSourceOP(3);

                Err::gassert(base != nullptr, "base register is NULL");

                if (base->getBase() == op) { // 需要setBase()
                    insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    base->setBase(read_stage); // 弃用原基址寄存器(修改原指令)
                    stageValues.insert(read_stage);
                    auto vmov_new = std::make_shared<Vmov>(SourceOperandType::rr, read_stage, fpuRegister, type_pair);

                    insts.insert(inst_it, vmov_new);
                }

                if (index == op) { // maybe nullptr
                    insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    str->setIndexReg(read_stage); // 修改原指令
                    stageValues.insert(read_stage);
                    auto vmov_new = std::make_shared<Vmov>(SourceOperandType::rr, read_stage, fpuRegister, type_pair);

                    insts.insert(inst_it, vmov_new);
                }
            } else {
                auto uses = getUse(inst);
                auto defs = getDef(inst);

                if (uses.find(op) != uses.end()) {
                    insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    auto vmov_new = std::make_shared<Vmov>(SourceOperandType::rr, read_stage, fpuRegister, type_pair);
                    for (int i = 1; i < 5; ++i) {
                        if (inst->getSourceOP(i) == op) {
                            inst->setSourceOP(i, read_stage);
                            break;
                        }
                    }
                    stageValues.insert(read_stage);

                    insts.insert(inst_it, vmov_new);
                }

                if (defs.find(op) != defs.end()) {
                    insert_after = true;

                    auto write_stage = varpool->addValue_anonymously(false);
                    auto vmov_new = std::make_shared<Vmov>(SourceOperandType::rr, fpuRegister, write_stage, type_pair);
                    inst->addTargetOP(write_stage);
                    stageValues.insert(write_stage);

                    insts.insert(std::next(inst_it), vmov_new);
                }
            }

            if (insert_after)
                ++inst_it, ++inst_it;
            else
                ++inst_it;
        }
    }
    return stageValues;
}

RAPass::Nodes RAPass::spill_classic(const OperP &op) {
    ///@brief 扫一遍insts, 将spillNode换成对应的新虚拟寄存器
    ///@brief 在def之后加str, 在use之前加ldr, 都溢出到栈上
    ///@warning 注意更改BaseADROP的基址寄存器(getBase())和变址寄存器

    Nodes stageValues;

    // 溢出的栈空间
    auto stackspace = std::make_shared<FrameObj>(FrameTrait::Spill, 4);
    stackspace->setId(Func->editInfo().StackObjs.size());
    Func->editInfo().StackObjs.emplace_back(stackspace);
    auto stackaddr = varpool->addStackValue_anonymously(stackspace); // base = sp

    for (const auto &blk : Func->getBlocks()) {
        auto &insts = blk->getInsts();
        for (auto inst_it = insts.begin(); inst_it != insts.end();) {
            // bool insert_before = false;
            bool insert_after = false;
            auto inst = *inst_it;

            if (auto ldr = std::dynamic_pointer_cast<ldrInst>(inst)) {
                auto def = ldr->getTargetOP();
                auto base = std::dynamic_pointer_cast<BaseADROP>(ldr->getSourceOP(1));
                auto index = ldr->getSourceOP(2);

                Err::gassert(base != nullptr, "base register is NULL");

                if (base->getBase() == op) { // 需要setBase()
                    // insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    base->setBase(read_stage); // 弃用原基址寄存器(修改原指令)
                    stageValues.insert(read_stage);
                    auto ldr_new = std::make_shared<ldrInst>(SourceOperandType::rsi, 4, read_stage,
                                                             stackaddr); // ldr %new_base, [%stackaddr]

                    insts.insert(inst_it, ldr_new);
                }

                if (index == op) { // maybe nullptr
                    // insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    ldr->setIndexReg(read_stage); // 修改原指令
                    stageValues.insert(read_stage);
                    auto ldr_new = std::make_shared<ldrInst>(SourceOperandType::rsi, 4, read_stage, stackaddr);

                    insts.insert(inst_it, ldr_new);
                }

                if (def == op) {
                    insert_after = true;

                    auto write_stage = varpool->addValue_anonymously(false);
                    ldr->addTargetOP(write_stage); // 修改原指令
                    stageValues.insert(write_stage);
                    auto str_new = std::make_shared<strInst>(SourceOperandType::rsi, 4, write_stage, stackaddr);

                    insts.insert(std::next(inst_it), str_new);
                }

            } else if (auto str = std::dynamic_pointer_cast<strInst>(inst)) {
                auto use = str->getSourceOP(1);
                auto base = std::dynamic_pointer_cast<BaseADROP>(str->getSourceOP(2));
                auto index = str->getSourceOP(3);

                Err::gassert(base != nullptr, "base register is NULL");

                if (use == op) {
                    // insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    str->setSourceOP(1, read_stage); // 修改原指令
                    stageValues.insert(read_stage);
                    auto ldr_new = std::make_shared<ldrInst>(SourceOperandType::rsi, 4, read_stage, stackaddr);

                    insts.insert(inst_it, ldr_new);
                }

                if (base->getBase() == op) { // 需要setBase()
                    // insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    base->setBase(read_stage); // 弃用原基址寄存器(修改原指令)
                    stageValues.insert(read_stage);
                    auto ldr_new = std::make_shared<ldrInst>(SourceOperandType::rsi, 4, read_stage,
                                                             stackaddr); // ldr %new_base, [%stackaddr]

                    insts.insert(inst_it, ldr_new);
                }

                if (index == op) { // maybe nullptr
                    // insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    str->setIndexReg(read_stage); // 修改原指令
                    stageValues.insert(read_stage);
                    auto ldr_new = std::make_shared<ldrInst>(SourceOperandType::rsi, 4, read_stage, stackaddr);

                    insts.insert(inst_it, ldr_new);
                }

            } else if (auto vldr = std::dynamic_pointer_cast<Vldr>(inst)) {
                auto base = std::dynamic_pointer_cast<BaseADROP>(vldr->getSourceOP(1));
                auto index = vldr->getSourceOP(2);

                Err::gassert(base != nullptr, "base register is NULL");

                if (base->getBase() == op) { // 需要setBase()
                    // insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    base->setBase(read_stage); // 弃用原基址寄存器(修改原指令)
                    stageValues.insert(read_stage);
                    auto ldr_new = std::make_shared<ldrInst>(SourceOperandType::rsi, 4, read_stage,
                                                             stackaddr); // ldr %new_base, [%stackaddr]

                    insts.insert(inst_it, ldr_new);
                }

                if (index == op) { // maybe nullptr
                    // insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    ldr->setIndexReg(read_stage); // 修改原指令
                    stageValues.insert(read_stage);
                    auto ldr_new = std::make_shared<ldrInst>(SourceOperandType::rsi, 4, read_stage, stackaddr);

                    insts.insert(inst_it, ldr_new);
                }
            } else if (auto vstr = std::dynamic_pointer_cast<Vstr>(inst)) {
                auto base = std::dynamic_pointer_cast<BaseADROP>(str->getSourceOP(2));
                auto index = str->getSourceOP(3);

                Err::gassert(base != nullptr, "base register is NULL");

                if (base->getBase() == op) { // 需要setBase()
                    // insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    base->setBase(read_stage); // 弃用原基址寄存器(修改原指令)
                    stageValues.insert(read_stage);
                    auto ldr_new = std::make_shared<ldrInst>(SourceOperandType::rsi, 4, read_stage,
                                                             stackaddr); // ldr %new_base, [%stackaddr]

                    insts.insert(inst_it, ldr_new);
                }

                if (index == op) { // maybe nullptr
                    // insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    str->setIndexReg(read_stage); // 修改原指令
                    stageValues.insert(read_stage);
                    auto ldr_new = std::make_shared<ldrInst>(SourceOperandType::rsi, 4, read_stage, stackaddr);

                    insts.insert(inst_it, ldr_new);
                }
            } else {
                auto uses = getUse(inst);
                auto defs = getDef(inst);

                if (uses.find(op) != uses.end()) {
                    // insert_before = true;

                    auto read_stage = varpool->addValue_anonymously(false);
                    auto ldr_new = std::make_shared<ldrInst>(SourceOperandType::rsi, 4, read_stage, stackaddr);
                    for (int i = 1; i < 5; ++i) {
                        if (inst->getSourceOP(i) == op) {
                            inst->setSourceOP(i, read_stage);
                            break;
                        }
                    }
                    stageValues.insert(read_stage);

                    insts.insert(inst_it, ldr_new);
                }

                if (defs.find(op) != defs.end()) {
                    insert_after = true;

                    auto write_stage = varpool->addValue_anonymously(false);
                    auto str_new = std::make_shared<strInst>(SourceOperandType::rsi, 4, write_stage, stackaddr);
                    inst->addTargetOP(write_stage);
                    stageValues.insert(write_stage);

                    insts.insert(std::next(inst_it), str_new);
                }
            }

            if (insert_after)
                ++inst_it, ++inst_it;
            else
                ++inst_it;
        }
    }
    return stageValues;
}

bool NeonRAPass::isMoveInstruction(const InstP &inst) {
    /// vmov sx, sy

    auto use = std::dynamic_pointer_cast<BindOnVirOP>(inst->getSourceOP(1));
    auto def = std::dynamic_pointer_cast<BindOnVirOP>(inst->getTargetOP());

    if (use == nullptr)
        return false;

    if (std::dynamic_pointer_cast<NeonInstruction>(inst)) {
        if (std::get<NeonOpCode>(inst->getOpCode()) == NeonOpCode::VMOV) {
            if (use->getBank() != RegisterBank::gpr && use->getBank() == def->getBank())
                return true;
        }
    } else {
        if (std::get<OpCode>(inst->getOpCode()) == OpCode::COPY) {
            if (use->getBank() != RegisterBank::gpr && use->getBank() == def->getBank())
                return true;
        }
    }

    return false;
}

NeonRAPass::Nodes NeonRAPass::getUse(const InstP &inst) {
    NeonRAPass::Nodes uses;

    if (inst->getOpCode().index() == 0 &&
        (std::get<OpCode>(inst->getOpCode()) == OpCode::BL || std::get<OpCode>(inst->getOpCode()) == OpCode::BLX)) {
        auto &varpool = Func->editInfo().getPool();

        for (int sx = 0; sx < 16; ++sx) {
            uses.insert(varpool.getValue(static_cast<FPURegister>(sx)));
        }

        return uses;
    }

    for (int i = 1; i < 5; ++i) {
        auto op = inst->getSourceOP(i);
        if (std::dynamic_pointer_cast<BindOnVirOP>(op) &&
            std::dynamic_pointer_cast<BindOnVirOP>(op)->getBank() == RegisterBank::spr)
            ///@todo dpr, qpr...

            uses.insert(op);
    }
    return uses;
}

NeonRAPass::Nodes NeonRAPass::getDef(const InstP &inst) {
    NeonRAPass::Nodes defs;

    auto target = inst->getTargetOP();

    if (!target)
        return defs;

    if (target->getBank() == RegisterBank::spr)
        ///@todo dpr, qpr
        defs.insert(inst->getTargetOP());

    return defs;
}

NeonRAPass::Nodes NeonRAPass::spill_tryOpt(const OperP &op) {
    ++spilltimes;
    return spill_classic(op);
}

NeonRAPass::Nodes NeonRAPass::spill_classic(const OperP &op) {
    Nodes stageValues;

    // 溢出的栈空间
    auto stackspace = std::make_shared<FrameObj>(FrameTrait::Spill, 4);
    stackspace->setId(Func->editInfo().StackObjs.size());
    Func->editInfo().StackObjs.emplace_back(stackspace);
    auto stackaddr = varpool->addStackValue_anonymously(stackspace);

    for (const auto &blk : Func->getBlocks()) {
        auto &insts = blk->getInsts();
        for (auto inst_it = insts.begin(); inst_it != insts.end();) {
            bool insert_before = false;
            bool insert_after = false;
            auto inst = *inst_it;

            auto uses = getUse(inst);
            auto defs = getDef(inst);

            if (uses.find(op) != uses.end()) {
                insert_before = true;
                ///@todo spr, dpr...

                auto read_stage = varpool->addValue_anonymously(false);
                auto vldr_new = std::make_shared<Vldr>(read_stage, stackaddr,
                                                       std::make_pair(bitType::DEFAULT32, bitType::DEFAULT32));
                for (int i = 1; i < 5; ++i) {
                    if (inst->getSourceOP(i) == op) {
                        inst->setSourceOP(i, read_stage);
                        break;
                    }
                }
                stageValues.insert(read_stage);

                insts.insert(inst_it, vldr_new);
            }

            if (defs.find(op) != defs.end()) {
                insert_after = true;
                ///@todo spr, dpr...

                auto write_stage = varpool->addValue_anonymously(true);
                auto vstr_new = std::make_shared<Vstr>(write_stage, stackaddr,
                                                       std::make_pair(bitType::DEFAULT32, bitType::DEFAULT32));
                stageValues.insert(write_stage);

                insts.insert(std::next(inst_it), vstr_new);
            }

            if (insert_after)
                ++inst_it, ++inst_it;
            else
                ++inst_it;
        }
    }

    return stageValues;
}