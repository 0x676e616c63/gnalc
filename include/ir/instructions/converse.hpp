/**
 * @brief Conversion Operations
 * @brief fptosi, sitofp
 */

#include "../instruction.hpp"
#include "../constant.hpp"
#include <memory>

namespace IR {

// %Y = fptosi float 1.0E-247 to i1
class FPTOSIInst : public Instruction {
public:
    FPTOSIInst(Value* _val, NameParam _name = "", _type _ty = INT);

    Value* getOVal();
    _type getOType(); // ORIGINAL TYPE FLOAT
    _type getTType(); // TARGET TYPE INT
};

// <result> = sitofp <ty> <value> to <ty2>
class SITOFPInst : public Instruction {
public:
    SITOFPInst(Value* _val, NameParam _name = "", _type _ty = FLOAT);

    Value* getOVal();
    _type getOType(); // ORIGINAL TYPE INT
    _type getTType(); // TARGET TYPE FLOAT
};

}