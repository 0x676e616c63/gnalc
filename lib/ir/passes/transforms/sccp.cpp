// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/sccp.hpp"
#include "ir/block_utils.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/vector.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"
#include "ir/passes/helpers/sparse_propagation.hpp"
#include "ir/match.hpp"
#include "utils/logger.hpp"

#include <optional>

namespace IR {
class LatticeVal {
public:
    enum class Type {
        UNDEF,    // Undefined
        CONSTANT, // Constant value
        NAC       // Not a constant value
    };

private:
    Type type;
    std::optional<ConstantProxy> value;

public:
    LatticeVal() : type(Type::UNDEF) {}

    LatticeVal(const LatticeVal &) = default;

    LatticeVal &operator=(const LatticeVal &rhs) = default;

    explicit LatticeVal(Type type_) : type(type_) { Err::gassert(type != Type::CONSTANT); }

    explicit LatticeVal(ConstantProxy val) : type(Type::CONSTANT), value(val) {}

    bool operator==(const LatticeVal &rhs) const {
        if (type != rhs.type)
            return false;
        if (isConstant())
            return value == rhs.value;
        return true;
    }

    bool operator!=(const LatticeVal &rhs) const { return !(*this == rhs); }

    bool isUndef() const { return type == Type::UNDEF; }
    bool isConstant() const { return type == Type::CONSTANT; }
    bool isNAC() const { return type == Type::NAC; }

    const auto &cproxy() const {
        Err::gassert(isConstant());
        return *value;
    }

    void setCProxy(const ConstantProxy &val) {
        type = Type::CONSTANT;
        value.emplace(val);
    }

    bool isZero() const {
        if (!isConstant())
            return false;
        return cproxy() == false || cproxy() == '\0' || cproxy() == 0 || cproxy() == static_cast<int64_t>(0) ||
               cproxy() == 0.0f;
    }
};

using LatticeKey = pVal;

class LatticeInfo {
public:
    inline static const auto NAC = LatticeVal(LatticeVal::Type::NAC);
    inline static const auto UNDEF = LatticeVal(LatticeVal::Type::UNDEF);

    static LatticeKey getKeyFromValue(const pVal &key) { return key; }

    static pVal getValueFromKey(const LatticeKey &key) { return key; }
};

using SCCPSolver = SparsePropagationSolver<LatticeKey, LatticeVal, LatticeInfo>;

class SCCPLatticeFunc : public SCCPSolver::LatticeFunction {
    ConstantPool *cpool;

public:
    explicit SCCPLatticeFunc(ConstantPool *pool) : cpool(pool) {}

    LatticeVal merge(LatticeVal lhs, LatticeVal rhs) const override {
        if (lhs.isNAC() || rhs.isNAC())
            return LatticeInfo::NAC;

        if (lhs.isUndef())
            return rhs;
        if (rhs.isUndef())
            return lhs;

        if (lhs.isConstant() && rhs.isConstant() && lhs.cproxy() == rhs.cproxy())
            return lhs;

        return LatticeInfo::NAC;
    }

