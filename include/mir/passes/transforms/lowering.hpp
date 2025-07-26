// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#include "ir/type.hpp"
#include "ir/type_alias.hpp"
#include "mir/info.hpp"
#include "utils/exception.hpp"
#ifndef GNALC_MIR_BUILD_LOWERING_HPP
#define GNALC_MIR_BUILD_LOWERING_HPP

#include "ir/instructions/compare.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/live_analysis.hpp"
#include "ir/passes/pass_manager.hpp"
#include "mir/passes/pass_manager.hpp"
#include <memory>

namespace MIR {

using IRVal = IR::Value;
using IRVal_p = std::shared_ptr<IRVal>;
using IRInst = IR::Instruction;
using IRInst_p = std::shared_ptr<IRInst>;
using IRBlk = IR::BasicBlock;
using IRBlk_p = std::shared_ptr<IRBlk>;
using IRFunc = IR::Function;
using IRFunc_p = std::shared_ptr<IRFunc>;
using IRGlobal = IR::GlobalVariable;
using IRGlobal_p = std::shared_ptr<IRGlobal>;
using IRModule = IR::Module;
using IRModule_p = std::shared_ptr<IRModule>;

OpT btypeConvert(const IR::BType &);
unsigned typeBitwide(const IR::pType &);
OpC IROpCodeConvert(IR::OP);
OpC IROpCodeConvert_v(IR::OP);

Cond IRCondConvert(IR::ICMPOP);
Cond IRCondConvert(IR::FCMPOP);

// class FPConstantPool;

struct PhiOperPair {
    MIRBlk_p blk_dst;
    MIRBlk_p blk_src;
    std::vector<std::pair<MIROperand_p, MIROperand_p>> pairs; // op_dst, op_src
};

class LoweringContext {
private:
    MIRModule &mModule;
    CodeGenContext &mCodeGenCtx;
    std::map<IRBlk_p, MIRBlk_p> &mBlkMap;
    std::map<string, MIRGlobal_p> &mGlobalMap;
    // mFPLoadedConstantCache
    std::map<unsigned, MIROperand_p> mConstMap;
    std::map<uint64_t, MIROperand_p> mLConstMap;
    std::map<unsigned, MIROperand_p> mSpConstMap;
    std::map<IRVal_p, MIROperand_p> &mValMap; // isa, vreg

    std::vector<PhiOperPair> phiOpers;

    MIRBlk_p mCurrentBlk = nullptr;
    OpT mPtrType; // Int64 for armv8

public:
    LoweringContext() = delete;
    LoweringContext(MIRModule &module, CodeGenContext &codeGenCtx, std::map<IRBlk_p, MIRBlk_p> &blkMap,
                    std::map<string, MIRGlobal_p> &globalMap, std::map<IRVal_p, MIROperand_p> &valMap) noexcept;

    CodeGenContext &CodeGenCtx() { return mCodeGenCtx; }

    MIRModule &Module() { return mModule; }
    [[nodiscard]] const MIRModule &Module() const { return mModule; }

    auto &BlkMap() { return mBlkMap; }
    [[nodiscard]] const auto &BlkMap() const { return mBlkMap; }
    [[nodiscard]] MIRBlk_p mapBlk(const IRBlk_p &) const;

    auto &GlobalMap() { return mGlobalMap; }
    [[nodiscard]] const auto &GlobalMap() const { return mGlobalMap; }
    [[nodiscard]] MIRGlobal_p mapGlobal(const string &) const;

    auto &ValMap() { return mValMap; }
    [[nodiscard]] const auto &ValMap() const { return mValMap; }
    MIROperand_p mapOperand(const IRVal_p &); // not const to fit as a constpool
    template <typename T> MIROperand_p mapOperand(T imme) {
        Err::gassert(std::is_same_v<T, int> || std::is_same_v<T, float> || std::is_same_v<T, int64_t> ||
                         std::is_same_v<T, Cond>,
                     "mapOperand: try mapping an unknown type const");

        ///@warning dont add cond to constMap, not necessary
        if constexpr (std::is_same_v<T, Cond>) {
            MIROperand_p mconst = MIROperand::asImme<T>(imme, OpT::CondFlag);
            return mconst;
        }

        MIROperand_p mconst = nullptr;

        /// LAMBDA BEGIN
        auto make_new = [&]() {
            if constexpr (std::is_same_v<T, int>) {
                mconst = MIROperand::asImme<T>(imme, OpT::Int32);
                auto bit32_imme_idx = *reinterpret_cast<unsigned *>(&imme);
                mConstMap.emplace(bit32_imme_idx, mconst);
            } else if constexpr (std::is_same_v<T, int64_t>) {
                mconst = MIROperand::asImme<T>(imme, OpT::Int64);
                auto bit64_imme_idx = *reinterpret_cast<uint64_t *>(&imme);
                mLConstMap.emplace(bit64_imme_idx, mconst);
            } else if constexpr (std::is_same_v<T, float>) {
                mconst = MIROperand::asImme<T>(imme, OpT::Float32);
                auto bit32_imme_idx = *reinterpret_cast<unsigned *>(&imme);
                mSpConstMap.emplace(bit32_imme_idx, mconst);
            }

            return mconst;
        };
        /// LAMBDA END

        if constexpr (std::is_same_v<T, int>) {
            auto bit32_imme_idx = *reinterpret_cast<unsigned *>(&imme);

            return mConstMap.count(bit32_imme_idx) ? mConstMap.at(bit32_imme_idx) : make_new();
        } else if constexpr (std::is_same_v<T, float>) {
            auto bit32_imme_idx = *reinterpret_cast<unsigned *>(&imme);
            return mSpConstMap.count(bit32_imme_idx) ? mSpConstMap.at(bit32_imme_idx) : make_new();
        } else if constexpr (std::is_same_v<T, int64_t>) {
            auto bit64_imme_idx = *reinterpret_cast<uint64_t *>(&imme);
            return mLConstMap.count(bit64_imme_idx) ? mLConstMap.at(bit64_imme_idx) : make_new();
        }

        Err::unreachable("mapOperand failed");

        return nullptr; // just make clang happy
    }

