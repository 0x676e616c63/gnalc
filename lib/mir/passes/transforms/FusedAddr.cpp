#include "mir/passes/transforms/FusedAddr.hpp"
#include "mir/MIR.hpp"
#include "mir/info.hpp"
#include "mir/tools.hpp"
#include "pass_manager/pass_manager.hpp"
#include "utils/exception.hpp"
#include <algorithm>
#include <iterator>
#include <optional>
#include <string>

using namespace MIR;

PM::PreservedAnalyses FusedAddr::run(MIRFunction &mfunc, FAM &fam) {
    FusedAddrImpl impl(mfunc, fam, mfunc.Context());
    impl.impl();

    return PM::PreservedAnalyses::all();
}

void FusedAddrImpl::impl() {

    while (true) {
        clear();
        ptr_use_record();
        ptr_def_record();
        if (!fused_apply()) {
            break;
        }
    }
}

void FusedAddrImpl::clear() {
    ptrUse.clear();
    withConstOff.clear();
    ptrDef.clear();
    ptrDetail.clear();
    fusedtimes = 0;
}

void FusedAddrImpl::ptr_use_record() {

    // LAMBDA BEGIN

    auto match_load = [this](const MIRInst_p &load) -> std::optional<MIROperand_p> {
        if (!load->isGeneric() || load->opcode<OpC>() != OpC::InstLoad) {
            return std::nullopt;
        }

        // InstLoad: <0, def> <1, base> <2, offset> <3, shift> <4, nullptr>, <5, size>

        auto base = load->getOp(1);
        auto offset = load->getOp(2);

        if (base->isStack()) {
            return std::nullopt;
        }

        if (!offset) {
            withConstOff.emplace(load, false);
            return {base};
        } else if (offset->isImme()) {
            withConstOff.emplace(load, true);
            return {base};
        }

        return std::nullopt;
    };

    auto match_store = [this](const MIRInst_p &store) -> std::optional<MIROperand_p> {
        if (!store->isGeneric() || store->opcode<OpC>() != OpC::InstStore) {
            return std::nullopt;
        }

        // InstStore: <1, use> <2, base> <3, offset> <4, shift> <5, size>

        auto base = store->getOp(2);
        auto offset = store->getOp(3);

        if (base->isStack()) {
            return std::nullopt;
        }

        if (!offset) {
            withConstOff.emplace(store, false);
            return {base};
        } else if (offset->isImme()) {
            withConstOff.emplace(store, true);
            return {base};
        }

        return std::nullopt;
    };

    auto match = [&](const MIRInst_p &memory) -> std::optional<MIROperand_p> {
        return match_load(memory) ? match_load(memory) : match_store(memory);
    };

    // LAMBDA END

    for (const auto &mblk : mfunc.blks()) {

        for (const auto &minst : mblk->Insts()) {

            if (auto addr_use = match(minst)) {
                ptrUse.emplace(minst, *addr_use);
                ptrDef.emplace(*addr_use, nullptr);
            }
        }
    }
}

