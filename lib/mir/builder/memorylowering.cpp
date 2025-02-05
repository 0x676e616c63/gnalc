#include "../../../include/mir/builder/lowering.hpp"
#include "../../../include/mir/instructions/binary.hpp"
#include "../../../include/mir/instructions/branch.hpp"
#include "../../../include/mir/instructions/copy.hpp"
#include "../../../include/mir/instructions/memory.hpp"
#include "../../../include/mirtools/tool.hpp"
#include <cassert>

using namespace MIR;

std::list<std::shared_ptr<Instruction>>
InstLowering::allocaLower(const std::shared_ptr<IR::ALLOCAInst> &alloca) {
    std::list<std::shared_ptr<Instruction>> insts{};
    unsigned long long size;
    size = alloca->getBaseType()->getBytes();

    auto target = operlower.mkStackOP(*alloca, size);

    return insts; // empty
}

std::list<std::shared_ptr<Instruction>>
InstLowering::loadLower(const std::shared_ptr<IR::LOADInst> &load) {
    std::list<std::shared_ptr<Instruction>> insts{};

    auto ptr = std::dynamic_pointer_cast<BaseADROP>(
        operlower.fastFind(load->getPtr()));
    if (!ptr)
        // lowering全局变量, 获得一个GlobalADROP(offset == 0)
        ptr = operlower.mkBaseOP(*load->getPtr(), load->getPtr()->getName(), 0);

    auto target = operlower.mkOP(*load, RegisterBank::gpr);

    auto ldr = std::make_shared<ldrInst>(SourceOperandType::a, 4, target, ptr);
    insts.emplace_back(ldr);

    return insts;
}

std::list<std::shared_ptr<Instruction>>
InstLowering::storeLower(const std::shared_ptr<IR::STOREInst> &store) {
    std::list<std::shared_ptr<Instruction>> insts{};

    auto ptr = std::dynamic_pointer_cast<BaseADROP>(
        operlower.fastFind(store->getPtr()));

    if (!ptr)
        // lowering全局变量, 获得一个GlobalADROP(offset == 0)
        ptr =
            operlower.mkBaseOP(*store->getPtr(), store->getPtr()->getName(), 0);

    auto val = store->getValue();
    std::shared_ptr<BindOnVirOP> regOP = nullptr;

    if (auto store_const = std::dynamic_pointer_cast<IR::ConstantInt>(val)) {
        // mov Rd, #imme
        auto const_int = operlower.fastFind(store_const->getVal());
        auto relay = operlower.mkOP(
            std::make_shared<IR::BType>(IR::IRBTYPE::I32), RegisterBank::gpr);

        auto mov =
            std::make_shared<movInst>(SourceOperandType::i, relay, const_int);
        insts.emplace_back(mov);
        regOP = relay;
    } else
        regOP = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(val));

    auto str = std::make_shared<strInst>(SourceOperandType::rr, 4, regOP, ptr);
    insts.emplace_back(str);

    return insts;
}

std::list<std::shared_ptr<Instruction>>
InstLowering::gepLower(const std::shared_ptr<IR::GEPInst> &gep) {
    std::list<std::shared_ptr<Instruction>> insts{};

    // 假设所有的Gep都以行开头作为基址, 也就是idx[0]一定为0
    auto idx = gep->getIdxs()[1];
    auto ptr =
        std::dynamic_pointer_cast<BaseADROP>(operlower.fastFind(gep->getPtr()));

    if (!ptr)
        // lowering全局变量, 获得一个GlobalADROP(offset == 0)
        ptr = operlower.mkBaseOP(*gep->getPtr(), gep->getPtr()->getName(), 0);

    auto arraytype =
        std::dynamic_pointer_cast<IR::ArrayType>(gep->getBaseType());
    auto PreElemSize = arraytype->getBytes();

    if (!arraytype)
        assert(false && "get gep ArrayType failed\n");

    // =======================
    // idx为常量, 后端隐式地统计偏移, 避免多余指令
    // =======================
    if (auto const_idx = std::dynamic_pointer_cast<IR::ConstantInt>(idx)) {

        unsigned long long add_offset = PreElemSize * const_idx->getVal();

        operlower.mkBaseOP(*gep, ptr, add_offset);
    }
    // =======================
    // idx为虚拟寄存器中的变量, 需要添加计算偏移的指令
    // =======================
    else {
        // mul temp1, operlower(idx), #imme (带优化)
        // add (BindOnVirOP)temp2, (BindOnVirOP)ptr, temp1
        auto relay = operlower.mkOP(
            std::make_shared<IR::BType>(IR::IRBTYPE::I32), RegisterBank::gpr);
        auto mul_midEnd = std::make_shared<IR::BinaryInst>(
            relay->getName(), IR::OP::MUL, idx,
            std::make_shared<IR::ConstantInt>(PreElemSize));

        insts.splice(insts.end(), binaryLower(mul_midEnd)); // 复用

        // temp2获取新的命名(gep->getName()), 继承ptr指向的内存以及常数偏移
        auto relay2 = operlower.mkBaseOP(*gep, ptr, 0);
        auto add = std::make_shared<binaryInst>(
            OpCode::ADD, SourceOperandType::rr, relay2, relay, ptr);
        insts.emplace_back(add);
    }

    return insts;
}