#pragma once
#ifndef GNALC_IR_UTILS_HPP
#define GNALC_IR_UTILS_HPP

#include <memory>
#include <list>
#include "../utils/exception.hpp"

namespace IR {

template <typename T>
const std::list<std::shared_ptr<T>> WeaktoSharedList(const std::list<std::weak_ptr<T>>& weak_list) {
    std::list<std::shared_ptr<T>> shared_list;
    for (const auto& weakp : weak_list) {
        auto sharedp = weakp.lock();
        if (sharedp) {
            shared_list.push_back(sharedp);
        } else {
            Err::error("WeaktoSharedList(): element is expired.");
        }
    }
    return shared_list;
}

template <typename T>
bool WeakListDel(std::list<std::weak_ptr<T>>& weak_list, const std::shared_ptr<T>& p) {
    bool found = false;
    for (auto it = weak_list.begin(); it != weak_list.end();) {
        if (it->lock() == p) {
            it = weak_list.erase(it);
            found = true;
        } else {
            ++it;
        }
    }
    Err::assert(found, "WeakListDel(): element not found.");
    return found;
}

template <typename T>
bool WeakListReplace(std::list<std::weak_ptr<T>>& weak_list, const std::shared_ptr<T>& old_p, const std::shared_ptr<T>& new_p) {
    bool found = false;
    for (auto& weakp : weak_list) {
        if (weakp.lock() == old_p) {
            weakp = new_p;
            found = true;
        }
    }
    Err::assert(found, "WeakListReplace(): element not found.");
    return found;
}

}
#endif