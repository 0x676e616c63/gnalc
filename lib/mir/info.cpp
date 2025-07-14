// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "mir/info.hpp"
#include "mir/armv8/base.hpp"
#include "mir/armv8/frame.hpp"
#include "mir/armv8/isel.hpp"
#include "mir/armv8/register.hpp"
#include "mir/riscv64/base.hpp"
#include "mir/riscv64/frame.hpp"
#include "mir/riscv64/isel.hpp"
#include "mir/riscv64/register.hpp"

using namespace MIR;

ISelInfo::~ISelInfo() = default;

CodeGenContext CodeGenContext::create(const BkdInfos &infos) {
    std::shared_ptr<RegisterInfo> register_info;
    std::shared_ptr<ISelInfo> isel;
    std::shared_ptr<FrameInfo> frame;
    if (infos.arch == Arch::ARMv8) {
        register_info = std::make_shared<ARMRegisterInfo>();
        isel = std::make_shared<ARMIselInfo>();
        frame = std::make_shared<ARMFrameInfo>();
    }
    else {
        register_info = std::make_shared<RVRegisterInfo>();
        isel = std::make_shared<RVIselInfo>();
        frame = std::make_shared<RVFrameInfo>();
    }
    return CodeGenContext {
        .infos = infos,
        .registerInfo = register_info,
        .iselInfo = isel,
        .frameInfo = frame,
    };
}
