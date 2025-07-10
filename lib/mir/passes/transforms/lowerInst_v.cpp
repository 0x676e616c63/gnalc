// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/constant.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/vector.hpp"
#include "ir/type_alias.hpp"
#include "mir/MIR.hpp"
#include "mir/passes/transforms/isel.hpp"
#include "mir/passes/transforms/lowering.hpp"
#include "utils/exception.hpp"

using namespace MIR;

OpC MIR::IROpCodeConvert_v(IR::OP op) {
    using OP = IR::OP;
    switch (op) {
    case OP::RET:
    case OP::ALLOCA:
    case OP::BR:
        Err::unreachable("IROpCodeConvert_v: op not expecteed");
    case OP::FNEG:
        return OpC::InstVFNeg;
    case OP::ADD:
        return OpC::InstVAdd;
    case OP::FADD:
        return OpC::InstVFAdd;
    case OP::SUB:
        return OpC::InstVSub;
    case OP::FSUB:
        return OpC::InstVFSub;
    case OP::MUL:
        return OpC::InstVMul;
    case OP::FMUL:
        return OpC::InstVFMul;
    case OP::DIV:
        return OpC::InstVSDiv;
    case OP::FDIV:
        return OpC::InstVFDiv;
    case OP::SREM:
        return OpC::InstVSRem;
    case OP::UREM:
        return OpC::InstVURem;
    case OP::FREM:
        return OpC::InstVFRem;
    case OP::AND:
        return OpC::InstVAnd;
    case OP::XOR:
        return OpC::InstVXor;
    case OP::OR:
        return OpC::InstVOr;
    case OP::ASHR:
        return OpC::InstVAShr;
    case OP::LSHR:
        return OpC::InstVLShr;
    case OP::SHL:
        return OpC::InstVShl;
    case OP::LOAD:
        Err::unreachable("IROpCodeConvert_v: LOAD should not be convert");
    case OP::STORE:
        Err::unreachable("IROpCodeConvert_v: STORE should not be convert");
    case OP::GEP:
        Err::unreachable("IROpCodeConvert_v: GEP should not be convert");
    case OP::FPTOSI:
        return OpC::InstVFP2SI;
    case OP::SITOFP:
        return OpC::InstVSI2FP;
    case OP::ZEXT:
    case OP::BITCAST:
        return OpC::InstCopy;
    case OP::PHI:
        Err::unreachable("IROpCodeConvert_v: PHI should not be convert");
    case OP::HELPER:
        Err::unreachable("IROpCodeConvert_v: HELPER should not be convert");
    default:
        Err::unreachable("IROpCodeConver_vt: op should be handled manully");
    }
}

void MIR::lowerInst_v(const IR::pExtract &extract, LoweringContext &ctx) {
    auto def = ctx.newVReg(extract->getType());

    if (ctx.CodeGenCtx().isARMv8()) {
        auto idx = ctx.mapOperand(extract->getIdx());

        Err::gassert(idx->isImme(), "lowerInst_v: try insert/extract with a variable idx");

        ctx.newInst(MIRInst::make(OpC::InstVExtract)
                        ->setOperand<0>(def, ctx.CodeGenCtx())
                        ->setOperand<1>(idx, ctx.CodeGenCtx())
                        ->setOperand<2>(ctx.mapOperand(extract->getVector()), ctx.CodeGenCtx()));

    } else if (ctx.CodeGenCtx().isRISCV64()) {
        Err::todo("");
    }

    ctx.addOperand(extract, def);
}

void MIR::lowerInst_v(const IR::pInsert &insert, LoweringContext &ctx) {
    if (ctx.CodeGenCtx().isARMv8()) {

        auto def = insert->getVector()->as<IR::ConstantIntVector>()
                       ? ctx.newVReg(insert->getType())
                       : ctx.mapOperand(insert->getVector()); // if poison or not

        auto idx = ctx.mapOperand(insert->getIdx());

        Err::gassert(idx->isImme(), "lowerInst_v: try insert/extract with a variable idx");

        ctx.newInst(MIRInst::make(OpC::InstVInsert)
                        ->setOperand<0>(def, ctx.CodeGenCtx())
                        ->setOperand<1>(idx, ctx.CodeGenCtx())
                        ->setOperand<2>(ctx.mapOperand(insert->getElm()), ctx.CodeGenCtx()));

        ctx.addOperand(insert, def); // n map to 1

    } else if (ctx.CodeGenCtx().isRISCV64()) {
        Err::todo("");
    }
}

void MIR::lowerInst_v(const IR::pBinary &binary, LoweringContext &ctx) {
    auto mop = IROpCodeConvert_v(binary->getOpcode());
    auto def = ctx.newVReg(binary->getType());

    if (ctx.CodeGenCtx().isARMv8()) {

        Err::gassert(
            !inSet(mop, OpC::InstVSDiv, OpC::InstVUDiv, OpC::InstVSRem, OpC::InstVURem, OpC::InstVLShr, OpC::InstVAShr),
            "lowerInst_v: armv8 Neon vector dont support this op");

    } else if (ctx.CodeGenCtx().isRISCV64()) {
        Err::todo("");
    }

    ctx.newInst(MIRInst::make(mop)
                    ->setOperand<0>(def, ctx.CodeGenCtx())
                    ->setOperand<1>(ctx.mapOperand(binary->getLHS()), ctx.CodeGenCtx())
                    ->setOperand<2>(ctx.mapOperand(binary->getRHS()), ctx.CodeGenCtx())); // 可能带常数

    ctx.addOperand(binary, def);
}

