#include "../../../include/ir/instructions/phi.hpp"
#include "../../../include/ir/visitor.hpp"

namespace IR
{
    void PHIInst::accept(IRVisitor& visitor) { visitor.visit(*this); }
}