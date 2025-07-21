// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Stack Trace
// Adapted from: https://panthema.net/2008/0901-stacktrace-demangled/
//
// stacktrace.h (c) 2008, Timo Bingmann from http://idlebox.net/
// published under the WTFPL v2.0

#pragma once
#ifndef GNALC_UTILS_STACKTRACE_HPP
#define GNALC_UTILS_STACKTRACE_HPP

#include <cstdio>
#include <cstdlib>

#ifdef GNALC_STACKTRACE_ENABLE
#include <cxxabi.h>
#include <execinfo.h>

/** Print a demangled stack backtrace of the caller function to FILE* out. */
static void print_stacktrace(FILE *out = stderr, unsigned int max_frames = 63) {
    fprintf(out, "stack trace:\n");

    // storage array for stack trace address data
    void *addr_list[max_frames + 1];

    // retrieve current stack addresses
    int addr_len = backtrace(addr_list, sizeof(addr_list) / sizeof(void *));

    if (addr_len == 0) {
        fprintf(out, "  <empty, possibly corrupt>\n");
        return;
    }

    // resolve addresses into strings containing "filename(function+address)",
    // this array must be free()-ed
    char **symbol_list = backtrace_symbols(addr_list, addr_len);

    // allocate string which will be filled with the demangled function name
    size_t func_name_size = 256;
    char *func_name = static_cast<char *>(malloc(func_name_size));

    // iterate over the returned symbol lines. skip the first, it is the
    // address of this function.
    for (int i = 1; i < addr_len; i++) {
        char *begin_name = nullptr, *begin_offset = nullptr, *end_offset = nullptr;

        // find parentheses and +address offset surrounding the mangled name:
        // ./module(function+0x15c) [0x8048a6d]
        for (char *p = symbol_list[i]; *p; ++p) {
            if (*p == '(')
                begin_name = p;
            else if (*p == '+')
                begin_offset = p;
            else if (*p == ')' && begin_offset) {
                end_offset = p;
                break;
            }
        }

        if (begin_name && begin_offset && end_offset && begin_name < begin_offset) {
            *begin_name++ = '\0';
            *begin_offset++ = '\0';
            *end_offset = '\0';

            // mangled name is now in [begin_name, begin_offset) and caller
            // offset in [begin_offset, end_offset). now apply
            // __cxa_demangle():

            int status;
            char *ret = abi::__cxa_demangle(begin_name, func_name, &func_name_size, &status);
            if (status == 0) {
                func_name = ret; // use possibly realloc()-ed string
                fprintf(out, "  %s: %s+%s\n", symbol_list[i], func_name, begin_offset);
            } else {
                // demangling failed. Output function name as a C function with
                // no arguments.
                fprintf(out, "  %s: %s()+%s\n", symbol_list[i], begin_name, begin_offset);
            }
        } else {
            // couldn't parse the line? print the whole line.
            fprintf(out, "  %s\n", symbol_list[i]);
        }
    }

    free(func_name);
    free(symbol_list);
}

#else
static inline void print_stacktrace(FILE *out = stderr, unsigned int max_frames = 63) {}
#endif
#endif // GNALC_UTILS_STACKTRACE_HPP