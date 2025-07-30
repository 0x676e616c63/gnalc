// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "benchmark_support.hpp"
#include "utils/misc.hpp"

using namespace Test;
using Entry = BenchmarkRegistry::Entry;

// Requires: ./example_exes/example_0
void register_example_0() {
    Entry entry{
        .ir_gen =
            [](const std::string &newsy, const std::string &outll) {
                return format("./example_exes/example_0 -t llvm {} -O3 -o {} && sed 's/@starttime/@_sysy_starttime/' "
                              "{} -i && sed 's/@stoptime/@_sysy_stoptime/' {} -i",
                              newsy, outll, outll, outll);
            },
        .asm_gen =
            [](const std::string &newsy, const std::string &outs) {
                return format("./example_exes/example_0 -t arm {} -O3 -o {}", newsy, outs);
            },
    };
    BenchmarkRegistry::register_benchmark("example_0", entry);
}

// Requires: ./example_exes/example_1/
void register_example_1() {
    Entry entry{
        .ir_gen =
            [](const std::string &newsy, const std::string &outll) {
                return format("java ./example_exes/example_1/src/example_1.java {} -arm {} no.s", newsy, outll);
            },
        .asm_gen =
            [](const std::string &newsy, const std::string &outs) {
                return format("java ./example_exes/example_1/src/example_1.java {} -arm {} no.ll", newsy, outs);
            },
    };
    BenchmarkRegistry::register_benchmark("example_1", entry);
}

// Only Frontend
// Requires: ./example_exes/example_2
void register_example_2() {
    Entry entry{
        .ir_gen =
            [](const std::string &newsy, const std::string &outll) {
                return format("./example_exes/example_2 {} -llvm -o {} -O2", newsy, outll);
            },
        .asm_gen =
            [](const std::string &newsy, const std::string &outs) {
                Err::not_implemented("Benchmark for example_2 backend");
                return "";
            },
    };
    BenchmarkRegistry::register_benchmark("example_2", entry);
}

// Only Frontend
// Requires: ./example_exes/example_3
void register_example_3() {
    Entry entry{
        .ir_gen =
            [](const std::string &newsy, const std::string &outll) {
                return format("./example_exes/example_3 -S {} -ll {} -O1", newsy, outll);
            },
        .asm_gen =
            [](const std::string &newsy, const std::string &outs) {
                Err::not_implemented("Benchmark for example_3 backend");
                return "";
            },
    };
    BenchmarkRegistry::register_benchmark("example_3", entry);
}

// Only Frontend
// Requires: ./example_exes/example_4
void register_example_4() {
    Entry entry{
        .ir_gen =
            [](const std::string &newsy, const std::string &outll) {
                return format(
                    "./example_exes/example_4 -S -o {} {} "
                    "&& echo 'declare i32 @getint() \n declare i32 @getch() \n declare i32 @getarray(i32* noundef) \n "
                    "declare float @getfloat() \n declare i32 @getfarray(float* noundef) \n declare void @putint(i32 "
                    "noundef) \n declare void @putch(i32 noundef) \n declare void @putarray(i32 noundef, i32* noundef) "
                    "\n declare void @putfloat(float noundef) \n declare void @putfarray(i32 noundef, float* noundef) "
                    "\n declare void @putf(i8* noundef, ...) \n declare void @_sysy_starttime(i32 noundef) \n declare "
                    "void @_sysy_stoptime(i32 noundef)' >> {}",
                    outll, newsy, outll);
            },
        .asm_gen =
            [](const std::string &newsy, const std::string &outs) {
                Err::not_implemented("Benchmark for example_4 backend");
                return "";
            },
    };
    BenchmarkRegistry::register_benchmark("example_4", entry);
}

// Only Backend
// Requires: ./example_exes/example_5
void register_example_5() {
    Entry entry{
        .ir_gen =
            [](const std::string &newsy, const std::string &outll) {
                Err::not_implemented("Benchmark for example_5 frontend");
                return "";
            },
        .asm_gen =
            [](const std::string &newsy, const std::string &outs) {
                return format("./example_exes/example_5 -S -O1 {} --arm -o {}", newsy, outs);
            },
    };
    BenchmarkRegistry::register_benchmark("example_5", entry);
}

// Only Frontend
// Requires: clang
void register_clang_o3() {
    Entry entry{
        .ir_gen =
            [](const std::string &newsy, const std::string &outll) {
                auto ret = format(
                    "sed -i '1i\\int getint(),getch(),getarray(int a[]);float getfloat();int getfarray(float a[]);void "
                    "putint(int a),putch(int a),putarray(int n,int a[]);void putfloat(float a);void putfarray(int n, "
                    "float a[]);void putf(char a[], ...);void _sysy_starttime(int);void _sysy_stoptime(int);typedef "
                    "void (*Task)(int beg, int end); void gnalc_parallel_for(int beg, int end, "
                    "Task task);\\n#define starttime() _sysy_starttime(__LINE__)\\n#define stoptime()  "
                    "_sysy_stoptime(__LINE__)' {}"
                    " && clang -O3 -Xclang -disable-O0-optnone -xc {} -emit-llvm -S -o {} 2>/dev/null",
                    newsy, newsy, outll);

                return ret;
            },
        .asm_gen =
            [](const std::string &newsy, const std::string &outs) {
                Err::not_implemented("Benchmark for clang backend");
                return "";
            }};
    BenchmarkRegistry::register_benchmark("clang_o3", entry);
}

