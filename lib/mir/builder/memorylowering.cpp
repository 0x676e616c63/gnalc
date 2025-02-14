#include "../../../include/mir/SIMDinstruction/memory.hpp"
#include "../../../include/mir/builder/lowering.hpp"
#include "../../../include/mir/instructions/binary.hpp"
#include "../../../include/mir/instructions/branch.hpp"
#include "../../../include/mir/instructions/copy.hpp"
#include "../../../include/mir/instructions/memory.hpp"
#include "../../../include/mirtools/tool.hpp"

using namespace MIR;

std::list<std::shared_ptr<Instruction>>
InstLowering::allocaLower(const std::shared_ptr<IR::ALLOCAInst> &alloca) {
    std::list<std::shared_ptr<Instruction>> insts;
    unsigned long long size;
    size = alloca->getBaseType()->getBytes();

    auto target = operlower.mkStackOP(*alloca, size);

    return insts; // empty
}

std::list<std::shared_ptr<Instruction>>
InstLowering::loadLower(const std::shared_ptr<IR::LOADInst> &load) {
    std::list<std::shared_ptr<Instruction>> insts;
    auto ptr = load->getPtr();
    std::shared_ptr<BindOnVirOP> val_in_reg = operlower.mkOP(*load, RegisterBank::gpr);
    std::shared_ptr<BaseADROP> ptr_in_reg;

    // ==================
    // step1: ptr是否是全局变量
    // ==================
    if (auto global_ptr = std::dynamic_pointer_cast<IR::GlobalVariable>(ptr)) {
        auto pair = operlower.LoadedFind(global_ptr->getName());
        ptr_in_reg = std::dynamic_pointer_cast<BaseADROP>(pair.second);

        if (!pair.first) {
            // mov %ptr_in_reg, #...
            auto mov = std::make_shared<movInst>(SourceOperandType::a, ptr_in_reg, operlower.fastFind(global_ptr->getName()));
            insts.emplace_back(mov);
        }
    } else {
        ptr_in_reg = std::dynamic_pointer_cast<BaseADROP>(operlower.fastFind(ptr));
    }

    // ==================
    // step2: ldr %val_in_reg, [%ptr_in_reg]
    // ==================

    auto ldr = std::make_shared<ldrInst>(SourceOperandType::ra, 4, val_in_reg, ptr_in_reg);
    insts.emplace_back(ldr);
    return insts;
}

std::list<std::shared_ptr<Instruction>>
InstLowering::storeLower(const std::shared_ptr<IR::STOREInst> &store) {
    std::list<std::shared_ptr<Instruction>> insts;
    auto ptr = store->getPtr();
    auto val = store->getValue();
    std::shared_ptr<BindOnVirOP> val_in_reg;
    std::shared_ptr<BaseADROP> ptr_in_reg;

    // ==================
    // step1: str的值是否为常数(int and float)
    // ==================
    if (auto const_int_val = std::dynamic_pointer_cast<IR::ConstantInt>(val)) {
        auto pair = operlower.LoadedFind(const_int_val->getVal());
        val_in_reg = pair.second;

        if (!pair.first) {
            // mov %val_in_reg, #imme_int
            auto mov = std::make_shared<movInst>(SourceOperandType::cp, val_in_reg, operlower.fastFind(const_int_val->getVal()));
            insts.emplace_back(mov);
        }
    } else if (auto const_float_val = std::dynamic_pointer_cast<IR::ConstantFloat>(val)) {
        auto pair = operlower.LoadedFind(const_float_val->getVal());
        val_in_reg = pair.second;

        if (!pair.first) {
            // mov %val_in_reg, #imme_float
            auto mov = std::make_shared<movInst>(SourceOperandType::cp, val_in_reg, operlower.fastFind(const_float_val->getVal()));
            insts.emplace_back(mov);
        }
    } else {
        val_in_reg = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(val));
    }

    // ==================
    // step2: ptr是否是全局变量
    // ==================
    if (auto global_ptr = std::dynamic_pointer_cast<IR::GlobalVariable>(ptr)) {
        auto pair = operlower.LoadedFind(global_ptr->getName());
        ptr_in_reg = std::dynamic_pointer_cast<BaseADROP>(pair.second);

        if (!pair.first) {
            // mov %ptr_in_reg, #...
            auto mov = std::make_shared<movInst>(SourceOperandType::a, ptr_in_reg, operlower.fastFind(global_ptr->getName()));
            insts.emplace_back(mov);
        }
    } else {
        ptr_in_reg = std::dynamic_pointer_cast<BaseADROP>(operlower.fastFind(ptr));
    }

    // ==================
    // step3: str %val_in_reg, [%ptr_in_reg]
    // ==================

    auto str = std::make_shared<strInst>(SourceOperandType::ra, 4, val_in_reg, ptr_in_reg);
    insts.emplace_back(str);
    return insts;
}

