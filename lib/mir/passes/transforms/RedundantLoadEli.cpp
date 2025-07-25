// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "mir/passes/transforms/RedundantLoadEli.hpp"
#include "mir/info.hpp"
#include "mir/passes/analysis/domtree_analysis.hpp"
#include "mir/passes/transforms/isel.hpp"
#include "mir/tools.hpp"
#include "utils/exception.hpp"
#include "utils/logger.hpp"
#include <cstddef>
#include <cstdint>
#include <cstdlib>
#include <iterator>
#include <optional>

using namespace MIR;

PM::PreservedAnalyses RedundantLoadEli::run(MIRFunction &mfunc, FAM &fam) {
    class RedundantLoadEliImpl impl(mfunc, fam);
    impl.Impl();

    return PM::PreservedAnalyses::all();
}

void RedundantLoadEliImpl::Impl() {
    MkInfo();
    CulculateLCA();
    ApplyCopys();
}

void RedundantLoadEliImpl::MkInfo() {
    // LAMBDA BEGIN

    auto isLoad = [](const MIRInst_p &minst) -> std::optional<ldValue> {
        if (!minst->isGeneric()) {
            return std::nullopt;
        }

        if (minst->opcode<OpC>() == OpC::InstLoadImm) {
            return {ldValue(static_cast<uint32_t>(minst->getOp(1)->imme()))};
            // return std::nullopt;
        } else if (minst->opcode<OpC>() == OpC::InstLoadFPImm) {

            auto val = static_cast<uint32_t>(minst->getOp(1)->imme());
            return {ldValue(*reinterpret_cast<float *>(&val))};
        } else if (minst->opcode<OpC>() == OpC::InstLoadImmEx) {

            return {ldValue((minst->getOp(1)->immeEx()))};
        } else if (minst->opcode<OpC>() == OpC::InstLoadLiteral) {
            const auto &val = minst->getOp(1);

            size_t size_align = inSet(val->type(), OpT::Floatvec2, OpT::Intvec2) ? 8 : 16; // FIXME: match more

            return {ldValue(val->literal(), val->type(), size_align, size_align)};
        } else {

            return std::nullopt;
        }
    };

    // LAMBDA END

    auto &mblks = mfunc.blks();

    for (auto &mblk : mblks) {

        auto &minsts = mblk->Insts();
        for (auto it = minsts.begin(); it != minsts.end(); ++it) {
            auto &minst = *it;

            if (auto ptr = isLoad(minst)) {
                auto loadVal = *ptr;

                if (mblk->getmSym() == "my_sin_impl_1") {
                    int debug;
                }

                if (!infos.count(loadVal)) {

                    infos.emplace(
                        loadVal,
                        loadInfo{loadVal, {mblk}, {{mblk.get(), 0}}, {{mblk.get(), {{minst->ensureDef(), it}}}}});
                    // 括号对齐带师
                } else {

                    auto &info = infos.at(loadVal); //

                    info.distance.emplace(mblk.get(), 0);
                    info.mblks.emplace(mblk);

                    ///@note 由于minsts顺序遍历, 所以这个vector内的pair顺序应该也是正确的
                    info.const_uses[mblk.get()].emplace_back(minst->ensureDef(), it);
                }
            }
        }
    }
}

void RedundantLoadEliImpl::CulculateLCA() {
    auto domTree = fam.getResult<DomTreeAnalysis>(mfunc);

    // LAMBDA BEGIN

    auto getLCA = [&domTree](loadInfo &info) {
        auto &in_use_mblks = info.mblks;

        std::vector<MIRBlk_p> stack(in_use_mblks.begin(), in_use_mblks.end());

        auto LCA = domTree[stack.back().get()].get(); // use raw ptr
        stack.pop_back();

        while (!stack.empty()) {
            auto node = domTree[stack.back().get()].get();
            stack.pop_back();

            while (LCA != node) {
                if (LCA->level() > node->level()) {
                    LCA = LCA->raw_parent();
                    continue;
                }
                if (LCA->level() < node->level()) {
                    node = node->raw_parent();
                    continue;
                }
                if (LCA->level() == node->level() && LCA != node) {
                    LCA = LCA->raw_parent();
                }
            }
        }

        info.lca = LCA->block();

        auto &distance = info.distance;

        for (auto &[mblk, distance] : distance) {
            distance = domTree[mblk]->level() - domTree[info.lca]->level();
        }
    };

    // LAMBDA END

    for (auto &[constVal, info] : infos) {

        getLCA(info); // fill in lca blk
    }
}

