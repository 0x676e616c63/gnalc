#pragma once

#include "base.hpp"
#include "basic_block.hpp"
#include "instruction.hpp"
#include <memory>

namespace IR {
/**
 * @todo 剩余的处理vector的函数
 * @todo caller, callee...
 */
class Function : public Value {
private:
    std::vector<std::unique_ptr<Value>> params;
    std::vector<std::unique_ptr<BasicBlock>> blks;
    std::vector<std::unique_ptr<Instruction>> insts; // 基本块划分前的过渡
public:
    Function(_type t, NameParam name = "") : Value(t, name) { }

    _type getRtnType() { return getType(); }
    // bool isDecl() { return blks.empty() && insts.empty(); } // SySy中没有函数声明

    void addParam(std::unique_ptr<Value> param);
    void addBlock(std::unique_ptr<BasicBlock> blk);
    void addInst(std::unique_ptr<Instruction> inst);

    std::vector<Value*>& getParams();
    std::vector<BasicBlock*>& getBlocks();
    std::vector<Instruction*>& getInsts();
    // ...

    ~Function() {}
};
}