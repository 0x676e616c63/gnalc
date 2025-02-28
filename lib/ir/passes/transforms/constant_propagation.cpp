#include "../../../../include/ir/passes/transforms/constant_propagation.hpp"
#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/converse.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/passes/helpers/sparse_propagation.hpp"
#include "../../../../include/utils/logger.hpp"
#include <optional>

namespace IR {
// [ min, max )
struct ValueRange {
    ConstantProxy min;
    ConstantProxy max;

    ValueRange(const ConstantProxy& a) : min(a), max(a) {}
    ValueRange(ConstantProxy min_, ConstantProxy max_) : min(std::move(min_)), max(std::move(max_)) {}

    bool overlap(const ValueRange& item) const {
        return min <= item.max && max >= item.min;
    }

    std::optional<ConstantProxy> getExactConstant() const {
        if (min == max)
            return min;
        return std::nullopt;
    }

    std::pair<int, int> getIntRange() const {
        return { min.get_int(), max.get_int() };
    }

    std::pair<float, float> getFloatRange() const {
        return { min.get_float(), max.get_float() };
    }

    bool operator==(const ValueRange& item) const {
        return min == item.min && max == item.max;
    }

    ValueRange operator+(const ValueRange& item) const {
        return { min + item.min, max + item.max };
    }
    ValueRange operator-(const ValueRange& item) const {
        return { min - item.max, max - item.min };
    }
    ValueRange operator-() const {
        return { -max, -min };
    }
    ValueRange operator*(const ValueRange& item) const {
        auto p = std::min(std::min(min * item.min, max * item.min), std::min(min * item.max, max * item.max));
        auto q = std::max(std::max(min * item.min, max * item.min), std::max(min * item.max, max * item.max));
        return { p, q };
    }
    ValueRange operator/(const ValueRange& item) const {
        auto p = std::min(std::min(min / item.min, max / item.min), std::min(min / item.max, max / item.max));
        auto q = std::max(std::max(min / item.min, max / item.min), std::max(min / item.max, max / item.max));
        return { p, q };
    }

    bool containsZero() const {
        if (auto min_ci32 = std::dynamic_pointer_cast<ConstantInt>(min.getConstant())) {
            auto max_ci32 = std::dynamic_pointer_cast<ConstantInt>(max.getConstant());
            return min_ci32->getVal() <= 0 && max_ci32->getVal() >= 0;
        }
        if (auto min_cf32 = std::dynamic_pointer_cast<ConstantFloat>(min.getConstant())) {
            auto max_cf32 = std::dynamic_pointer_cast<ConstantFloat>(max.getConstant());
            return min_cf32->getVal() <= 0.0f && max_cf32->getVal() >= 0.0f;
        }
        if (auto min_ci8 = std::dynamic_pointer_cast<ConstantI8>(min.getConstant())) {
            auto max_ci8 = std::dynamic_pointer_cast<ConstantI8>(max.getConstant());
            return min_ci8->getVal() <= 0 && max_ci8->getVal() >= 0;
        }
        if (auto min_ci1 = std::dynamic_pointer_cast<ConstantI1>(min.getConstant())) {
            auto max_ci1 = std::dynamic_pointer_cast<ConstantI1>(max.getConstant());
            return !min_ci1->getVal() || !max_ci1->getVal();
        }
        return true;
    }
};


class LatticeVal {
public:
    enum class Type {
        UNDEF,    // Undefined
        CONSTANT_RANGE, // Constant value range
        NAC       // Not a constant value
    };

private:
    Type type;
    std::optional<ValueRange> value;

public:
    LatticeVal() : type(Type::UNDEF) {}

    LatticeVal(const LatticeVal &) = default;

    LatticeVal &operator=(const LatticeVal &rhs) = default;

    explicit LatticeVal(Type type_) : type(type_) {
        Err::gassert(type != Type::CONSTANT_RANGE);
    }

    explicit LatticeVal(ValueRange val) : type(Type::CONSTANT_RANGE), value(val) {}

    bool operator==(const LatticeVal &rhs) const {
        if (type != rhs.type)
            return false;
        if (isConstantRange())
            return value == rhs.value;
        return true;
    }

    bool operator!=(const LatticeVal &rhs) const { return !(*this == rhs); }

