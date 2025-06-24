#ifndef GNALC_UTILS_ENUM_OPERATOR_HPP
#define GNALC_UTILS_ENUM_OPERATOR_HPP

#include <type_traits>

#define GNALC_ENUM_OPERATOR_CMP(ENUM)                                                                                  \
    inline bool operator<(ENUM a, ENUM b) {                                                                            \
        return static_cast<std::underlying_type_t<ENUM>>(a) < static_cast<std::underlying_type_t<ENUM>>(b);            \
    }                                                                                                                  \
    inline bool operator<=(ENUM a, ENUM b) {                                                                           \
        return static_cast<std::underlying_type_t<ENUM>>(a) <= static_cast<std::underlying_type_t<ENUM>>(b);           \
    }                                                                                                                  \
    inline bool operator>(ENUM a, ENUM b) {                                                                            \
        return static_cast<std::underlying_type_t<ENUM>>(a) > static_cast<std::underlying_type_t<ENUM>>(b);            \
    }                                                                                                                  \
    inline bool operator>=(ENUM a, ENUM b) {                                                                           \
        return static_cast<std::underlying_type_t<ENUM>>(a) >= static_cast<std::underlying_type_t<ENUM>>(b);           \
    }

#define GNALC_ENUM_OPERATOR_CMP_INT(ENUM)                                                                              \
    template <typename T>                                                                                              \
    std::enable_if_t<std::is_integral_v<std::remove_reference_t<std::remove_cv_t<T>>>, bool> operator==(T a, ENUM b) {   \
        return a == static_cast<std::underlying_type_t<ENUM>>(b);                                                      \
    }                                                                                                                  \
    template <typename T>                                                                                              \
    std::enable_if_t<std::is_integral_v<std::remove_reference_t<std::remove_cv_t<T>>>, bool> operator==(ENUM a, T b) {   \
        return static_cast<std::underlying_type_t<ENUM>>(a) == b;                                                      \
    }                                                                                                                  \
    template <typename T>                                                                                              \
    std::enable_if_t<std::is_integral_v<std::remove_reference_t<std::remove_cv_t<T>>>, bool> operator!=(T a, ENUM b) {   \
        return a != static_cast<std::underlying_type_t<ENUM>>(b);                                                      \
    }                                                                                                                  \
    template <typename T>                                                                                              \
    std::enable_if_t<std::is_integral_v<std::remove_reference_t<std::remove_cv_t<T>>>, bool> operator!=(ENUM a, T b) {   \
        return static_cast<std::underlying_type_t<ENUM>>(a) != b;                                                      \
    }                                                                                                                  \
    template <typename T>                                                                                              \
    std::enable_if_t<std::is_integral_v<std::remove_reference_t<std::remove_cv_t<T>>>, bool> operator<(T a, ENUM b) {    \
        return a < static_cast<std::underlying_type_t<ENUM>>(b);                                                       \
    }                                                                                                                  \
    template <typename T>                                                                                              \
    std::enable_if_t<std::is_integral_v<std::remove_reference_t<std::remove_cv_t<T>>>, bool> operator<=(T a, ENUM b) {   \
        return a <= static_cast<std::underlying_type_t<ENUM>>(b);                                                      \
    }                                                                                                                  \
    template <typename T>                                                                                              \
    std::enable_if_t<std::is_integral_v<std::remove_reference_t<std::remove_cv_t<T>>>, bool> operator>(T a, ENUM b) {    \
        return a > static_cast<std::underlying_type_t<ENUM>>(b);                                                       \
    }                                                                                                                  \
    template <typename T>                                                                                              \
    std::enable_if_t<std::is_integral_v<std::remove_reference_t<std::remove_cv_t<T>>>, bool> operator>=(T a, ENUM b) {   \
        return a >= static_cast<std::underlying_type_t<ENUM>>(b);                                                      \
    }                                                                                                                  \
    template <typename T>                                                                                              \
    std::enable_if_t<std::is_integral_v<std::remove_reference_t<std::remove_cv_t<T>>>, bool> operator<(ENUM a, T b) {    \
        return static_cast<std::underlying_type_t<ENUM>>(a) < b;                                                       \
    }                                                                                                                  \
    template <typename T>                                                                                              \
    std::enable_if_t<std::is_integral_v<std::remove_reference_t<std::remove_cv_t<T>>>, bool> operator<=(ENUM a, T b) {   \
        return static_cast<std::underlying_type_t<ENUM>>(a) <= b;                                                      \
    }                                                                                                                  \
    template <typename T>                                                                                              \
    std::enable_if_t<std::is_integral_v<std::remove_reference_t<std::remove_cv_t<T>>>, bool> operator>(ENUM a, T b) {    \
        return static_cast<std::underlying_type_t<ENUM>>(a) > b;                                                       \
    }                                                                                                                  \
    template <typename T>                                                                                              \
    std::enable_if_t<std::is_integral_v<std::remove_reference_t<std::remove_cv_t<T>>>, bool> operator>=(ENUM a, T b) {   \
        return static_cast<std::underlying_type_t<ENUM>>(a) >= b;                                                      \
    }

