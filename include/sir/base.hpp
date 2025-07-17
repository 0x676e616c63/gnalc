// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_SIR_BASE_HPP
#define GNALC_SIR_BASE_HPP

#include "ir/base.hpp"
#include "ir/constant.hpp"
#include "ir/instruction.hpp"
#include "ir/function.hpp"
#include "ir/module.hpp"
#include "ir/instructions/helper.hpp"
#include "ir/passes/pass_manager.hpp"
#include "ir/passes/pass_builder.hpp"

namespace SIR {
using namespace IR;

using IList = std::list<pInst>;

template <typename F>
bool IListDelIf(IList& ilist, F pred) {
    bool found = false;
    for (auto it = ilist.begin(); it != ilist.end();) {
        if (pred(*it)) {
            it = ilist.erase(it);
            found = true;
        } else {
            ++it;
        }
    }
    return found;
}
bool IListDel(IList& ilist, const pInst& val);
bool IListDel(IList& ilist, const Instruction*  val);
bool IListReplace(IList &ilist, const pInst &old_p, const pInst &new_p);
bool IListReplace(IList &ilist, const Instruction* old_p, const pInst & new_p);

IList::iterator IListFind(IList& ilist, const pInst& p);
IList::iterator IListFind(IList& ilist, const Instruction* p);
IList::const_iterator IListFind(const IList& ilist, const pInst& p);
IList::const_iterator IListFind(const IList& ilist, const Instruction* p);
IList::reverse_iterator IListRFind(IList& ilist, const pInst& p);
IList::reverse_iterator IListRFind(IList& ilist, const Instruction* p);
IList::const_reverse_iterator IListRFind(const IList& ilist, const pInst& p);
IList::const_reverse_iterator IListRFind(const IList& ilist, const Instruction* p);

template <typename F>
bool IListDelIfRecursive(IList& ilist, F pred) {
    bool found = false;
    for (auto it = ilist.begin(); it != ilist.end();) {
        if (pred(*it)) {
            it = ilist.erase(it);
            found = true;
        } else {
            if (auto if_inst = (*it)->as<IFInst>()) {
                found |= IListDelIfRecursive(if_inst->getBodyInsts(), pred);
                found |= IListDelIfRecursive(if_inst->getElseInsts(), pred);
            }
            if (auto while_inst = (*it)->as<WHILEInst>()) {
                found |= IListDelIfRecursive(while_inst->getCondInsts(), pred);
                found |= IListDelIfRecursive(while_inst->getBodyInsts(), pred);
            }
            if (auto for_inst =  (*it)->as<FORInst>())
                found |= IListDelIfRecursive(for_inst->getBodyInsts(), pred);

            ++it;
        }
    }
    return found;
}
bool IListDelRecursive(IList& ilist, const pInst& val);
bool IListDelRecursive(IList& ilist, const Instruction* val);
bool IListReplaceRecursive(IList &ilist, const pInst &old_p, const pInst &new_p);
bool IListReplaceRecursive(IList &ilist, const Instruction* old_p, const pInst & new_p);
} // namespace SIR
#endif