    bool isUndef() const { return type == Type::UNDEF; }
    bool isConstantRange() const { return type == Type::CONSTANT_RANGE; }
    bool isNAC() const { return type == Type::NAC; }

    const auto &getConstantRange() const {
        Err::gassert(isConstantRange());
        return *value;
    }

    void setConstantRange(const ValueRange &val) {
        type = Type::CONSTANT_RANGE;
        value.emplace(ValueRange(val));
    }

    bool isZero() const {
        if (!isConstantRange())
            return false;

        auto rng = getConstantRange();
        if (auto exact = rng.getExactConstant()) {
            return exact == false || exact == '\0' ||
                   exact == 0 || exact == 0.0f;
        }
        return false;
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

        if (lhs.isConstantRange() && rhs.isConstantRange() &&
            lhs.getConstantRange() == rhs.getConstantRange()) {
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
                if (lhs.isConstantRange() && rhs.isConstantRange())
                    changes[inst].setConstantRange(lhs.getConstantRange() +
                                              rhs.getConstantRange());
                else if (lhs.isNAC() || rhs.isNAC())
                    changes[inst] = LatticeInfo::NAC;
                break;
            case OP::SUB:
            case OP::FSUB:
                if (lhs.isConstantRange() && rhs.isConstantRange())
                    changes[inst].setConstantRange(lhs.getConstantRange() -
                                              rhs.getConstantRange());
                else if (lhs.isNAC() || rhs.isNAC())
                    changes[inst] = LatticeInfo::NAC;
                break;
            case OP::MUL:
            case OP::FMUL:
                if (lhs.isZero() || rhs.isZero()) {
                    if (bin->getOpcode() == OP::MUL)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, 0));
                    else
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, 0.0f));
                }
                else if (lhs.isConstantRange() && rhs.isConstantRange())
                    changes[inst].setConstantRange(lhs.getConstantRange() *
                                              rhs.getConstantRange());
                else if (lhs.isNAC() || rhs.isNAC())
                    changes[inst] = LatticeInfo::NAC;
                break;
            case OP::DIV:
            case OP::FDIV:
                if (rhs.isZero()) {
                    Logger::logWarning("[Value Analysis]: Zero divisor detected.");
                    changes[inst] = LatticeInfo::NAC;
                }
                else if (lhs.isZero())
                    changes[inst].setConstantRange(lhs.getConstantRange());
                else if (lhs.isConstantRange() && rhs.isConstantRange()) {
                    if (rhs.getConstantRange().containsZero())
                        changes[inst] = LatticeInfo::NAC;
                    else {
                        changes[inst].setConstantRange(lhs.getConstantRange() /
                                                     rhs.getConstantRange());
                    }
                }
                else if (lhs.isNAC() || rhs.isNAC())
                    changes[inst] = LatticeInfo::NAC;
                break;
            case OP::REM:
                if (rhs.isZero()) {
                    Logger::logWarning("[Value Analysis]: Zero divisor detected.");
                    changes[inst] = LatticeInfo::NAC;
                }
                else if (lhs.isZero())
                    changes[inst].setConstantRange(ConstantProxy(constant_pool, 0));
                else if (lhs.isConstantRange() && rhs.isConstantRange()) {
                    auto lhsc = lhs.getConstantRange().getExactConstant();
                    auto rhsc = rhs.getConstantRange().getExactConstant();
                    if (lhsc && rhsc)
                        changes[inst].setConstantRange(*lhsc % *rhsc);
                    else
                        changes[inst] = LatticeInfo::NAC;
                }
                else if (lhs.isNAC() || rhs.isNAC())
                    changes[inst] = LatticeInfo::NAC;
                break;
            case OP::AND:
            case OP::OR:
                if (lhs.isConstantRange() && rhs.isConstantRange()) {
                    if (bin->getOpcode() == OP::AND) {
                        auto lhsc = lhs.getConstantRange().getExactConstant();
                        auto rhsc = rhs.getConstantRange().getExactConstant();
                        if (lhsc && rhsc)
                            changes[inst].setConstantRange(*lhsc && *rhsc);
                        else if ((lhsc && *lhsc == false) || (rhsc && *rhsc == false))
                            changes[inst].setConstantRange(ConstantProxy(constant_pool, false));
                        else
                            changes[inst] = LatticeInfo::NAC;
                    }
                    else {
                        auto lhsc = lhs.getConstantRange().getExactConstant();
                        auto rhsc = rhs.getConstantRange().getExactConstant();
                        if (lhsc && rhsc)
                            changes[inst].setConstantRange(*lhsc || *rhsc);
                        else if ((lhsc && *lhsc == true) || (rhsc && *rhsc == true))
                            changes[inst].setConstantRange(ConstantProxy(constant_pool, true));
                        else
                            changes[inst] = LatticeInfo::NAC;
                    }
                } else if (lhs.isNAC() || rhs.isNAC())
                    changes[inst] = LatticeInfo::NAC;
                break;
            default:
                Err::unreachable("Unknown binary opcode");
            }
        } else if (auto fneg = std::dynamic_pointer_cast<FNEGInst>(inst)) {
            auto val =
                solver.getVal(LatticeInfo::getKeyFromValue(fneg->getVal()));
            if (val.isConstantRange())
                changes[inst].setConstantRange(-val.getConstantRange());
            else if (val.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto icmp = std::dynamic_pointer_cast<ICMPInst>(inst)) {
            auto lhs =
                solver.getVal(LatticeInfo::getKeyFromValue(icmp->getLHS()));
            auto rhs =
                solver.getVal(LatticeInfo::getKeyFromValue(icmp->getRHS()));
            if (lhs.isConstantRange() && rhs.isConstantRange()) {
                const auto& lhsrng = lhs.getConstantRange();
                const auto& rhsrng = rhs.getConstantRange();
                auto lhsc = lhsrng.getExactConstant();
                auto rhsc = rhsrng.getExactConstant();
                switch (icmp->getCond()) {
                case ICMPOP::eq:
                    if (lhsc && rhsc)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, *lhsc == *rhsc));
                    else if (!lhsrng.overlap(rhsrng))
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, false));
                    else
                        changes[inst] = LatticeInfo::NAC;
                    break;
                case ICMPOP::ne:
                    if (lhsc && rhsc)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, *lhsc != *rhsc));
                    else if (!lhsrng.overlap(rhsrng))
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, true));
                    else
                        changes[inst] = LatticeInfo::NAC;
                    break;
                case ICMPOP::sge:
                    if (lhsc && rhsc)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, *lhsc >= *rhsc));
                    else if (!lhsrng.overlap(rhsrng) && lhsrng.min >= rhsrng.max)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, true));
                    else if (!lhsrng.overlap(rhsrng) && lhsrng.max <= rhsrng.min)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, false));
                    else
                        changes[inst] = LatticeInfo::NAC;
                    break;
                case ICMPOP::sgt:
                    if (lhsc && rhsc)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, *lhsc > *rhsc));
                    else if (!lhsrng.overlap(rhsrng) && lhsrng.min >= rhsrng.max)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, true));
                    else if (!lhsrng.overlap(rhsrng) && lhsrng.max <= rhsrng.min)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, false));
                    else
                        changes[inst] = LatticeInfo::NAC;
                    break;
                case ICMPOP::sle:
                    if (lhsc && rhsc)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, *lhsc <= *rhsc));
                    else if (!lhsrng.overlap(rhsrng) && lhsrng.min >= rhsrng.max)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, false));
                    else if (!lhsrng.overlap(rhsrng) && lhsrng.max <= rhsrng.min)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, true));
                    else
                        changes[inst] = LatticeInfo::NAC;
                    break;
                case ICMPOP::slt:
                    if (lhsc && rhsc)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, *lhsc < *rhsc));
                    else if (!lhsrng.overlap(rhsrng) && lhsrng.min >= rhsrng.max)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, false));
                    else if (!lhsrng.overlap(rhsrng) && lhsrng.max <= rhsrng.min)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, true));
                    else
                        changes[inst] = LatticeInfo::NAC;
                    break;
                }
            } else if (lhs.isNAC() || rhs.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto fcmp = std::dynamic_pointer_cast<FCMPInst>(inst)) {
            auto lhs =
                solver.getVal(LatticeInfo::getKeyFromValue(fcmp->getLHS()));
            auto rhs =
                solver.getVal(LatticeInfo::getKeyFromValue(fcmp->getRHS()));
            if (lhs.isConstantRange() && rhs.isConstantRange()) {
                const auto& lhsrng = lhs.getConstantRange();
                const auto& rhsrng = rhs.getConstantRange();
                auto lhsc = lhsrng.getExactConstant();
                auto rhsc = rhsrng.getExactConstant();
                switch (fcmp->getCond()) {
                case FCMPOP::oeq:
                    if (lhsc && rhsc)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, *lhsc == *rhsc));
                    else if (!lhsrng.overlap(rhsrng))
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, false));
                    else
                        changes[inst] = LatticeInfo::NAC;
                    break;
                case FCMPOP::one:
                    if (lhsc && rhsc)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, *lhsc != *rhsc));
                    else if (!lhsrng.overlap(rhsrng))
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, true));
                    else
                        changes[inst] = LatticeInfo::NAC;
                    break;
                case FCMPOP::oge:
                    if (lhsc && rhsc)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, *lhsc >= *rhsc));
                    else if (!lhsrng.overlap(rhsrng) && lhsrng.min >= rhsrng.max)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, true));
                    else if (!lhsrng.overlap(rhsrng) && lhsrng.max <= rhsrng.min)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, false));
                    else
                        changes[inst] = LatticeInfo::NAC;
                    break;
                case FCMPOP::ogt:
                    if (lhsc && rhsc)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, *lhsc > *rhsc));
                    else if (!lhsrng.overlap(rhsrng) && lhsrng.min >= rhsrng.max)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, true));
                    else if (!lhsrng.overlap(rhsrng) && lhsrng.max <= rhsrng.min)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, false));
                    else
                        changes[inst] = LatticeInfo::NAC;
                    break;
                case FCMPOP::ole:
                    if (lhsc && rhsc)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, *lhsc <= *rhsc));
                    else if (!lhsrng.overlap(rhsrng) && lhsrng.min >= rhsrng.max)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, false));
                    else if (!lhsrng.overlap(rhsrng) && lhsrng.max <= rhsrng.min)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, true));
                    else
                        changes[inst] = LatticeInfo::NAC;
                    break;
                case FCMPOP::olt:
                    if (lhsc && rhsc)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, *lhsc < *rhsc));
                    else if (!lhsrng.overlap(rhsrng) && lhsrng.min >= rhsrng.max)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, false));
                    else if (!lhsrng.overlap(rhsrng) && lhsrng.max <= rhsrng.min)
                        changes[inst].setConstantRange(ConstantProxy(constant_pool, true));
                    else
                        changes[inst] = LatticeInfo::NAC;
                    break;
                case FCMPOP::ord:
                    changes[inst] = LatticeInfo::NAC;
                }
            } else if (lhs.isNAC() || rhs.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto fti = std::dynamic_pointer_cast<FPTOSIInst>(inst)) {
            auto val =
                solver.getVal(LatticeInfo::getKeyFromValue(fti->getOVal()));
            if (val.isConstantRange()) {
                const auto& rng = val.getConstantRange();
                changes[inst].setConstantRange(
                    ValueRange(ConstantProxy(constant_pool, static_cast<int>(rng.min.get_float())),
                        ConstantProxy(constant_pool, static_cast<int>(rng.max.get_float()))));
            }
            else if (val.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto itf = std::dynamic_pointer_cast<SITOFPInst>(inst)) {
            auto val = solver.getVal(LatticeInfo::getKeyFromValue(itf->getOVal()));
            if (val.isConstantRange()) {
                const auto& rng = val.getConstantRange();
                changes[inst].setConstantRange(
                    ValueRange(ConstantProxy(constant_pool, static_cast<float>(rng.min.get_int())),
                        ConstantProxy(constant_pool, static_cast<float>(rng.max.get_int()))));
            }
            else if (val.isNAC())
                changes[inst] = LatticeInfo::NAC;
        } else if (auto zext = std::dynamic_pointer_cast<ZEXTInst>(inst)) {
            auto val = solver.getVal(LatticeInfo::getKeyFromValue(zext->getOVal()));
            if (val.isConstantRange()) {
                const auto& rng = val.getConstantRange();
                switch (toBType(zext->getOType())->getInner()) {
                case IRBTYPE::I1:
                    switch (toBType(zext->getTType())->getInner()) {
                    case IRBTYPE::I8:
                        changes[inst].setConstantRange(
                            ValueRange(ConstantProxy(constant_pool, static_cast<char>(rng.min.get_i1())),
                                ConstantProxy(constant_pool, static_cast<char>(rng.min.get_i1()))));
                        break;
                    case IRBTYPE::I32:
                        changes[inst].setConstantRange(
                            ValueRange(ConstantProxy(constant_pool, static_cast<int>(rng.min.get_i1())),
                                ConstantProxy(constant_pool, static_cast<int>(rng.min.get_i1()))));
                        break;
                    default:
                        changes[inst] = LatticeInfo::NAC;
                    }
                    break;
                case IRBTYPE::I8:
                    switch (toBType(zext->getTType())->getInner()) {
                    case IRBTYPE::I32:
                        changes[inst].setConstantRange(
                            ValueRange(ConstantProxy(constant_pool, static_cast<int>(rng.min.get_i8())),
                                ConstantProxy(constant_pool, static_cast<int>(rng.min.get_i8()))));
                        break;
                    default:
                        changes[inst] = LatticeInfo::NAC;
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
            if (call->getFuncName() == "@getch") {
                changes[inst].setConstantRange
                (ValueRange(ConstantProxy(constant_pool, -1),
               ConstantProxy(constant_pool, 256)));
            }
            else
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
        return v.getConstantRange().getExactConstant().value();
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

    std::set<std::shared_ptr<PHIInst>> dead_phis;

    // Simplify Instruction and Cut the In Edge of Unreachable block
    for (const auto &[key, val] : solver.get_map()) {
        if (val.isConstantRange()) {
            auto rng = val.getConstantRange();
            if (auto exact = rng.getExactConstant())
            {
                // Note that the key might already be a ConstantLiteral before SCCP,
                // but that doesn't matter.
                // If we can get a ConstantLiteral here, it must be used in propagation,
                // and thus might be a BRInst's Cond, which we should handle it as if it is
                // a constant deduced by SCCP.
                auto use_list = key->getUseList();
                for (const auto &use : use_list) {
                    if (auto br_inst = std::dynamic_pointer_cast<BRInst>(use->getUser())) {
                        // BRInst of other function should be handled by their SCCP !!!
                        if (br_inst->getParent()->getParent().get() != &function)
                            continue;

                        Err::gassert(br_inst->isConditional());

                        // Since we delete unreachable blocks below, we don't check if `safeUnlinkBB`
                        // requires us to delete the BRInst. (no successor)
                        if (exact->get_i1())
                            safeUnlinkBB(br_inst->getParent(), br_inst->getFalseDest(), dead_phis);
                        else
                            safeUnlinkBB(br_inst->getParent(), br_inst->getTrueDest(), dead_phis);
                        sccp_cfg_modified = true;
                    }
                }
                // If the key is not a ConstantLiteral, it must be a constant deduced by SCCP.
                // So we replace and delete the key.
                if (key->getVTrait() != ValueTrait::CONSTANT_LITERAL) {
                    key->replaceSelf(exact->getConstant());
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
    }

    // Clear the solver to destructs temp values.
    solver.clear();

    // Since we already handled CFG above,
    // all the unreachable blocks' in edge have been cut.
    // So just a trivial traversal will find all of them
    auto dfv = function.getDFVisitor();
    std::unordered_set live(dfv.begin(), dfv.end());

    // Cut the outgoing edge of the unreachable block
    for (const auto& block : function) {
        if (live.find(block) == live.end()) {
            for (const auto& succ : block->getNextBB())
                safeUnlinkBB(block, succ, dead_phis);
        }
    }

    // Delete dead blocks first, because dead phis may be used in dead blocks.
    sccp_cfg_modified |= function.delBlockIf(
    [&live](const auto& bb) { return live.find(bb) == live.end();});

    for (auto& block : function) {
        block->delInstIf([&dead_phis](const auto& p) {
            return dead_phis.find(std::dynamic_pointer_cast<PHIInst>(p)) != dead_phis.end();
        }, BasicBlock::DEL_MODE::PHI);
    }

    if (sccp_cfg_modified)
        return PM::PreservedAnalyses::none();

    if (sccp_inst_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        pa.preserve<PostDomTreeAnalysis>();
        pa.preserve<LoopAnalysis>();
        return pa;
    }

    return PM::PreservedAnalyses::all();
}
} // namespace IR