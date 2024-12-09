#include "../../include/ir/base.hpp"
#include "../../include/ir/function.hpp"

namespace IR {
    void Function::addParam(std::unique_ptr<Value> param) {
        params.push_back(std::move(param));
    }

    void Function::addBlock(std::unique_ptr<BasicBlock> blk) {
        blks.push_back(std::move(blk));
    }

    void Function::addInst(std::unique_ptr<Instruction> inst) {
        insts.push_back(std::move(inst));
    }
}
