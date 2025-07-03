// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/base.hpp"
namespace SIR {

bool IListDel(IList& ilist, const pInst& val) {
    bool found = false;
    for (auto it = ilist.begin(); it != ilist.end();) {
        if (*it == val) {
            it = ilist.erase(it);
            found = true;
        } else {
            ++it;
        }
    }
    return found;
}

bool IListReplace(IList &ilist, const pInst &old_p, const pInst &new_p) {
    bool found = false;
    for (auto &p : ilist) {
        if (p == old_p) {
            p = new_p;
            found = true;
        }
    }
    return found;
}

IList::iterator IListFind(IList& ilist, const pInst& val) {
    for (auto it = ilist.begin(); it != ilist.end(); ++it) {
        if (*it == val)
            return it;
    }
    return ilist.end();
}

IList::const_iterator IListFind(const IList& ilist, const pInst& val) {
    for (auto it = ilist.begin(); it != ilist.end(); ++it) {
        if (*it == val)
            return it;
    }
    return ilist.end();
}

IList::reverse_iterator IListRFind(IList& ilist, const pInst& val) {
    for (auto it = ilist.rbegin(); it != ilist.rend(); ++it) {
        if (*it == val)
            return it;
    }
    return ilist.rend();
}
IList::const_reverse_iterator IListRFind(const IList& ilist, const pInst& val) {
    for (auto it = ilist.rbegin(); it != ilist.rend(); ++it) {
        if (*it == val)
            return it;
    }
    return ilist.rend();
}
}