#pragma once

#include "base.h"
#include "basic_block.h"
#include "instruction.h"
#include <memory>

namespace IR {
/**
 * @todo 剩余的处理vector的函数
 * @todo 继承User还是Value?
 * @todo caller, callee...
 */
class Function : public Value {
private:
    /**
     * @todo params可单独设计一个类
     */
    std::vector<std::unique_ptr<Value>> params;
    std::vector<std::unique_ptr<BasicBlock>> blks;
    std::vector<std::unique_ptr<Instruction>> insts; // 基本块划分前的过渡，后续可能再修改
public:
    // 默认void类型
    Function(NameParam name = "") : Value(VOID, name) { }

    void setRtnType(_type ty) { setType(ty); }
    _type getRtnType() { return getType(); }
    bool isDecl() { return blks.empty() && insts.empty(); }

    void addParam(std::unique_ptr<Value> param);
    void addBlock(std::unique_ptr<BasicBlock> blk);
    void addInst(std::unique_ptr<Instruction> inst);
    // ...

    ~Function() {}
};
}