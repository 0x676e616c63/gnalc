#pragma once
#ifndef GNALC_MIR_PASSES_TRANSFORMS_POSTRASTACKFORMAT_HPP
#define GNALC_MIR_PASSES_TRANSFORMS_POSTRASTACKFORMAT_HPP

#include "mir/passes/pass_manager.hpp"

#include <deque>

///@note 栈帧生成pass(PostRApass)
///@note 1. 计算栈帧大小
///@note 2. 为每个FrameObj分配和填写偏移位置
///@note 3. 在blk: %0之前插入%stack_create块, 填入开栈指令和保护指令(callee saved)
///@note 3.1 保护指令直接遍历RA注册表即可, 标记使用的才保存
///@note 4. 在每个RET语句前, 插入恢复指令
namespace MIR {
class postRAstackformat : public PM::PassInfo<postRAstackformat> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);

private:
    Function *func;
    VarPool *varpool;
    ConstPool *constpool;
    std::deque<std::shared_ptr<FrameObj>> *objs;
    std::set<unsigned> *regdit;
    std::set<unsigned> *regdit_s;
    size_t calleeSavedSize = 0;
    size_t *stackSize;
    unsigned *maxAlignment;

    void FrameGenerate(); // caculate stack size and resort it
    void frameObjSort();
    void frameSaveANDPadding(); // with callee saved insert to the head and maybe padding
    void frameObjImpl();        // assign a physical offset

    void Leagalize(); // insert insts
};
} // namespace MIR

#endif