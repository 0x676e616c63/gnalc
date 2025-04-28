#include "mir/passes/transforms/isel.hpp"
#include <algorithm>
#include <optional>

using namespace MIR_new;

OpC MIR_new::chooseCopyOpC(const MIROperand_p &dst, const MIROperand_p &src) {
    if (dst->isISA() && src->isImme()) {
        return OpC::InstLoadImmToReg;
    } else if (dst->isISA() && src->isVReg()) {
        return OpC::InstCopyToReg;
    } else if (dst->isVReg() && src->isImme()) {
        return OpC::InstLoadImm;
    } else if (dst->isVReg() && src->isISA()) {
        return OpC::InstCopyFromReg;
    } else if (dst->isVReg() && src->isVReg()) {
        return OpC::InstCopy;
    }
}

///@note 关键是 iselInfo.matchAndSelect
///@todo 现阶段没有matchOpt的情况下, 基本上没有replace
void ISelContext::impl(MIRFunction_p mfunc) {
    auto &iselInfo = mCodeGenCtx.iselInfo;
    bool allowComplexPattern = false;
    bool tryOptLegal = false;

    while (true) {
        MIRInst_p minst_illegal_first = nullptr;

        ///@brief stage1: 简单优化

        ///@todo include "peephole.hpp"
        ///@todo removeUnusedInsts()
        ///@todo genericPeepholeOpt()

        ///@brief stage2: 构建表项
        bool modified = false;
        bool hasIllegal = false;
        mDelWorkList.clear();
        // mReplaceBlkWorkList.clear();
        mReplaceMap.clear();
        mConstantMap.clear(); // const val load inst map
        mUseCnt.clear();

        for (auto &mblk : mfunc->blks()) {

            for (auto &minst : mblk->Insts()) {
                ///@brief mCounstantMap 添加常数load映射
                if (minst->isGeneric() && minst->opcode<OpC>() == OpC::InstLoadImm) {
                    auto &def = minst->ensureDef();
                    mConstantMap.emplace(def, minst);
                }

                ///@brief mUseCount添加引用计数
                for (int i = 1; i - 1 < minst->getUseNr(); ++i) {
                    auto mop = minst->getOp(i);

                    if (mop->isVReg()) {
                        if (!mUseCnt.count(mop)) {
                            mUseCnt[mop] = 1;
                        } else {
                            ++mUseCnt[mop];
                        }
                    }
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
                    auto isIllegal = minst->isGeneric() && iselInfo.isLegalGenericInst(minst);

                    if (isIllegal && !minst_illegal_first) {
                        ///@note 第一个不合法的Generic MIR
                        minst_illegal_first = minst;
                    }

                    hasIllegal |= isIllegal;

                    ///@note 尝试模式匹配更换MIR(重点)
                    if ((tryOptLegal || isIllegal) &&
                        iselInfo.matchAndSel(minst, *this, allowComplexPattern)) { // allow is passed by value
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
            mblk->Insts().remove_if([&](const MIRInst_p &minst) -> bool { return mDelWorkList.count(minst); });

            // replace defs
            for (auto &minst : mblk->Insts()) {

                // if (mReplaceBlkWorkList.count(minst)) {
                //     continue;
                // }

                for (auto idx = 1U; idx <= minst->getUseNr(); ++idx) {
                    auto &use = minst->getOp(idx);

                    if (use->isReg() && mReplaceMap.count(use)) {
                        use = mReplaceMap.at(use);
                    }
                }

                auto &def = minst->getDef();

                if (def->isReg() && mReplaceMap.count(def)) {
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

MIRInst_p ISelContext::newInst(OpC mopcode) {
    auto minst = MIRInst::make(mopcode);

    mCurrentBlk->Insts().insert(mInstInsertPos, minst);

    return minst;
}

bool ISelContext::notUsed(const MIROperand_p &mop) const {
    return mUseCnt.count(mop) == 0; //
}

bool ISelContext::singleUsed(const MIROperand_p &mop) const {
    return mUseCnt.find(mop) != mUseCnt.end() && mUseCnt.at(mop) == 1; //
}

bool ISelContext::notMultiUsed(const MIROperand_p &mop) const {
    return notUsed(mop) || singleUsed(mop); //
}

///@brief
MIRInst_p_l ISelContext::lookforDef(const MIROperand_p &mop) const {

    if (mop->isImme()) {
        auto it = mConstantMap.find(mop);

        if (it == mConstantMap.end()) {
            return {};
        } else {
            return {it->second};
        }
    } else {
        auto it = mInstMap.find(mop);

        if (it == mInstMap.end()) {
            return {};
        } else {
            return it->second;
        }
    }
}

MIRInst_p_l ISelContext::getInsts() const { return mCurrentBlk->Insts(); }

MIRInst_p_l::iterator ISelContext::getCurrentPos() const { return mInstInsertPos; }

void ISelContext::delInst(MIRInst_p minst) {
    auto minsts = mCurrentBlk->Insts();
    auto it = std::find(minsts.begin(), minsts.end(), minst);
    minsts.erase(it);
}

void ISelContext::replaceOperand(const MIROperand_p &_old, const MIROperand_p &_new) {
    Err::gassert(_old->isReg() && _new->isReg(), "replaceOperand: not regs");

    if (_old != _new) {
        mReplaceMap.emplace(_old, _new);
    }
}
