#ifndef GNALC_UTILS_EXCEPTION_HPP
#define GNALC_UTILS_EXCEPTION_HPP
#pragma once


#if __has_include(<experimental/source_location>)
#define GNALC_SOURCE_LOCATION_ENABLE 1
#include <experimental/source_location>
using std::experimental::source_location;
#elif __has_include(<source_location>)
#define GNALC_SOURCE_LOCATION_ENABLE 1
#include <source_location>
using std::source_location;
#else
#define GNALC_SOURCE_LOCATION_ENABLE 0
#endif

#include <cstdint>
#include <stdexcept>
#include <string>

namespace Err {
class GnalcException : public std::logic_error {
    std::string detail;

public:
#if GNALC_SOURCE_LOCATION_ENABLE
    static std::string location_to_str(const source_location &l)
    {
        return std::string(l.file_name()) + ":" + std::to_string(l.line()) +
               ":" + l.function_name() + "()";
    }
    explicit GnalcException(const std::string &detail_, source_location loc_ = source_location::current())
        : logic_error("\033[0;32;31mError: \033[1;37m" + location_to_str(loc_) + ":\033[m " + detail_),
            detail(detail_) {}
#else
    explicit GnalcException(const std::string &detail_)
        : logic_error("\033[0;32;31mError\033[m: " + detail_), detail(detail_) {}
#endif
};

#if GNALC_SOURCE_LOCATION_ENABLE
inline void gassert(bool b, const std::string &detail_ = "Assertion failed.",
    source_location loc_ = source_location::current()) {
    if (!b) {
        throw GnalcException(detail_, loc_);
    }
}

inline void todo(const std::string &detail_ = "", source_location loc_ = source_location::current()) {
    throw GnalcException("TODO: " + detail_, loc_);
}

inline void not_implemented(const std::string &detail_ = "", source_location loc_ = source_location::current()) {
    throw GnalcException("Not implemented: " + detail_, loc_);
}

inline void unreachable(const std::string &detail_ = "", source_location loc_ = source_location::current()) {
    throw GnalcException("Unreachable: " + detail_, loc_);
}
inline void error(const std::string &detail_, source_location loc_ = source_location::current()) {
    throw GnalcException(detail_, loc_);
}
#else
inline void gassert(bool b, const std::string &detail_ = "Assertion failed.") {
    if (!b) {
        throw GnalcException(detail_);
    }
}

inline void todo(const std::string &detail_ = "") {
    throw GnalcException("TODO: " + detail_);
}

inline void not_implemented(const std::string &detail_ = "") {
    throw GnalcException("Not implemented: " + detail_);
}

inline void unreachable(const std::string &detail_ = "") {
    throw GnalcException("Unreachable: " + detail_);
}
inline void error(const std::string &detail_) { throw GnalcException(detail_); }
#endif
} // namespace Err
#endif
