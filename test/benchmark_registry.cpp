#include "benchmark_support.hpp"

using namespace Test;
using Entry = BenchmarkRegistry::Entry;

// Requires: ./example_exes/example_23
void register_example_23() {
    Entry entry{
        .ir_gen =
            [](const std::string &newsy, const std::string &outll) {
                return format("./example_exes/example_23 -t llvm {} -O3 -o {} && sed 's/@starttime/@_sysy_starttime/' "
                              "{} -i && sed 's/@stoptime/@_sysy_stoptime/' {} -i",
                              newsy, outll, outll, outll);
            },
        .asm_gen =
            [](const std::string &newsy, const std::string &outs) {
                return format("./example_exes/example_23 -t arm {} -O3 -o {}", newsy, outs);
            },
    };
    BenchmarkRegistry::register_benchmark("example_23", entry);
}

// Requires: ./example_exes/example_24/
void register_example_24() {
    Entry entry{
        .ir_gen =
            [](const std::string &newsy, const std::string &outll) {
                return format("java ./example_exes/example_24/src/example_24.java {} -arm {} no.s", newsy, outll);
            },
        .asm_gen =
            [](const std::string &newsy, const std::string &outs) {
                return format("java ./example_exes/example_24/src/example_24.java {} -arm {} no.ll", newsy, outs);
            },
    };
    BenchmarkRegistry::register_benchmark("example_24", entry);
}

// Only Frontend
// Requires: ./example_exes/example_24_1
void register_example_24_1() {
    Entry entry{
        .ir_gen =
            [](const std::string &newsy, const std::string &outll) {
                return format("./example_exes/example_24_1 {} -llvm -o {} -O2", newsy, outll);
            },
        .asm_gen =
            [](const std::string &newsy, const std::string &outs) {
                Err::not_implemented("Benchmark for example_24_1 backend");
                return "";
            },
    };
    BenchmarkRegistry::register_benchmark("example_24_1", entry);
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
                    "float "
                    "a[]);void putf(char a[], ...);void _sysy_starttime(int);void _sysy_stoptime(int);\\n#define "
                    "starttime() "
                    "_sysy_starttime(__LINE__)\\n#define stoptime()  _sysy_stoptime(__LINE__)' {}"
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
                    "sed -i '1i\\extern \"C\"{ int getint(),getch(),getarray(int a[]);float getfloat();int getfarray(float "
                    "a[]);void "
                    "putint(int a),putch(int a),putarray(int n,int a[]);void putfloat(float a);void putfarray(int n, "
                    "float "
                    "a[]);void putf(char a[], ...);void _sysy_starttime(int);void _sysy_stoptime(int);\\n#define "
                    "starttime() "
                    "_sysy_starttime(__LINE__)\\n#define stoptime()  _sysy_stoptime(__LINE__)' {}"
                    " && echo '}' >> {} && {} -O3 -S -o {} -xc++ {}",
                    newsy, newsy, cfg::gcc_arm_command, outs, newsy);
            }};
    BenchmarkRegistry::register_benchmark("gcc_o3", entry);
}

// Requires ./gnalc
Entry gnalc_register_helper(const std::string &param) {
    Entry entry{
        .ir_gen =
            [param](const std::string &newsy, const std::string &outll) {
                return format("../gnalc -emit-llvm -S {} -o {} {}", newsy, outll, param);
            },
        .asm_gen = [param](const std::string &newsy,
                           const std::string &outs) { return format("../gnalc -S {} -o {} {}", newsy, outs, param); }};
    return entry;
}

void register_gnalc_mem2reg() {
    auto entry = gnalc_register_helper("--mem2reg");
    BenchmarkRegistry::register_benchmark("gnalc_mem2reg", entry);
}

void register_gnalc_o1() {
    auto entry = gnalc_register_helper("-O1");
    BenchmarkRegistry::register_benchmark("gnalc_o1", entry);
}

void register_gnalc_fixed() {
    auto entry = gnalc_register_helper("-fixed-point");
    BenchmarkRegistry::register_benchmark("gnalc_fixed", entry);
}

void register_gnalc_debug() {
    auto entry = gnalc_register_helper("-debug-pipeline");
    BenchmarkRegistry::register_benchmark("gnalc_debug", entry);
}

void Test::register_all_benchmarks() {
    register_example_23();
    register_example_24();
    register_example_24_1();
    register_clang_o3();
    register_gcc_o3();
    register_gnalc_mem2reg();
    register_gnalc_o1();
    register_gnalc_fixed();
    register_gnalc_debug();
}