#define GNALC_ENUM_OPERATOR_BITWISE(ENUM)                                                                              \
    inline constexpr ENUM operator|(ENUM a, ENUM b) {                                                                            \
        return static_cast<ENUM>(static_cast<std::underlying_type_t<ENUM>>(a) |                                        \
                                 static_cast<std::underlying_type_t<ENUM>>(b));                                        \
    }                                                                                                                  \
    inline constexpr ENUM operator&(ENUM a, ENUM b) {                                                                            \
        return static_cast<ENUM>(static_cast<std::underlying_type_t<ENUM>>(a) &                                        \
                                 static_cast<std::underlying_type_t<ENUM>>(b));                                        \
    }                                                                                                                  \
    inline constexpr ENUM operator^(ENUM a, ENUM b) {                                                                            \
        return static_cast<ENUM>(static_cast<std::underlying_type_t<ENUM>>(a) ^                                        \
                                 static_cast<std::underlying_type_t<ENUM>>(b));                                        \
    }                                                                                                                  \
    inline constexpr ENUM operator~(ENUM a) { return static_cast<ENUM>(~static_cast<std::underlying_type_t<ENUM>>(a)); }         \
    inline ENUM &operator|=(ENUM &a, ENUM b) {                                                                         \
        a = static_cast<ENUM>(static_cast<std::underlying_type_t<ENUM>>(a) |                                           \
                              static_cast<std::underlying_type_t<ENUM>>(b));                                           \
        return a;                                                                                                      \
    }                                                                                                                  \
    inline ENUM &operator&=(ENUM &a, ENUM b) {                                                                         \
        a = static_cast<ENUM>(static_cast<std::underlying_type_t<ENUM>>(a) &                                           \
                              static_cast<std::underlying_type_t<ENUM>>(b));                                           \
        return a;                                                                                                      \
    }                                                                                                                  \
    inline ENUM &operator^=(ENUM &a, ENUM b) {                                                                         \
        a = static_cast<ENUM>(static_cast<std::underlying_type_t<ENUM>>(a) ^                                           \
                              static_cast<std::underlying_type_t<ENUM>>(b));                                           \
        return a;                                                                                                      \
    }

#define GNALC_ENUM_OPERATOR(ENUM)                                                                                      \
    GNALC_ENUM_OPERATOR_CMP(ENUM)                                                                                      \
    GNALC_ENUM_OPERATOR_CMP_INT(ENUM)                                                                                  \
    GNALC_ENUM_OPERATOR_BITWISE(ENUM)

namespace Util {
template<typename T>
std::underlying_type_t<T> to_underlying(T e) {
    return static_cast<std::underlying_type_t<T>>(e);
}
}
#endif
