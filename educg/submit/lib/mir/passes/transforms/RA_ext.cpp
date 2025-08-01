// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/mir/MIR.hpp"
#include "../../../../include/mir/info.hpp"
#include "../../../../include/mir/passes/transforms/RA.hpp"
#include "../../../../include/mir/tools.hpp"
#include "../../../../include/utils/exception.hpp"
#include <algorithm>
#include <cstddef>
#include <iostream>
#include <iterator>
#include <list>
#include <optional>
#include <string>

using namespace MIR;

bool RegisterAllocImpl::isMoveInstruction(const MIRInst_p &minst) {

    if (!minst->isGeneric()) {
        return false;
    }

    auto mopcode = minst->opcode<OpC>();

    if (mopcode == OpC::InstCopy || mopcode == OpC::InstCopyFromReg || mopcode == OpC::InstCopyToReg) {

        if (isCore(minst->ensureDef()) && isCore(minst->getOp(1))) {

            if (!minst->getOp(1)->isImme()) { // chk use
                return true;
            }
        }
    }

    return false;
}

RegisterAllocImpl::Nodes RegisterAllocImpl::getUse(const MIRInst_p &minst) {
    Nodes uses;

    if (frameInfo->isFuncCall(minst)) {
        auto list = registerInfo->getCallerSaveCRs();
        for (auto reg : list)
            uses.emplace(MIROperand::asISAReg(reg, OpT::Int));
        return uses;
    }

    for (unsigned idx = 1; idx <= minst->getUseNr(); ++idx) {

        auto use = minst->getOp(idx);

        if (use && use->isVRegOrISAReg() && isCore(use)) {
            uses.emplace(use);
        }
    }

    return uses;
}

RegisterAllocImpl::Nodes RegisterAllocImpl::getDef(const MIRInst_p &minst) {
    Nodes defs;

    if (frameInfo->isFuncCall(minst)) {
        auto list = registerInfo->getCallerSaveCRs();
        for (auto reg : list)
            defs.emplace(MIROperand::asISAReg(reg, OpT::Int));
        return defs;
    }

    if (auto def = minst->getDef()) {

        if ((def->type() == OpT::Int16 || def->type() == OpT::Int32 || def->type() == OpT::Int64 ||
             def->type() == OpT::Int)) {

            defs.emplace(def);
        }
    }

    return defs;
}

MIROperand_p RegisterAllocImpl::heuristicSpill() {
    const int64_t Weight_IntervalLength = 5;
    const int64_t Weight_Degree = -25;
    const int64_t Weight_ref_cnt = 15;
    const int64_t extra_Weight_ForNotPtr = 60;
    const int64_t extra_Weight_ForSpilled = -1000000;
    const int64_t extra_Weight_ForConstValue = 100000;

    int64_t weight_max = std::numeric_limits<int64_t>::min();
    MIROperand_p spilled = nullptr;
    for (const auto &op : spillWorkList) {
        int64_t weight = 0;

        if (GeneratedBySpill.count(op))
            weight += extra_Weight_ForSpilled;

        if (op->getUseTrait() == MIROperand::usage::StoreConst)
            weight += extra_Weight_ForConstValue;

        weight += liveinfo.intervalLengths[op] * Weight_IntervalLength; // narrowing convert here

        weight += mfunc->Context().queryOp(op) * Weight_ref_cnt;

        weight += degree[op] * Weight_Degree;

        if (op->type() == OpT::Int64) {
            weight += extra_Weight_ForNotPtr;
        }

        if (weight >= weight_max) {
            spilled = op;
            weight_max = weight;
        }
    }

    spilled == nullptr ? void(spilled = spillWorkList.front()) : nop;

    return spilled;

    // return spillWorkList.front();
}

RegisterAllocImpl::Nodes RegisterAllocImpl::spill(const MIROperand_p &mop) {

    if (GeneratedBySpill.count(mop))
        ++badspill;

    if (mop->getUseTrait() == MIROperand::usage::StoreConst) {
        ++reloadtimes;
        return reloadConstVal(mop);
    } else {
        ++spilltimes;
        return spillToMem(mop);
    }
}

