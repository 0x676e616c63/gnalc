#include "../../../include/mir/SIMDinstruction/arithmetics.hpp"
#include "../../../include/mir/builder/lowering.hpp"

using namespace MIR;

std::list<std::shared_ptr<Instruction>> InstLowering::fptosiLower(const std::shared_ptr<IR::FPTOSIInst> &fptosi,
                                                                  const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;

    // 类型转换应该不会有常数
    // vcvt.s32.f32
    auto target = operlower.mkOP(*fptosi, RegisterBank::gpr);
    auto origin = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(fptosi->getOVal()));

    auto pair = std::make_pair(bitType::s32, bitType::f32);
    auto vcvt_s32_f32 = std::make_shared<Vunary>(NeonOpCode::VCVT, target, origin, pair);
    insts.emplace_back(vcvt_s32_f32);

    return insts;
}

std::list<std::shared_ptr<Instruction>> InstLowering::sitofpLower(const std::shared_ptr<IR::SITOFPInst> &sitofp,
                                                                  const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;

    // 类型转换应该不会有常数
    // vcvt.f32.s32
    auto target = operlower.mkOP(*sitofp, RegisterBank::gpr);
    auto origin = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(sitofp->getOVal()));

    auto pair = std::make_pair(bitType::f32, bitType::s32);
    auto vcvt_f32_s32 = std::make_shared<Vunary>(NeonOpCode::VCVT, target, origin, pair);
    insts.emplace_back(vcvt_f32_s32);

    return insts;
}

std::list<std::shared_ptr<Instruction>> InstLowering::bitcastLower(const std::shared_ptr<IR::BITCASTInst> &bitcast,
                                                                   const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;

    /// bitcast 用于转换不同类型的指针, 但是对于后端来说
    /// 对指针的类型并不敏感, 实质上都是地址
    auto origin_ptr = std::dynamic_pointer_cast<BaseADROP>(operlower.fastFind(bitcast->getOVal()));
    operlower.mkBind(*bitcast, origin_ptr);

    return insts;
}

std::list<std::shared_ptr<Instruction>> InstLowering::zextLower(const std::shared_ptr<IR::ZEXTInst> &zext,
                                                                const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;

    ///@note zext语句主要出现在进行连续比较时
    ///@note 将上一个比较的结果(i1)拓展为i32, 进行下一轮比较

    auto origin_i1 = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(zext->getOVal()));
    operlower.mkBind(*zext, origin_i1);

    return insts;
}