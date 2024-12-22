#include "../../include/ir/function.hpp"
#include "../../include/ir/visitor.hpp"

namespace IR {
    Function::Function(std::string _name, std::shared_ptr<Type> _vtype) : Value(std::move(_name), std::move(_vtype)) {}

    void Function::addParam(std::shared_ptr<Value> param) {
        params.push_back(std::move(param));
    }

    void Function::addBlock(std::shared_ptr<BasicBlock> blk) {
        blks.push_back(std::move(blk));
    }

    void Function::addInst(std::shared_ptr<Instruction> inst) {
        insts.push_back(std::move(inst));
    }

    const std::vector<std::shared_ptr<Value>>& Function::getParams() const {
        return params;
    }

    const std::vector<std::shared_ptr<BasicBlock>>& Function::getBlocks() const {
        return blks;
    }

    const std::vector<std::shared_ptr<Instruction>>& Function::getInsts() const {
        return insts;
    }

    std::vector<std::shared_ptr<Value>>& Function::getParams() {
        return params;
    }

    std::vector<std::shared_ptr<BasicBlock>>& Function::getBlocks() {
        return blks;
    }

    std::vector<std::shared_ptr<Instruction>>& Function::getInsts() {
        return insts;
    }

    void Function::accept(IRVisitor& visitor) { visitor.visit(*this); }

    Function::~Function() {}
}