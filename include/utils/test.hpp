#pragma once
#ifndef GNALC_UTILS_TEST_HPP
#define GNALC_UTILS_TEST_HPP

#include <string>

namespace Test {
std::string readFile(const std::string &file_name);

// :(
void fixNewline(std::string &str);

size_t parseTime(const std::string &s);
} // namespace Test
#endif
