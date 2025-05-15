#pragma once
#ifndef GNALC_ARMV8_MIR_BUILD_LOWERING_HPP
#define GNALC_ARMV8_MIR_BUILD_LOWERING_HPP

#include "ir/instructions/compare.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/live_analysis.hpp"
#include "ir/passes/pass_manager.hpp"
#include "mir/passes/pass_manager.hpp"
#include <memory>

namespace MIR_new {

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
        Err::gassert(std::is_same_v<T, int> || std::is_same_v<T, float> || std::is_same_v<T, Cond>,
                     "mapOperand: try mapping an unknown type const");

        ///@warning dont add cond to constMap, not necessary
        if constexpr (std::is_same_v<T, Cond>) {
            MIROperand_p mconst = MIROperand::asImme<T>(imme, OpT::CondFlag);
            return mconst;
        }

        auto imme_idx = static_cast<unsigned>(imme);

        MIROperand_p mconst = nullptr;

        //
        auto make_new = [&]() {
            if constexpr (std::is_same_v<T, int>) {
                mconst = MIROperand::asImme<T>(imme, OpT::Int32);
            } else if constexpr (std::is_same_v<T, float>) {
                mconst = MIROperand::asImme<T>(imme, OpT::Float32);
            }
            mConstMap.emplace(imme_idx, mconst);

            return mconst;
        };
        //

        if (!mConstMap.count(imme_idx)) {
            return make_new();
        } else {
            mconst = mConstMap.at(imme_idx);

            if constexpr (std::is_same_v<T, int>) {
                if (mconst->type() != OpT::Int32) {
                    return make_new();
                }
            } else if constexpr (std::is_same_v<T, float>) {
                if (mconst->type() != OpT::Float32) {
                    return make_new();
                }
            }

            return mconst;
        }
        //
    }

    void setCurrentBlk(MIRBlk_p blk) { mCurrentBlk = std::move(blk); }
    auto &CurrentBlk() { return mCurrentBlk; }

    MIROperand_p newVReg(const std::shared_ptr<IR::Type> &);
    MIROperand_p newVReg(const IR::BType &);
    MIROperand_p newVReg(const IR::PtrType &);
    MIROperand_p newVReg(const IR::ArrayType &);
    MIROperand_p newVReg(const IR::VectorType &);
    MIROperand_p newVReg(const OpT &);

    void newInst(const MIRInst_p &);
    void addCopy(const MIROperand_p &dst, const MIROperand_p &src);
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

// more detially
void lowerInst(const IR::pBinary &, LoweringContext &);
// void lowerInst(IR::pBinary, LoweringContext &, IR::DomTreeAnalysis::Result &,
//                IR::LiveAnalysis::Result &); // sdiv / srem
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

}; // namespace MIR_new

#endif