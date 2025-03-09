#include "../../../../include/mir/SIMDinstruction/memory.hpp"
#include "../../../../include/mir/instructions/memory.hpp"
#include "../../../../include/mir/passes/transforms/registeralloc.hpp"
#include <random>
#include <utility>

using namespace MIR;

bool RAPass::isMoveInstruction(const InstP &inst) {
    auto use = std::dynamic_pointer_cast<BindOnVirOP>(inst->getSourceOP(1));
    auto def = std::dynamic_pointer_cast<BindOnVirOP>(inst->getTargetOP());

    if (use == nullptr)
        return false;

    if (!std::dynamic_pointer_cast<NeonInstruction>(inst)) {
        if (std::get<OpCode>(inst->getOpCode()) == OpCode::MOV || std::get<OpCode>(inst->getOpCode()) == OpCode::COPY) {
        }
    } else {
        if (std::get<NeonOpCode>(inst->getOpCode()) == NeonOpCode::VMOV) {
            if (use->getBank() == def->getBank())
                return true;
        }
    }

    return false;
}

RAPass::Nodes RAPass::getUse(const InstP &inst) {
    Nodes uses;
    for (int i = 1; i < 5; ++i) {
        auto op = inst->getSourceOP(i);
        if (std::dynamic_pointer_cast<BindOnVirOP>(op))
            uses.insert(op);
    }

    return uses;
}

RAPass::Nodes RAPass::getDef(const InstP &inst) {
    return Nodes{inst->getTargetOP()};
}

OperP RAPass::heuristicSpill() {
    const double Weight_IntervalLength = 2.5;
    const double Weight_Degree = 3;
    const double extra_Weight_ForNotPtr = -50;

    ///@note 计算溢出权重
    double weight_max = 0;
    OperP spilled = nullptr;
    for (const auto &op : spilledNodes) {
        double weight = liveAnalysis.getInfo().intervalLengths[op] * Weight_IntervalLength;
        weight += degree[op] * Weight_Degree;
        if (!std::dynamic_pointer_cast<BaseADROP>(op))
            weight += extra_Weight_ForNotPtr;

        if (weight > weight_max)
            spilled = op;
    }

    return spilled;
}

///@note 返回用于替换的小区间虚拟寄存器
RAPass::Nodes RAPass::spill(const OperP &op) {
    ///@brief 扫一遍insts, 将spillNode换成对应的新虚拟寄存器
    ///@brief 在def之后加str, 在use之前加ldr, 都溢出到栈上
    ///@warning 注意更改BaseADROP的基址寄存器(getBase())和变址寄存器

    Nodes stageValues;

    // 溢出的栈空间
    auto stackspace = std::make_shared<FrameObj>(FrameTrait::Spill, 4);
    func.editInfo().StackObjs.emplace_back(stackspace);

    for (auto blk : func.getBlocks()) {
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

                    auto stackaddr = varpool.addStackValue_anonymously(stackspace); // base = r7
                    auto read_stage = varpool.addValue_anonymously(false);
                    base->setBase(read_stage); // 弃用原基址寄存器(修改原指令)
                    stageValues.insert(read_stage);
                    auto ldr_new = std::make_shared<ldrInst>(SourceOperandType::rsi, 4, read_stage, stackaddr); // ldr %new_base, [%stackaddr]

                    insts.insert(inst_it, ldr_new);
                }

                if (index == op) { // maybe nullptr
                    insert_before = true;

                    auto stackaddr = varpool.addStackValue_anonymously(stackspace); // base = r7
                    auto read_stage = varpool.addValue_anonymously(false);
                    ldr->setIndexReg(read_stage); // 修改原指令
                    stageValues.insert(read_stage);
                    auto ldr_new = std::make_shared<ldrInst>(SourceOperandType::rsi, 4, read_stage, stackaddr);

                    insts.insert(inst_it, ldr_new);
                }

                if (def == op) {
                    insert_after = true;

                    auto stackaddr = varpool.addStackValue_anonymously(stackspace); // base = r7
                    auto write_stage = varpool.addValue_anonymously(false);
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
                    insert_before = true;

                    auto stackaddr = varpool.addStackValue_anonymously(stackspace); // base = r7
                    auto read_stage = varpool.addValue_anonymously(false);
                    str->setSourceOP(1, read_stage); // 修改原指令
                    stageValues.insert(read_stage);
                    auto ldr_new = std::make_shared<ldrInst>(SourceOperandType::rsi, 4, read_stage, stackaddr);

                    insts.insert(inst_it, ldr_new);
                }

                if (base->getBase() == op) { // 需要setBase()
                    insert_before = true;

                    auto stackaddr = varpool.addStackValue_anonymously(stackspace); // base = r7
                    auto read_stage = varpool.addValue_anonymously(false);
                    base->setBase(read_stage); // 弃用原基址寄存器(修改原指令)
                    stageValues.insert(read_stage);
                    auto ldr_new = std::make_shared<ldrInst>(SourceOperandType::rsi, 4, read_stage, stackaddr); // ldr %new_base, [%stackaddr]

                    insts.insert(inst_it, ldr_new);
                }

                if (index == op) { // maybe nullptr
                    insert_before = true;

                    auto stackaddr = varpool.addStackValue_anonymously(stackspace); // base = r7
                    auto read_stage = varpool.addValue_anonymously(false);
                    str->setIndexReg(read_stage); // 修改原指令
                    stageValues.insert(read_stage);
                    auto ldr_new = std::make_shared<ldrInst>(SourceOperandType::rsi, 4, read_stage, stackaddr);

                    insts.insert(inst_it, ldr_new);
                }

            } else {
                auto uses = getUse(inst);
                auto defs = getDef(inst);

                if (uses.find(op) != uses.end()) {
                }

                if (defs.find(op) != defs.end()) {
                }
            }

            if (insert_after)
                ++inst_it, ++inst_it;
            else
                ++inst_it;
        }
    }
}
