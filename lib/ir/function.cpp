#include "../../include/ir/visitor.hpp"
#include "../../include/ir/function.hpp"

#include <algorithm>


namespace IR {
    FunctionDecl::FunctionDecl(std::string name_, std::vector<std::shared_ptr<Type>> params,
    std::shared_ptr<Type> ret_type, bool va_arg_)
        : Value(std::move(name_),
            makeFunctionType(std::move(params), std::move(ret_type), va_arg_), ValueTrait::FUNCTION)
    {}

    void FunctionDecl::accept(IRVisitor& visitor) { visitor.visit(*this); }

    FunctionDecl::~FunctionDecl() {}

    std::vector<std::shared_ptr<Type>> get_params_type(const std::vector<std::shared_ptr<Value>>& p) {
        std::vector<std::shared_ptr<Type>> params_type;
        std::transform(p.begin(), p.end(), std::back_inserter(params_type),
            [](auto&& v){return v->getType();});
        return params_type;
    }

    Function::Function(std::string name_, const std::vector<std::shared_ptr<Value>>& params_,
        std::shared_ptr<Type> ret_type)
    : FunctionDecl(std::move(name_),
        get_params_type(params_), std::move(ret_type), false), params(params_) {}

    void Function::addBlock(std::shared_ptr<BasicBlock> blk) {
        blks.emplace_back(std::move(blk));
    }

    void Function::addInst(std::shared_ptr<Instruction> inst) {
        insts.emplace_back(std::move(inst));
    }

    void Function::setInsts(std::vector<std::shared_ptr<Instruction>> insts_) {
        std::swap(insts, insts_);
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