    void setCurrentBlk(MIRBlk_p blk) { mCurrentBlk = std::move(blk); }
    auto &CurrentBlk() { return mCurrentBlk; }

    MIROperand_p newVReg(const std::shared_ptr<IR::Type> &);
    MIROperand_p newVReg(const IR::BType &);
    MIROperand_p newVReg(const IR::PtrType &);
    MIROperand_p newVReg(const IR::ArrayType &);
    MIROperand_p newVReg(const IR::VectorType &);
    MIROperand_p newVReg(const OpT &);

    MIROperand_p newLiteral(string liter, size_t size, size_t align, OpT type);

    // add to literal pool later and manually
    MIROperand_p newLiteral_no_add(string liter, size_t size, size_t align, OpT type);

    void newInst(const MIRInst_p &);
    void addCopy(MIROperand_p dst, MIROperand_p src);
    void addInstBeforeBr(const MIRInst_p_l &);
    void addInstBeforeBr(const MIRInst_p &);

    void addPhiOpers(PhiOperPair &pairs) { phiOpers.emplace_back(pairs); }
    void elimPhi();

    MIRBlk_p addBlkAfter();

    void addOperand(const IRVal_p &, const MIROperand_p &);

    ~LoweringContext() = default;
};

///@note implement entry
MIRModule_p loweringModule(const IRModule &module, CodeGenContext &ctx);

MIRGlobal_p loweringGlobal(const IR::GlobalVariable &);

void loweringFunction(MIRFunction_p, IRFunc_p, CodeGenContext &, MIRModule &, std::map<string, MIRGlobal_p>);

void lowerInst(const IR::pInst &, LoweringContext &);
void lowerInst_v(const IR::pInst &, LoweringContext &);
// more detially
void lowerInst(const IR::pBinary &, LoweringContext &);
void lowerInst(const IR::pFneg &, LoweringContext &);
void lowerInst(const IR::pIcmp &, LoweringContext &);
void lowerInst(const IR::pFcmp &, LoweringContext &);
void lowerInst(const IR::pRet &, LoweringContext &);
void lowerInst(const IR::pBr &, LoweringContext &);
void lowerInst(const IR::pLoad &, LoweringContext &, size_t);
void lowerInst(const IR::pStore &, LoweringContext &, size_t);
void lowerInst(const IR::pCast &, LoweringContext &); // copy
void lowerInst(const IR::pGep &, LoweringContext &);
void lowerInst(const IR::pCall &, LoweringContext &);
void lowerInst(const IR::pSelect &, LoweringContext &);

// helpr vectorflating to literal
inline auto vector2literal(const IR::pVal &ir_vector) {
    string literal = "";
    size_t size = 0;
    OpT type;

    if (auto const_vec_i32 = ir_vector->as<IR::ConstantIntVector>()) {
        for (auto elem : const_vec_i32->getVector()) {
            literal = hex_str(elem).append(literal);
            size += 4;
        }

        size == 8 ? type = OpT::Intvec2 : type = OpT::Intvec4;

    } else if (auto const_vec_f32 = ir_vector->as<IR::ConstantFloatVector>()) {
        for (auto elem : const_vec_f32->getVector()) {
            auto elem_i3e = *reinterpret_cast<unsigned *>(&elem);

            literal = hex_str(elem_i3e).append(literal);
            size += 4;
        }

        size == 8 ? type = OpT::Floatvec2 : type = OpT::Floatvec4;
    } else {
        Err::unreachable("vector2literal: unknown const vector");
    }

    literal = "0X" + literal;

    return std::make_tuple(literal, size, type);
}
MIROperand_p vector_flatting(const IR::pVal &, LoweringContext &);
MIROperand_p try_vector_flatting(const IR::pVal &, LoweringContext &);

// vector lowering
void lowerInst_v(const IR::pInsert &, LoweringContext &);
void lowerInst_v(const IR::pExtract &, LoweringContext &);
void lowerInst_v(const IR::pBinary &, LoweringContext &);
void lowerInst_v(const IR::pFneg &, LoweringContext &);
void lowerInst_v(const IR::pIcmp &, LoweringContext &);
void lowerInst_v(const IR::pFcmp &, LoweringContext &);
void lowerInst_v(const IR::pLoad &, LoweringContext &);
void lowerInst_v(const IR::pStore &, LoweringContext &);
void lowerInst_v(const IR::pCast &, LoweringContext &); // copy
void lowerInst_v(const IR::pGep &, LoweringContext &);
void lowerInst_v(const IR::pSelect &, LoweringContext &);
}; // namespace MIR

#endif