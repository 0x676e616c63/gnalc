/**
 * @brief Memory Access and Addressing Operations
 * @brief alloca, load, store, getelementptr(gep)
 * 
 * @todo 这之中的一些向量处理语法没有给出，例如<result> = getelementptr <ty>, <N x ptr> <ptrval>, <vector index type> <idx>
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
    std::shared_ptr<Type> basetype;
    bool is_static = true;
    int align = 4;
public:
    ALLOCAInst(NameRef name, std::shared_ptr<Type> btype, int _align = 4); // FOR STATIC
    // ALLOCAInst(NameRef name, std::shared_ptr<Type> btype, std::shared_ptr<Value> num_elements, int _align = 4); // FOR DYNAMIC

    std::shared_ptr<Type> getBaseType() const;
    bool isStatic() const;
    // std::vector<int> getStaticArraySize() const;
    bool isArray() const;
    // std::shared_ptr<Value> getNumElements() const; // 修改使用 User基类 的方法
    int getAlign() const;

    void accept(IRVisitor& visitor) override;
};

// <result> = load [volatile] <ty>, ptr <pointer>[, align <alignment>]......
// %0 = load i32, ptr %arrayidx, align 4
class LOADInst : public Instruction {
private:
    // Value* ptr; 添加到oprands中
    int align = 4;
public:
    // LOADInst(NameRef name, std::shared_ptr<Type> ty, std::shared_ptr<Value> _ptr, int _align = 4);
    LOADInst(NameRef name, std::shared_ptr<Value> _ptr, int _align = 4);

    std::shared_ptr<Value> getPtr() const;
    int getAlign() const;

    void accept(IRVisitor& visitor) override;
};

// store [volatile] <ty> <value>, ptr <pointer>[, align <alignment>]......
// storeinst的type为undefined, 因其没有Value
class STOREInst : public Instruction {
private:
    // std::shared_ptr<Type> basetype; // value的类型
    int align = 4;

public:
    STOREInst(std::shared_ptr<Value> _value, std::shared_ptr<Value> _ptr, int _align = 4);

    std::shared_ptr<Type> getBaseType() const;
    std::shared_ptr<Value> getValue() const;
    std::shared_ptr<Value> getPtr() const;
    int getAlign() const;

    void accept(IRVisitor& visitor) override;
};

// <result> = getelementptr <ty>, ptr <ptrval>{, <ty> <idx>}*
// inbounds(必须在边界之内), nsw等修饰符未给出，目前只考虑上述一种情况
// result的类型为ptr(makePtrType(getElm(getElm(_ptr->getTypePtr()))))
// 目前先不考虑多维数组，用i*col+j的方式索引，或者先gep计算出行开头，再计算偏移
// 12.6：多个index操作已加
class GEPInst : public Instruction {
private:
    // std::shared_ptr<Type> basetype; // _ptr的类型的element
public:
    GEPInst(NameRef name, const std::shared_ptr<Value>& _ptr,
        const std::shared_ptr<Value>& idx1, const std::shared_ptr<Value>& idx2);

    GEPInst(NameRef name, const std::shared_ptr<Value>& _ptr,
        const std::shared_ptr<Value>& idx);

    std::shared_ptr<Type> getBaseTypePtr() const;
    // std::vector<int> getArraySize() const;
    std::shared_ptr<Value> getPtr() const;
    std::vector<std::shared_ptr<Value>> getIdxs() const;

    void accept(IRVisitor& visitor) override;
};

}

#endif