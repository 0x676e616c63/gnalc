// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_TEST_BENCHMARK_HPP
#define GNALC_TEST_BENCHMARK_HPP

#include "runner.hpp"
#include "utils.hpp"

#include <map>
#include <optional>
#include <string>

namespace Test {
struct BenchmarkData {
    std::string mode1;
    std::string mode2;

    struct Item {
        TestData data;
        TestResult res;
        bool success{};
    };
    std::vector<Item> results1;
    std::vector<Item> results2;
};

struct RankData {
    std::string testcase;
    std::string testcase_path;
    std::string compiler_output1;
    std::string compiler_output2;
    size_t time1;
    size_t time2;
    double ratio;
};

struct BenchmarkRegistry {
    struct Entry {
        using ir_asm_gen_t = decltype(TestData::ir_asm_gen);
        ir_asm_gen_t ir_gen;
        ir_asm_gen_t asm_gen;
    };

    static void register_benchmark(const std::string &mode_id, const Entry &entry) {
        auto &instance = BenchmarkRegistry::get();
        Err::gassert(!instance.index.count(mode_id), "Benchmark already registered: " + mode_id + ".");
        instance.index.emplace(mode_id, get().benchmarks.size());
        instance.benchmarks.emplace_back(mode_id, entry);
    }

    struct TestInfo {
        std::string mode_id;

        std::filesystem::directory_entry sy;
        std::string sylib;
        std::string temp_dir;
        bool only_frontend;
    };

    static TestData get_test_data(const TestInfo &info) {
        const auto &instance = BenchmarkRegistry::get();
        auto it = instance.index.find(info.mode_id);
        Err::gassert(it != instance.index.end(), "Benchmark not found: " + info.mode_id + ".");

        const auto &entry = instance.benchmarks[it->second].second;
        return TestData{.sy = info.sy,
                        .sylib = info.sylib,
                        .temp_dir = info.temp_dir,
                        .mode_id = info.mode_id,
                        .ir_asm_gen = info.only_frontend ? entry.ir_gen : entry.asm_gen};
    }

    BenchmarkRegistry(const BenchmarkRegistry &) = delete;
    BenchmarkRegistry &operator=(const BenchmarkRegistry &) = delete;

    static auto entries() {
        auto &instance = get();
        std::vector<std::string> ret;
        ret.reserve(instance.benchmarks.size());
        for (const auto &[k, v] : instance.benchmarks)
            ret.emplace_back(k);
        return ret;
    }

private:
    static BenchmarkRegistry &get() {
        static BenchmarkRegistry instance;
        return instance;
    }

    // Ensure a deterministic order of benchmarks
    std::vector<std::pair<std::string, Entry>> benchmarks;
    std::unordered_map<std::string, size_t> index;
    BenchmarkRegistry() = default;
};

void register_all_benchmarks();
} // namespace Test

#endif // GNALC_TEST_BENCHMARK_HPP
