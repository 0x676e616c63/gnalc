#include "../../include/mirtools/tool.hpp"

using namespace MIR;

std::string variant_const_toString::operator()(const int &val) const { return std::to_string(val); }

std::string variant_const_toString::operator()(const size_t &val) const { return std::to_string(val); }

std::string variant_const_toString::operator()(const float &val) const {
    float stage = val;
    return std::to_string(*reinterpret_cast<unsigned *>(&stage));
    // turn to encoding format
}

std::string variant_opcode_toString::operator()(const OpCode &opcode) const { return enum_name(opcode); }
std::string variant_opcode_toString::operator()(const NeonOpCode &opcode) const { return enum_name(opcode); }

std::string variant_reg_toString::operator()(CoreRegister emVal) { return enum_name(emVal); }

std::string variant_reg_toString::operator()(FPURegister emVal) { return enum_name(emVal); }
