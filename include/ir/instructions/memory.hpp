/**
 * @brief Memory Access and Addressing Operations
 * @brief alloca, load, store, getelementptr(gep)
 *
 * @todo 这之中的一些向量处理语法没有给出，例如<result> = getelementptr <ty>, <N
 * x ptr> <ptrval>, <vector index type> <idx>
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTION_MEMORY_HPP
#define GNALC_IR_INSTRUCTION_MEMORY_HPP

#include "../instruction.hpp"
#include <vector>

namespace IR {
// 不考虑动态分配数组
// <result> = alloca <type>  [, align <alignment>] [, addrspace(<num>)]
//
// result 的类型是 ptr, <type> 是基类型
// getBaseType() 即返回 <type>
class ALLOCAInst : public Instruction {
private:
    std::shared_ptr<Type> basetype;
    int align = 4;

public:
    ALLOCAInst(NameRef name, std::shared_ptr<Type> btype, int _align = 4);

    std::shared_ptr<Type> getBaseType() const;
    bool isArray() const;
    int getAlign() const;

    void accept(IRVisitor &visitor) override;
};

// <result> = load [volatile] <ty>, ptr <pointer>[, align <alignment>]......
// %0 = load i32, ptr %arrayidx, align 4
class LOADInst : public Instruction {
private:
    int align = 4;

public:
    LOADInst(NameRef name, const std::shared_ptr<Value> &_ptr, int _align = 4);

    std::shared_ptr<Value> getPtr() const;
    int getAlign() const;

    void accept(IRVisitor &visitor) override;
};

// store [volatile] <ty> <value>, ptr <pointer>[, align <alignment>]......
// storeinst的type为undefined, 因其没有Value
class STOREInst : public Instruction {
    int align = 4;

public:
    STOREInst(const std::shared_ptr<Value> &_value,
              const std::shared_ptr<Value> &_ptr, int _align = 4);

    std::shared_ptr<Type> getBaseType() const;
    std::shared_ptr<Value> getValue() const;
    std::shared_ptr<Value> getPtr() const;
    int getAlign() const;

    void accept(IRVisitor &visitor) override;
};

// <result> = getelementptr <ty>, ptr <ptrval> {, <ty> <idx>}*
// inbounds(必须在边界之内), nsw等修饰符未给出，目前只考虑上述一种情况
// result的类型为ptr(makePtrType(getElm(getElm(_ptr->getTypePtr()))))
// 目前先不考虑多维数组，用i*col+j的方式索引，或者先gep计算出行开头，再计算偏移
// 12.6：多个index操作已加
class GEPInst : public Instruction {
public:
    GEPInst(NameRef name, const std::shared_ptr<Value> &_ptr,
            const std::shared_ptr<Value> &idx1,
            const std::shared_ptr<Value> &idx2);

    GEPInst(NameRef name, const std::shared_ptr<Value> &_ptr,
            const std::shared_ptr<Value> &idx);

    GEPInst(NameRef name, const std::shared_ptr<Value> &_ptr,
        const std::vector<std::shared_ptr<Value>> &idxs);

    std::shared_ptr<Type> getBaseType() const;
    std::shared_ptr<Value> getPtr() const;
    std::vector<std::shared_ptr<Value>> getIdxs() const;

    // Check if all the indices are constant.
    bool isConstantOffset() const;
    // Get the constant offset, if not constant, an exception will be thrown.
    size_t getConstantOffset() const;

    void accept(IRVisitor &visitor) override;
};

} // namespace IR

#endif