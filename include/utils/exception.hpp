#ifndef GNALC_UTILS_EXCEPTION_HPP
#define GNALC_UTILS_EXCEPTION_HPP
#pragma once

#include <cstdint>
#include <string>
#include <stdexcept>

namespace Err {
class GnalcException : public std::logic_error {
    std::string detail;
public:
    GnalcException(const std::string &detail_)
        : logic_error("\033[0;32;31mError\033[m: " + detail_),
          detail(detail_) {}
};

inline void assert(bool b, const std::string &detail_ = "Assertion failed.")
{
    if (!b)
    {
        throw GnalcException(detail_);
    }
}
}
#endif
