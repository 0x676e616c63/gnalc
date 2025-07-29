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

void collectIlist(const pVal &val, std::vector<IList *> &ilists) {
    if (auto if_inst = val->as<IFInst>()) {
        collectIlist(if_inst->getCond(), ilists);
        ilists.emplace_back(&if_inst->getBodyInsts());
        ilists.emplace_back(&if_inst->getElseInsts());
    }
    if (auto while_inst = val->as<WHILEInst>()) {
        collectIlist(while_inst->getCond(), ilists);
        ilists.emplace_back(&while_inst->getCondInsts());
        ilists.emplace_back(&while_inst->getBodyInsts());
    }
    if (auto for_inst = val->as<FORInst>())
        ilists.emplace_back(&for_inst->getBodyInsts());
    if (auto lfn = val->as<LinearFunction>())
        ilists.emplace_back(&lfn->getInsts());
    if (auto cond_value = val->as<CONDValue>()) {
        ilists.emplace_back(&cond_value->getRHSInsts());
        collectIlist(cond_value->getRHS(), ilists);
        collectIlist(cond_value->getLHS(), ilists);
    }
}

// Const version
void collectIlist(const pVal &val, std::vector<const IList *> &ilists) {
    if (auto if_inst = val->as<IFInst>()) {
        ilists.emplace_back(&if_inst->getElseInsts());
        ilists.emplace_back(&if_inst->getBodyInsts());
        collectIlist(if_inst->getCond(), ilists);
    }
    if (auto while_inst = val->as<WHILEInst>()) {
        ilists.emplace_back(&while_inst->getBodyInsts());
        ilists.emplace_back(&while_inst->getCondInsts());
        collectIlist(while_inst->getCond(), ilists);
    }
    if (auto for_inst = val->as<FORInst>())
        ilists.emplace_back(&for_inst->getBodyInsts());
    if (auto lfn = val->as<LinearFunction>())
        ilists.emplace_back(&lfn->getInsts());
    if (auto cond_value = val->as<CONDValue>()) {
        collectIlist(cond_value->getRHS(), ilists);
        ilists.emplace_back(&cond_value->getRHSInsts());
        collectIlist(cond_value->getLHS(), ilists);
    }
}

bool IListReplaceRecursive(IList &ilist, const Instruction *old_p, const pInst &new_p) {
    bool found = false;
    for (auto it = ilist.begin(); it != ilist.end(); ++it) {
        if (it->get() == old_p) {
            *it = new_p;
            found = true;
        } else {
            std::vector<IList*> ilists;
            collectIlist(*it, ilists);
            for (auto curr : ilists)
                found |= IListReplaceRecursive(*curr, old_p, new_p);
        }
    }
    return found;
}
bool IListReplaceRecursive(IList &ilist, const pInst &old_p, const pInst &new_p) {
    return IListReplaceRecursive(ilist, old_p.get(), new_p);
}

bool IListContainsRecursive(const IList &ilist, const Instruction* val) {
    for (auto it = ilist.begin(); it != ilist.end(); ++it) {
        if (it->get() == val)
            return true;

        std::vector<IList*> ilists;
        collectIlist(*it, ilists);
        for (auto curr : ilists) {
            if (IListContainsRecursive(*curr, val))
                return true;
        }
    }
    return false;
}
bool IListContainsRecursive(const IList &ilist, const pInst &val) {
    return IListContainsRecursive(ilist, val.get());
}

bool IListContainsRecursive(const IList &ilist, const std::unordered_set<pVal> &set) {
    for (auto it = ilist.begin(); it != ilist.end(); ++it) {
        if (set.count(*it))
            return true;

        std::vector<IList*> ilists;
        collectIlist(*it, ilists);
        for (auto curr : ilists) {
            if (IListContainsRecursive(*curr, set))
                return true;
        }
    }
    return false;
}

bool IListContainsRecursive(const IList &ilist, const std::unordered_set<Value *> &set) {
    for (auto it = ilist.begin(); it != ilist.end(); ++it) {
        if (set.count(it->get()))
            return true;

        std::vector<IList*> ilists;
        collectIlist(*it, ilists);
        for (auto curr : ilists) {
            if (IListContainsRecursive(*curr, set))
                return true;
        }
    }
    return false;
}

} // namespace SIR