// Only Backend
// Requires: arm gcc
void register_gcc_o3() {
    Entry entry{
        .ir_gen =
            [](const std::string &newsy, const std::string &outll) {
                Err::not_implemented("Benchmark for gcc frontend");
                return "";
            },
        .asm_gen =
            [](const std::string &newsy, const std::string &outs) {
                return format(
                    "sed -i '1i\\int getint(),getch(),getarray(int a[]);float getfloat();int "
                    "getfarray(float "
                    "a[]);void "
                    "putint(int a),putch(int a),putarray(int n,int a[]);void putfloat(float a);void putfarray(int n, "
                    "float "
                    "a[]);void putf(char a[], ...);void _sysy_starttime(int);void _sysy_stoptime(int);\\n#define "
                    "starttime() "
                    "_sysy_starttime(__LINE__)\\n#define stoptime()  _sysy_stoptime(__LINE__)' {}"
                    " && {} -O3 -fpermissive -fno-builtin-exp -Wno-builtin-declaration-mismatch "
                    "-Wno-incompatible-pointer-types -Wno-error=incompatible-pointer-types -S -o {} -xc {}",
                    newsy, cfg::gcc_arm_command, outs, newsy);
            }};
    BenchmarkRegistry::register_benchmark("gcc_o3", entry);
}

// Requires ./gnalc
Entry gnalc_register_helper(const std::string &param) {
    Entry entry{.ir_gen =
                    [param](const std::string &newsy, const std::string &outll) {
                        return format("../gnalc -with-runtime -emit-llvm -S {} -o {} {}", newsy, outll, param);
                    },
                .asm_gen =
                    [param](const std::string &newsy, const std::string &outs) {
                        return format("../gnalc -with-runtime -S {} -o {} {}", newsy, outs, param);
                    }};
    return entry;
}

void register_gnalc_mem2reg() {
    auto entry = gnalc_register_helper("--mem2reg");
    BenchmarkRegistry::register_benchmark("gnalc_mem2reg", entry);
}

void register_gnalc_std() {
    auto entry = gnalc_register_helper("-std-pipeline");
    BenchmarkRegistry::register_benchmark("gnalc_std", entry);
}

void register_gnalc_fixed() {
    auto entry = gnalc_register_helper("-fixed-point");
    BenchmarkRegistry::register_benchmark("gnalc_fixed", entry);
}

#define REGISTER_GNALC_FIXED_EXCEPT_PASS(pass)                                                                         \
    void register_gnalc_fixed_no_##pass() {                                                                            \
        auto entry = gnalc_register_helper("-fixed-point --no-" GNALC_STRINGFY(pass));                                 \
        BenchmarkRegistry::register_benchmark("gnalc_fixed_no_" GNALC_STRINGFY(pass), entry);                          \
    }

REGISTER_GNALC_FIXED_EXCEPT_PASS(memo)
REGISTER_GNALC_FIXED_EXCEPT_PASS(parallel)
REGISTER_GNALC_FIXED_EXCEPT_PASS(vectorizer)
REGISTER_GNALC_FIXED_EXCEPT_PASS(gepflatten)
REGISTER_GNALC_FIXED_EXCEPT_PASS(interchange)
REGISTER_GNALC_FIXED_EXCEPT_PASS(unswitch)
REGISTER_GNALC_FIXED_EXCEPT_PASS(fuse)
REGISTER_GNALC_FIXED_EXCEPT_PASS(reshapefold)
REGISTER_GNALC_FIXED_EXCEPT_PASS(loopunroll)
REGISTER_GNALC_FIXED_EXCEPT_PASS(codesink)
REGISTER_GNALC_FIXED_EXCEPT_PASS(inline)
REGISTER_GNALC_FIXED_EXCEPT_PASS(internalize)
REGISTER_GNALC_FIXED_EXCEPT_PASS(lsr)

void register_gnalc_fixed_no_inline_lsr() {
    auto entry = gnalc_register_helper("--no-inline --no-lsr");
    BenchmarkRegistry::register_benchmark("gnalc_fixed_no_inline_lsr", entry);
}

void register_gnalc_debug() {
    auto entry = gnalc_register_helper("-debug-pipeline");
    BenchmarkRegistry::register_benchmark("gnalc_debug", entry);
}

void register_gnalc_sir_debug() {
    auto entry = gnalc_register_helper("-sir-debug-pipeline -O1");
    BenchmarkRegistry::register_benchmark("gnalc_sir_debug", entry);
}

