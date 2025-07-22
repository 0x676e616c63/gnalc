// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/base.hpp"
#include "ir/constant.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/vector.hpp"
#include "ir/type.hpp"
#include "ir/type_alias.hpp"
#include "mir/MIR.hpp"
#include "mir/armv8/base.hpp"
#include "mir/info.hpp"
#include "mir/passes/transforms/isel.hpp"
#include "mir/passes/transforms/lowering.hpp"
#include "mir/tools.hpp"
#include "utils/exception.hpp"
#include <charconv>
#include <cstddef>
#include <iostream>
#include <optional>
#include <tuple>

using namespace MIR;

MIROperand_p MIR::vector_flatting(const IR::pVal &ir_vector, LoweringContext &ctx) {

    auto [literal, size, type] = vector2literal(ir_vector);

    auto liter_op = ctx.newLiteral(literal, size, 16, type);
    MIROperand_p load_op = ctx.newVReg(type);

    ctx.newInst(MIRInst::make(OpC::InstLoadLiteral)
                    ->setOperand<0>(load_op, ctx.CodeGenCtx())
                    ->setOperand<1>(liter_op, ctx.CodeGenCtx()));

    return load_op;
}

MIROperand_p MIR::try_vector_flatting(const IR::pVal &ir_vector, LoweringContext &ctx) {
    string literal = "";
    MIROperand_p load_op = nullptr;

    if (ir_vector->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL) {
        load_op = vector_flatting(ir_vector, ctx);
    } else {
        load_op = ctx.mapOperand(ir_vector);
    }

    return load_op;
}

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

    auto is_const_vector = [&](const IR::pVal &vec) {
        if (vec->as<IR::ConstantIntVector>() || vec->as<IR::ConstantFloatVector>()) {
            return true;
        }
        return false;
    };

    auto is_all_zero_vector = [&](const IR::pVal &vec) {
        if (!vec->as<IR::ConstantIntVector>() && !vec->as<IR::ConstantFloatVector>()) {
            return false;
        }

        if (auto int_vec = vec->as<IR::ConstantIntVector>()) {
            for (const auto &elem : int_vec->getVector()) {
                if (elem) {
                    return false;
                }
            }
        } else if (auto float_vec = vec->as<IR::ConstantFloatVector>()) {
            for (const auto &elem : float_vec->getVector()) {
                if (elem != 0.0) {
                    return false;
                }
            }
        }

        return true;
    };

    if (ctx.CodeGenCtx().isARMv8()) {

        MIROperand_p def, use;
        auto idx = ctx.mapOperand(insert->getIdx());

        Err::gassert(insert->getIdx()->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL,
                     "lowerInst_v: try insert/extract with a variable idx");

        if (is_const_vector(insert->getVector())) {
            // poison & clear

            if (idx->imme() == 0 && is_all_zero_vector(insert->getVector())) {
                def = ctx.newVReg(insert->getType()), use = nullptr;
            } else if (is_all_zero_vector(insert->getVector())) {
                def = ctx.newVReg(insert->getType()), use = nullptr;
                ctx.newInst(MIRInst::make(ARMOpC::MOVI)
                                ->setOperand<0>(def, ctx.CodeGenCtx())
                                ->setOperand<1>(ctx.mapOperand(0L), ctx.CodeGenCtx()));
            } else {
                def = vector_flatting(insert->getVector(), ctx);
                use = nullptr;
            }

        } else {
            def = ctx.mapOperand(insert->getVector()), use = def;
        }

        // avoid use xzr/wzr

        ctx.newInst(MIRInst::make(OpC::InstVInsert)
                        ->setOperand<0>(def, ctx.CodeGenCtx())
                        ->setOperand<1>(idx, ctx.CodeGenCtx())
                        ->setOperand<2>(ctx.mapOperand(insert->getElm()), ctx.CodeGenCtx())
                        ->setOperand<3>(use, ctx.CodeGenCtx())); // this use is only to provide infos

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
                    ->setOperand<1>(try_vector_flatting(binary->getLHS(), ctx), ctx.CodeGenCtx())
                    ->setOperand<2>(try_vector_flatting(binary->getRHS(), ctx), ctx.CodeGenCtx())); // 可能带常数

    ctx.addOperand(binary, def);
}

