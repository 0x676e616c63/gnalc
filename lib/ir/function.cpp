#include "../../include/ir/function.hpp"
#include "../../include/ir/visitor.hpp"

namespace IR {
    Function::Function(std::string _name, IRTYPE _ty) : Value(std::move(_name), _ty) {}

    void Function::addParam(Value* param) {
        params.push_back(std::move(param));
    }

    void Function::addBlock(BasicBlock* blk) {
        blks.push_back(std::move(blk));
    }

    void Function::addInst(Instruction* inst) {
        insts.push_back(std::move(inst));
    }

    std::vector<Value*>& Function::getParams() {
        return params;
    }

    std::vector<BasicBlock*>& Function::getBlocks() {
        return blks;
    }

    std::vector<Instruction*>& Function::getInsts() {
        return insts;
    }

    void Function::accept(IRVisitor& visitor) { visitor.visit(*this); }

    Function::~Function() {}
}