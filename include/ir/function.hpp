#pragma once
#ifndef GNALC_IR_FUNCTION_HPP
#define GNALC_IR_FUNCTION_HPP

#include "base.hpp"
#include "basic_block.hpp"
#include "instruction.hpp"
#include <memory>
#include <vector>

namespace IR {
/**
 * @todo 其他的处理vector的函数未写，故get函数先不设const
 * @todo caller, callee...可用use_list
 * @todo 目前还没有确定容器采用哪种类型，暂时写成vector，后续看需求再改
 * @todo 指针对象的类型未定，先用unique_ptr
 * @todo function的type是ptr还是返回类型？
 * 
 * @attention 目前想的生成方法是先生成指令流，其中包含标识性的辅助指令（见helper.hpp），再根据指令流划分基本块
 */
class Function : public Value {
private:
    std::vector<std::shared_ptr<Value>> params;
    std::vector<std::shared_ptr<BasicBlock>> blks;
    std::vector<std::shared_ptr<Instruction>> insts; // 基本块划分前的过渡
    int vreg_idx = 0;
public:
    Function(std::string _name, std::shared_ptr<Type> _vtype);

    // bool isDecl() { return blks.empty() && insts.empty(); } // SySy中没有函数声明

    void addParam(std::shared_ptr<Value> param);
    void addBlock(std::shared_ptr<BasicBlock> blk);
    void addInst(std::shared_ptr<Instruction> inst);

    const std::vector<std::shared_ptr<Value>>& getParams() const;
    const std::vector<std::shared_ptr<BasicBlock>>& getBlocks() const;
    const std::vector<std::shared_ptr<Instruction>>& getInsts() const;
    std::vector<std::shared_ptr<Value>>& getParams();
    std::vector<std::shared_ptr<BasicBlock>>& getBlocks();
    std::vector<std::shared_ptr<Instruction>>& getInsts();
    // ...

    int getVRegIdx() { return vreg_idx++; }; // 用于生成SSA时的虚拟寄存器计数，从0开始，GetIdx后++
    int getVRegNum() const { return vreg_idx; }; // 虚拟寄存器数量

    void accept(IRVisitor& visitor) override;
    ~Function() override;
};
}

#endif