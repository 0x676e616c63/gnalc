// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_TEST_BENCHMARK_HPP
#define GNALC_TEST_BENCHMARK_HPP

#include "config.hpp"
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

static void write_benchmark_result_to(const BenchmarkData &data, std::ostream &out,
                                      const std::vector<TestData> &failed) {
    std::vector<RankData> rank;
    size_t total1 = 0;
    size_t total2 = 0;

    auto ratio = [](auto a, auto b) { return static_cast<double>(a) / static_cast<double>(b); };

    for (size_t i = 0; i < data.results1.size() && i < data.results2.size(); ++i) {
        const auto &[test1, res1, success1] = data.results1[i];
        const auto &[test2, res2, success2] = data.results2[i];

        Err::gassert(test1.sy == test2.sy);

        if (!success1 || !success2)
            continue;

        rank.emplace_back(RankData{.testcase = test1.sy.path().stem().string(),
                                   .testcase_path = test1.sy.path(),
                                   .compiler_output1 = res1.source_output,
                                   .compiler_output2 = res2.source_output,
                                   .time1 = res1.time_elapsed,
                                   .time2 = res2.time_elapsed,
                                   .ratio = ratio(res1.time_elapsed, res2.time_elapsed)});

        total1 += res1.time_elapsed;
        total2 += res2.time_elapsed;
    }

    std::sort(rank.begin(), rank.end(), [](const RankData &a, const RankData &b) { return a.ratio < b.ratio; });

    auto average_ratio = ratio(total1, total2);

    println(out, "Benchmark results:");
    bool printed_divider_line = false;
    for (size_t i = 0; i < rank.size(); ++i) {
        const auto &item = rank[i];

        println(out, "<{}> {}:", i, item.testcase);
        println(out, "'{}' compiler output: {}", data.mode1, item.compiler_output1);
        println(out, "'{}': {}us", data.mode1, item.time1);
        println(out, "'{}' compiler output: {}", data.mode2, item.compiler_output2);
        println(out, "'{}': {}us", data.mode2, item.time2);
        println(out, "'{}' is {}x faster than '{}'.", data.mode2, ratio(item.time1, item.time2), data.mode1);

        if (!printed_divider_line && i != rank.size() - 1 && rank[i + 1].ratio >= 1.0) {
            println(out, "------------------------- 1.0x -------------------------");
            printed_divider_line = true;
        } else
            println(out, "--------------------");
    }

    println(out, "Total time:");
    println(out, "'{}': {}us", data.mode1, total1);
    println(out, "'{}': {}us", data.mode2, total2);
    println(out, "On average, '{}' is {}x faster than '{}'.", data.mode2, average_ratio, data.mode1);

    if (!failed.empty()) {
        println(out, "WARNING: {} tests failed!", failed.size());
        println(out, "Failed tests: ");
        for (const auto &f : failed)
            println(out, "| testcase: {} | mode: {}", f.sy.path().string(), f.mode_id);
    }
}

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
