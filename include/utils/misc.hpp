#pragma once
#ifndef GNALC_UTILS_MISC_HPP
#define GNALC_UTILS_MISC_HPP

#include "exception.hpp"

#include <list>
#include <memory>
#include <string_view>
#include <ostream>
#include <type_traits>

namespace Util {
template <class... Ts> struct overloaded : Ts... {
    using Ts::operator()...;
};
template <class... Ts> overloaded(Ts...) -> overloaded<Ts...>;

// Black magic from unaccepted C++ proposal, WG21 P2098R0
// See: https://www.open-std.org/JTC1/SC22/WG21/docs/papers/2020/p2098r0.pdf
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

template <typename T> void hashSeedCombine(size_t &seed, T x) { seed ^= x + 0x9e3779b9 + (seed << 6) + (seed >> 2); }

template <typename Container>
std::enable_if_t<std::is_integral_v<typename remove_cvref_t<Container>::value_type> &&
                     sizeof(typename remove_cvref_t<Container>::value_type) == 4,
                 size_t>
vectorHash(Container &&vec) {
    size_t seed = vec.size();
    for (auto x : vec) {
        x = ((x >> 16) ^ x) * 0x45d9f3b;
        x = ((x >> 16) ^ x) * 0x45d9f3b;
        x = (x >> 16) ^ x;
        hashSeedCombine(seed, x);
    }
    return seed;
}
template <typename Container>
std::enable_if_t<std::is_integral_v<typename remove_cvref_t<Container>::value_type> &&
                     sizeof(typename remove_cvref_t<Container>::value_type) == 8,
                 size_t>
vectorHash(Container &&vec) {
    size_t seed = vec.size();
    for (auto x : vec) {
        x = ((x >> 30) ^ x) * 0xbf58476d1ce4e5b9;
        x = ((x >> 27) ^ x) * 0x94d049bb133111eb;
        x = (x >> 31) ^ x;
        hashSeedCombine(seed, x);
    }
    return seed;
}
template <typename Container>
std::enable_if_t<!std::is_integral_v<typename remove_cvref_t<Container>::value_type>, size_t>
vectorHash(Container &&vec) {
    size_t seed = vec.size();
    for (auto x : vec)
        hashSeedCombine(seed, std::hash<typename remove_cvref_t<Container>::value_type>()(x));
    return seed;
}

// https://stackoverflow.com/questions/8243743/is-there-a-null-stdostream-implementation-in-c-or-libraries
class NullStream : public std::ostream {
    class NullBuffer : public std::streambuf {
    public:
        int overflow(int c) { return c; }
    } m_nb;

public:
    NullStream() : std::ostream(&m_nb) {}
};

static NullStream & null_stream() {
    static NullStream null_stream;
    return null_stream;
}

struct PairHash {
    template <class T1, class T2>
    size_t operator()(const std::pair<T1, T2> &p) const
    {
        size_t seed = std::hash<T1>()(p.first);
        Util::hashSeedCombine(seed, std::hash<T2>()(p.second));
        return seed;
    }
};

bool begins_with(const std::string &a, const std::string &b);

#define GNALC_STRINGFY(x) _GNALC_STRINGFY(x)
#define _GNALC_STRINGFY(x) #x
} // namespace Util
#endif
