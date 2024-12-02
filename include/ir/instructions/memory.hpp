/**
 * @brief Memory Access and Addressing Operations
 * @brief alloca, load, store, getelementptr(gep)
 */

#include "../instruction.hpp"

namespace IR {

// <result> = alloca [inalloca] <type> [, <ty> <NumElements>] [, align <alignment>] [, addrspace(<num>)]
// %1 = alloca [2 x i32], align 4
// %array2 = alloca i32, i32 2
class ALLOCAInst : public Instruction {
public:
};

}