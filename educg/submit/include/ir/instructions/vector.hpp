// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

/**
 * @brief vector operation
 * @brief extractelement, insertelement, shufflevector
 */
#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_VECTOR_HPP
#define GNALC_IR_INSTRUCTIONS_VECTOR_HPP

#include "../constant.hpp"
#include "../instruction.hpp"
#include "../type_alias.hpp"

namespace IR {
// <result> = extractelement <n x <ty>> <val>, <ty2> <idx>  ; yields <ty>
class EXTRACTInst : public Instruction {
public:
    EXTRACTInst(NameRef name, const pVal &vector, const pVal &idx);

    pVal getVector() const;
    pVal getIdx() const;

    void accept(IRVisitor &visitor) override;

private:
    pVal cloneImpl() const override { return std::make_shared<EXTRACTInst>(getName(), getVector(), getIdx()); }
};

// <result> = insertelement <n x <ty>> <val>, <ty> <elt>, <ty2> <idx>    ; yields <n x <ty>>
class INSERTInst : public Instruction {
public:
    INSERTInst(NameRef name, const pVal &vector, const pVal &element, const pVal &idx);

    pVal getVector() const;
    pVal getElm() const;
    pVal getIdx() const;

    void accept(IRVisitor &visitor) override;

private:
    pVal cloneImpl() const override { return std::make_shared<INSERTInst>(getName(), getVector(), getElm(), getIdx()); }
};

// <result> = shufflevector <n x <ty>> <v1>, <n x <ty>> <v2>, <m x i32> <mask>    ; yields <m x <ty>>
class SHUFFLEInst : public Instruction {
public:
    SHUFFLEInst(NameRef name, const pVal &v1, const pVal &v2, const pConstI32Vec &mask);

    pVal getVector1() const;
    pVal getVector2() const;
    pConstI32Vec getMask() const;

    void accept(IRVisitor &visitor) override;

private:
    pVal cloneImpl() const override {
        return std::make_shared<SHUFFLEInst>(getName(), getVector1(), getVector2(), getMask());
    }
};
} // namespace IR

#endif