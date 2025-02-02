#pragma once
#ifndef GNALC_UTILS_MISC_HPP
#define GNALC_UTILS_MISC_HPP

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
} // namespace Util
#endif
