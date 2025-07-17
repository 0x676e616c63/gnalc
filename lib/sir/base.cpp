// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/base.hpp"
namespace SIR {

bool IListDel(IList &ilist, const pInst &val) {
    return IListDelIf(ilist, [&](const pInst &p) { return p == val; });
}

bool IListDel(IList &ilist, const Instruction *val) {
    return IListDelIf(ilist, [&](const pInst &p) { return p.get() == val; });
}

bool IListReplace(IList &ilist, const Instruction *old_p, const pInst &new_p) {
    bool found = false;
    for (auto &p : ilist) {
        if (p.get() == old_p) {
            p = new_p;
            found = true;
        }
    }
    return found;
}
IList::iterator IListFind(IList &ilist, const Instruction *val) {
    for (auto it = ilist.begin(); it != ilist.end(); ++it) {
        if (it->get() == val)
            return it;
    }
    return ilist.end();
}

IList::const_iterator IListFind(const IList &ilist, const Instruction *val) {
    for (auto it = ilist.begin(); it != ilist.end(); ++it) {
        if (it->get() == val)
            return it;
    }
    return ilist.end();
}

IList::reverse_iterator IListRFind(IList &ilist, const Instruction *val) {
    for (auto it = ilist.rbegin(); it != ilist.rend(); ++it) {
        if (it->get() == val)
            return it;
    }
    return ilist.rend();
}
IList::const_reverse_iterator IListRFind(const IList &ilist, const Instruction *val) {
    for (auto it = ilist.rbegin(); it != ilist.rend(); ++it) {
        if (it->get() == val)
            return it;
    }
    return ilist.rend();
}

bool IListReplace(IList &ilist, const pInst &old_p, const pInst &new_p) {
    return IListReplace(ilist, old_p.get(), new_p);
}
IList::iterator IListFind(IList &ilist, const pInst &val) { return IListFind(ilist, val.get()); }
IList::const_iterator IListFind(const IList &ilist, const pInst &val) { return IListFind(ilist, val.get()); }
IList::reverse_iterator IListRFind(IList &ilist, const pInst &val) { return IListRFind(ilist, val.get()); }
IList::const_reverse_iterator IListRFind(const IList &ilist, const pInst &val) { return IListRFind(ilist, val.get()); }

bool IListDelRecursive(IList &ilist, const pInst &val) {
    return IListDelIfRecursive(ilist, [&](const pInst &p) { return p == val; });
}

bool IListDelRecursive(IList &ilist, const Instruction *val) {
    return IListDelIfRecursive(ilist, [&](const pInst &p) { return p.get() == val; });
}

bool IListReplaceRecursive(IList &ilist, const Instruction *old_p, const pInst &new_p) {
    bool found = false;
    for (auto it = ilist.begin(); it != ilist.end(); ++it) {
        if (it->get() == old_p) {
            *it = new_p;
            found = true;
        } else {
            if (auto if_inst = (*it)->as<IFInst>()) {
                found |= IListReplaceRecursive(if_inst->getBodyInsts(), old_p, new_p);
                found |= IListReplaceRecursive(if_inst->getElseInsts(), old_p, new_p);
            }
            if (auto while_inst = (*it)->as<WHILEInst>()) {
                found |= IListReplaceRecursive(while_inst->getCondInsts(), old_p, new_p);
                found |= IListReplaceRecursive(while_inst->getBodyInsts(), old_p, new_p);
            }
            if (auto for_inst = (*it)->as<FORInst>())
                found |= IListReplaceRecursive(for_inst->getBodyInsts(), old_p, new_p);
        }
    }
    return found;
}
bool IListReplaceRecursive(IList &ilist, const pInst &old_p, const pInst &new_p) {
    return IListReplaceRecursive(ilist, old_p.get(), new_p);
}
} // namespace SIR