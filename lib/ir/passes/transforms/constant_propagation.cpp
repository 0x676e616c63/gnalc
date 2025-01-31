#include "../../../../include/ir/passes/helpers/sparse_propagation.hpp"
#include "../../../../include/ir/passes/transforms/constant_propagation.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/instructions/binary.hpp"

namespace IR {
    class SCCPLatticeVal {
        enum class Type {
            UNDEF, // Undefined
            CONSTANT, // Constant value
            NAC // Not a constant value
        };


        // TODO
    public:
        // monostate for UNDEF and NAC
        std::variant<std::monostate, ConstantI1, ConstantI8, ConstantInt, ConstantFloat> value;

        SCCPLatticeVal() : type(Type::UNDEF), value(std::monostate{}) {
        }

        explicit SCCPLatticeVal(ConstantI1 val) : type(Type::CONSTANT), value(val) {
        }

        explicit SCCPLatticeVal(ConstantI8 val) : type(Type::CONSTANT), value(val) {
        }

        explicit SCCPLatticeVal(ConstantInt val) : type(Type::CONSTANT), value(val) {
        }

        explicit SCCPLatticeVal(ConstantFloat val) : type(Type::CONSTANT), value(val) {
        }

        bool isUndef() const { return type == Type::UNDEF; }
        bool isConstant() const { return type == Type::CONSTANT; }
        bool isNAC() const { return type == Type::NAC; }

        static SCCPLatticeVal makeNAC() {
            SCCPLatticeVal val;
            val.type = Type::NAC;
            val.value = std::monostate{};
            return val;
        }

        static SCCPLatticeVal makeUndef() {
            SCCPLatticeVal val;
            val.type = Type::UNDEF;
            val.value = std::monostate{};
            return val;
        }

        Type type;
    };

    using SCCPSolver = SparsePropagationSolver<Value *, SCCPLatticeVal>;

    class SCCPLatticeFunc : public SCCPSolver::LatticeFunction {
        using KeyT = Value *;
        using ValT = SCCPLatticeVal;

    public:
        std::unordered_map<KeyT, ValT> latticeValues;

        ValT merge(ValT lhs, ValT rhs) override {
            // TODO

            if (lhs.isNAC() || rhs.isNAC())
                return ValT::makeNAC();
            if (lhs.isUndef())
                return rhs;
            if (rhs.isUndef())
                return lhs;
            if (lhs.isConstant() && rhs.isConstant()) {
                if (lhs.value == rhs.value)
                    return lhs;
            } else return ValT::makeNAC();

            return ValT::makeNAC();
        }

        ValT getVal(KeyT key) override {
            if (latticeValues.find(key) != latticeValues.end()) {
                return latticeValues[key];
            }
            return ValT();
        }

        void transfer(Instruction *inst, KeyT key) override {
            if (auto binaryInst = dynamic_cast<IR::BinaryInst *>(inst)) {
                auto &lhs_lattice = latticeValues[binaryInst->getLHS().get()];
                auto &rhs_lattice = latticeValues[binaryInst->getRHS().get()];

                switch (binaryInst->getOpcode()) {
                    case OP::ADD:
                    case OP::FADD: {
                        if (lhs_lattice.isConstant() && rhs_lattice.isConstant()) {
                            latticeValues[key] = ValT(lhs_lattice.value + rhs_lattice.value);
                        } else if (lhs_lattice.isNAC() || rhs_lattice.
                                   isNAC()) { latticeValues[key] = ValT::makeNAC(); } else
                            latticeValues[key] = ValT::makeUndef();

                        break;
                    }
                    case OP::SUB:
                    case OP::FSUB: {
                        if (lhs_lattice.isConstant() && rhs_lattice.isConstant()) {
                            latticeValues[key] = ValT(lhs_lattice.value - rhs_lattice.value);
                        } else if (lhs_lattice.isNAC() || rhs_lattice.
                                   isNAC()) { latticeValues[key] = ValT::makeNAC(); } else
                            latticeValues[key] = ValT::makeUndef();
                        break;
                    }
                    case OP::MUL:
                    case OP::FMUL: {
                        if (lhs_lattice.isConstant() && rhs_lattice.isConstant()) {
                            latticeValues[key] = ValT(lhs_lattice.value * rhs_lattice.value);
                        } else if (lhs_lattice.value == 0 || rhs_lattice.value == 0) {
                            latticeValues[key].value = 0;
                            latticeValues[key].type = ValT::Type::CONSTANT;
                        } else if (lhs_lattice.isNAC() || rhs_lattice.
                                   isNAC()) { latticeValues[key] = ValT::makeNAC(); } else
                            latticeValues[key] = ValT::makeUndef();
                        break;
                    }
                    case OP::DIV:
                    case OP::FDIV: {
                        if (lhs_lattice.isConstant() && rhs_lattice.isConstant()) {
                            latticeValues[key] = ValT(lhs_lattice.value / rhs_lattice.value);
                        } else if (lhs_lattice.value == 0) {
                            //latticeValues[key].value = getIRConstantType<>;
                            latticeValues[key].type = ValT::Type::CONSTANT;
                        } else if (lhs_lattice.isNAC() || rhs_lattice.
                                   isNAC()) { latticeValues[key] = ValT::makeNAC(); } else
                            latticeValues[key] = ValT::makeUndef();
                        break;
                        //TODO rhs=0?
                    }
                    // TODO more opcode to write
                    default:
                        latticeValues[key] = ValT::makeNAC();
                        break;
                }
            } else latticeValues[key] = ValT::makeNAC();
        }
    };

    PM::PreservedAnalyses ConstantPropagationPass::run(Function &function, FAM &manager) {
        SCCPLatticeFunc lattice_func;
        SCCPSolver solver(&lattice_func);
        solver.solve(function);

        auto pa = PM::PreservedAnalyses::none();
        // FIXME: Not none?
        return pa;
    }
}
