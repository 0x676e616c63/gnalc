#include "../../../include/ir/instructions/helper.hpp"
#include "../../../include/ir/visitor.hpp"
namespace IR {
    void IFBEntry::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void IFBEnd::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void ELSEBEntry::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void ELSEBEnd::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void WHILEBEntry::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void WHILEBEnd::accept(IRVisitor& visitor) { visitor.visit(*this); }
}