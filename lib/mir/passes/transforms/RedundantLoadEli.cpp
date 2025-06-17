#include "mir/passes/transforms/RedundantLoadEli.hpp"
#include "mir/passes/analysis/domtree_analysis.hpp"
#include <optional>

using namespace MIR_new;

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

    auto isLoad = [](const MIRInst_p &minst) {
        ///@todo InstLoadImmEx, though maybe not very useful
        ///@todo fix me
        if (minst->isGeneric() &&
            (minst->opcode<OpC>() == OpC::InstLoadImm || minst->opcode<OpC>() == OpC::InstLoadFPImm)) {
            std::optional loaded = minst->getOp(1)->imme();
            return loaded;
        } else {
            return std::optional<uint64_t>();
        }
    };

    auto isFP = [&isLoad](const MIRInst_p &minst) {
        if (!isLoad(minst)) {
            return false;
        }

        if (minst->isGeneric()) {
            if (minst->opcode<OpC>() == OpC::InstLoadImm) {
                return false;
            }

            return true;
        }

        return false;
    };

    // LAMBDA END

    auto &mblks = mfunc.blks();

    for (auto &mblk : mblks) {

        auto &minsts = mblk->Insts();
        for (auto it = minsts.begin(); it != minsts.end(); ++it) {
            auto &minst = *it;

            if (auto ptr = isLoad(minst)) {
                unsigned loadVal = *ptr;

                if (!infos.count({loadVal, isFP(minst)})) {

                    infos[{loadVal, isFP(minst)}] =
                        loadInfo{loadVal, {mblk}, {{mblk.get(), {{minst->ensureDef(), it}}}}}; // 括号对齐带师

                } else {

                    auto &info = infos.at({loadVal, isFP(minst)}); //
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
    };

    // LAMBDA END

    for (auto &[constVal, info] : infos) {

        getLCA(info); // fill in lca blk
    }
}

void RedundantLoadEliImpl::ApplyCopys() {
    ///@note 减少load就会增加寄存器压力, 尤其是对一些0,1,2等常用的数, 不过寄存器大概是够用的
    ///@todo 对于某些数, 可以考虑仅在blk内做消除而不是全局地消除

    for (auto &[pair, /* a number */ info] : infos) {

        const auto &[constVal, isFP] = pair;

        if (!isFP && constVal >= 0 && constVal < 65536) {
            continue; // giveup
        } else if (isFP && (isFloat8(constVal) || constVal == 0)) {
            continue; // giveup
        }

        MIROperand_p loaded_constVal = nullptr;

        if (info.const_uses.count(info.lca)) {
            auto iter_lca = info.const_uses.at(info.lca).begin();
            loaded_constVal = iter_lca->first;

            // 防止误改
            info.const_uses.at(info.lca).erase(iter_lca);
        } else {
            loaded_constVal = MIROperand::asVReg(mfunc.Context().nextId(), OpT::Int32);

            info.lca->addInstBeforeBr(MIRInst::make(OpC::InstLoadImm)
                                          ->setOperand<0>(loaded_constVal, mfunc.Context())
                                          ->setOperand<1>(MIROperand::asImme(constVal, OpT::Int32), mfunc.Context()));
        }

        for (auto &[mblk, uses] : info.const_uses) {

            for (auto &[mop, miter] : uses) {
                auto &minst_loadImm = *miter;

                if (inSet(minst_loadImm->opcode<OpC>(), OpC::InstLoadImm, OpC::InstLoadFPImm)) {
                    minst_loadImm->resetOpcode(OpC::InstCopy);
                }

                ///@note 寄存器压力大时, 这里可能有两种表现
                ///@note 1. 这里的copy没法消掉
                ///@note 2. constVal被溢出

                minst_loadImm->setOperand<0>(mop, mfunc.Context());
                minst_loadImm->setOperand<1>(loaded_constVal, mfunc.Context());
            }
        }
    }
}