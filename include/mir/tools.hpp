#pragma once
#ifndef GNALC_ARMV8_MIR_TOOLS_HPP
#define GNALC_ARMV8_MIR_TOOLS_HPP

int clz_wrapper(int vic) { return __builtin_clz(static_cast<unsigned>(vic)); }

int ctz_warpper(int vic) { return __builtin_ctz(static_cast<unsigned>(vic)); }

#endif