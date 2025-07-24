// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "mir/passes/transforms/isel.hpp"
#include "mir/tools.hpp"
#include <optional>

using namespace MIR;

OpC MIR::chooseCopyOpC(const MIROperand_p &dst, const MIROperand_p &src) {
    if (dst->isISA() && src->isImme()) {
        if (inRange(dst->type(), OpT::Int, OpT::Int64))
            return OpC::InstLoadImmToReg;
        else if (inRange(dst->type(), OpT::Float, OpT::Float32))
            return OpC::InstLoadFPImmToReg;
    } else if (dst->isISA() && src->isVReg()) {
        return OpC::InstCopyToReg;
    } else if (dst->isVReg() && src->isImme()) {
        if (src->isExImme())
            return OpC::InstLoadImmEx;
        else if (inRange(dst->type(), OpT::Int, OpT::Int64))
            return OpC::InstLoadImm;
        else if (inRange(dst->type(), OpT::Float, OpT::Float32))
            return OpC::InstLoadFPImm;
    } else if (dst->isVReg() && src->isISA()) {
        return OpC::InstCopyFromReg;
    } else if (dst->isVReg() && src->isVReg()) {
        if (inRange(dst->type(), OpT::Intvec2, OpT::Floatvec4)) {
            return OpC::InstVCopy;
        } else {
            return OpC::InstCopy;
        }
    } else if (dst->isVReg() && src->isStack()) {
        return OpC::InstCopyStkPtr;
    } else if (dst->isISA() && src->isStack()) {
        return OpC::InstCopyStkPtr;
    } else if (src->isLiteral()) {
        return OpC::InstLoadLiteral;
    } else {
        Err::unreachable("chooseCopyOpC: dont match any copy op");
    }
    return OpC::InstCopy; // just make clang happy
}

void ISelContext::impl(MIRFunction *mfunc) {
    auto &iselInfo = mCodeGenCtx.iselInfo;
    bool allowComplexPattern = false;
    bool tryOptLegal = false;

    while (true) {
        MIRInst_p minst_illegal_first = nullptr;

        ///@brief stage2: 构建表项
        bool modified = false;
        bool hasIllegal = false;
        mDelWorkList.clear();
        // mReplaceBlkWorkList.clear();
        mReplaceMap.clear();
        mConstantMap.clear(); // const val load inst map

        for (auto &mblk : mfunc->blks()) {
            for (auto &minst : mblk->Insts()) {
                ///@brief mConstantMap 添加常数 load 映射
                if (minst->isGeneric() && minst->opcode<OpC>() == OpC::InstLoadImm) {
                    auto &def = minst->ensureDef();
                    mConstantMap.emplace(def, minst);
                }
            }
        }

        ///@brief stage3: 模式匹配进行优化/合法化
        for (auto &mblk : mfunc->blks()) {
            mInstMap.clear();

            ///@note 填充mInstMap
            auto &minsts = mblk->Insts();
            for (auto &minst : minsts) {
                auto def = minst->getDef();

                if (def && def->isVReg()) {
                    mInstMap[def].emplace_back(minst);
                }
            }

            mCurrentBlk = mblk;

            if (minsts.empty()) {
                continue;
            }
            ///@note begin
            auto it = std::prev(minsts.end());
            while (true) {
                mInstInsertPos = it;
                auto &minst = *it;

                std::optional<MIRInst_p_l::iterator> prev = std::nullopt;
                if (it != minsts.begin()) {
                    prev = std::prev(it);
                }

                if (!mDelWorkList.count(minst)) {
                    auto isIllegal = minst->isGeneric() && iselInfo->isLegalGenericInst(minst);

                    if (isIllegal && !minst_illegal_first) {
                        ///@note 第一个不合法的Generic MIR
                        minst_illegal_first = minst;
                    }

                    hasIllegal |= isIllegal;

                    if ((tryOptLegal || isIllegal) && iselInfo->match(minst, *this, allowComplexPattern)) {
                        modified = true;
                        if (allowComplexPattern) {
                            break;
                        }
                    }

                    if (prev) { // not std::nullopt
                        it = *prev;
                    } else {
                        break;
                    }
                }
            }
        }

        ///@brief stage4: 将原operand进行替换

        for (auto &mblk : mfunc->blks()) {
            // remove old insts;
            mblk->Insts().remove_if([&](const MIRInst_p &minst) -> bool {
                if (mDelWorkList.count(minst)) {
                    minst->putAllOp(mCodeGenCtx);
                    return true;
                } else {
                    return false;
                }
            });

            // replace defs
            for (auto &minst : mblk->Insts()) {

                for (auto idx = 1U; idx <= minst->getUseNr(); ++idx) {
                    auto &use = minst->getOp(idx);

                    if (use && use->isReg() && mReplaceMap.count(use)) {
                        use = mReplaceMap.at(use);
                    }
                }

                auto &def = minst->getDef();

                if (def && def->isReg() && mReplaceMap.count(def)) {
                    def = mReplaceMap.at(def);
                }
            }
        }

        if (modified) {
            allowComplexPattern = false;
            continue;
        }

        ///@todo 打印替换信息

        if (!tryOptLegal) {
            tryOptLegal = true;
            continue;
        }

        ///@brief when not modified and trying opt legal, jump out the loop
        break;
    }

    return;
}

MIRInst_p_l ISelContext::getInsts() const { return mCurrentBlk->Insts(); }

MIRInst_p_l::iterator ISelContext::getCurrentPos() const { return mInstInsertPos; }

void ISelContext::delInst(MIRInst_p minst) { mDelWorkList.emplace(minst); }

void ISelContext::replaceOperand(const MIROperand_p &_old, const MIROperand_p &_new) {
    Err::gassert(_old->isReg() && _new->isReg(), "replaceOperand: not regs");

    if (_old != _new) {
        mReplaceMap.emplace(_old, _new);
    }
}

PM::PreservedAnalyses ISel::run(MIRFunction &mfunc, FAM &fam) {
    ISelContext isel(mfunc.Context());

    isel.impl(&mfunc);

    return PM::PreservedAnalyses::all();
}