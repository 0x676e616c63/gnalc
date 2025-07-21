// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../include/utils/misc.hpp"
#include <string>

namespace Util {
bool beginsWith(const std::string &a, const std::string &b) {
    if (a.size() < b.size())
        return false;
    for (size_t i = 0; i < b.size(); ++i) {
        if (a[i] != b[i]) {
            return false;
        }
    }
    return true;
}
}