RegisterAllocImpl::Nodes RegisterAllocImpl::spillToMem(const MIROperand_p &mop) {
    auto &ctx = mfunc->Context();

    auto getSize = [](OpT type) {
        switch (type) {
        case OpT::Intvec2:
        case OpT::Floatvec2:
        case OpT::Int64:
            return 8;
        case OpT::Floatvec3:
        case OpT::Intvec3:
            return 12;
        case OpT::Floatvec4:
        case OpT::Int64vec2:
        case OpT::Intvec4:
            return 16;
        case OpT::Int:
            return 8;
        default:
            return 4;
        }
    };

    auto mtype = mop->type();
    auto stkobj = mfunc->addStkObj(mfunc->Context(), getSize(mtype), getSize(mtype), 0, StkObjUsage::Spill);
    Nodes staged{};

    for (auto &mblk : mfunc->blks()) {
        auto &minsts = mblk->Insts();
        for (auto it = minsts.begin(); it != minsts.end();) {
            auto &minst = *it;
            auto recover = it;

            bool if_loaded = false; // only load once per inst
            auto &ops = minst->operands();
            // auto replace = MIROperand::asVReg(ctx.nextId(), mtype);
            std::optional<MIROperand_p> replace = std::nullopt;
            for (auto it_op = ops.begin(); it_op != ops.end(); ++it_op) {
                if (*it_op != mop) {
                    continue;
                }

                if (!replace) {
                    replace = {MIROperand::asVReg(ctx.nextId(), mtype)};
                    staged.emplace(*replace);
                }

                if (it_op == ops.begin()) { // def
                    auto minst_store =
                        MIRInst::make(OpC::InstStore)
                            ->setOperand<1>(*replace, mfunc->Context())
                            ->setOperand<2>(stkobj, mfunc->Context())
                            ->setOperand<5>(MIROperand::asImme(getBitWide(mtype), OpT::special), mfunc->Context());

                    minsts.insert(std::next(it), minst_store);
                    ++recover;
                } else if (!if_loaded) { // use
                    auto minst_load =
                        MIRInst::make(OpC::InstLoad)
                            ->setOperand<0>(*replace, mfunc->Context())
                            ->setOperand<1>(stkobj, mfunc->Context())
                            ->setOperand<5>(MIROperand::asImme(getBitWide(mtype), OpT::special), mfunc->Context());

                    minsts.insert(it, minst_load);
                    if_loaded = true;
                }

                *it_op = *replace;
            }

            it = ++recover;
        }
    }

    return staged;
}

RegisterAllocImpl::Nodes RegisterAllocImpl::reloadConstVal(const MIROperand_p &mop) {
    auto &ctx = mfunc->Context();
    auto mtype = mop->type();
    Nodes staged{};

    std::list<MIRInst_p> load_template{};
    for (auto &mblk : mfunc->blks()) {

        auto &minsts = mblk->Insts();
        for (auto it = minsts.begin(); it != minsts.end();) {

            if (mop != (*it)->getDef()) {
                ++it;
                continue;
            }

            load_template.emplace_back(*it); // 按次序遍历应该能保证movz movk 的顺序
            minsts.erase(it++);
        }

        if (!load_template.empty()) {
            continue;
        }
    }

    if (load_template.empty()) {
        return staged; // thanks to not SSA, sometimes wont find def insts
    }

    for (auto &mblk : mfunc->blks()) {

        auto &minsts = mblk->Insts();
        for (auto it = minsts.begin(); it != minsts.end(); ++it) {
            auto &minst = *it;
            auto &ops = minst->operands();

            std::optional<MIROperand_p> replace = std::nullopt;
            for (auto it_op = std::next(ops.begin()); it_op != ops.end(); ++it_op) {
                if (*it_op != mop) {
                    continue;
                }

                if (replace) {
                    // *it_op = *replace;
                    minst->replace(*it_op, *replace, ctx);
                    continue;
                }

                replace = std::optional(MIROperand::asVReg(ctx.nextId(), mtype));
                (*replace)->setUseTrait(MIROperand::usage::StoreConst);
                staged.emplace(*replace);

                std::list<MIRInst_p> loads = {}; // need clone

                std::for_each(load_template.begin(), load_template.end(), [&](const MIRInst_p &load) {
                    auto load_instance = load->clone();
                    load_instance->setOperand<0>(*replace, ctx);
                    loads.emplace_back(load_instance);
                });

                minsts.splice(it, loads);
                // *it_op = *replace;
                minst->replace(*it_op, *replace, ctx);
            }
        }
    }

    return staged;
}

