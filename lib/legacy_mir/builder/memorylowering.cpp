// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#include "legacy_mir/tool.hpp"
#include "legacy_mir/SIMDinstruction/memory.hpp"
#include "legacy_mir/builder/lowering.hpp"
#include "legacy_mir/instructions/binary.hpp"
#include "legacy_mir/instructions/branch.hpp"
#include "legacy_mir/instructions/memory.hpp"

using namespace LegacyMIR;

std::list<std::shared_ptr<Instruction>> InstLowering::allocaLower(const std::shared_ptr<IR::ALLOCAInst> &alloca,
                                                                  const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;
    unsigned long long size;
    size = alloca->getBaseType()->getBytes();

    auto target = operlower.mkStackOP(*alloca, size);

    return insts; // empty
}

std::list<std::shared_ptr<Instruction>> InstLowering::loadLower(const std::shared_ptr<IR::LOADInst> &load,
                                                                const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;
    auto ptr = load->getPtr();
    std::shared_ptr<BindOnVirOP> val_in_reg = operlower.mkOP(*load, RegisterBank::gpr);
    std::shared_ptr<BaseADROP> ptr_in_reg;

    // ==================
    // step1: ptr是否是全局变量
    // ==================
    if (auto global_ptr = std::dynamic_pointer_cast<IR::GlobalVariable>(ptr)) {
        ptr_in_reg = std::dynamic_pointer_cast<BaseADROP>(operlower.LoadedFind(global_ptr->getName(), blk));
        Err::gassert(ptr_in_reg != nullptr, "find a loaded global ptr failed");
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

std::list<std::shared_ptr<Instruction>> InstLowering::storeLower(const std::shared_ptr<IR::STOREInst> &store,
                                                                 const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;
    auto ptr = store->getPtr();
    auto val = store->getValue();
    std::shared_ptr<BindOnVirOP> val_in_reg;
    std::shared_ptr<BaseADROP> ptr_in_reg;

    // ==================
    // step1: str的值是否为常数 int or float(pass down by storeLower_v)
    // ==================
    if (auto const_int_val = std::dynamic_pointer_cast<IR::ConstantInt>(val)) {
        val_in_reg = operlower.LoadedFind(const_int_val->getVal(), blk);
    } else if (auto const_float_val = std::dynamic_pointer_cast<IR::ConstantFloat>(val)) {
        val_in_reg = operlower.LoadedFind(const_float_val->getVal(), blk);
    } else {
        val_in_reg = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(val));
    }

    // ===================
    // step1.5: val_in_reg 是否需要展开, 替换val_in_reg
    // 应该用不到(交给store_p), 但还是留在这里
    // ===================
    if (val_in_reg->getOperandTrait() == OperandTrait::BaseAddress) {
        auto base_in_reg = val_in_reg->as<BaseADROP>();

        auto val_in_reg = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);

        if (base_in_reg->getTrait() == BaseAddressTrait::Local) {
            auto stk_in_reg = base_in_reg->as<StackADROP>();
            auto unknown = make<UnknownConstant>(stk_in_reg->getObj());
            auto add1 =
                make<binaryImmInst>(OpCode::ADD, SourceOperandType::ri, val_in_reg, val_in_reg, unknown, nullptr);
            insts.emplace_back(add1);
        }
        if (base_in_reg->getConstOffset()) {
            auto constoffset = operlower.fastFind(base_in_reg->getConstOffset())->as<ConstantIDX>();
            std::shared_ptr<binaryImmInst> add2;

            if (!constoffset->getConst()->isEncoded())
                add2 = make<binaryImmInst>(OpCode::ADD, SourceOperandType::ri, val_in_reg, val_in_reg, constoffset,
                                           nullptr);
            else
                add2 = make<binaryImmInst>(OpCode::ADD, SourceOperandType::rr, val_in_reg, val_in_reg,
                                           operlower.LoadedFind(base_in_reg->getConstOffset(), blk), nullptr);

            insts.emplace_back(add2);
        }
    }
    // ps: 经过这步操作之后, str中的source1应该能从BaseAddress降格至一般reg

    // ==================
    // step2: ptr是否是全局变量
    // ==================
    if (auto global_ptr = std::dynamic_pointer_cast<IR::GlobalVariable>(ptr)) {
        ptr_in_reg = std::dynamic_pointer_cast<BaseADROP>(operlower.LoadedFind(global_ptr->getName(), blk));
        Err::gassert(ptr_in_reg != nullptr, "find a loaded global ptr failed");
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

std::list<std::shared_ptr<Instruction>> InstLowering::gepLower(const std::shared_ptr<IR::GEPInst> &gep,
                                                               const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;

    /// gep 将数组退化为对应类型的指针, 所以其实也算是一种converse?

    auto ptr = gep->getPtr();
    ///@note 使用指针时为[0], 使用数组时为[1]
    // auto idx = gep->getIdxs().size() == 1 ? gep->getIdxs()[0] : gep->getIdxs()[1];
    // int perElemSize = std::dynamic_pointer_cast<IR::ArrayType>(gep->getBaseType())->getElmType()->getBytes();
    IR::pVal idx;
    auto idxs = gep->getIdxs();
    unsigned perElemSize;

    if (auto arraytype = gep->getBaseType()->as<IR::ArrayType>()) {
        if (idxs.size() == 1) {
            idx = idxs[0];
            perElemSize = arraytype->getBytes();
        } else {
            idx = idxs[1];
            perElemSize = arraytype->getElmType()->getBytes();
        }

    } else if (auto btype = gep->getBaseType()->as<IR::BType>()) {
        idx = idxs[0];
        perElemSize = 4;
    } else {
        Err::unreachable("gep unknown base val type");
    }

    /// 一共四种情况, ptr是否是全局变量

    std::shared_ptr<BaseADROP> baseOP;
    if (auto global_ptr = std::dynamic_pointer_cast<IR::GlobalVariable>(ptr)) {
        baseOP = operlower.LoadedFind(global_ptr->getName(), blk)->as<BaseADROP>();
        Err::gassert(baseOP != nullptr, "find a loaded global ptr failed");
    } else {
        baseOP = std::dynamic_pointer_cast<BaseADROP>(operlower.fastFind(ptr));
    }

    /// idx是否是常量
    if (auto const_idx = std::dynamic_pointer_cast<IR::ConstantInt>(idx)) {
        auto add_offset = const_idx->getVal() * perElemSize;
        operlower.mkBaseOP(*gep, baseOP, add_offset);
    } else {
        // mul %relay1, %var_idx, #perElemsize ; 带优化, 计算偏移大小
        // add (%BindOnVirOP)target, %(BindOnVirOP)baseOP, %relay1
        // 这里add之后可以考虑做一个窥孔, 将相应的ldr改成基址变址寻址
        auto relay1 = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
        auto target = operlower.mkBaseOP(*gep, baseOP); // base = self, offset = 0

        auto mul_insts = mulOpt(relay1, idx, std::make_shared<IR::ConstantInt>(perElemSize), operlower, blk);
        insts.insert(insts.end(), mul_insts.begin(), mul_insts.end());

        auto add = std::make_shared<binaryImmInst>(OpCode::ADD, SourceOperandType::rr, target, baseOP->getBase(),
                                                   relay1, nullptr);
        insts.emplace_back(add);

        if (auto constoffset = baseOP->getConstOffset()) {
            std::shared_ptr<binaryImmInst> add1;
            if (isImmCanBeEncodedInText((unsigned)constoffset)) {
                auto constobj = operlower.fastFind(constoffset);
                add1 = make<binaryImmInst>(OpCode::ADD, SourceOperandType::ri, target, target, constobj, nullptr);
            } else {
                add1 = make<binaryImmInst>(OpCode::ADD, SourceOperandType::rr, target, target,
                                           operlower.LoadedFind(constoffset, blk), nullptr);
            }

            insts.emplace_back(add1);
        }

        // ///@brief 基址为sp, 需要展开
        // if (baseOP->getTrait() == BaseAddressTrait::Local &&
        //     baseOP->getBase() == operlower.getPreColored(CoreRegister::sp)) {
        //     auto stkop = baseOP->as<StackADROP>();
        //     auto unknonw = make<UnknownConstant>(stkop->getObj());
        //     auto add2 = make<binaryImmInst>(OpCode::ADD, SourceOperandType::ri, target, target, unknonw, nullptr);
        //     insts.emplace_back(add2);
        // }
    }

    return insts;
}

std::list<std::shared_ptr<Instruction>> InstLowering::loadLower_v(const std::shared_ptr<IR::LOADInst> &load,
                                                                  const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;
    auto ptr = load->getPtr();
    std::shared_ptr<BindOnVirOP> val_in_reg = operlower.mkOP(*load, RegisterBank::spr);
    std::shared_ptr<BaseADROP> ptr_in_reg;

    // ==================
    // step1: ptr是否是全局变量
    // ==================
    if (auto global_ptr = std::dynamic_pointer_cast<IR::GlobalVariable>(ptr)) {
        ptr_in_reg = std::dynamic_pointer_cast<BaseADROP>(operlower.LoadedFind(global_ptr->getName(), blk));
        Err::gassert(ptr_in_reg != nullptr, "find a loaded global ptr failed");
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

std::list<std::shared_ptr<Instruction>> InstLowering::storeLower_v(const std::shared_ptr<IR::STOREInst> &store,
                                                                   const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;
    auto ptr = store->getPtr();
    auto val = store->getValue();
    std::shared_ptr<BindOnVirOP> val_in_reg;
    std::shared_ptr<BaseADROP> ptr_in_reg;

    // ==================
    // step1: str的值是否为常数, 为常数退化为str
    // ==================
    if (auto const_val = std::dynamic_pointer_cast<IR::ConstantFloat>(val)) {
        insts = storeLower(store, blk);
        return insts;
    } else {
        val_in_reg = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(val));
    }

    // ==================
    // step2: ptr是否是全局变量
    // ==================
    if (auto global_ptr = std::dynamic_pointer_cast<IR::GlobalVariable>(ptr)) {
        ptr_in_reg = std::dynamic_pointer_cast<BaseADROP>(operlower.LoadedFind(global_ptr->getName(), blk));
        Err::gassert(ptr_in_reg != nullptr, "find a loaded global ptr failed");
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

std::list<std::shared_ptr<Instruction>> InstLowering::loadLower_p(const std::shared_ptr<IR::LOADInst> &load,
                                                                  const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;

    ///@brief load获得的值为一个指针
    ///@brief 由于基本类型只有int float, 所以load ptr应该不会是全局变量
    ///@brief target 为 #Rt
    std::shared_ptr<BaseADROP> ptr = std::dynamic_pointer_cast<BaseADROP>(operlower.fastFind(load->getPtr()));
    std::shared_ptr<BaseADROP> target = operlower.mkBaseOP(*load);

    // ldr %target, [%ptr]
    auto ldr = std::make_shared<ldrInst>(SourceOperandType::ra, 4, target, ptr);
    insts.emplace_back(ldr);

    return insts;
}

std::list<std::shared_ptr<Instruction>> InstLowering::storeLower_p(const std::shared_ptr<IR::STOREInst> &store,
                                                                   const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;

    ///@brief store的指针值不为常数, 无需多余判断

    std::shared_ptr<BaseADROP> value = std::dynamic_pointer_cast<BaseADROP>(operlower.fastFind(store->getValue()));
    std::shared_ptr<BaseADROP> ptr = std::dynamic_pointer_cast<BaseADROP>(operlower.fastFind(store->getPtr()));

    // ===================
    // step0: value 是否需要展开, 替换value
    // ===================
    if (value->getOperandTrait() == OperandTrait::BaseAddress) {
        auto base_in_reg = value->as<BaseADROP>();

        auto value = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);

        if (base_in_reg->getTrait() == BaseAddressTrait::Local) {
            auto stk_in_reg = base_in_reg->as<StackADROP>();
            auto unknown = make<UnknownConstant>(stk_in_reg->getObj());
            auto add1 = make<binaryImmInst>(OpCode::ADD, SourceOperandType::ri, value, value, unknown, nullptr);
            insts.emplace_back(add1);
        }
        if (base_in_reg->getConstOffset()) {
            auto constoffset = operlower.fastFind(base_in_reg->getConstOffset())->as<ConstantIDX>();
            std::shared_ptr<binaryImmInst> add2;

            if (!constoffset->getConst()->isEncoded())
                add2 = make<binaryImmInst>(OpCode::ADD, SourceOperandType::ri, value, value, constoffset, nullptr);
            else
                add2 = make<binaryImmInst>(OpCode::ADD, SourceOperandType::rr, value, value,
                                           operlower.LoadedFind(base_in_reg->getConstOffset(), blk), nullptr);

            insts.emplace_back(add2);
        }
    }
    // ps: 经过这步操作之后, str中的source1应该能从BaseAddress降格至一般reg

    auto str = std::make_shared<strInst>(SourceOperandType::ra, 4, value, ptr);
    insts.emplace_back(str);

    return insts;
}

std::list<std::shared_ptr<Instruction>> InstLowering::gepLower_p(const std::shared_ptr<IR::GEPInst> &gep,
                                                                 const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;

    ///@bug
    auto ptr = std::dynamic_pointer_cast<BaseADROP>(operlower.fastFind(gep->getPtr())); // base
    auto target = std::dynamic_pointer_cast<BaseADROP>(operlower.mkBaseOP(*gep, ptr));  // gep value

    return insts; // empty
}
#endif