void MIR::lowerInst_v(const IR::pFneg &fneg, LoweringContext &ctx) {
    if (ctx.CodeGenCtx().isARMv8()) {
        auto def = ctx.newVReg(fneg->getType());

        ctx.newInst(MIRInst::make(OpC::InstFNeg)
                        ->setOperand<0>(def, ctx.CodeGenCtx())
                        ->setOperand<1>(try_vector_flatting(fneg->getVal(), ctx), ctx.CodeGenCtx()));

        ctx.addOperand(fneg, def);
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
                        ->setOperand<2>(try_vector_flatting(icmp->getLHS(), ctx), ctx.CodeGenCtx())
                        ->setOperand<3>(try_vector_flatting(icmp->getRHS(), ctx), ctx.CodeGenCtx()));

    } else if (ctx.CodeGenCtx().isRISCV64()) {
        Err::todo("");
    }

    ctx.addOperand(icmp, def);
}

void MIR::lowerInst_v(const IR::pFcmp &fcmp, LoweringContext &ctx) {
    // def <cond> op1, op2

    auto def = ctx.newVReg(fcmp->getType());

    if (ctx.CodeGenCtx().isARMv8()) {
        ctx.newInst(MIRInst::make(OpC::InstVFcmp)
                        ->setOperand<0>(def, ctx.CodeGenCtx())
                        ->setOperand<1>(ctx.mapOperand(IRCondConvert(fcmp->getCond())), ctx.CodeGenCtx())
                        ->setOperand<2>(try_vector_flatting(fcmp->getLHS(), ctx), ctx.CodeGenCtx())
                        ->setOperand<3>(try_vector_flatting(fcmp->getRHS(), ctx), ctx.CodeGenCtx()));

    } else if (ctx.CodeGenCtx().isRISCV64()) {
        Err::todo("");
    }

    ctx.addOperand(fcmp, def);
}

void MIR::lowerInst_v(const IR::pLoad &load, LoweringContext &ctx) {
    if (ctx.CodeGenCtx().isARMv8()) {
        lowerInst(load, ctx, load->getAlign());
    } else if (ctx.CodeGenCtx().isRISCV64()) {
        Err::todo("");
    }
}

void MIR::lowerInst_v(const IR::pStore &store, LoweringContext &ctx) {
    if (ctx.CodeGenCtx().isARMv8()) {
        if (auto load_op = try_vector_flatting(store->getValue(), ctx)) {

            ctx.newInst(
                MIRInst::make(OpC::InstStore)
                    ->setOperand<0>(nullptr, ctx.CodeGenCtx())
                    ->setOperand<1>(load_op, ctx.CodeGenCtx())
                    ->setOperand<2>(ctx.mapOperand(store->getPtr()), ctx.CodeGenCtx())
                    // ->setOperand<5>(MIROperand::asImme(store->getAlign(), OpT::special), ctx.CodeGenCtx()));
                    ->setOperand<5>(MIROperand::asImme(getBitWide(load_op->type()), OpT::special), ctx.CodeGenCtx()));
        } else {
            lowerInst(store, ctx, store->getAlign());
        }
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
                        ->setOperand<1>(try_vector_flatting(select->getTrueVal(), ctx), ctx.CodeGenCtx())
                        ->setOperand<2>(try_vector_flatting(select->getFalseVal(), ctx), ctx.CodeGenCtx()));
    } else if (ctx.CodeGenCtx().isRISCV64()) {
        Err::todo("");
    }

    ctx.addOperand(select, def);
}