void FusedAddrImpl::ptr_def_record() {
    // LAMBDA BEGIN
    auto giveup = [](gep &detail) -> bool {
        detail.if_giveup = true;
        return true;
    };

    auto match_add_sp_imme = [&](const auto &minsts, const auto &iter, gep &detail) -> bool {
        // return giveup(detail); // Debug

        const MIRInst_p &minst = *iter;

        if (!minst->isGeneric() || minst->opcode<OpC>() != OpC::InstAddSP || !minst->getOp(2)->isImme()) {
            return false;
        }

        detail.baseptr = minst->getOp(1); // stkobj
        detail.offset = minst->getOp(2);  // imme offset

        return true;
    };

    auto match_add_var_imme = [&](const auto &minsts, const auto &iter, gep &detail) -> bool {
        // return giveup(detail); // Debug

        const MIRInst_p &minst = *iter;

        if (!minst->isGeneric() || minst->opcode<OpC>() != OpC::InstAdd || !minst->getOp(2)->isImme()) {
            return false;
        }

        detail.baseptr = minst->getOp(1); // var ptr
        detail.offset = minst->getOp(2);  // imme offset

        return true;
    };

    auto match_copy = [&](const auto &minsts, const auto &iter, gep &detail) -> bool {
        // with multiple defs
        return giveup(detail);
    };

    auto match_mul_add_sp_var = [&](const auto &minsts, const auto &iter, gep &detail) -> bool {
        // return giveup(detail); // Debug

        const MIRInst_p &addsp = *iter;

        if (std::prev(iter) == std::prev(minsts.end())) {
            return false;
        }

        const MIRInst_p &mul = *std::prev(iter);

        if (!mul->isGeneric() || mul->opcode<OpC>() != OpC::InstMul || !mul->getOp(2)->isImme()) {
            return false;
        }

        if (!addsp->isGeneric() || addsp->opcode<OpC>() != OpC::InstAddSP || !addsp->getOp(2)->isVReg()) {
            return false;
        }

        auto per_elem_size = mul->getOp(2)->imme();

        detail.if_giveup = true; // give up, var offset and const offset conflict

        return true;
    };

    auto match_mul_add_var_var = [&](const auto &minsts, const auto &iter, gep &detail) -> bool {
        // return giveup(detail); // Debug

        const MIRInst_p &add = *iter;

        if (std::prev(iter) == std::prev(minsts.end())) {
            return false;
        }

        const MIRInst_p &mul = *std::prev(iter);

        if (!mul->isGeneric() || mul->opcode<OpC>() != OpC::InstMul || !mul->getOp(2)->isImme()) {
            return false;
        }

        if (!add->isGeneric() || add->opcode<OpC>() != OpC::InstAdd || !add->getOp(2)->isVReg()) {
            return false;
        }

        auto per_elem_size = mul->getOp(2)->imme();

        if (per_elem_size == 8ULL) { // permitted in A64
            detail.baseptr = add->getOp(1);
            detail.offset = mul->getOp(1);                    // array idx
            detail.shift = MIROperand::asImme(3, OpT::Int32); // lsl #3
        } else {
            detail.baseptr = add->getOp(1);
            detail.offset = mul->ensureDef(); // offset = idx * persize
        }

        return true;
    };

    // LAMBDA END

    for (const auto &mblk : mfunc.blks()) {
        const auto &minsts = mblk->Insts();
        for (auto iter = minsts.begin(); iter != minsts.end(); ++iter) {
            const auto &minst = *iter;

            if (!ptrDef.count(minst->getDef())) {
                continue;
            }

            auto def = minst->ensureDef();

            if (auto pre_definst = ptrDef.at(def)) {
                continue; // multiple copy ptr, usually giveup
            }

            ptrDef.at(def) = minst;

            ///@note get detail: ptr, idx, shift
            gep detail{};
            if (match_add_sp_imme(minsts, iter, detail)) {
                ;
            } else if (match_add_var_imme(minsts, iter, detail)) {
                ;
            } else if (match_copy(minsts, iter, detail)) {
                ;
            } else if (match_mul_add_sp_var(minsts, iter, detail)) {
                ;
            } else if (match_mul_add_var_var(minsts, iter, detail)) {
                ;
            } else {
                Err::unreachable("unknow gep lowering template");
            }

            ptrDetail[def] = detail;
        }
    }
}

bool FusedAddrImpl::fused_apply() {

    for (auto &[memory, ptr] : ptrUse) {

        if (!ptrDetail.count(ptr)) {
            continue;
        }

        auto &[baseptr, offset, shift, if_giveup] = ptrDetail.at(ptr);

        if (if_giveup || withConstOff.at(memory) && offset && !offset->isImme()) {
            continue;
        }

        if (memory->opcode<OpC>() == OpC::InstLoad) {

            auto newoffset =
                withConstOff.at(memory)
                    ? MIROperand::asImme((offset ? offset->imme() : 0) + memory->getOp(2)->imme(), OpT::Int32)
                    : offset;

            memory->setOperand<1>(baseptr, ctx);
            memory->setOperand<2>(newoffset, ctx);
            memory->setOperand<3>(shift, ctx);
        } else { // OpC::InstStore

            auto newoffset =
                withConstOff.at(memory)
                    ? MIROperand::asImme((offset ? offset->imme() : 0) + memory->getOp(3)->imme(), OpT::Int32)
                    : offset;

            memory->setOperand<2>(baseptr, ctx);
            memory->setOperand<3>(newoffset, ctx);
            memory->setOperand<4>(shift, ctx);
        }

        ++fusedtimes;
    }

    Logger::logInfo("successfully fused: " + std::to_string(fusedtimes));

    return fusedtimes;
}