#include "../../../../include/ir/passes/helpers/sparse_propagation.hpp"
#include "../../../../include/ir/passes/transforms/constant_propagation.hpp"

#include <optional>

#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/utils/logger.hpp"
#include "../../../../include/utils/misc.hpp"

namespace IR {
    class SCCPLatticeVal {
    public:
        enum class Type {
            UNDEF,     // Undefined
            CONSTANT,  // Constant value
            NAC        // Not a constant value
        };
    private:
        Type type;
        std::optional<ConstantProxy> value;
    public:
        SCCPLatticeVal() : type(Type::UNDEF) {}

        explicit SCCPLatticeVal(Type type_) : type(type_) {
            Err::gassert(type != Type::CONSTANT);
        }

        explicit SCCPLatticeVal(ConstantProxy val)
            : type(Type::CONSTANT), value(val) { }

        bool isUndef() const { return type == Type::UNDEF; }
        bool isConstant() const { return type == Type::CONSTANT; }
        bool isNAC() const { return type == Type::NAC; }
        const auto& getConstant() const {
            Err::gassert(isConstant());
            return *value;
        }
        void setConstant(ConstantProxy val) {
            type = Type::CONSTANT;
            value.emplace(val);
        }
        bool isZero() const {
            Err::gassert(isConstant());
            return getConstant() == false || getConstant() == '\0'
                || getConstant() == 0 || getConstant() == 0.0f;
        }
    };

    using SCCPSolver = SparsePropagationSolver<Value *, SCCPLatticeVal>;

    class SCCPLatticeFunc : public SCCPSolver::LatticeFunction {
        using KeyT = Value *;
        using ValT = SCCPLatticeVal;

        inline static const auto NAC = SCCPLatticeVal(SCCPLatticeVal::Type::NAC);
        inline static const auto UNDEF = SCCPLatticeVal(SCCPLatticeVal::Type::UNDEF);

        ConstantPool* constant_pool;
    public:
        explicit SCCPLatticeFunc(ConstantPool* pool) : constant_pool(pool) {}

        std::unordered_map<KeyT, ValT> latticeValues;

        ValT merge(ValT lhs, ValT rhs) override {
            if (lhs.isNAC() || rhs.isNAC())
                return NAC;
            if (lhs.isUndef())
                return rhs;
            if (rhs.isUndef())
                return lhs;

            if (lhs.isConstant() && rhs.isConstant()) {
                if (lhs.getConstant() == rhs.getConstant())
                    return lhs;
            }

            return NAC;
        }

        ValT& getVal(KeyT key) override {
            auto it = latticeValues.find(key);
            Err::gassert(it != latticeValues.end());
            return it->second;
        }

        void transfer(Instruction *inst, KeyT key) override {
            if (auto binaryInst = dynamic_cast<BinaryInst *>(inst)) {
                auto &lhs_lattice = getVal(binaryInst->getLHS().get());
                auto &rhs_lattice = getVal(binaryInst->getRHS().get());

                switch (binaryInst->getOpcode())
                {
                case OP::ADD:
                case OP::FADD: {
                    if (lhs_lattice.isConstant() && rhs_lattice.isConstant())
                        latticeValues[key].setConstant(lhs_lattice.getConstant() + rhs_lattice.getConstant());
                    else if (lhs_lattice.isNAC() || rhs_lattice.isNAC())
                        latticeValues[key] = NAC;
                    else
                        latticeValues[key] = UNDEF;
                    break;
                }
                case OP::SUB:
                case OP::FSUB: {
                    if (lhs_lattice.isConstant() && rhs_lattice.isConstant())
                        latticeValues[key].setConstant(lhs_lattice.getConstant() - rhs_lattice.getConstant());
                    else if (lhs_lattice.isNAC() || rhs_lattice.isNAC())
                        latticeValues[key] = NAC;
                    else
                        latticeValues[key] = UNDEF;
                    break;
                }
                case OP::MUL:
                case OP::FMUL: {
                    if (lhs_lattice.isConstant() && rhs_lattice.isConstant())
                        latticeValues[key].setConstant(lhs_lattice.getConstant() * rhs_lattice.getConstant());
                    else if (lhs_lattice.isZero() || rhs_lattice.isZero())
                        latticeValues[key].setConstant(ConstantProxy(constant_pool, binaryInst->getOpcode() == OP::MUL ? 0 : 0.0f));
                    else if (lhs_lattice.isNAC() || rhs_lattice.isNAC())
                        latticeValues[key] = NAC;
                    else
                        latticeValues[key] = UNDEF;
                    break;
                }
                case OP::DIV:
                case OP::FDIV: {
                    // This should cause an abort in run-time, not compile-time.
                    if (rhs_lattice.isZero())
                        Logger::logInfo("Warning: Divide by zero.");

                    if (lhs_lattice.isConstant() && rhs_lattice.isConstant())
                        latticeValues[key].setConstant(lhs_lattice.getConstant() / rhs_lattice.getConstant());
                    else if (lhs_lattice.isZero())
                        latticeValues[key].setConstant(ConstantProxy(constant_pool, binaryInst->getOpcode() == OP::DIV ? 0 : 0.0f));
                    else if (lhs_lattice.isNAC() || rhs_lattice.isNAC())
                        latticeValues[key] = NAC;
                    else
                        latticeValues[key] = UNDEF;
                    break;
                }
                    // TODO more opcode to write
                default:
                    Err::unreachable("Unexpected Instruction.");
                    break;
                }
            } else latticeValues[key] = NAC;
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
