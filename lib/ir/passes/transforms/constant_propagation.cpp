#include "../../../../include/ir/passes/transforms/constant_propagation.hpp"
#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/converse.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/passes/helpers/sparse_propagation.hpp"
#include "../../../../include/utils/logger.hpp"
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

    explicit LatticeVal(Type type_) : type(type_) {
        Err::gassert(type != Type::CONSTANT);
    }

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

    const auto &getConstant() const {
        Err::gassert(isConstant());
        return *value;
    }

    void setConstant(const ConstantProxy &val) {
        type = Type::CONSTANT;
        value.emplace(val);
    }

    bool isZero() const {
        if (!isConstant())
            return false;
        return getConstant() == false || getConstant() == '\0' ||
               getConstant() == 0 || getConstant() == 0.0f;
    }
};

using LatticeKey = std::shared_ptr<Value>;

class LatticeInfo {
public:
    inline static const auto NAC = LatticeVal(LatticeVal::Type::NAC);
    inline static const auto UNDEF = LatticeVal(LatticeVal::Type::UNDEF);

    static LatticeKey getKeyFromValue(const std::shared_ptr<Value> &key) {
        return key;
    }

    static std::shared_ptr<Value> getValueFromKey(const LatticeKey &key) {
        return key;
    }
};

using SCCPSolver = SparsePropagationSolver<LatticeKey, LatticeVal, LatticeInfo>;

class SCCPLatticeFunc : public SCCPSolver::LatticeFunction {
    ConstantPool *constant_pool;

public:
    explicit SCCPLatticeFunc(ConstantPool *pool) : constant_pool(pool) {}

    LatticeVal merge(LatticeVal lhs, LatticeVal rhs) const override {
        if (lhs.isNAC() || rhs.isNAC())
            return LatticeInfo::NAC;

        if (lhs.isUndef())
            return rhs;
        if (rhs.isUndef())
            return lhs;

        if (lhs.isConstant() && rhs.isConstant() &&
            lhs.getConstant() == rhs.getConstant()) {
            return lhs;
        }

        return LatticeInfo::NAC;
    }

