#ifdef GNALC_EXTENSION_ARMv7
#include "legacy_mir/base.hpp"

using namespace LegacyMIR;

Value::Value(ValueTrait _vtrait) : NameC(), vtrait(_vtrait) {}

Value::Value(ValueTrait _vtrait, std::string _name) : NameC(std::move(_name)), vtrait(_vtrait) {}

ValueTrait Value::getValueTrait() const { return vtrait; }
#endif