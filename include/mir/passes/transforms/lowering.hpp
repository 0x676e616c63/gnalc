#pragma once
#ifndef GNALC_ARMV8_MIR_BUILD_LOWERING_HPP
#define GNALC_ARMV8_MIR_BUILD_LOWERING_HPP

#include "ir/instructions/compare.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/live_analysis.hpp"
#include "ir/passes/pass_manager.hpp"
#include "mir/MIR.hpp"
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

// 中端类型转为后端类型, 虽然放在这里有些突兀
OpT btypeConvert(const IR::BType &);
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
    const MIRModule &Module() const { return mModule; }

    auto &BlkMap() { return mBlkMap; }
    const auto &BlkMap() const { return mBlkMap; }
    MIRBlk_p mapBlk(const IRBlk_p &) const;

    auto &GlobalMap() { return mGlobalMap; }
    const auto &GlobalMap() const { return mGlobalMap; }
    MIRGlobal_p mapGlobal(const string &) const;

    auto &ValMap() { return mValMap; }
    const auto &ValMap() const { return mValMap; }
    MIROperand_p mapOperand(const IRVal_p &); // not const to fit as a constpool
    template <typename T> MIROperand_p mapOperand(T imme) {
        Err::gassert(std::is_same_v<T, int> || std::is_same_v<T, float> || std::is_same_v<T, Cond>,
                     "mapOperand: try mapping an unknown type const");
        auto imme_idx = static_cast<unsigned>(imme);

        auto mconst = mConstMap.at(imme_idx);

        if (!mconst) {
            mconst = MIROperand::asImme<T>(imme);
            mConstMap.emplace(imme_idx, mconst);
        }

        return mconst;
    }

    void setCurrentBlk(MIRBlk_p blk) { mCurrentBlk = std::move(blk); }
    auto &CurrentBlk() { return mCurrentBlk; }

    MIROperand_p newVReg(const std::shared_ptr<IR::Type> &);
    MIROperand_p newVReg(const IR::BType &);
    MIROperand_p newVReg(const IR::PtrType &);
    MIROperand_p newVReg(const IR::ArrayType &);
    MIROperand_p newVReg(const IR::VectorType &);
    MIROperand_p newVReg(const OpT &);

    void emitInst(const MIRInst_p &);
    void emitCopy(const MIROperand_p &dst, const MIROperand_p &src);
    void emitInstBeforeBr(const MIRInst_p_l &);
    void emitInstBeforeBr(const MIRInst_p &);

    void addPhiOpers(PhiOperPair &pairs) { phiOpers.emplace_back(pairs); }
    void emitPhi();

    MIRBlk_p addBlkAfter();

    void addOperand(const IRVal_p &, const MIROperand_p &);

    ~LoweringContext() = default;
};

MIRModule &loweringModule(const IRModule_p &module, CodeGenContext &ctx, IR::FAM &);

MIRGlobal_p loweringGlobal(const IR::GlobalVariable &);

void loweringFunction(MIRFunction_p, IRFunc_p, CodeGenContext &, MIRModule &, std::map<string, MIRGlobal_p>, IR::FAM &);

void lowerInst(IR::pInst &, LoweringContext &, IR::DomTreeAnalysis::Result &, IR::LiveAnalysis::Result &);

// more detially
void lowerInst(IR::pBinary, LoweringContext &);
void lowerInst(IR::pBinary, LoweringContext &, IR::DomTreeAnalysis::Result &,
               IR::LiveAnalysis::Result &); // sdiv / srem
void lowerInst(IR::pFneg, LoweringContext &);
void lowerInst(IR::pIcmp, LoweringContext &);
void lowerInst(IR::pFcmp, LoweringContext &);
void lowerInst(IR::pRet, LoweringContext &);
void lowerInst(IR::pBr, LoweringContext &);
void lowerInst(IR::pLoad, LoweringContext &, size_t);
void lowerInst(IR::pStore, LoweringContext &, size_t);
void lowerInst(IR::pCast, LoweringContext &); // copy
void lowerInst(IR::pGep, LoweringContext &);
void lowerInst(IR::pCall, LoweringContext &);

}; // namespace MIR_new

#endif