#include "mir-old/base.hpp"

using namespace MIR;

Value::Value(ValueTrait _vtrait) : NameC(), vtrait(_vtrait) {}

Value::Value(ValueTrait _vtrait, std::string _name) : NameC(std::move(_name)), vtrait(_vtrait) {}

ValueTrait Value::getValueTrait() const { return vtrait; }
