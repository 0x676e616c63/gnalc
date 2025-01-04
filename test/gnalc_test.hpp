#ifndef GNALC_TEST_HPP
#define GNALC_TEST_HPP

#include <chrono>
#include <string>
#include <sstream>
#include <vector>

#include <ctime>

#include "../include/utils/exception.hpp"

namespace Test
{
inline std::string generate_unique_temp_dir() {
    auto systt = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());
    struct tm *ptm = localtime(&systt);
    char date[60] = {0};
    sprintf(date, "%d-%02d-%02d_%02d:%02d:%02d",
           ptm->tm_year + 1900, ptm->tm_mon + 1, ptm->tm_mday,
            ptm->tm_hour, ptm->tm_min, ptm->tm_sec);
    return {date};
}


namespace detail
{
    template<typename T>
    std::string tostr(const T& value) {
        std::ostringstream oss;
        oss << value;
        return oss.str();
    }

    template<typename... Args>
    std::vector<std::string> to_string_vector(Args&&... args) {
        return { tostr(args)... };
    }
}

template <typename ...Args>
std::string format(const std::string& fmtstr, Args&&... args) {
    auto vec_args = detail::to_string_vector(std::forward<Args>(args)...);
    std::string ret;
    ret.reserve(fmtstr.size() * 2);
    size_t argidx = 0;
    for (auto ch = fmtstr.cbegin(); ch < fmtstr.cend(); ++ch)
    {
        if (*ch == '{')
        {
            Err::gassert(ch + 1 != fmtstr.cend()
                && *++ch == '}'
                && argidx < vec_args.size(),
                "Invalid format string");
            ret += vec_args[argidx++];
        }
        else
            ret += *ch;
    }
    Err::gassert(argidx == vec_args.size(), "Invalid format string");
    return ret;
}

template<typename ...Args>
void println(const std::string& fmtstr, Args&&... args) {
    std::cout << format(fmtstr, std::forward<Args>(args)...) << std::endl;
}
}
#endif //GNALC_TEST_HPP
