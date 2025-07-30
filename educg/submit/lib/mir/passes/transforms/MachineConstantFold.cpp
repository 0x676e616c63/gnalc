#include "../../../../include/mir/passes/transforms/MachineConstantFold.hpp"
#include "../../../../include/mir/MIR.hpp"
#include "../../../../include/mir/info.hpp"
#include "../../../../include/pass_manager/pass_manager.hpp"
#include "../../../../include/utils/logger.hpp"
#include <string>
#include <vector>

using namespace MIR;

PM::PreservedAnalyses MachineConstantFold::run(MIRFunction &_mfunc, FAM &_fam) {
    MachineConstantFoldImpl impl{_mfunc, _fam};

    impl.Impl();

    return PM::PreservedAnalyses::all();
}

void MachineConstantFoldImpl::clear() {
    infos.clear();
    last_folded = folded;
    folded = 0;
}

void MachineConstantFoldImpl::Impl() {

    while (true) {
        clear();

        auto &mblks = mfunc.blks();
        for (auto &mblk : mblks) {
            runOnBlk(mblk);
        }

        if (!apply_fold()) {
            break;
        }

        Logger::logInfo("Machine Constant Fold times: " + std::to_string(folded));
    }
}

void MachineConstantFoldImpl::runOnBlk(MIRBlk_p &mblk) {
    auto &minsts = mblk->Insts();
    for (auto it = minsts.begin(); it != minsts.end(); ++it) {
        match(it);
    }
}

void MachineConstantFoldImpl::match(MIRInst_p_l::iterator &iter) {
    /// @note assume that most of the constant has been folded in IR form

    const auto &minst = *iter;
    if (!minst->isGeneric() || minst->opcode<OpC>() != OpC::InstAdd) {
        return;
    }

    if (ctx.queryOp(minst->ensureDef()) <= 1) {
        Logger::logInfo("def inst of %" + std::to_string(minst->ensureDef()->getRecover() - VRegBegin) + " deleted");
        return;
    }

    auto op1 = minst->getOp(1);
    auto op2 = minst->getOp(2);

    if (!op1->isImme() && !op2->isImme()) {
        return;
    }

    auto def = minst->ensureDef();
    auto var = op1->isImme() ? op2 : op1;
    auto imme = op1->isImme() ? op1->imme() : op2->imme();

    bool find = false;
    for (auto &info : infos) {

        if (info.chain_end != var) {
            continue;
        }

        info.chain_end = def;
        info.iters.emplace_back(iter);
        info.constants.emplace_back(info.constants.back() + imme);

        find = true;
    }

    if (!find) {
        infos.emplace_back(iter, var, def, imme);
    }
}

bool MachineConstantFoldImpl::apply_fold() {
    if (infos.empty() || infos.size() == last_folded) {
        return false;
    }

    folded = infos.size();

    for (const auto &info : infos) {

        auto &[iters, begin, _, constants] = info;

        // auto chain_end = *iters.back();

        // chain_end->setOperand<1>(begin, ctx);
        // chain_end->setOperand<2>(MIROperand::asImme(constant, OpT::Int64), ctx);
        for (int i = 0; i < iters.size(); ++i) {

            (*iters[i])->setOperand<1>(begin, ctx);
            (*iters[i])->setOperand<2>(MIROperand::asImme(constants[i], OpT::Int64), ctx);
        }
    }

    return true;
}