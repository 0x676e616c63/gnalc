#include "../../include/ir/constant.hpp"
#include "../../include/ir/visitor.hpp"

#include <string>
#include <cstdint>
#include <cinttypes>

namespace IR
{
ConstantInt::ConstantInt(int _val)
    : Value(std::to_string(_val), makeBType(IRBTYPE::I32), ValueTrait::CONSTANT_LITERAL), val(_val) {}

int ConstantInt::getVal() const { return val; }

// Maybe there is some historical reasons :(
// See https://llvm.org/docs/LangRef.html and https://groups.google.com/g/llvm-dev/c/IlqV3TbSk6M?pli=1
// A Useful Tool: https://www.h-schmidt.net/FloatConverter/IEEE754.html
// More info about how llvm check our output float:
// LLParser: https://github.com/llvm/llvm-project/blob/main/llvm/lib/AsmParser/LLParser.cpp#L6140
// ConstantFP::isValueValidForType: https://github.com/llvm/llvm-project/blob/main/llvm/lib/IR/Constants.cpp#L1611
// IEEEFloat::convert: https://github.com/llvm/llvm-project/blob/main/llvm/lib/Support/APFloat.cpp#L2533
// That's hard to port, orz, so we just convert all float to the hexadecimal form.
std::string toIRString(float f) {
    char buf[32];
    auto d = static_cast<double>(f);
    sprintf(buf, "0x%016" PRIX64, *reinterpret_cast<uint64_t*>(&d));
    return buf;
}

ConstantFloat::ConstantFloat(float _val)
    : Value(toIRString(_val), makeBType(IRBTYPE::FLOAT), ValueTrait::CONSTANT_LITERAL), val(_val) {}

float ConstantFloat::getVal() const { return val; }

ConstantI1::ConstantI1(bool _val)
    : Value(_val ? "1" : "0", makeBType(IRBTYPE::I1), ValueTrait::CONSTANT_LITERAL), val(_val) {}

bool ConstantI1::getVal() const { return val; }

void ConstantInt::accept(IRVisitor& visitor) { visitor.visit(*this); }

void ConstantFloat::accept(IRVisitor& visitor) { visitor.visit(*this); }

void ConstantI1::accept(IRVisitor& visitor) { visitor.visit(*this); }
}