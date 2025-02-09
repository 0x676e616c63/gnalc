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
class is_specialization_of : public std::false_type {};

template <template <typename...> typename Primary, typename... Args>
class is_specialization_of<Primary<Args...>, Primary> : public std::true_type {
};

template <typename T, template <typename...> typename Primary>
constexpr bool is_specialization_of_v = is_specialization_of<T, Primary>::value;

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
