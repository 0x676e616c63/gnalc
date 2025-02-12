#ifndef GNALC_TEST_UTILS_HPP
#define GNALC_TEST_UTILS_HPP

#include <chrono>
#include <ctime>
#include <sstream>
#include <string>
#include <vector>

#include "../include/utils/exception.hpp"

namespace Test {
inline std::string generate_unique_temp_dir() {
    auto systt =
        std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());
    struct tm *ptm = localtime(&systt);
    char date[60] = {0};
    sprintf(date, "%d-%02d-%02d_%02d:%02d:%02d", ptm->tm_year + 1900,
            ptm->tm_mon + 1, ptm->tm_mday, ptm->tm_hour, ptm->tm_min,
            ptm->tm_sec);
    return {date};
}

namespace detail {
template <typename T> std::string tostr(const T &value) {
    std::ostringstream oss;
    oss << value;
    return oss.str();
}

template <typename... Args>
std::vector<std::string> to_string_vector(Args &&...args) {
    return {tostr(args)...};
}
} // namespace detail

template <typename... Args>
std::string format(const std::string &fmtstr, Args &&...args) {
    auto vec_args = detail::to_string_vector(std::forward<Args>(args)...);
    std::string ret;
    ret.reserve(fmtstr.size() * 2);
    size_t argidx = 0;
    for (auto ch = fmtstr.cbegin(); ch < fmtstr.cend(); ++ch) {
        if (*ch == '{') {
            Err::gassert(ch + 1 != fmtstr.cend() && *++ch == '}' &&
                             argidx < vec_args.size(),
                         "Invalid format string");
            ret += vec_args[argidx++];
        } else
            ret += *ch;
    }
    Err::gassert(argidx == vec_args.size(), "Invalid format string");
    return ret;
}

template <typename... Args>
void println(std::ostream& os, const std::string &fmtstr, Args &&...args) {
    os << format(fmtstr, std::forward<Args>(args)...) << std::endl;
}

template <typename... Args>
void println(const std::string &fmtstr, Args &&...args) {
    println(std::cout, fmtstr, std::forward<Args>(args)...);
}

template <typename... Args>
void print(std::ostream& os, const std::string &fmtstr, Args &&...args) {
    os << format(fmtstr, std::forward<Args>(args)...);
}

template <typename... Args>
void print(const std::string &fmtstr, Args &&...args) {
    print(std::cout, fmtstr, std::forward<Args>(args)...);
}

std::string read_file(const std::string &file_name) {
    std::ifstream in(file_name);
    std::istreambuf_iterator<char> beg(in), end;
    return {beg, end};
}

// :(
inline void fix_newline(std::string &str) {
    for (auto &&ch : str)
        if (ch == '\r')
            ch = '\n';

    while (!str.empty() && str[0] == '\n')
        str.erase(0, 1);
    while (!str.empty() && str.back() == '\n')
        str.pop_back();
    for (size_t i = 0; i < str.size();) {
        if (str[i] == '\n' && i + 1 < str.size() && str[i + 1] == '\n')
            str.erase(i, 1);
        else
            ++i;
    }
}

inline bool begins_with(const std::string &a, const std::string &b) {
    if (a.size() < b.size())
        return false;
    for (size_t i = 0; i < b.size(); ++i) {
        if (a[i] != b[i]) {
            return false;
        }
    }
    return true;
}

inline size_t parse_time(const std::string &s) {
    auto lastline_beg = s.rfind('\n', s.size() - 2);
    std::string lastline = s.substr(lastline_beg + 1);
    int hour, minute, second, microsecond;
    sscanf(lastline.c_str(), "TOTAL: %dH-%dM-%dS-%dus\n", &hour, &minute,
           &second, &microsecond);
    return hour * 3600000000 + minute * 60000000 + second * 1000000 +
           microsecond;
}
} // namespace Test
#endif // GNALC_TEST_HPP