bool VectorRegisterAllocImpl::isMoveInstruction(const MIRInst_p &minst) {
    if (!minst->isGeneric()) {
        return false;
    }

    auto mopcode = minst->opcode<OpC>();

    if (mopcode == OpC::InstCopy || mopcode == OpC::InstCopyFromReg || mopcode == OpC::InstCopyToReg) {

        auto mtype = minst->ensureDef()->type();
        auto mtype2 = minst->getOp(1)->type();

        ///@warning RISCV  may be not fit this
        if (inRange(mtype, OpT::Float, OpT::Floatvec4) && inRange(mtype2, OpT::Float, OpT::Floatvec4)) {
            if (!minst->getOp(1)->isImme()) { // chk use
                return true;
            }
        }
    }

    return false;
}

RegisterAllocImpl::Nodes VectorRegisterAllocImpl::getUse(const MIRInst_p &minst) {
    Nodes uses;

    if (frameInfo->isFuncCall(minst)) {
        auto list = registerInfo->getCallerSaveFpVRs();
        for (auto reg : list)
            uses.emplace(MIROperand::asISAReg(reg, OpT::Float));
        return uses;
    }

    for (unsigned idx = 1; idx <= minst->getUseNr(); ++idx) {

        auto use = minst->getOp(idx);

        if (use && use->isVRegOrISAReg() && inRange(use->type(), OpT::Float, OpT::Floatvec4)) {
            uses.emplace(use);
        }
    }

    return uses;
}

RegisterAllocImpl::Nodes VectorRegisterAllocImpl::getDef(const MIRInst_p &minst) {
    Nodes defs;

    if (frameInfo->isFuncCall(minst)) {
        auto list = registerInfo->getCallerSaveFpVRs();
        for (auto reg : list)
            defs.emplace(MIROperand::asISAReg(reg, OpT::Float));
        return defs;
    }

    if (auto def = minst->getDef()) {

        if (inRange(def->type(), OpT::Float, OpT::Floatvec4)) {
            defs.emplace(def);
        }
    }

    return defs;
}

void RegisterAllocImpl::dmpMap() {

    if (dmpConflictMap == 0) {
        return;
    }
    --dmpConflictMap;

    auto node_info = [](const MIROperand_p &op) {
        string str{};

        if (op->isVReg()) {
            str += "VReg(";
            str += std::to_string(op->getRecover() - MIR::VRegBegin) + ')';
        } else if (op->isImme()) {
            str += "Imme(";
            str += std::to_string(op->imme()) + ')';
        } else if (op->isISA()) {
            str += "ISAReg(";
            str += std::to_string(op->isa()) + ')';
        } else if (op->stkobj()) {
            str += "Stk(";
            str += std::to_string(op->getRecover() - MIR::StkObjBegin) + ')';
        } else {
            str += "Misc(?)";
        }

        return str;
    };

    for (const auto &[node, adjset] : adjList) {
        writeln(node_info(node), " : ", degree[node]);
        std::for_each(adjset.begin(), adjset.end(), [&](const auto &adj_node) { write(node_info(adj_node), ' '); });
        writeln("");
    }
}