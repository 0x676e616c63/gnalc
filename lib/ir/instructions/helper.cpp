#include "../../../include/ir/instructions/helper.hpp"
#include "../../../include/ir/visitor.hpp"
namespace IR {
    void IFInst::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void WHILEInst::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void BREAKInst::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void CONTINUEInst::accept(IRVisitor& visitor) { visitor.visit(*this); }
}