void MIR::lowerInst_v(const IR::pFneg &fneg, LoweringContext &ctx) {
    if (ctx.CodeGenCtx().isARMv8()) {
        lowerInst(fneg, ctx);
    } else if (ctx.CodeGenCtx().isRISCV64()) {
        Err::todo("");
    }
}

void MIR::lowerInst_v(const IR::pIcmp &icmp, LoweringContext &ctx) {
    // def <cond> op1, op2

    auto def = ctx.newVReg(icmp->getType());

    if (ctx.CodeGenCtx().isARMv8()) {
        ctx.newInst(MIRInst::make(OpC::InstVIcmp)
                        ->setOperand<0>(def, ctx.CodeGenCtx())
                        ->setOperand<1>(ctx.mapOperand(IRCondConvert(icmp->getCond())), ctx.CodeGenCtx())
                        ->setOperand<2>(ctx.mapOperand(icmp->getLHS()), ctx.CodeGenCtx())
                        ->setOperand<3>(ctx.mapOperand(icmp->getRHS()), ctx.CodeGenCtx()));

    } else if (ctx.CodeGenCtx().isRISCV64()) {
        Err::todo("");
    }

    ctx.addOperand(icmp, def);
}

void MIR::lowerInst_v(const IR::pFcmp &fcmp, LoweringContext &ctx) {
    // def <cond> op1, op2

    auto def = ctx.newVReg(fcmp->getType());

    if (ctx.CodeGenCtx().isARMv8()) {
        ctx.newInst(MIRInst::make(OpC::InstVIcmp)
                        ->setOperand<0>(def, ctx.CodeGenCtx())
                        ->setOperand<1>(ctx.mapOperand(IRCondConvert(fcmp->getCond())), ctx.CodeGenCtx())
                        ->setOperand<2>(ctx.mapOperand(fcmp->getLHS()), ctx.CodeGenCtx())
                        ->setOperand<3>(ctx.mapOperand(fcmp->getRHS()), ctx.CodeGenCtx()));

    } else if (ctx.CodeGenCtx().isRISCV64()) {
        Err::todo("");
    }

    ctx.addOperand(fcmp, def);
}

void MIR::lowerInst_v(const IR::pLoad &load, LoweringContext &ctx) {
    if (ctx.CodeGenCtx().isARMv8()) {
        lowerInst(load, ctx);
    } else if (ctx.CodeGenCtx().isRISCV64()) {
        Err::todo("");
    }
}

void MIR::lowerInst_v(const IR::pStore &store, LoweringContext &ctx) {
    if (ctx.CodeGenCtx().isARMv8()) {
        lowerInst(store, ctx);
    } else if (ctx.CodeGenCtx().isRISCV64()) {
        Err::todo("");
    }
}

void MIR::lowerInst_v(const IR::pCast &cast, LoweringContext &ctx) {
    auto def = ctx.newVReg(cast->getType());

    using OP = IR::OP;

    if (cast->getOpcode() == OP::SITOFP) {
        ctx.newInst(MIRInst::make(OpC::InstVSI2FP)
                        ->setOperand<0>(def, ctx.CodeGenCtx())
                        ->setOperand<1>(ctx.mapOperand(cast->getOVal()), ctx.CodeGenCtx()));
    } else if (cast->getOpcode() == OP::FPTOSI) {
        ctx.newInst(MIRInst::make(OpC::InstVFP2SI)
                        ->setOperand<0>(def, ctx.CodeGenCtx())
                        ->setOperand<1>(ctx.mapOperand(cast->getOVal()), ctx.CodeGenCtx()));
    } else {
        ctx.addCopy(def, ctx.mapOperand(cast->getOVal()));
    }

    ctx.addOperand(cast, def);
}

void MIR::lowerInst_v(const IR::pGep &gep, LoweringContext &ctx) {
    if (ctx.CodeGenCtx().isARMv8()) {
        lowerInst(gep, ctx);
    } else if (ctx.CodeGenCtx().isRISCV64()) {
        Err::todo("");
    }
}

void MIR::lowerInst_v(const IR::pSelect &select, LoweringContext &ctx) {
    auto def = ctx.newVReg(select->getType());

    if (ctx.CodeGenCtx().isARMv8()) {
        // in bsl (select inst in aarch64), def is a use and a def

        ctx.addCopy(def, ctx.mapOperand(select->getCond()));
        ctx.newInst(MIRInst::make(OpC::InstVSelect)
                        ->setOperand<0>(def, ctx.CodeGenCtx())
                        ->setOperand<1>(ctx.mapOperand(select->getTrueVal()), ctx.CodeGenCtx())
                        ->setOperand<2>(ctx.mapOperand(select->getFalseVal()), ctx.CodeGenCtx()));
    } else if (ctx.CodeGenCtx().isRISCV64()) {
        Err::todo("");
    }

    ctx.addOperand(select, def);
}