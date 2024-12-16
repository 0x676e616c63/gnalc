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
    std::vector<Value*> params;
    std::vector<BasicBlock*> blks;
    std::vector<Instruction*> insts; // 基本块划分前的过渡
public:
    Function(std::string _name, IRTYPE _type);

    // bool isDecl() { return blks.empty() && insts.empty(); } // SySy中没有函数声明

    void addParam(Value* param);
    void addBlock(BasicBlock* blk);
    void addInst(Instruction* inst);

    std::vector<Value*>& getParams();
    std::vector<BasicBlock*>& getBlocks();
    std::vector<Instruction*>& getInsts();
    // ...

    void accept(IRVisitor& visitor) override;
    ~Function() override;
};
}

#endif