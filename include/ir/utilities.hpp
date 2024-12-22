#pragma once
#ifndef GNALC_IR_UTILS_HPP
#define GNALC_IR_UTILS_HPP

#include <memory>
#include <list>
#include "../utils/exception.hpp"

template <typename T>
const std::list<std::shared_ptr<T>> WeaktoSharedList(const std::list<std::weak_ptr<T>> weak_list) {
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

#endif