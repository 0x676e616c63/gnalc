#include "utils/misc.hpp"
#include <string>

namespace Util {
bool begins_with(const std::string &a, const std::string &b) {
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