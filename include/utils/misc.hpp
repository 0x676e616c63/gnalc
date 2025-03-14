#pragma once
#ifndef GNALC_UTILS_MISC_HPP
#define GNALC_UTILS_MISC_HPP

#include <map>
#include <utility>
#include <string_view>
#include <type_traits>

namespace Util {
template <class... Ts> struct overloaded : Ts... {
    using Ts::operator()...;
};
template <class... Ts> overloaded(Ts...) -> overloaded<Ts...>;

template <typename T, template <typename...> typename Primary>
struct is_specialization_of : public std::false_type {};

template <template <typename...> typename Primary, typename... Args>
struct is_specialization_of<Primary<Args...>, Primary> : public std::true_type {
};

template <typename T, template <typename...> typename Primary>
constexpr bool is_specialization_of_v = is_specialization_of<T, Primary>::value;

template <typename T>
struct remove_cvref
{
    using type = std::remove_cv_t<std::remove_reference_t<T>>;
};

template <typename T>
using remove_cvref_t = typename remove_cvref<T>::type;

template <typename T>
struct make_iterator_range {
    make_iterator_range(const T& begin, const T& end) : begin_it(begin), end_it(end) {}

    auto begin() const { return begin_it; }
    auto end() const { return end_it; }

private:
    T begin_it;
    T end_it;
};

template <typename T>
struct reverse {
    using BegIterT = decltype(std::rbegin(std::declval<T>()));
    using EndIterT = decltype(std::rend(std::declval<T>()));
    explicit reverse(const T& range) : begin_it(std::rbegin(range)), end_it(std::rend(range)) {}

    auto begin() const { return begin_it; }
    auto end() const { return end_it; }

private:
    BegIterT begin_it;
    EndIterT end_it;
};

// C++20's source_location may be better.
template <typename getTypeNameArgument>
std::string_view getTypeName() {
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
} // namespace Util
#endif
