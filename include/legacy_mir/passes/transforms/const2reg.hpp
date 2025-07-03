// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#pragma once
#ifndef GNALC_LEGACY_MIR_PASSES_TRANSFROMS_CONST2REG_HPP
#define GNALC_LEGACY_MIR_PASSES_TRANSFROMS_CONST2REG_HPP

#include "legacy_mir/module.hpp"
#include "legacy_mir/passes/analysis/domtree_analysis.hpp"
#include "legacy_mir/passes/pass_manager.hpp"

///@note 这是一个专门用于加载int/float/dataSectionAddress(统称为const)的自创backend pass
///@note 暂且命名为const2reg
///@note 由于宏展开指令选择方式的局限性, 当指令的立即数不合法或者需要一个全局地址时会立即load或者mov一次
///@note 以保证指令流最基本的正确性
///@note 但是极有可能造成load/mov的重复使用, 不仅长而且会干扰指令流水
///@note 一种简单的解决方式是在block_0提前load/mov好, 但这样无可避免地造成活跃区间过长, 增大溢出风险
///@todo const2reg会在指令选择时记录使用const的虚拟寄存器virops和基本块blks
///@todo 当指令选择和合法化(针对数和地址的)结束之后,
///@todo 对blks求公共最近支配结点, 并在该结点头部插入move
///@warning 这是在简单宏展开指令选择下一种不是办法的办法
///@warning 该pass可以减少常数或者全局地址的重复load, 但同时会加长活跃区间
///@warning 在造成溢出之后, 又会退化成重复load的形式

namespace LegacyMIR {

class Const2Reg : public PM::PassInfo<Const2Reg> {
public:
    PM::PreservedAnalyses run(Function &, FAM &);

private:
    Function *function;
    VarPool *varpool;
    DomTree dominfo;

    void Main();
    void runOneach(std::unordered_set<BlkP>, const ConstObj &, const BindOnP &); // 筛选最近公共支配结点
    void mkConst2Reg(const ConstObj &, const BindOnP &, BasicBlock *);           // 插入
};

} // namespace MIR
#endif
#endif