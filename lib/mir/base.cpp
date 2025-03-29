#include "../../include/mir/base.hpp"

using namespace MIR;

Value::Value(ValueTrait _vtrait) : IR::NameC(), vtrait(_vtrait) {}

Value::Value(ValueTrait _vtrait, std::string _name) : IR::NameC(std::move(_name)), vtrait(_vtrait) {}

ValueTrait Value::getValueTrait() const { return vtrait; }
