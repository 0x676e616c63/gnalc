#include "../../include/ir/function.hpp"
#include "../../include/ir/visitor.hpp"

namespace IR {
    Function::Function(std::string _name, IRTYPE _ty) : Value(std::move(_name), _ty) {}

    void Function::addParam(std::unique_ptr<Value> param) {
        params.push_back(std::move(param));
    }

    void Function::addBlock(std::unique_ptr<BasicBlock> blk) {
        blks.push_back(std::move(blk));
    }

    void Function::addInst(std::unique_ptr<Instruction> inst) {
        insts.push_back(std::move(inst));
    }

    auto& Function::getParams() {
        return params;
    }

    auto& Function::getBlocks() {
        return blks;
    }

    auto& Function::getInsts() {
        return insts;
    }

    void Function::accept(IRVisitor& visitor) { visitor.visit(*this); }

    Function::~Function() {}
}