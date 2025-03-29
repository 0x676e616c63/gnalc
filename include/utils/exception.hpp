#ifndef GNALC_UTILS_EXCEPTION_HPP
#define GNALC_UTILS_EXCEPTION_HPP
#pragma once

#include <cstdint>
#include <stdexcept>
#include <string>

#include "stacktrace.hpp"

#if __has_builtin(__builtin_FILE) && __has_builtin(__builtin_FUNCTION) && __has_builtin(__builtin_LINE)
#define GNALC_SOURCE_LOCATION_ENABLE
struct SourceLocation {
    static constexpr SourceLocation current(const char *file = __builtin_FILE(),
                                            const char *func = __builtin_FUNCTION(),
                                            uint32_t line = __builtin_LINE()) noexcept {
        SourceLocation loc;
        loc.file = file;
        loc.func = func;
        loc.lineno = line;
        return loc;
    }

    [[nodiscard]] constexpr uint32_t line() const noexcept { return lineno; }
    [[nodiscard]] constexpr const char *file_name() const noexcept { return file; }
    [[nodiscard]] constexpr const char *function_name() const noexcept { return func; }

private:
    const char *file{};
    const char *func{};
    uint32_t lineno{};
};

static std::string location_to_str(const SourceLocation &l) {
    return std::string(l.file_name()) + ":" + std::to_string(l.line()) + ":" + l.function_name() + "()";
}
#endif

namespace Err {
class GnalcException : public std::logic_error {
    std::string detail;

public:
#ifdef GNALC_SOURCE_LOCATION_ENABLE
    explicit GnalcException(const std::string &detail_, SourceLocation loc_ = SourceLocation::current())
        : logic_error("\033[0;32;31mError: \033[1;37m" + location_to_str(loc_) + ":\033[m " + detail_),
          detail(detail_) {
        print_stacktrace();
    }
#else
    explicit GnalcException(const std::string &detail_)
        : logic_error("\033[0;32;31mError\033[m: " + detail_), detail(detail_) {}
#endif
};

#ifdef GNALC_SOURCE_LOCATION_ENABLE
inline void gassert(bool b, const std::string &detail_ = "Assertion failed.",
                    SourceLocation loc_ = SourceLocation::current()) {
    if (!b) {
        throw GnalcException(detail_, loc_);
    }
}

inline void todo(const std::string &detail_ = "", SourceLocation loc_ = SourceLocation::current()) {
    throw GnalcException("TODO: " + detail_, loc_);
}

inline void not_implemented(const std::string &detail_ = "", SourceLocation loc_ = SourceLocation::current()) {
    throw GnalcException("Not implemented: " + detail_, loc_);
}

inline void unreachable(const std::string &detail_ = "", SourceLocation loc_ = SourceLocation::current()) {
    throw GnalcException("Unreachable: " + detail_, loc_);
}
inline void error(const std::string &detail_, SourceLocation loc_ = SourceLocation::current()) {
    throw GnalcException(detail_, loc_);
}
#else
inline void gassert(bool b, const std::string &detail_ = "Assertion failed.") {
    if (!b) {
        throw GnalcException(detail_);
    }
}

inline void todo(const std::string &detail_ = "") { throw GnalcException("TODO: " + detail_); }

inline void not_implemented(const std::string &detail_ = "") { throw GnalcException("Not implemented: " + detail_); }

inline void unreachable(const std::string &detail_ = "") { throw GnalcException("Unreachable: " + detail_); }
inline void error(const std::string &detail_) { throw GnalcException(detail_); }
#endif
} // namespace Err
#endif
