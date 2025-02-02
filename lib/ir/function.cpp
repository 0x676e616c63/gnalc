#include "../../include/ir/function.hpp"
#include "../../include/ir/visitor.hpp"

#include <algorithm>

namespace IR {
FunctionDecl::FunctionDecl(std::string name_,
                           std::vector<std::shared_ptr<Type>> params,
                           std::shared_ptr<Type> ret_type, bool is_va_arg_,
                           bool is_builtin_, bool is_sylib_)
    : Value(
          std::move(name_),
          makeFunctionType(std::move(params), std::move(ret_type), is_va_arg_),
          ValueTrait::FUNCTION),
      is_builtin(is_builtin_), is_sylib(is_sylib_) {
    Err::gassert(!is_builtin_ || !is_sylib_);
}

void FunctionDecl::accept(IRVisitor &visitor) { visitor.visit(*this); }

bool FunctionDecl::isSylib() const { return is_sylib; }

bool FunctionDecl::isBuiltin() const { return is_builtin; }

FunctionDecl::~FunctionDecl() {}

std::vector<std::shared_ptr<Type>>
get_params_type(const std::vector<std::shared_ptr<Value>> &p) {
    std::vector<std::shared_ptr<Type>> params_type;
    std::transform(p.begin(), p.end(), std::back_inserter(params_type),
                   [](auto &&v) { return v->getType(); });
    return params_type;
}

Function::Function(std::string name_,
                   const std::vector<std::shared_ptr<Value>> &params_,
                   std::shared_ptr<Type> ret_type, ConstantPool *pool_)
    : FunctionDecl(std::move(name_), get_params_type(params_),
                   std::move(ret_type), false, false, false),
      params(params_), constant_pool(pool_) {}

void Function::addBlock(std::shared_ptr<BasicBlock> blk) {
    blks.emplace_back(std::move(blk));
}

bool Function::delBlock(const std::shared_ptr<BasicBlock> &blk) {
    return delBlockIf([&blk](auto &&b) { return b == blk; });
}

const std::vector<std::shared_ptr<Value>> &Function::getParams() const {
    return params;
}

const std::vector<std::shared_ptr<BasicBlock>> &Function::getBlocks() const {
    return blks;
}

std::vector<std::shared_ptr<Value>> &Function::getParams() { return params; }

std::vector<std::shared_ptr<BasicBlock>> &Function::getBlocks() { return blks; }

Function::const_iterator Function::cbegin() const { return blks.cbegin(); }

Function::const_iterator Function::cend() const { return blks.cend(); }

Function::iterator Function::begin() { return blks.begin(); }

Function::iterator Function::end() { return blks.end(); }

ConstantPool &Function::getConstantPool() { return *constant_pool; }

void Function::accept(IRVisitor &visitor) { visitor.visit(*this); }

void LinearFunction::addInst(std::shared_ptr<Instruction> inst) {
    insts.emplace_back(std::move(inst));
}

void LinearFunction::appendInsts(
    std::vector<std::shared_ptr<Instruction>> insts_) {
    insts.insert(insts.end(), std::make_move_iterator(insts_.begin()),
                 std::make_move_iterator(insts_.end()));
}

const std::vector<std::shared_ptr<Instruction>> &
LinearFunction::getInsts() const {
    return insts;
}

std::vector<std::shared_ptr<Instruction>> &LinearFunction::getInsts() {
    return insts;
}

LinearFunction::const_iterator LinearFunction::cbegin() const {
    return insts.cbegin();
}

LinearFunction::const_iterator LinearFunction::cend() const {
    return insts.cend();
}

LinearFunction::iterator LinearFunction::begin() { return insts.begin(); }

LinearFunction::iterator LinearFunction::end() { return insts.end(); }

void LinearFunction::accept(IRVisitor &visitor) { visitor.visit(*this); }
} // namespace IR