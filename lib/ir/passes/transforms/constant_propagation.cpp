#include "../../../../include/ir/passes/helpers/sparse_propagation.hpp"
#include "../../../../include/ir/passes/transforms/constant_propagation.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/utils/logger.hpp"
#include <optional>

namespace IR {
    class LatticeVal {
    public:
        enum class Type {
            UNDEF, // Undefined
            CONSTANT, // Constant value
            NAC // Not a constant value
        };

    private:
        Type type;
        std::optional<ConstantProxy> value;

    public:
        LatticeVal() : type(Type::UNDEF) {
        }

        LatticeVal(const LatticeVal &) = default;

        LatticeVal &operator=(const LatticeVal &rhs) = default;

        explicit LatticeVal(Type type_) : type(type_) {
            Err::gassert(type != Type::CONSTANT);
        }

        explicit LatticeVal(ConstantProxy val)
            : type(Type::CONSTANT), value(val) {
        }


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
            Err::gassert(isConstant());
            return getConstant() == false || getConstant() == '\0'
                   || getConstant() == 0 || getConstant() == 0.0f;
        }
    };

    using LatticeKey = std::shared_ptr<Value>;

    class LatticeInfo {
    public:
        inline static const auto NAC = LatticeVal(LatticeVal::Type::NAC);
        inline static const auto UNDEF = LatticeVal(LatticeVal::Type::UNDEF);
        static LatticeKey getKeyFromValue(const std::shared_ptr<Value> &key) { return key; }
        static std::shared_ptr<Value> getValueFromKey(const LatticeKey &key) { return key; }
    };

    using SCCPSolver = SparsePropagationSolver<LatticeKey, LatticeVal, LatticeInfo>;

    class SCCPLatticeFunc : public SCCPSolver::LatticeFunction {
        ConstantPool *constant_pool;

    public:
        explicit SCCPLatticeFunc(ConstantPool *pool) : constant_pool(pool) {
        }

        LatticeVal merge(LatticeVal lhs, LatticeVal rhs) const override {
            if (lhs.isNAC() || rhs.isNAC())
                return LatticeInfo::NAC;

            if (lhs.isUndef())
                return rhs;
            if (rhs.isUndef())
                return lhs;

            if (lhs.isConstant() && rhs.isConstant() && lhs.getConstant() == rhs.getConstant()) {
                return lhs;
            }

            return LatticeInfo::NAC;
        }

        void transfer(
            const std::shared_ptr<Instruction> &inst,
            std::unordered_map<LatticeKey, LatticeVal> &changes,
            SCCPSolver &solver) const override {
            if (auto bin = std::dynamic_pointer_cast<BinaryInst>(inst)) {
                auto lhs = solver.getVal(LatticeInfo::getKeyFromValue(bin->getLHS()));
                auto rhs = solver.getVal(LatticeInfo::getKeyFromValue(bin->getRHS()));

                switch (bin->getOpcode()) {
                    case OP::ADD:
                    case OP::FADD:
                        if (lhs.isConstant() && rhs.isConstant())
                            changes[inst].setConstant(lhs.getConstant() + rhs.getConstant());
                        else if (lhs.isNAC() || rhs.isNAC())
                            changes[inst] = LatticeInfo::NAC;
                        break;
                    case OP::SUB:
                    case OP::FSUB:
                        if (lhs.isConstant() && rhs.isConstant())
                            changes[inst].setConstant(lhs.getConstant() - rhs.getConstant());
                        else if (lhs.isNAC() || rhs.isNAC())
                            changes[inst] = LatticeInfo::NAC;
                        break;
                    case OP::MUL:
                    case OP::FMUL:
                        if (lhs.isZero() || rhs.isZero())
                            changes[inst].setConstant(lhs.getConstant() * 0);
                        else if (lhs.isConstant() && rhs.isConstant())
                            changes[inst].setConstant(lhs.getConstant() * rhs.getConstant());
                        else if (lhs.isNAC() || rhs.isNAC())
                            changes[inst] = LatticeInfo::NAC;
                        break;
                    case OP::DIV:
                    case OP::FDIV:
                        if (rhs.isZero())
                            Err::unreachable("Divisor should no be zero in div");
                        else if (lhs.isZero())
                            changes[inst].setConstant(lhs.getConstant());
                        else if (lhs.isConstant() && rhs.isConstant())
                            changes[inst].setConstant(lhs.getConstant() / rhs.getConstant());
                        else if (lhs.isNAC() || rhs.isNAC())
                            changes[inst] = LatticeInfo::NAC;
                        break;
                    case OP::REM:
                    case OP::FREM:
                        if (rhs.isZero())
                            Err::unreachable("Divisor should no be zero in mod");
                        else if (lhs.isZero())
                            changes[inst].setConstant(lhs.getConstant());
                        else if (lhs.isConstant() && rhs.isConstant())
                            changes[inst].setConstant(lhs.getConstant() % rhs.getConstant());
                        else if (lhs.isNAC() || rhs.isNAC())
                            changes[inst] = LatticeInfo::NAC;

                    default:
                        Err::unreachable("Unknown binary opcode");
                }
            } else if (inst->getOpcode() == OP::BR || inst->getOpcode() == OP::PHI)
                Err::unreachable("Transfer on br or phi.");
            else
                Err::unreachable("Unknown instruction.");
        }

        ConstantProxy getValueFromLatticeVal(const LatticeVal &v) const override {
            return v.getConstant();
        }
    };

    PM::PreservedAnalyses ConstantPropagationPass::run(Function &function, FAM &manager) {
        SCCPLatticeFunc lattice_func(&function.getConstantPool());
        SCCPSolver solver(&lattice_func);
        solver.solve(function);

        auto pa = PM::PreservedAnalyses::none();
        // FIXME: Not none?
        return pa;
    }
}