void RedundantLoadEliImpl::ApplyCopys() {
    ///@note 减少load就会增加寄存器压力, 尤其是对一些0,1,2等常用的数, 不过寄存器大概是够用的
    ///@todo 对于某些数, 可以考虑仅在blk内做消除而不是全局地消除

    for (auto &[constVal, /* a number */ info] : infos) {

        if (constVal.isZero()) {
            continue; // giveup
        }

        ApplyCopys_inFunc(info, constVal);
    }
}

void RedundantLoadEliImpl::ApplyCopys_inFunc(loadInfo &info, const ldValue &constVal) {

    MIROperand_p loaded_op = nullptr;
    std::map<MIRBlk *, bool> weights;

    weights_cal(info, weights);

    if (info.const_uses.count(info.lca)) {
        // Logger::logInfo("remain: " + (*iter_lca->second)->dbgDump() + " in " + info.lca->getmSym());

        auto iter_lca = info.const_uses.at(info.lca).begin(); // the first load in lca
        loaded_op = iter_lca->first;

        // info.const_uses.at(info.lca).erase(iter_lca); // remain the first one

        ApplyCopys_inBlks(info.lca, info.const_uses.at(info.lca), constVal);

        info.const_uses.erase(info.lca);
    } else {
        // add a load in lca blk

        loaded_op = MIROperand::asVReg(ctx.nextId(), constVal.type);

        auto new_load = MIRInst::make(constVal.getLoadOpC())
                            ->setOperand<0>(loaded_op, ctx)
                            ->setOperand<1>(constVal.getConstOp(), ctx);
        info.lca->addInstBeforeBr(new_load);

        Logger::logInfo("add in lca: " + new_load->dbgDump() + " in " + info.lca->getmSym());

        // add into literal pool
        if (constVal.isLiteral()) {
            info.lca->add_tail_literal(std::get<string>(constVal.inner), constVal.size, constVal.align);
        }
    }

    for (auto &[mblk, uses] : info.const_uses) {

        if (!weights.at(mblk)) {
            ApplyCopys_inBlks(mblk, uses, constVal);
            continue;
        }

        for (auto &[mop, miter] : uses) {
            auto &minst_loadImm = *miter;

            Logger::logInfo("before change to copy(global): " + minst_loadImm->dbgDump() + " in " + mblk->getmSym());

            minst_loadImm->resetOpcode(chooseCopyOpC(mop, loaded_op));
            minst_loadImm->setOperand<0>(mop, ctx);
            minst_loadImm->setOperand<1>(loaded_op, ctx);

            Logger::logInfo("after change to copy(global): " + minst_loadImm->dbgDump() + " in " + mblk->getmSym());

            if (constVal.isLiteral()) {
                mblk->removeLitetal(std::get<string>(constVal.inner));
            }
        }
    }
}

void RedundantLoadEliImpl::ApplyCopys_inBlks(MIRBlk *mblk, loadInfo::useInfo_blk &blk_info, const ldValue &constVal) {

    Err::gassert(!blk_info.empty(), "no ref in this blk");

    MIROperand_p loaded_op = blk_info.front().first;

    Logger::logInfo("remain: " + (*blk_info.front().second)->dbgDump() + " in " + mblk->getmSym());

    blk_info.erase(blk_info.begin());

    for (auto &[mop, miter] : blk_info) {

        auto &minst_loadImm = *miter;

        Logger::logInfo("before change to copy(local): " + minst_loadImm->dbgDump() + " in " + mblk->getmSym());

        minst_loadImm->resetOpcode(chooseCopyOpC(mop, loaded_op));
        minst_loadImm->setOperand<0>(mop, ctx);
        minst_loadImm->setOperand<1>(loaded_op, ctx);

        Logger::logInfo("after change to copy(local): " + minst_loadImm->dbgDump() + " in " + mblk->getmSym());

        if (constVal.isLiteral()) {
            mblk->removeLitetal(std::get<string>(constVal.inner));
        }
    }
}

void RedundantLoadEliImpl::weights_cal(loadInfo &info, std::map<MIRBlk *, bool> &weights) {
    const size_t weight_distance = average_inst_cnt;
    const size_t weight_prv = 1;
    const size_t weight_live_len = 1;

    const size_t n = 60; // Try more and fix me

    for (const auto &[mblk, uses] : info.const_uses) {

        auto live_len_in_blk = std::distance(mblk->Insts().begin(), uses.back().second);
        auto distance = info.distance.at(mblk);
        auto prv_cnt = mblk->preds().size();

        auto output = live_len_in_blk * weight_live_len + distance * weight_distance * prv_cnt * weight_prv;

        weights.emplace(mblk, n * output < overall_inst_cnt);
    }
}
