#pragma once
#ifndef GNALC_UTILS_MISC_HPP
#define GNALC_UTILS_MISC_HPP

#include "exception.hpp"

#include <list>
#include <memory>
#include <string_view>
#include <type_traits>

namespace Util {
template <class... Ts> struct overloaded : Ts... {
    using Ts::operator()...;
};
template <class... Ts> overloaded(Ts...) -> overloaded<Ts...>;

template <typename T, template <typename...> typename Primary> struct is_specialization_of : public std::false_type {};

template <template <typename...> typename Primary, typename... Args>
struct is_specialization_of<Primary<Args...>, Primary> : public std::true_type {};

template <typename T, template <typename...> typename Primary>
constexpr bool is_specialization_of_v = is_specialization_of<T, Primary>::value;

template <typename T> struct remove_cvref {
    using type = std::remove_cv_t<std::remove_reference_t<T>>;
};

template <typename T> using remove_cvref_t = typename remove_cvref<T>::type;

// C++20's source_location may be better.
template <typename getTypeNameArgument> std::string_view getTypeName() {
#if defined(__clang__) || defined(__GNUC__)
    std::string_view name = __PRETTY_FUNCTION__;
    // std::string_view Util::getTypeName() [getTypeNameArgument = <What we want>]
    std::string_view key = "getTypeNameArgument = ";
    name = name.substr(name.find(key)).substr(key.size());
    name.remove_suffix(1);
    // name = name.substr(0, name.size() - 1);
    return name;
#else
    return std::string_view{"UNKNOWN_NAME"};
#endif
}

template <typename T>
const std::list<std::shared_ptr<T>> WeaktoSharedList(const std::list<std::weak_ptr<T>> &weak_list) {
    std::list<std::shared_ptr<T>> shared_list;
    for (const auto &weakp : weak_list) {
        auto sharedp = weakp.lock();
        if (sharedp) {
            shared_list.push_back(sharedp);
        } else {
            Err::error("WeaktoSharedList(): element is expired.");
        }
    }
    return shared_list;
}

template <typename T> bool WeakListDel(std::list<std::weak_ptr<T>> &weak_list, const std::shared_ptr<T> &p) {
    bool found = false;
    for (auto it = weak_list.begin(); it != weak_list.end();) {
        if (it->lock() == p) {
            it = weak_list.erase(it);
            found = true;
        } else {
            ++it;
        }
    }
    Err::gassert(found, "WeakListDel(): element not found.");
    return found;
}

template <typename T>
bool WeakListReplace(std::list<std::weak_ptr<T>> &weak_list, const std::shared_ptr<T> &old_p,
                     const std::shared_ptr<T> &new_p) {
    bool found = false;
    for (auto &weakp : weak_list) {
        if (weakp.lock() == old_p) {
            weakp = new_p;
            found = true;
        }
    }
    Err::gassert(found, "WeakListReplace(): element not found.");
    return found;
}
} // namespace Util
#endif