    void transfer(const std::shared_ptr<Instruction> &inst,
                  std::unordered_map<LatticeKey, LatticeVal> &changes,
                  SCCPSolver &solver) const override {
        if (auto bin = std::dynamic_pointer_cast<BinaryInst>(inst)) {
            auto lhs =
                solver.getVal(LatticeInfo::getKeyFromValue(bin->getLHS()));
            auto rhs =
                solver.getVal(LatticeInfo::getKeyFromValue(bin->getRHS()));

            switch (bin->getOpcode()) {
            case OP::ADD:
            case OP::FADD:
                if (lhs.isConstant() && rhs.isConstant())
                    changes[inst].setConstant(lhs.getConstant() +
                                              rhs.getConstant());
                else if (lhs.isNAC() || rhs.isNAC())
                    changes[inst] = LatticeInfo::NAC;
                break;
            case OP::SUB:
            case OP::FSUB:
                if (lhs.isConstant() && rhs.isConstant())
                    changes[inst].setConstant(lhs.getConstant() -
                                              rhs.getConstant());
                else if (lhs.isNAC() || rhs.isNAC())
                    changes[inst] = LatticeInfo::NAC;
                break;
            case OP::MUL:
            case OP::FMUL:
                if (lhs.isZero() || rhs.isZero()) {
                    if (bin->getOpcode() == OP::MUL)
                        changes[inst].setConstant(ConstantProxy(constant_pool, 0));
                    else
                        changes[inst].setConstant(ConstantProxy(constant_pool, 0.0f));
                }
                else if (lhs.isConstant() && rhs.isConstant())
                    changes[inst].setConstant(lhs.getConstant() *
                                              rhs.getConstant());
                else if (lhs.isNAC() || rhs.isNAC())
                    changes[inst] = LatticeInfo::NAC;
                break;
            case OP::DIV:
            case OP::FDIV:
                if (rhs.isZero())
                    Logger::logDebug("Divisor should no be zero in div");
                else if (lhs.isZero())
                    changes[inst].setConstant(lhs.getConstant());
                else if (lhs.isConstant() && rhs.isConstant())
                    changes[inst].setConstant(lhs.getConstant() /
                                              rhs.getConstant());
                else if (lhs.isNAC() || rhs.isNAC())
                    changes[inst] = LatticeInfo::NAC;
                break;
            case OP::REM:
                if (rhs.isZero())
                    Logger::logDebug("Divisor should no be zero in mod");
                else if (lhs.isZero())
                    changes[inst].setConstant(lhs.getConstant());
                else if (lhs.isConstant() && rhs.isConstant())
                    changes[inst].setConstant(lhs.getConstant() %
                                              rhs.getConstant());
                else if (lhs.isNAC() || rhs.isNAC())
                    changes[inst] = LatticeInfo::NAC;
                break;
            case OP::AND:
            case OP::OR:
                if (lhs.isConstant() && rhs.isConstant()) {
                    if (bin->getOpcode() == OP::AND)
                        changes[inst].setConstant(lhs.getConstant() &&
                                                  rhs.getConstant());
                    else
                        changes[inst].setConstant(lhs.getConstant() ||
                                                  rhs.getConstant());
                } else if (lhs.isNAC() || rhs.isNAC())
                    changes[inst] = LatticeInfo::NAC;
                break;
            default:
                Err::unreachable("Unknown binary opcode");
            }
        } else if (auto fneg = std::dynamic_pointer_cast<FNEGInst>(inst)) {
            auto val =
                solver.getVal(LatticeInfo::getKeyFromValue(fneg->getVal()));
            if (val.isConstant())
                changes[inst].setConstant(-val.getConstant());
            else if (val.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto icmp = std::dynamic_pointer_cast<ICMPInst>(inst)) {
            auto lhs =
                solver.getVal(LatticeInfo::getKeyFromValue(icmp->getLHS()));
            auto rhs =
                solver.getVal(LatticeInfo::getKeyFromValue(icmp->getRHS()));
            if (lhs.isConstant() && rhs.isConstant()) {
                switch (icmp->getCond()) {
                case ICMPOP::eq:
                    changes[inst].setConstant(ConstantProxy(
                        constant_pool, lhs.getConstant() == rhs.getConstant()));
                    break;
                case ICMPOP::ne:
                    changes[inst].setConstant(ConstantProxy(
                        constant_pool, lhs.getConstant() != rhs.getConstant()));
                    break;
                case ICMPOP::sge:
                    changes[inst].setConstant(ConstantProxy(
                        constant_pool, lhs.getConstant() >= rhs.getConstant()));
                    break;
                case ICMPOP::sgt:
                    changes[inst].setConstant(ConstantProxy(
                        constant_pool, lhs.getConstant() > rhs.getConstant()));
                    break;
                case ICMPOP::sle:
                    changes[inst].setConstant(ConstantProxy(
                        constant_pool, lhs.getConstant() <= rhs.getConstant()));
                    break;
                case ICMPOP::slt:
                    changes[inst].setConstant(ConstantProxy(
                        constant_pool, lhs.getConstant() < rhs.getConstant()));
                    break;
                }
            } else if (lhs.isNAC() || rhs.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto fcmp = std::dynamic_pointer_cast<FCMPInst>(inst)) {
            auto lhs =
                solver.getVal(LatticeInfo::getKeyFromValue(fcmp->getLHS()));
            auto rhs =
                solver.getVal(LatticeInfo::getKeyFromValue(fcmp->getRHS()));
            if (lhs.isConstant() && rhs.isConstant()) {
                switch (fcmp->getCond()) {
                case FCMPOP::oeq:
                    changes[inst].setConstant(ConstantProxy(
                        constant_pool, lhs.getConstant() == rhs.getConstant()));
                    break;
                case FCMPOP::one:
                    changes[inst].setConstant(ConstantProxy(
                        constant_pool, lhs.getConstant() != rhs.getConstant()));
                    break;
                case FCMPOP::oge:
                    changes[inst].setConstant(ConstantProxy(
                        constant_pool, lhs.getConstant() >= rhs.getConstant()));
                    break;
                case FCMPOP::ogt:
                    changes[inst].setConstant(ConstantProxy(
                        constant_pool, lhs.getConstant() > rhs.getConstant()));
                    break;
                case FCMPOP::ole:
                    changes[inst].setConstant(ConstantProxy(
                        constant_pool, lhs.getConstant() <= rhs.getConstant()));
                    break;
                case FCMPOP::olt:
                    changes[inst].setConstant(ConstantProxy(
                        constant_pool, lhs.getConstant() < rhs.getConstant()));
                    break;
                default:
                    Err::unreachable("Unknown fcmp OP");
                }

            } else if (lhs.isNAC() || rhs.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto fti = std::dynamic_pointer_cast<FPTOSIInst>(inst)) {
            auto val =
                solver.getVal(LatticeInfo::getKeyFromValue(fti->getOVal()));
            if (val.isConstant()) {
                changes[inst].setConstant(ConstantProxy(
                    constant_pool,
                    static_cast<int>(val.getConstant().get_float())));
            }
            else if (val.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto itf = std::dynamic_pointer_cast<SITOFPInst>(inst)) {
            auto val = solver.getVal(LatticeInfo::getKeyFromValue(itf->getOVal()));
            if (val.isConstant()) {
                changes[inst].setConstant(ConstantProxy(
                   constant_pool,
                   static_cast<float>(val.getConstant().get_int())));
            }
            else if (val.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto zext = std::dynamic_pointer_cast<ZEXTInst>(inst)) {
            auto val = solver.getVal(LatticeInfo::getKeyFromValue(zext->getOVal()));
            if (val.isConstant()) {
                switch (toBType(zext->getOType())->getInner()) {
                case IRBTYPE::I1:
                    switch (toBType(zext->getTType())->getInner()) {
                    case IRBTYPE::I8:
                        changes[inst].setConstant(ConstantProxy(
                            constant_pool,
                            static_cast<char>(val.getConstant().get_i1())));
                        break;
                    case IRBTYPE::I32:
                        changes[inst].setConstant(ConstantProxy(
                            constant_pool,
                            static_cast<int>(val.getConstant().get_i1())));
                        break;
                    default:
                        Err::unreachable("target type could not zext otype:I1");
                    }
                    break;
                case IRBTYPE::I8:
                    switch (toBType(zext->getTType())->getInner()) {
                    case IRBTYPE::I32:
                        changes[inst].setConstant(ConstantProxy(
                            constant_pool,
                            static_cast<int>(val.getConstant().get_i8())));
                        break;
                    default:
                        Err::unreachable("target type could not zext otype:I8");
                    }
                    break;
                default:
                    Err::unreachable("target type could not zext");
                }
            } else if (val.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto alloca = std::dynamic_pointer_cast<ALLOCAInst>(inst)) {
            changes[inst] = LatticeInfo::NAC;
        } else if (auto gep = std::dynamic_pointer_cast<GEPInst>(inst)) {
            changes[inst] = LatticeInfo::NAC;
        } else if (auto load = std::dynamic_pointer_cast<LOADInst>(inst)) {
            changes[inst] = LatticeInfo::NAC;
        } else if (auto call = std::dynamic_pointer_cast<CALLInst>(inst)) {
            changes[inst] = LatticeInfo::NAC;
        } else if (auto bit = std::dynamic_pointer_cast<BITCASTInst>(inst)) {
            changes[inst] = LatticeInfo::NAC;
        }
        else if (inst->getOpcode() == OP::BR || inst->getOpcode() == OP::PHI)
            Err::unreachable("Transfer on br or phi.");
        else
            Err::unreachable("Unknown instruction.");
    }

    ConstantProxy getValueFromLatticeVal(const LatticeVal &v) const override {
        return v.getConstant();
    }

    LatticeVal computeLatticeVal(const std::shared_ptr<Value>& key) const override {
        if (key->getVTrait() == ValueTrait::CONSTANT_LITERAL)
            return LatticeVal(ConstantProxy(constant_pool, key));
        if (key->getVTrait() == ValueTrait::FORMAL_PARAMETER)
            return LatticeInfo::NAC;
        return LatticeInfo::UNDEF;
    }
};

PM::PreservedAnalyses ConstantPropagationPass::run(Function &function,
                                                   FAM &manager) {
    bool sccp_inst_modified = false;
    bool sccp_cfg_modified = false;

    SCCPLatticeFunc lattice_func(&function.getConstantPool());
    SCCPSolver solver(&lattice_func);
    solver.solve(function);

    // Simplify Instruction
    for (const auto &[key, val] : solver.get_map()) {
        if (val.isConstant()) {
            // Note that the key might already be a ConstantLiteral before SCCP,
            // but that doesn't matter.
            // If we can get a ConstantLiteral here, it must be used in propagation,
            // and thus might be a BRInst's Cond, which we should handle it as if it is
            // a constant produced by SCCP.
            for (auto &use : key->getUseList()) {
                use->getUser()->replaceUse(key,
                                           val.getConstant().getConstant());
                if (auto br_inst =
                        std::dynamic_pointer_cast<BRInst>(use->getUser())) {

                    Err::gassert(br_inst->isConditional());

                    std::shared_ptr<BasicBlock> dropped;
                    if (val.getConstant().get_i1())
                        safeUnlinkBB(br_inst->getParent(), br_inst->getFalseDest());
                    else
                        safeUnlinkBB(br_inst->getParent(), br_inst->getTrueDest());

                    sccp_cfg_modified = true;
                }
            }
            // If the key is not a ConstantLiteral, it must be a constant produced by SCCP.
            // So we delete the key.
            if (key->getVTrait() != ValueTrait::CONSTANT_LITERAL) {
                // Delete replaced constant instruction,
                // Though DCE/ADCE can make it too, deleting them in an earlier pass
                // can invalidate less Analysis Results, thus making the compiler faster.
                auto inst = std::dynamic_pointer_cast<Instruction>(key);
                Err::gassert(inst != nullptr);
                inst->getParent()->delInst(inst);
                sccp_inst_modified = true;
            }
        }
    }

    // Since we already handled CFG above,
    // all the unreachable blocks' in edge have been cut.
    // So just a trivial traversal will find all of them
    auto dfv = function.getDFVisitor();
    std::unordered_set live(dfv.begin(), dfv.end());

    // Cut the outgoing edge of the unreachable block
    for (const auto& block : function) {
        if (live.find(block) == live.end()) {
            for (const auto& succ : block->getNextBB())
                safeUnlinkBB(block, succ);
        }
    }

    sccp_cfg_modified |= function.delBlockIf(
        [&live](const auto& bb) { return live.find(bb) == live.end();});

    if (sccp_cfg_modified)
        return PM::PreservedAnalyses::none();

    if (sccp_inst_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        return pa;
    }

    return PM::PreservedAnalyses::all();
}
} // namespace IR