    void transfer(const pInst &inst, std::unordered_map<LatticeKey, LatticeVal> &changes,
                  SCCPSolver &solver) const override {
        if (auto bin = inst->as<BinaryInst>()) {
            auto lhs = solver.getVal(LatticeInfo::getKeyFromValue(bin->getLHS()));
            auto rhs = solver.getVal(LatticeInfo::getKeyFromValue(bin->getRHS()));
            if (lhs.isNAC() || rhs.isNAC())
                changes[inst] = LatticeInfo::NAC;
            switch (bin->getOpcode()) {
            case OP::ADD:
            case OP::FADD:
                if (lhs.isConstant() && rhs.isConstant())
                    changes[inst].setCProxy(lhs.cproxy() + rhs.cproxy());
                break;
            case OP::SUB:
            case OP::FSUB:
                if (lhs.isConstant() && rhs.isConstant())
                    changes[inst].setCProxy(lhs.cproxy() - rhs.cproxy());
                break;
            case OP::MUL:
            case OP::FMUL:
                if (lhs.isZero() || rhs.isZero())
                    changes[inst].setCProxy(ConstantProxy(cpool, cpool->getZero(inst->getType())));
                else if (lhs.isConstant() && rhs.isConstant())
                    changes[inst].setCProxy(lhs.cproxy() * rhs.cproxy());
                break;
            case OP::DIV:
            case OP::FDIV:
                if (rhs.isZero()) {
                    Logger::logWarning("Zero divisor detected.");
                    changes[inst] = LatticeInfo::NAC;
                } else if (lhs.isZero())
                    changes[inst].setCProxy(lhs.cproxy());
                else if (lhs.isConstant() && rhs.isConstant())
                    changes[inst].setCProxy(lhs.cproxy() / rhs.cproxy());
                break;
            case OP::SREM:
                if (rhs.isZero()) {
                    Logger::logWarning("Zero divisor detected.");
                    changes[inst] = LatticeInfo::NAC;
                } else if (lhs.isZero())
                    changes[inst].setCProxy(lhs.cproxy());
                else if (lhs.isConstant() && rhs.isConstant())
                    changes[inst].setCProxy(lhs.cproxy() % rhs.cproxy());
                break;
            case OP::UREM:
                if (rhs.isZero()) {
                    Logger::logWarning("Zero divisor detected.");
                    changes[inst] = LatticeInfo::NAC;
                } else if (lhs.isZero())
                    changes[inst].setCProxy(lhs.cproxy());
                else if (lhs.isConstant() && rhs.isConstant())
                    changes[inst].setCProxy(lhs.cproxy().urem(rhs.cproxy()));
                break;
            case OP::AND:
                if ((lhs.isConstant() && lhs.cproxy() == false) || (rhs.isConstant() && rhs.cproxy() == false))
                    changes[inst].setCProxy(ConstantProxy(cpool, false));
                else if (lhs.isConstant() && rhs.isConstant())
                    changes[inst].setCProxy(lhs.cproxy() && rhs.cproxy());
                break;
            case OP::OR:
                if ((lhs.isConstant() && lhs.cproxy() == true) || (rhs.isConstant() && rhs.cproxy() == true))
                    changes[inst].setCProxy(ConstantProxy(cpool, true));
                else if (lhs.isConstant() && rhs.isConstant())
                    changes[inst].setCProxy(lhs.cproxy() || rhs.cproxy());
                break;
            case OP::XOR:
                if (lhs.isConstant() && rhs.isConstant())
                    changes[inst].setCProxy(lhs.cproxy() ^ rhs.cproxy());
                break;
            case OP::SHL:
                if (lhs.isConstant() && rhs.isConstant())
                    changes[inst].setCProxy(lhs.cproxy() << rhs.cproxy());
                else if (lhs.isNAC() || rhs.isNAC())
                    changes[inst] = LatticeInfo::NAC;
                break;
            case OP::LSHR:
                if (lhs.isConstant() && rhs.isConstant())
                    changes[inst].setCProxy(lhs.cproxy().lshr(rhs.cproxy()));
                else if (lhs.isNAC() || rhs.isNAC())
                    changes[inst] = LatticeInfo::NAC;
                break;
            case OP::ASHR:
                if (lhs.isConstant() && rhs.isConstant())
                    changes[inst].setCProxy(lhs.cproxy().ashr(rhs.cproxy()));
                else if (lhs.isNAC() || rhs.isNAC())
                    changes[inst] = LatticeInfo::NAC;
                break;
            default:
                Err::unreachable("Unknown binary opcode");
            }
        } else if (auto fneg = inst->as<FNEGInst>()) {
            auto val = solver.getVal(LatticeInfo::getKeyFromValue(fneg->getVal()));
            if (val.isConstant())
                changes[inst].setCProxy(-val.cproxy());
            else if (val.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto icmp = inst->as<ICMPInst>()) {
            auto lhs = solver.getVal(LatticeInfo::getKeyFromValue(icmp->getLHS()));
            auto rhs = solver.getVal(LatticeInfo::getKeyFromValue(icmp->getRHS()));
            if (lhs.isConstant() && rhs.isConstant()) {
                switch (icmp->getCond()) {
                case ICMPOP::eq:
                    changes[inst].setCProxy(ConstantProxy(cpool, lhs.cproxy() == rhs.cproxy()));
                    break;
                case ICMPOP::ne:
                    changes[inst].setCProxy(ConstantProxy(cpool, lhs.cproxy() != rhs.cproxy()));
                    break;
                case ICMPOP::sge:
                    changes[inst].setCProxy(ConstantProxy(cpool, lhs.cproxy() >= rhs.cproxy()));
                    break;
                case ICMPOP::sgt:
                    changes[inst].setCProxy(ConstantProxy(cpool, lhs.cproxy() > rhs.cproxy()));
                    break;
                case ICMPOP::sle:
                    changes[inst].setCProxy(ConstantProxy(cpool, lhs.cproxy() <= rhs.cproxy()));
                    break;
                case ICMPOP::slt:
                    changes[inst].setCProxy(ConstantProxy(cpool, lhs.cproxy() < rhs.cproxy()));
                    break;
                }
            } else if (lhs.isNAC() || rhs.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto fcmp = inst->as<FCMPInst>()) {
            auto lhs = solver.getVal(LatticeInfo::getKeyFromValue(fcmp->getLHS()));
            auto rhs = solver.getVal(LatticeInfo::getKeyFromValue(fcmp->getRHS()));
            if (lhs.isConstant() && rhs.isConstant()) {
                switch (fcmp->getCond()) {
                case FCMPOP::oeq:
                    changes[inst].setCProxy(ConstantProxy(cpool, lhs.cproxy() == rhs.cproxy()));
                    break;
                case FCMPOP::one:
                    changes[inst].setCProxy(ConstantProxy(cpool, lhs.cproxy() != rhs.cproxy()));
                    break;
                case FCMPOP::oge:
                    changes[inst].setCProxy(ConstantProxy(cpool, lhs.cproxy() >= rhs.cproxy()));
                    break;
                case FCMPOP::ogt:
                    changes[inst].setCProxy(ConstantProxy(cpool, lhs.cproxy() > rhs.cproxy()));
                    break;
                case FCMPOP::ole:
                    changes[inst].setCProxy(ConstantProxy(cpool, lhs.cproxy() <= rhs.cproxy()));
                    break;
                case FCMPOP::olt:
                    changes[inst].setCProxy(ConstantProxy(cpool, lhs.cproxy() < rhs.cproxy()));
                    break;
                default:
                    Err::unreachable("Unknown fcmp OP");
                }

            } else if (lhs.isNAC() || rhs.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto fptosi = inst->as<FPTOSIInst>()) {
            auto val = solver.getVal(LatticeInfo::getKeyFromValue(fptosi->getOVal()));
            if (val.isConstant())
                changes[inst].setCProxy(ConstantProxy(cpool, static_cast<int>(val.cproxy().get_float())));
            else if (val.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto sitofp = inst->as<SITOFPInst>()) {
            auto val = solver.getVal(LatticeInfo::getKeyFromValue(sitofp->getOVal()));
            if (val.isConstant())
                changes[inst].setCProxy(ConstantProxy(cpool, static_cast<float>(val.cproxy().get_int())));
            else if (val.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto zext = inst->as<ZEXTInst>()) {
            auto val = solver.getVal(LatticeInfo::getKeyFromValue(zext->getOVal()));
            auto ttype = zext->getTType()->as<BType>()->getInner();
            auto otype = zext->getOType()->as<BType>()->getInner();
            if (val.isConstant()) {
                switch (otype) {
                case IRBTYPE::I1:
                    if (ttype == IRBTYPE::I8)
                        changes[inst].setCProxy(
                            ConstantProxy(cpool, static_cast<char>(static_cast<unsigned char>(val.cproxy().get_i1()))));
                    else if (ttype == IRBTYPE::I32)
                        changes[inst].setCProxy(
                            ConstantProxy(cpool, static_cast<int>(static_cast<unsigned int>(val.cproxy().get_i1()))));
                    else if (ttype == IRBTYPE::I64)
                        changes[inst].setCProxy(
                            ConstantProxy(cpool, static_cast<int64_t>(static_cast<uint64_t>(val.cproxy().get_i1()))));
                    else
                        Err::unreachable("Invalid type");
                    break;
                case IRBTYPE::I8:
                    if (ttype == IRBTYPE::I32)
                        changes[inst].setCProxy(
                            ConstantProxy(cpool, static_cast<int>(static_cast<unsigned int>(val.cproxy().get_i8()))));
                    else if (ttype == IRBTYPE::I64)
                        changes[inst].setCProxy(
                            ConstantProxy(cpool, static_cast<int64_t>(static_cast<uint64_t>(val.cproxy().get_i8()))));
                    else
                        Err::unreachable("Invalid type");
                    break;
                case IRBTYPE::I32:
                    if (ttype == IRBTYPE::I64)
                        changes[inst].setCProxy(
                            ConstantProxy(cpool, static_cast<int64_t>(static_cast<uint64_t>(val.cproxy().get_int()))));
                    else
                        Err::unreachable("Invalid type");
                    break;
                default:
                    Err::unreachable("Invalid type to zext.");
                }
            } else if (val.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto sext = inst->as<SEXTInst>()) {
            auto val = solver.getVal(LatticeInfo::getKeyFromValue(sext->getOVal()));
            auto ttype = sext->getTType()->as<BType>()->getInner();
            auto otype = sext->getOType()->as<BType>()->getInner();
            if (val.isConstant()) {
                switch (otype) {
                case IRBTYPE::I1:
                    if (ttype == IRBTYPE::I8)
                        changes[inst].setCProxy(ConstantProxy(cpool, static_cast<char>(val.cproxy().get_i1())));
                    else if (ttype == IRBTYPE::I32)
                        changes[inst].setCProxy(ConstantProxy(cpool, static_cast<int>(val.cproxy().get_i1())));
                    else if (ttype == IRBTYPE::I64)
                        changes[inst].setCProxy(ConstantProxy(cpool, static_cast<int64_t>(val.cproxy().get_i1())));
                    else
                        Err::unreachable("Invalid type");
                    break;
                case IRBTYPE::I8:
                    if (ttype == IRBTYPE::I32)
                        changes[inst].setCProxy(ConstantProxy(cpool, static_cast<int>(val.cproxy().get_i8())));
                    else if (ttype == IRBTYPE::I64)
                        changes[inst].setCProxy(ConstantProxy(cpool, static_cast<int64_t>(val.cproxy().get_i8())));
                    else
                        Err::unreachable("Invalid type");
                    break;
                case IRBTYPE::I32:
                    if (ttype == IRBTYPE::I64)
                        changes[inst].setCProxy(ConstantProxy(cpool, static_cast<int64_t>(val.cproxy().get_int())));
                    else
                        Err::unreachable("Invalid type");
                    break;
                default:
                    Err::unreachable("Invalid type to sext.");
                }
            } else if (val.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto insert = inst->as<INSERTInst>()) {
            auto vec = solver.getVal(LatticeInfo::getKeyFromValue(insert->getVector()));
            auto elm = solver.getVal(LatticeInfo::getKeyFromValue(insert->getElm()));
            if (vec.isConstant() && elm.isConstant()) {
                auto index = insert->getIdx()->as<ConstantInt>()->getVal();

                auto elmcval = elm.cproxy().getConstant();
                int elm_ci;
                float elm_cf;
                if (match(elmcval, M::Bind(elm_ci))) {
                    auto vec_ci = vec.cproxy().get_i32_vector();
                    vec_ci[index] = elm_ci;
                    changes[inst].setCProxy(ConstantProxy(cpool, vec_ci));
                } else if (match(elmcval, M::Bind(elm_cf))) {
                    auto vec_cf = vec.cproxy().get_f32_vector();
                    vec_cf[index] = elm_cf;
                    changes[inst].setCProxy(ConstantProxy(cpool, vec_cf));
                } else
                    Err::unreachable("Unknown vector");
            } else if (vec.isNAC() || elm.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto extract = inst->as<EXTRACTInst>()) {
            auto vec = solver.getVal(LatticeInfo::getKeyFromValue(extract->getVector()));
            if (vec.isConstant()) {
                auto index = extract->getIdx()->as<ConstantInt>()->getVal();
                auto btype = getElm(vec.cproxy().getConstant()->getType())->as<BType>();
                Err::gassert(btype != nullptr, "Unknown vector");
                if (btype->getInner() == IRBTYPE::I32) {
                    auto vec_ci = vec.cproxy().get_i32_vector();
                    changes[inst] = LatticeVal(ConstantProxy(cpool, vec_ci[index]));
                } else if (btype->getInner() == IRBTYPE::FLOAT) {
                    auto vec_cf = vec.cproxy().get_f32_vector();
                    changes[inst] = LatticeVal(ConstantProxy(cpool, vec_cf[index]));
                } else
                    Err::unreachable("Unknown vector");
            } else if (vec.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto shuffle = inst->as<SHUFFLEInst>()) {
            auto vec1 = solver.getVal(LatticeInfo::getKeyFromValue(shuffle->getVector1()));
            auto vec2 = solver.getVal(LatticeInfo::getKeyFromValue(shuffle->getVector2()));
            if (vec1.isConstant() && vec2.isConstant()) {
                auto mask = shuffle->getMask()->as<ConstantIntVector>()->getVector();
                auto btype = getElm(vec1.cproxy().getConstant()->getType())->as<BType>();
                Err::gassert(btype != nullptr, "Unknown vector");
                if (btype->getInner() == IRBTYPE::I32) {
                    auto vec1_ci = vec1.cproxy().get_i32_vector();
                    auto vec2_ci = vec2.cproxy().get_i32_vector();
                    std::vector<int> res;
                    for (auto m : mask) {
                        if (m < vec1_ci.size())
                            res.push_back(vec1_ci[m]);
                        else
                            res.push_back(vec2_ci[m - vec1_ci.size()]);
                    }
                    changes[inst].setCProxy(ConstantProxy(cpool, res));
                } else if (btype->getInner() == IRBTYPE::FLOAT) {
                    auto vec1_cf = vec1.cproxy().get_f32_vector();
                    auto vec2_cf = vec2.cproxy().get_f32_vector();
                    std::vector<float> res;
                    for (auto m : mask) {
                        if (m < vec1_cf.size())
                            res.push_back(vec1_cf[m]);
                        else
                            res.push_back(vec2_cf[m - vec1_cf.size()]);
                    }
                    changes[inst].setCProxy(ConstantProxy(cpool, res));
                } else
                    Err::unreachable("Unknown vector");
            } else if (vec1.isNAC() || vec2.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (inst->is<ALLOCAInst, GEPInst, LOADInst, CALLInst, BITCASTInst, PTRTOINTInst, INTTOPTRInst>())
            changes[inst] = LatticeInfo::NAC;
        else if (inst->is<BRInst, PHIInst, SELECTInst>())
            Err::unreachable("Transfer on br, phi or select.");
        else
            Err::unreachable("Unknown instruction.");
    }

    ConstantProxy getValueFromLatticeVal(const LatticeVal &v) const override { return v.cproxy(); }

    LatticeVal computeLatticeVal(const pVal &key) const override {
        if (key->getVTrait() == ValueTrait::CONSTANT_LITERAL)
            return LatticeVal(ConstantProxy(cpool, key));
        if (key->getVTrait() == ValueTrait::FORMAL_PARAMETER)
            return LatticeInfo::NAC;
        return LatticeInfo::UNDEF;
    }
};

PM::PreservedAnalyses SCCPPass::run(Function &function, FAM &manager) {
    bool sccp_inst_modified = false;
    bool sccp_cfg_modified = false;

    SCCPLatticeFunc lattice_func(&function.getConstantPool());
    SCCPSolver solver(&lattice_func);
    solver.solve(function);

    std::set<pPhi> dead_phis;

    // Simplify Instruction and Cut the In Edge of Unreachable block
    for (const auto &[key, val] : solver.get_map()) {
        if (val.isConstant()) {
            // Note that the key might already be a ConstantLiteral before SCCP,
            // but that doesn't matter.
            // If we can get a ConstantLiteral here, it must be used in propagation,
            // and thus might be a BRInst's Cond, which we should handle it as if it is
            // a constant deduced by SCCP.
            auto use_list = key->getUseList();
            for (const auto &use : use_list) {
                if (auto br_inst = use->getUser()->as<BRInst>()) {
                    // BRInst of other function should be handled by their SCCP !!!
                    if (br_inst->getParent()->getParent().get() != &function)
                        continue;

                    Err::gassert(br_inst->isConditional());

                    // Since we delete unreachable blocks below, we don't check if `safeUnlinkBB`
                    // requires us to delete the BRInst. (no successor)
                    if (val.cproxy().get_i1())
                        safeUnlinkBB(br_inst->getParent(), br_inst->getFalseDest(), dead_phis);
                    else
                        safeUnlinkBB(br_inst->getParent(), br_inst->getTrueDest(), dead_phis);
                    sccp_cfg_modified = true;
                }
            }
            // If the key is not a ConstantLiteral, it must be a constant deduced by SCCP.
            // So we replace and delete the key.
            if (key->getVTrait() != ValueTrait::CONSTANT_LITERAL) {
                key->replaceSelf(val.cproxy().getConstant());
                // Delete replaced constant instruction,
                // Though DCE/ADCE can make it too, deleting them in an earlier pass
                // can invalidate less Analysis Results, thus making the compiler faster.
                auto inst = key->as<Instruction>();
                Err::gassert(inst != nullptr);
                inst->getParent()->delInst(inst);
                sccp_inst_modified = true;
            }
        }
    }

    // Clear the solver to destructs temp values.
    solver.clear();

    // Since we already handled CFG above,
    // all the unreachable blocks' in edge have been cut.
    // So just a trivial traversal will find all of them
    auto dfv = function.getDFVisitor();
    std::unordered_set live(dfv.begin(), dfv.end());

    // Cut the outgoing edge of the unreachable block
    for (const auto &block : function) {
        if (live.find(block) == live.end()) {
            auto succs = block->getNextBB();
            for (const auto &succ : succs)
                safeUnlinkBB(block, succ, dead_phis);
        }
    }

    // Delete dead blocks first, because dead phis may be used in dead blocks.
    sccp_cfg_modified |= function.delBlockIf([&live](const auto &bb) { return live.find(bb) == live.end(); });

    for (auto &block : function) {
        block->delInstIf(
            [&dead_phis](const auto &p) { return dead_phis.find(p->template as<PHIInst>()) != dead_phis.end(); },
            BasicBlock::DEL_MODE::PHI);
    }

    if (sccp_cfg_modified)
        return PreserveNone();

    if (sccp_inst_modified)
        return PreserveCFGAnalyses();

    return PreserveAll();
}
} // namespace IR