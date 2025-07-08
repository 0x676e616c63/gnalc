// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/function.hpp"
#include "ir/visitor.hpp"
#include "sir/visitor.hpp"

#include <algorithm>
#include <map>
#include <numeric>
#include <utility>

namespace IR {
FunctionDecl::FunctionDecl(std::string name_, std::vector<pType> params, pType ret_type, bool is_va_arg_,
                           std::unordered_set<FuncAttr> attrs)
    : Value(std::move(name_), makeFunctionType(std::move(params), std::move(ret_type), is_va_arg_),
            ValueTrait::FUNCTION),
      func_attrs(std::move(attrs)) {
    Err::gassert(!(hasAttr(FuncAttr::isSylib) && hasAttr(FuncAttr::isIntrinsic)));
    Err::gassert(!(hasAttr(FuncAttr::builtinMemReadOnly) && hasAttr(FuncAttr::builtinMemWriteOnly)));

    // user defined functions
    if (func_attrs.empty())
        func_attrs.emplace(FuncAttr::NotBuiltin);
}

bool FunctionDecl::isRecursive() const {
    for (const auto &inst_user : inst_users()) {
        auto call = inst_user->as<CALLInst>();
        Err::gassert(call != nullptr);
        auto caller_bb = call->getParent();
        if (caller_bb == nullptr)
            continue;
        auto caller_func = caller_bb->getParent();
        if (caller_func.get() == this)
            return true;
    }
    return false;
}

bool FunctionDecl::hasAttr(FuncAttr attr) const { return func_attrs.count(attr); }
void FunctionDecl::addAttr(FuncAttr attr) { func_attrs.emplace(attr); }
const std::unordered_set<FuncAttr> &FunctionDecl::getAttrs() const { return func_attrs; }

void FunctionDecl::accept(IRVisitor &visitor) { visitor.visit(*this); }

bool FunctionDecl::isSylib() const { return hasAttr(FuncAttr::isSylib); }

bool FunctionDecl::isIntrinsic() const { return hasAttr(FuncAttr::isIntrinsic); }

void FunctionDecl::setParent(Module *module) { parent = module; }

Module *FunctionDecl::getParent() const { return parent; }

FunctionDecl::~FunctionDecl() = default;
void FormalParam::accept(IRVisitor &visitor) { visitor.visit(*this); }

std::vector<pType> get_params_type(const std::vector<pFormalParam> &p) {
    std::vector<pType> params_type;
    std::transform(p.begin(), p.end(), std::back_inserter(params_type), [](auto &&v) { return v->getType(); });
    return params_type;
}

Function::Function(std::string name_, const std::vector<pFormalParam> &params_, pType ret_type, ConstantPool *pool_,
                   std::unordered_set<FuncAttr> attrs)
    : FunctionDecl(std::move(name_), get_params_type(params_), std::move(ret_type), false, attrs), params(params_),
      constant_pool(pool_) {}

void Function::addBlock(iterator it, pBlock blk) {
    Err::gassert(blk->getParent() == nullptr, "BasicBlock already has parent.");
    blk->setParent(as<Function>());
    blks.insert(it, std::move(blk));
    updateBBIndex();
}

void Function::addBlock(size_t index, pBlock blk) {
    Err::gassert(blk->getParent() == nullptr, "BasicBlock already has parent.");
    blk->setParent(as<Function>());
    blks.insert(std::next(blks.begin(), static_cast<iterator::difference_type>(index)), std::move(blk));
    updateBBIndex();
}

void Function::addBlock(pBlock blk) {
    Err::gassert(blk->getParent() == nullptr, "BasicBlock already has parent.");
    blk->index = blks.size();
    blk->setParent(as<Function>());
    blks.emplace_back(std::move(blk));
}

void Function::addBlockAsEntry(const pBlock &blk) {
    Err::gassert(blk->getParent() == nullptr, "BasicBlock already has parent.");
    blk->index = 0;
    blk->setParent(as<Function>());
    blks.insert(blks.begin(), blk);
    updateBBIndex();
}

bool Function::delFirstOfBlock(const pBlock &blk) {
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

bool Function::delBlock(const pBlock &blk) {
    return delBlockIf([&blk](auto &&b) { return b == blk; });
}

const std::vector<pFormalParam> &Function::getParams() const { return params; }

const std::list<pBlock> &Function::getBlocks() const { return blks; }

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

std::vector<pBlock> Function::getExitBBs() const {
    std::vector<pBlock> ret;
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

void Function::updateCFG() {
    for (const auto &bb : blks) {
        bb->pre_bb.clear();
        bb->next_bb.clear();
    }
    for (auto blk_it = begin(); blk_it != end(); ++blk_it) {
        if ((*blk_it)->getInsts().empty())
            continue;
        switch (auto end_inst = (*blk_it)->getTerminator(); end_inst->getOpcode()) {
        case OP::BR: {
            if (const auto inst = end_inst->as<BRInst>(); inst->isConditional()) {
                linkBB(*blk_it, inst->getTrueDest());
                linkBB(*blk_it, inst->getFalseDest());
            } else {
                linkBB(*blk_it, inst->getDest());
            }
            break;
        }
        case OP::RET:
            break;
        default:
            auto next_blk = std::next(blk_it);
            if (next_blk != end()) {
                linkBB(*blk_it, *next_blk);
            }
            break;
        }
    }
}

void Function::updateAndCheckCFG() {
    updateCFG();

    // link完了之后，遍历基本块，查找空块和不可达的块并删除
    for (auto it = begin(); it != end();) {
        // 删除不可达块
        if ((*it)->getNumPreds() == 0 && it != begin()) {
            for (const auto &nextbb : (*it)->succs()) {
                Util::WeakListDel(nextbb->pre_bb, *it);
            }
            it = blks.erase(it);
            continue;
        }
        // 删除空块
        if ((*it)->getInsts().empty()) {
            // 遍历user去替换为他的prebb中的br
            // 非结尾块的情况，prebb的br替换为惟一nextbb
            if ((*it)->getNumSuccs() == 1) {
                auto nxt = *(*it)->succ_begin();
                for (const auto &prebb : (*it)->preds()) {
                    if (auto brinst = prebb->getBRInst()) {
                        Err::gassert(brinst != nullptr, "CFGBuilder::linker(): can't cast BRInst");
                        brinst->replaceAllOperands(*it, nxt); // 改 br
                    }
                    Util::WeakListReplace(prebb->next_bb, *it, nxt); // 改nextbb
                    Util::WeakListReplace(nxt->pre_bb, *it, prebb);  // 改prebb
                }
                it = blks.erase(it);
            } else if ((*it)->getNumSuccs() == 0) {
                // 结尾块
                if (getType()->as<FunctionType>()->getRet()->as<BType>()->getInner() == IRBTYPE::VOID) {
                    (*it)->addInst(std::make_shared<RETInst>());
                } else {
                    Err::unreachable("CFGBuilder::linker(): invalid function type.");
                }
                ++it;
            } else {
                Err::unreachable("CFGBuilder::linker(): empty block has "
                                 "multiple next block.");
            }
            continue;
        }
        ++it;
    }
}

bool Function::removeParam(size_t index) {
    Err::gassert(index < params.size() && params[index]->getUseCount() == 0);
    params.erase(params.begin() + index);
    size_t i = 0;
    for (const auto &param : params)
        param->setIndex(i++);
    return true;
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
pVal Function::cloneImpl() const {
    static size_t name_cnt = 0;

    // left is old, right is new
    std::map<pBlock, pBlock> old2new_bb;
    std::map<pInst, pInst> old2new_inst;
    std::map<pFormalParam, pFormalParam> old2new_param;

    std::vector<pFormalParam> cloned_params;
    for (const auto &param : params) {
        auto cloned_param = makeClone(param);
        cloned_params.emplace_back(cloned_param);
        old2new_param[param] = cloned_param;
    }

    auto cloned_fn =
        std::make_shared<Function>(getName(), cloned_params, getType()->as<FunctionType>()->getRet(), constant_pool);

    for (const auto &blk : blks) {
        auto cloned_bb = std::make_shared<BasicBlock>(blk->getName() + ".dup" + std::to_string(name_cnt++));
        for (auto &phi : blk->phis()) {
            auto cloned_phi = makeClone(phi);
            cloned_bb->addPhiInst(cloned_phi);
            old2new_inst[phi] = cloned_phi;
        }
        for (auto &inst : *blk) {
            auto cloned_inst = makeClone(inst);
            cloned_bb->addInst(cloned_inst);
            old2new_inst[inst] = cloned_inst;
        }

        for (const auto &p : blk->preds())
            cloned_bb->addPreBB(p);
        for (const auto &n : blk->succs())
            cloned_bb->addNextBB(n);

        std::vector<pVal> cloned_bbparams;
        for (const auto &p : blk->getBBParams())
            cloned_bbparams.emplace_back(makeClone(p));
        cloned_bb->setBBParam(cloned_bbparams);

        old2new_bb[blk] = cloned_bb;
        cloned_fn->addBlock(cloned_bb);
    }

    for (const auto &cloned_bb : cloned_fn->blks) {
        for (auto &p : cloned_bb->pre_bb)
            p = old2new_bb[p.lock()];
        for (auto &n : cloned_bb->next_bb)
            n = old2new_bb[n.lock()];

        for (const auto &inst : cloned_bb->all_insts()) {
            for (const auto &use : inst->operand_uses()) {
                auto usee = use->getValue();
                if (usee->getVTrait() == ValueTrait::BASIC_BLOCK) {
                    auto usee_blk = usee->as<BasicBlock>();
                    Err::gassert(usee_blk != nullptr);
                    use->setValue(old2new_bb[usee_blk]);
                } else if (usee->getVTrait() == ValueTrait::FORMAL_PARAMETER) {
                    auto usee_fp = usee->as<FormalParam>();
                    use->setValue(old2new_param[usee_fp]);
                } else if (usee->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                    auto usee_inst = usee->as<Instruction>();
                    Err::gassert(usee_inst != nullptr);
                    use->setValue(old2new_inst[usee_inst]);
                }
            }
            inst->setName(inst->getName() + ".dup" + std::to_string(name_cnt++));
        }
    }
    cloned_fn->updateAllIndex();
    return cloned_fn;
}

void Function::accept(IRVisitor &visitor) { visitor.visit(*this); }

LinearFunction::LinearFunction(std::string name_, const std::vector<pFormalParam> &params_, pType ret_type,
                               ConstantPool *pool_)
    : FunctionDecl(std::move(name_), get_params_type(params_), std::move(ret_type), false, {}), params(params_),
      constant_pool(pool_) {}

void LinearFunction::addInst(pInst inst) {
    inst->inst_index = insts.size();
    insts.emplace_back(std::move(inst));
}

void LinearFunction::addInst(iterator it, const pInst &inst) {
    Err::gassert(inst->getParent() == nullptr, "Instruction already has parent.");
    insts.insert(it, inst);
    inst_index_valid = false;
}
void LinearFunction::addInst(size_t index, const pInst &inst) {
    Err::gassert(inst->getParent() == nullptr, "Instruction already has parent.");
    auto it = std::next(insts.begin(), static_cast<decltype(insts)::iterator::difference_type>(index));
    insts.insert(it, inst);
    inst_index_valid = false;
}

void LinearFunction::appendInsts(std::list<pInst> insts_) {
    size_t i = insts.size();
    for (auto &inst : insts_) {
        inst->inst_index = i++;
    }
    insts.insert(insts.end(), std::make_move_iterator(insts_.begin()), std::make_move_iterator(insts_.end()));
}

size_t LinearFunction::getInstCount() const {
    size_t i = 0;
    for (const auto &inst : insts) {
        if (auto if_inst = inst->as<IFInst>())
            i += if_inst->getInstCount();
        else if (auto while_inst = inst->as<WHILEInst>())
            i += while_inst->getInstCount();
        else if (auto for_inst = inst->as<FORInst>())
            i += for_inst->getInstCount();
        else
            i++;
    }
    return i;
}

const std::vector<pFormalParam> &LinearFunction::getParams() const { return params; }
ConstantPool &LinearFunction::getConstantPool() { return *constant_pool; }

bool LinearFunction::delFirstOfInst(const pInst &inst) {
    for (auto it = insts.begin(); it != insts.end(); ++it) {
        if (*it == inst) {
            insts.erase(it);
            inst_index_valid = false;
            return true;
        }
    }
    return false;
}

bool LinearFunction::delInst(const pInst &target) {
    return delInstIf([&target](const auto &inst) { return inst == target; });
}

const std::list<pInst> &LinearFunction::getInsts() const { return insts; }

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
void LinearFunction::accept(SIR::Visitor &visitor) {
    visitor.visit(*this);
}
void LinearFunction::accept(SIR::LookBehindVisitor &visitor) {
    visitor.visit(SIR::LookBehindVisitor::PrevInfo::makeInitial(), *this);
}

void LinearFunction::updateInstIndex() const {
    if (inst_index_valid)
        return;

    size_t i = 0;
    for (const auto &inst : insts) {
        inst->inst_index = i++;
    }
}
} // namespace IR