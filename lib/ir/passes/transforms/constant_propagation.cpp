#include "../../../../include/ir/passes/helpers/sparse_propagation.hpp"
#include "../../../../include/ir/passes/transforms/constant_propagation.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

namespace IR {
class SCCPLatticeVal {
    enum class Type {
        UNDEF,      // Undefined
        CONSTANT,   // Constant value
        NAC         // Not a constant value
    };

    // monostate for UNDEF and NAC
    std::variant<std::monostate, ConstantI1, ConstantI8, ConstantInt, ConstantFloat> value;

    // TODO
};

using SCCPSolver = SparsePropagationSolver<Value*, SCCPLatticeVal>;

class SCCPLatticeFunc : public SCCPSolver::LatticeFunction {
    using KeyT = Value*;
    using ValT = SCCPLatticeVal;
public:
    ValT merge(ValT lhs, ValT rhs) override {
        // TODO
    }

    ValT getVal(KeyT key) override {
        // TODO
    }

    void transfer(Instruction* inst, KeyT key) override {
        // TODO
    }
};

PM::PreservedAnalyses ConstantPropagationPass::run(Function& function, FAM& manager) {
    SCCPLatticeFunc lattice_func;
    SCCPSolver solver(&lattice_func);
    solver.solve(function);

    auto pa = PM::PreservedAnalyses::none();
    // FIXME: Not none?
    return pa;
}
}
