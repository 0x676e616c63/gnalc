#ifndef GNALC_UTILS_EXCEPTION_HPP
#define GNALC_UTILS_EXCEPTION_HPP
#pragma once

#include <cstdint>
#include <stdexcept>
#include <string>

namespace Err {
class GnalcException : public std::logic_error {
    std::string detail;

public:
    explicit GnalcException(const std::string &detail_)
        : logic_error("\033[0;32;31mError\033[m: " + detail_), detail(detail_) {
    }
};

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
} // namespace Err
#endif
