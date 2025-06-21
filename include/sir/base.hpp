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

bool IListDel(IList& ilist, const pInst& val);
bool IListReplace(IList &ilist, const pInst &old_p, const pInst &new_p);
IList::iterator IListFind(IList& ilist, const pInst& p);
IList::const_iterator IListFind(const IList& ilist, const pInst& p);
IList::reverse_iterator IListRFind(IList& ilist, const pInst& p);
IList::const_reverse_iterator IListRFind(const IList& ilist, const pInst& p);
} // namespace SIR
#endif
