#include "../../include/ir/function.hpp"
#include "../../include/ir/visitor.hpp"

#include <algorithm>
#include <numeric>

namespace IR {
FunctionDecl::FunctionDecl(std::string name_,
                           std::vector<std::shared_ptr<Type>> params,
                           std::shared_ptr<Type> ret_type, bool is_va_arg_,
                           bool is_builtin_, bool is_sylib_)
    : Value( std::move(name_),
          makeFunctionType(std::move(params), std::move(ret_type), is_va_arg_),
          ValueTrait::FUNCTION),
      is_builtin(is_builtin_), is_sylib(is_sylib_) {
    Err::gassert(!is_builtin_ || !is_sylib_);
}

void FunctionDecl::accept(IRVisitor &visitor) { visitor.visit(*this); }

bool FunctionDecl::isSylib() const { return is_sylib; }

bool FunctionDecl::isBuiltin() const { return is_builtin; }

FunctionDecl::~FunctionDecl() = default;
void FormalParam::accept(IRVisitor &visitor) { visitor.visit(*this); }

std::vector<std::shared_ptr<Type>>
get_params_type(const std::vector<std::shared_ptr<FormalParam>> &p) {
    std::vector<std::shared_ptr<Type>> params_type;
    std::transform(p.begin(), p.end(), std::back_inserter(params_type),
                   [](auto &&v) { return v->getType(); });
    return params_type;
}

Function::Function(std::string name_, const std::vector<std::shared_ptr<FormalParam>> &params_,
                   std::shared_ptr<Type> ret_type, ConstantPool *pool_)
    : FunctionDecl(std::move(name_), get_params_type(params_), std::move(ret_type), false, false, false),
      params(params_), constant_pool(pool_) {}

void Function::addBlock(iterator it, std::shared_ptr<BasicBlock> blk) {
    Err::gassert(blk->getParent() == nullptr, "BasicBlock already has parent.");
    blk->setParent(shared_from_this());
    blks.insert(it, std::move(blk));
    updateBBIndex();
}

void Function::addBlock(size_t index, std::shared_ptr<BasicBlock> blk) {
    Err::gassert(blk->getParent() == nullptr, "BasicBlock already has parent.");
    blk->setParent(shared_from_this());
    blks.insert(std::next(blks.begin(), static_cast<iterator::difference_type>(index)), std::move(blk));
    updateBBIndex();
}

void Function::addBlock(std::shared_ptr<BasicBlock> blk) {
    Err::gassert(blk->getParent() == nullptr, "BasicBlock already has parent.");
    blk->index = blks.size();
    blk->setParent(shared_from_this());
    blks.emplace_back(std::move(blk));
}

void Function::addBlockAsEntry(const std::shared_ptr<BasicBlock> &blk) {
    Err::gassert(blk->getParent() == nullptr, "BasicBlock already has parent.");
    blk->index = 0;
    blk->setParent(shared_from_this());
    blks.insert(blks.begin(), blk);
    updateBBIndex();
}

bool Function::delFirstOfBlock(const std::shared_ptr<BasicBlock> &blk) {
    for (auto it = blks.begin(); it != blks.end(); ++it) {
        if (*it == blk) {
            blk->setParent(nullptr);
            blks.erase(it);
            updateBBIndex();
            return true;
        }
    }
    return false;
}

bool Function::delBlock(const std::shared_ptr<BasicBlock> &blk) {
    return delBlockIf([&blk](auto &&b) { return b == blk; });
}

const std::vector<std::shared_ptr<FormalParam>> &Function::getParams() const {
    return params;
}

const std::list<std::shared_ptr<BasicBlock>> &Function::getBlocks() const {
    return blks;
}

Function::const_iterator Function::begin() const { return blks.begin(); }

Function::const_iterator Function::end() const { return blks.end(); }

Function::iterator Function::begin() { return blks.begin(); }

Function::iterator Function::end() { return blks.end(); }

Function::const_iterator Function::cbegin() const { return blks.cbegin(); }

Function::const_iterator Function::cend() const { return blks.cend(); }

Function::const_reverse_iterator Function::rbegin() const { return blks.rbegin(); }

Function::const_reverse_iterator Function::rend() const { return blks.rend(); }

Function::reverse_iterator Function::rbegin() { return blks.rbegin(); }

Function::reverse_iterator Function::rend() { return blks.rend(); }

Function::const_reverse_iterator Function::crbegin() const { return blks.crbegin(); }

Function::const_reverse_iterator Function::crend() const { return blks.crend(); }

ConstantPool &Function::getConstantPool() { return *constant_pool; }

std::vector<std::shared_ptr<BasicBlock>> Function::getExitBBs() const {
    std::vector<std::shared_ptr<BasicBlock>> ret;
    for (const auto &bb : blks) {
        if (bb->getNumSuccs() == 0)
            ret.emplace_back(bb);
    }
    return ret;
}

size_t Function::getInstCount() const {
    size_t ret = 0;
    for (const auto &bb : blks)
        ret += bb->getAllInstCount();
    return ret;
}

void Function::updateBBIndex() {
    size_t i = 0;
    for (const auto &blk : blks) {
        blk->index = i++;
    }
}

void Function::updateAllIndex() {
    size_t i = 0;
    for (const auto &blk : blks) {
        blk->index = i++;
        blk->updateInstIndex();
    }
}

// FIXME: BB PARAM not available
std::shared_ptr<Value> Function::cloneImpl() const {
    // left is old, right is new
    std::map<std::shared_ptr<BasicBlock>, std::shared_ptr<BasicBlock>> old2new_bb;
    std::map<std::shared_ptr<Instruction>, std::shared_ptr<Instruction>> old2new_inst;
    std::map<std::shared_ptr<FormalParam>, std::shared_ptr<FormalParam>> old2new_param;

    std::vector<std::shared_ptr<FormalParam>> cloned_params;
    for (const auto &param : params) {
        auto cloned_param = makeClone(param);
        cloned_params.emplace_back(cloned_param);
        old2new_param[param] = cloned_param;
    }

    auto cloned_fn = std::make_shared<Function>(getName(), cloned_params,
        toFunctionType(getType())->getRet(), constant_pool);

    for (const auto &blk : blks) {
        auto cloned_bb = std::make_shared<BasicBlock>(blk->getName() + ".cloned");
        for (auto& phi : blk->phis()) {
            auto cloned_phi = makeClone(phi);
            cloned_bb->addPhiInst(cloned_phi);
            old2new_inst[phi] = cloned_phi;
        }
        for (auto& inst : *blk) {
            auto cloned_inst = makeClone(inst);
            cloned_bb->addInst(cloned_inst);
            old2new_inst[inst] = cloned_inst;
        }

        for (const auto& p : blk->preds())
            cloned_bb->addPreBB(p);
        for (const auto& n : blk->succs())
            cloned_bb->addNextBB(n);

        std::vector<std::shared_ptr<Value>> cloned_bbparams;
        for (const auto& p : blk->getBBParams())
            cloned_bbparams.emplace_back(makeClone(p));
        cloned_bb->setBBParam(cloned_bbparams);

        old2new_bb[blk] = cloned_bb;
        cloned_fn->addBlock(cloned_bb);
    }

    for (const auto& cloned_bb : cloned_fn->blks) {
        for (auto& p : cloned_bb->pre_bb)
            p = old2new_bb[p.lock()];
        for (auto& n : cloned_bb->next_bb)
            n = old2new_bb[n.lock()];

        auto all_insts = cloned_bb->getAllInsts();
        for (const auto& inst : all_insts) {
            auto operands = inst->getOperands();
            for (const auto& use : operands) {
                auto usee = use->getValue();
                if (usee->getVTrait() == ValueTrait::BASIC_BLOCK) {
                    auto usee_blk = std::dynamic_pointer_cast<BasicBlock>(usee);
                    Err::gassert(usee_blk != nullptr);
                    inst->replaceUse(use, old2new_bb[usee_blk]);
                }
                else if (usee->getVTrait() == ValueTrait::FORMAL_PARAMETER) {
                    auto usee_fp = std::dynamic_pointer_cast<FormalParam>(usee);
                    inst->replaceUse(use, old2new_param[usee_fp]);
                }
                else if (usee->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                    auto usee_inst = std::dynamic_pointer_cast<Instruction>(usee);
                    Err::gassert(usee_inst != nullptr);
                    inst->replaceUse(use, old2new_inst[usee_inst]);
                }
            }
            inst->setName(inst->getName() + ".cloned");
        }
    }
    cloned_fn->updateAllIndex();
    return cloned_fn;
}

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

LinearFunction::const_iterator LinearFunction::begin() const { return insts.begin(); }

LinearFunction::const_iterator LinearFunction::end() const { return insts.end(); }

LinearFunction::iterator LinearFunction::begin() { return insts.begin(); }

LinearFunction::iterator LinearFunction::end() { return insts.end(); }

LinearFunction::const_iterator LinearFunction::cbegin() const { return insts.cbegin(); }

LinearFunction::const_iterator LinearFunction::cend() const { return insts.cend(); }

LinearFunction::const_reverse_iterator LinearFunction::rbegin() const { return insts.rbegin(); }

LinearFunction::const_reverse_iterator LinearFunction::rend() const { return insts.rend(); }

LinearFunction::reverse_iterator LinearFunction::rbegin() { return insts.rbegin(); }

LinearFunction::reverse_iterator LinearFunction::rend() { return insts.rend(); }

LinearFunction::const_reverse_iterator LinearFunction::crbegin() const { return insts.crbegin(); }

LinearFunction::const_reverse_iterator LinearFunction::crend() const { return insts.crend(); }

void LinearFunction::accept(IRVisitor &visitor) { visitor.visit(*this); }
} // namespace IR