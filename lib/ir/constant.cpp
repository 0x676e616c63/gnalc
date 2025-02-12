#include "../../include/ir/constant.hpp"
#include "../../include/ir/visitor.hpp"

namespace IR {
namespace detail {
template <typename T, IRBTYPE IRType>
void BasicConstant<T, IRType>::accept(IRVisitor &visitor) {
    visitor.visit(*this);
}
} // namespace detail

template void ConstantI1::accept(IRVisitor &visitor);
template void ConstantI8::accept(IRVisitor &visitor);
template void ConstantInt::accept(IRVisitor &visitor);
template void ConstantFloat::accept(IRVisitor &visitor);
} // namespace IR
