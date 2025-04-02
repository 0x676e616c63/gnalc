#include "../../../include/mir/SIMDinstruction/memory.hpp"
#include "../../../include/mir/builder/lowering.hpp"
#include "../../../include/mir/instructions/binary.hpp"
#include "../../../include/mir/instructions/branch.hpp"
#include "../../../include/mir/instructions/copy.hpp"
#include "../../../include/mir/instructions/memory.hpp"
#include "../../../include/mirtools/tool.hpp"

using namespace MIR;

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
    unsigned perElemSize;

    if (auto arraytype = gep->getBaseType()->as<IR::ArrayType>()) {
        idx = gep->getIdxs()[1];
        perElemSize = arraytype->getElmType()->getBytes();
    } else if (auto btype = gep->getBaseType()->as<IR::BType>()) {
        idx = gep->getIdxs()[0];
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
        // add (%BindOnVirOP)relay2, %(BindOnVirOP)baseOP, %relay1
        // 这里add之后可以考虑做一个窥孔, 将相应的ldr改成基址变址寻址
        auto relay1 = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
        auto relay2 = operlower.mkBaseOP(*gep, baseOP);

        auto mul_insts = mulOpt(relay1, idx, std::make_shared<IR::ConstantInt>(perElemSize), operlower, blk);
        insts.insert(insts.end(), mul_insts.begin(), mul_insts.end());

        auto add = std::make_shared<binaryImmInst>(OpCode::ADD, SourceOperandType::rr, relay2, baseOP, relay1, nullptr);
        insts.emplace_back(add);
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
    std::shared_ptr<BaseADROP> ptr = std::dynamic_pointer_cast<BaseADROP>(operlower.fastFind(load->getPtr()));
    std::shared_ptr<BaseADROP> target = operlower.mkBaseOP(*load, ptr);

    // ldr %target, [%ptr]
    auto ldr = std::make_shared<ldrInst>(SourceOperandType::ra, 4, target, ptr);
    insts.emplace_back(ldr);

    return insts;
}

std::list<std::shared_ptr<Instruction>> InstLowering::storeLower_p(const std::shared_ptr<IR::STOREInst> &store,
                                                                   const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;

    ///@brief store的指针值不为常数

    std::shared_ptr<BaseADROP> value = std::dynamic_pointer_cast<BaseADROP>(operlower.fastFind(store->getValue()));
    std::shared_ptr<BaseADROP> ptr = std::dynamic_pointer_cast<BaseADROP>(operlower.fastFind(store->getPtr()));

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