/**
 * @brief Memory Access and Addressing Operations
 * @brief alloca, load, store, getelementptr(gep)
 * 
 * @todo 这之中的一些向量处理语法没有给出，例如<result> = getelementptr <ty>, <N x ptr> <ptrval>, <vector index type> <idx>
 * @todo 对于[2 x i32]这种类型的包装--目前弃用
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTION_MEMORY_HPP
#define GNALC_IR_INSTRUCTION_MEMORY_HPP

#include "../instruction.hpp"
#include <vector>

namespace IR {

// <result> = alloca [inalloca] <type> [, <ty> <NumElements>] [, align <alignment>] [, addrspace(<num>)]
// ty 是 numelements 的类型
//
// 类型一：%1 = alloca [2 x i32], align 4 // 静态分配，在函数开头，用于确定大小的数组
// 类型二：%array2 = alloca i32, i32 %1 // 动态分配，需保存栈帧？
// 
// result 的类型是ptr, <type>是基类型
class ALLOCAInst : public Instruction {
private:
    IRTYPE basetype;
    bool is_static = true;
    std::vector<int> static_array_size; // 只有静态分配的情况会用到，[3 x [4 x i32]] 就是 {3, 4} 和语言中的数组大小顺序一致
    bool is_array = false;
    int align = 4;
public:
    ALLOCAInst(NameRef name, IRTYPE btype, int _align = 4); // FOR NOTARRAY
    ALLOCAInst(NameRef name, IRTYPE btype, const std::vector<int>& _array_size, int _align = 4); // FOR STATIC ARRAY ALLOCATION
    ALLOCAInst(NameRef name, IRTYPE btype, Value* num_elements, int _align = 4); // FOR DYNAMIC ARRAY ALLOCATION

    IRTYPE getBaseType() const;
    bool isStatic() const;
    std::vector<int> getStaticArraySize() const;
    bool isArray() const;
    Value* getNumElements() const; // 修改使用 User基类 的方法
    int getAlign() const;
};

// <result> = load [volatile] <ty>, ptr <pointer>[, align <alignment>]......
// %0 = load i32, ptr %arrayidx, align 4
class LOADInst : public Instruction {
private:
    // Value* ptr; 添加到oprands中
    int align = 4;
public:
    LOADInst(NameRef name, IRTYPE ty, Value* _ptr, int _align = 4);

    Value* getPtr() const;
    int getAlign() const;
};

// store [volatile] <ty> <value>, ptr <pointer>[, align <alignment>]......
// storeinst的type为undefined, 因其没有Value
class STOREInst : public Instruction {
private:
    IRTYPE basetype;
    int align = 4;

public:
    STOREInst(IRTYPE btype, Value* _value, Value* _ptr, int _align = 4);

    IRTYPE getBaseType() const;
    Value* getValue() const;
    Value* getPtr() const;
    int getAlign() const;
};

// <result> = getelementptr <ty>, ptr <ptrval>{, <ty> <idx>}*
// inbounds(必须在边界之内), nsw等修饰符未给出，目前只考虑上述一种情况
// result的类型为ptr；为了简便，默认索引值的类型均为i32
// 目前先不考虑多维数组，用i*col+j的方式索引，或者先gep计算出行开头，再计算偏移
// 12.6：多个index操作已加
class GEPInst : public Instruction {
private:
    IRTYPE basetype;
public:
    GEPInst(NameRef name, IRTYPE btype, Value* _ptr, const std::list<Value*>& idxs);

    IRTYPE getBaseType();
    Value* getPtr() const;
    std::vector<Value*> getIdxs() const;
};

}

#endif