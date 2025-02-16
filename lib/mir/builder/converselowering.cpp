#include "../../../include/mir/SIMDinstruction/arithmetics.hpp"
#include "../../../include/mir/builder/lowering.hpp"

using namespace MIR;

std::list<std::shared_ptr<Instruction>>
InstLowering::fptosiLower(const std::shared_ptr<IR::FPTOSIInst> &fptosi) {
    std::list<std::shared_ptr<Instruction>> insts;

    // 类型转换应该不会有常数
    // vcvt.s32.f32
    auto target = operlower.mkOP(*fptosi, RegisterBank::gpr);
    auto origin = operlower.fastFind(fptosi->getOVal());

    auto pair = std::make_pair(bitType::s32, bitType::f32);
    auto vcvt_s32_f32 = std::make_shared<Vunary>(NeonOpCode::VCVT, target, origin, pair);
    insts.emplace_back(vcvt_s32_f32);

    return insts;
}

std::list<std::shared_ptr<Instruction>>
InstLowering::sitofpLower(const std::shared_ptr<IR::SITOFPInst> &sitofp) {
    std::list<std::shared_ptr<Instruction>> insts;

    // 类型转换应该不会有常数
    // vcvt.f32.s32
    auto target = operlower.mkOP(*sitofp, RegisterBank::gpr);
    auto origin = operlower.fastFind(sitofp->getOVal());

    auto pair = std::make_pair(bitType::f32, bitType::s32);
    auto vcvt_f32_s32 = std::make_shared<Vunary>(NeonOpCode::VCVT, target, origin, pair);
    insts.emplace_back(vcvt_f32_s32);

    return insts;
}