std::list<std::shared_ptr<Instruction>>
InstLowering::gepLower(const std::shared_ptr<IR::GEPInst> &gep) {
    std::list<std::shared_ptr<Instruction>> insts;
    auto ptr = gep->getPtr();
    auto idx = gep->getIdxs()[1];
    int perElemSize =
        std::dynamic_pointer_cast<IR::ArrayType>(gep->getBaseType())
            ->getElmType()
            ->getBytes();

    /// 一共四种情况, ptr是否是全局变量, idx是否是常量

    std::shared_ptr<BaseADROP> baseOP;
    if (auto global_ptr = std::dynamic_pointer_cast<IR::GlobalVariable>(ptr)) {
        auto pair = operlower.LoadedFind(global_ptr->getName());
        if (pair.first)
            baseOP = std::dynamic_pointer_cast<BaseADROP>(pair.second);
        else {
            /// 加mov
            auto relay = std::dynamic_pointer_cast<BaseADROP>(pair.second);

            auto global_addr = operlower.fastFind(global_ptr->getName());

            auto mov = std::make_shared<movInst>(SourceOperandType::a, relay,
                                                 global_addr);
            insts.emplace_back(mov);
            baseOP = relay;
        }

        if (auto const_idx = std::dynamic_pointer_cast<IR::ConstantInt>(idx)) {
            auto add_offset = const_idx->getVal() * perElemSize;
            operlower.mkBaseOP(*gep, baseOP, add_offset);
        } else {
            // mul %temp1, %var_idx, #imme (带优化)
            // add (%BindOnVirOP)temp2, %(BindOnVirOP)baseOP, %temp1
            auto relay2 = operlower.mkBaseOP(*gep, baseOP, 0);
            auto var_idx = operlower.fastFind(idx);

            auto relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32),
                                        RegisterBank::gpr);
            auto mul_midEnd = std::make_shared<IR::BinaryInst>(
                relay->getName(), IR::OP::MUL, idx,
                std::make_shared<IR::ConstantInt>(perElemSize));

            insts.splice(insts.end(), binaryLower(mul_midEnd)); // 复用
        }
    }

    return insts;
}

std::list<std::shared_ptr<Instruction>> InstLowering::loadLower_v(const std::shared_ptr<IR::LOADInst> &load) {
    std::list<std::shared_ptr<Instruction>> insts;
    auto ptr = load->getPtr();
    std::shared_ptr<BindOnVirOP> val_in_reg = operlower.mkOP(*load, RegisterBank::spr);
    std::shared_ptr<BaseADROP> ptr_in_reg;

    // ==================
    // step1: ptr是否是全局变量
    // ==================
    if (auto global_ptr = std::dynamic_pointer_cast<IR::GlobalVariable>(ptr)) {
        auto pair = operlower.LoadedFind(global_ptr->getName());
        ptr_in_reg = std::dynamic_pointer_cast<BaseADROP>(pair.second);

        if (!pair.first) {
            // vmov %ptr_in_reg, #...
            auto pair = std::make_pair(bitType::DEFAULT32, bitType::DEFAULT32);
            auto vmov = std::make_shared<Vmov>(SourceOperandType::a, ptr_in_reg, operlower.fastFind(global_ptr->getName()), pair);
            insts.emplace_back(vmov);
        }
    } else {
        ptr_in_reg = std::dynamic_pointer_cast<BaseADROP>(operlower.fastFind(ptr));
    }

    // ==================
    // step2: vldr %val_in_reg, [%ptr_in_reg]
    // ==================
    auto pair = std::make_pair(bitType::f32, bitType::DEFAULT32);
    auto vldr = std::make_shared<Vldr>(val_in_reg, ptr_in_reg, pair);
    insts.emplace_back(vldr);
    return insts;
}

std::list<std::shared_ptr<Instruction>> InstLowering::storeLower_v(const std::shared_ptr<IR::STOREInst> &store) {
    std::list<std::shared_ptr<Instruction>> insts;
    auto ptr = store->getPtr();
    auto val = store->getValue();
    std::shared_ptr<BindOnVirOP> val_in_reg;
    std::shared_ptr<BaseADROP> ptr_in_reg;

    // ==================
    // step1: str的值是否为常数, 为常数退化为str
    // ==================
    if (auto const_val = std::dynamic_pointer_cast<IR::ConstantFloat>(val)) {
        insts = storeLower(store);
        return insts;
    } else {
        val_in_reg = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(val));
    }

    // ==================
    // step2: ptr是否是全局变量
    // ==================
    if (auto global_ptr = std::dynamic_pointer_cast<IR::GlobalVariable>(ptr)) {
        auto pair = operlower.LoadedFind(global_ptr->getName());
        ptr_in_reg = std::dynamic_pointer_cast<BaseADROP>(pair.second);

        if (!pair.first) {
            // mov %ptr_in_reg, #...
            auto mov = std::make_shared<movInst>(SourceOperandType::a, ptr_in_reg, operlower.fastFind(global_ptr->getName()));
            insts.emplace_back(mov);
        }
    } else {
        ptr_in_reg = std::dynamic_pointer_cast<BaseADROP>(operlower.fastFind(ptr));
    }

    // ==================
    // step3: vstr %val_in_reg, [%ptr_in_reg]
    // ==================
    auto pair = std::make_pair(bitType::DEFAULT32, bitType::DEFAULT32);
    auto vstr = std::make_shared<Vstr>(val_in_reg, ptr_in_reg, pair);
    insts.emplace_back(vstr);
    return insts;
}