void register_gnalc_fuzz3() {
    auto entry = gnalc_register_helper("-fuzz-rate 3");
    BenchmarkRegistry::register_benchmark("gnalc_fuzz3", entry);
}

void register_gnalc_fuzz5() {
    auto entry = gnalc_register_helper("-fuzz-rate 5");
    BenchmarkRegistry::register_benchmark("gnalc_fuzz5", entry);
}

void register_gnalc_fuzz10() {
    auto entry = gnalc_register_helper("-fuzz-rate 10");
    BenchmarkRegistry::register_benchmark("gnalc_fuzz10", entry);
}

void register_gnalc_fuzz100() {
    auto entry = gnalc_register_helper("-fuzz-rate 100");
    BenchmarkRegistry::register_benchmark("gnalc_fuzz100", entry);
}

// Requires ./gnalc2
Entry gnalc2_register_helper(const std::string &param) {
    Entry entry{.ir_gen =
                    [param](const std::string &newsy, const std::string &outll) {
                        return format("../gnalc2 -with-runtime -emit-llvm -S {} -o {} {}", newsy, outll, param);
                    },
                .asm_gen =
                    [param](const std::string &newsy, const std::string &outs) {
                        return format("../gnalc2 -with-runtime -S {} -o {} {}", newsy, outs, param);
                    }};
    return entry;
}

void register_gnalc2_fixed() {
    auto entry = gnalc2_register_helper("-fixed-point");
    BenchmarkRegistry::register_benchmark("gnalc2_fixed", entry);
}

void register_gnalc2_fixed_no_vectorizer() {
    auto entry = gnalc2_register_helper("-fixed-point --no-vectorizer");
    BenchmarkRegistry::register_benchmark("gnalc2_fixed_no_vectorizer", entry);
}

void register_gnalc2_fixed_no_loopunroll() {
    auto entry = gnalc2_register_helper("-fixed-point --no-loopunroll");
    BenchmarkRegistry::register_benchmark("gnalc2_fixed_no_loopunroll", entry);
}

void register_gnalc2_loadEli_w0() {
    auto entry = gnalc2_register_helper("-O1 -loadEli=60");
    BenchmarkRegistry::register_benchmark("gnalc2_loadEli_w0", entry);
}

void register_gnalc2_loadEli_w1() {
    auto entry = gnalc2_register_helper("-O1 -loadEli=100");
    BenchmarkRegistry::register_benchmark("gnalc2_loadEli_w1", entry);
}

void register_gnalc2_loadEli_w2() {
    auto entry = gnalc2_register_helper("-O1 -loadEli=200");
    BenchmarkRegistry::register_benchmark("gnalc2_loadEli_w2", entry);
}

void register_gnalc2_loadEli_w3() {
    auto entry = gnalc2_register_helper("-O1 -loadEli=500");
    BenchmarkRegistry::register_benchmark("gnalc2_loadEli_w3", entry);
}

void register_gnalc_no_mlicm() {
    auto entry = gnalc_register_helper("-O1 -fno-machineLICM");
    BenchmarkRegistry::register_benchmark("gnalc_fixed_no_mlicm", entry);
}

void register_gnalc_no_mloadeli() {
    auto entry = gnalc_register_helper("-O1 -fno-redundantLoadEli");
    BenchmarkRegistry::register_benchmark("gnalc_fixed_no_mloadeli", entry);
}

void Test::register_all_benchmarks() {
    register_example_0();
    register_example_1();
    register_example_2();
    register_example_3();
    register_example_4();
    register_example_5();
    register_clang_o3();
    register_gcc_o3();
    register_gnalc_mem2reg();
    register_gnalc_std();
    register_gnalc_fixed();
    register_gnalc2_loadEli_w0();
    register_gnalc2_loadEli_w1();
    register_gnalc2_loadEli_w2();
    register_gnalc2_loadEli_w3();

    register_gnalc_fixed_no_memo();
    register_gnalc_fixed_no_parallel();
    register_gnalc_fixed_no_vectorizer();
    register_gnalc_fixed_no_gepflatten();
    register_gnalc_fixed_no_interchange();
    register_gnalc_fixed_no_unswitch();
    register_gnalc_fixed_no_fuse();
    register_gnalc_fixed_no_reshapefold();
    register_gnalc_fixed_no_inline();
    register_gnalc_fixed_no_loopunroll();
    register_gnalc_fixed_no_codesink();

    register_gnalc_sir_debug();
    register_gnalc_debug();
    register_gnalc_fuzz3();
    register_gnalc_fuzz5();
    register_gnalc_fuzz10();
    register_gnalc_fuzz100();
    register_gnalc_no_mlicm();
    register_gnalc_no_mloadeli();
    register_gnalc_fixed_no_internalize();
    register_gnalc_fixed_no_lsr();
    register_gnalc_fixed_no_inline_lsr();

    register_gnalc2_fixed();
    register_gnalc2_fixed_no_vectorizer();
    register_gnalc2_fixed_no_loopunroll();
}