// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "utils/test.hpp"
#include <fstream>

namespace Test {
std::string readFile(const std::string &file_name) {
    std::ifstream in(file_name);
    std::istreambuf_iterator<char> beg(in), end;
    return {beg, end};
}

// :(
void fixNewline(std::string &str) {
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

size_t parseTime(const std::string &s) {
    auto lastline_beg = s.rfind('\n', s.size() - 2);
    std::string lastline = s.substr(lastline_beg + 1);
    int hour, minute, second, microsecond;
    sscanf(lastline.c_str(), "TOTAL: %dH-%dM-%dS-%dus\n", &hour, &minute, &second, &microsecond);
    return hour * 3600000000 + minute * 60000000 + second * 1000000 + microsecond;
}
}