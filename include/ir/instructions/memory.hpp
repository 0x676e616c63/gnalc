/**
 * @brief Memory Access and Addressing Operations
 * @brief alloca, load, store, getelementptr(gep)
 * 
 * @todo 这之中的一些向量处理语法没有给出，例如<result> = getelementptr <ty>, <N x ptr> <ptrval>, <vector index type> <idx>
 * @todo 对于[2 x i32]这种类型的包装
 */

#include "../instruction.hpp"

namespace IR {

// <result> = alloca [inalloca] <type> [, <ty> <NumElements>] [, align <alignment>] [, addrspace(<num>)]
// %1 = alloca [2 x i32], align 4 先写一个这种形式的
// %array2 = alloca i32, i32 2
// 
// result 的类型是ptr, <type>是基类型
class ALLOCAInst : public Instruction {
private:
    _type basetype;
    bool _array = false;
    int num_elements = 0;
    int align = 4;
public:
    ALLOCAInst(NameParam name, _type ty, int _align = 4);
    ALLOCAInst(NameParam name, _type ty, int _num_elements, int _align = 4);

    _type getBaseType();
    bool isArray() const;
    int getNumElements() const;
    int getAlign() const;
};

// <result> = load [volatile] <ty>, ptr <pointer>[, align <alignment>]......
// %0 = load i32, ptr %arrayidx, align 4
class LOADInst : public Instruction {
private:
    // Value* ptr; 添加到oprands中
    int align = 4;
public:
    LOADInst(NameParam name, _type ty, Value* _ptr, int _align = 4);

    Value* getPtr() const;
    int getAlign() const;
};

// store [volatile] <ty> <value>, ptr <pointer>[, align <alignment>]......
// store的type为undefined
class STOREInst : public Instruction {
private:
    _type basetype;

public:
    STOREInst(_type ty, Value* _value, Value* _ptr, int _align = 4);

    _type getBaseType();
    Value* getValue() const;
    Value* getPtr() const;
};

// <result> = getelementptr <ty>, ptr <ptrval>{, <ty> <idx>}*
// inbonds, nsw等修饰符未给出，目前只考虑上述一种情况
// result的类型为ptr；为了简便，默认索引值的类型均为i32
class GEPInst : public Instruction {
private:
    _type basetype;
public:
    GEPInst(NameParam name, _type ty, Value* _ptr, Value* idx_begin, Value* idx_end);

    _type getBaseType();
    Value* getPtr() const;
    Value* getIdxBegin(int i) const;
    Value* getIdxEnd() const;
};

}