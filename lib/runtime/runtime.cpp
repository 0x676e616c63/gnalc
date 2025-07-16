#include "runtime/runtime.hpp"

#include "../../runtime/artifacts/thread.armv8.s.cpp"
#include "../../runtime/artifacts/thread.ll.cpp"

#define MAKE_RUNTIME_INIT(name, xxd_name) std::string_view name(reinterpret_cast<char *>(xxd_name), xxd_name##_len);

namespace Runtime::Artifacts {
#define GNALC_RUNTIME_TABLE_ENTRY(name, xxd_name) MAKE_RUNTIME_INIT(name, xxd_name)
GNALC_RUNTIME_TABLE
#undef GNALC_RUNTIME_TABLE_ENTRY
} // namespace Runtime::Artifacts

#undef MAKE_RUNTIME_INIT
