#include <filesystem>
#include <string>
#include <vector>
#include <fstream>
#include <ctime>
#include <iomanip>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <queue>
#include <atomic>
#include <functional>
#include <future>

#include "config.hpp"
#include "runner.hpp"

using namespace Test;
using namespace std::filesystem;

struct Entry {
    std::string id;
    std::string ir_or_asm;
    std::string testcase_out;
    std::string testcase_in;
};

struct Result {
    std::string id;
    std::string file_path;
    size_t time_elapsed;
    std::string expected_output;
    std::string actual_output;
    bool passed;
};

std::string escape_md(const std::string& input) {
    std::string output;
    for (char c : input) {
        if (c == '\\') output += "\\\\";
        else if (c == '`') output += "\\`";
        else if (c == '*') output += "\\*";
        else if (c == '_') output += "\\_";
        else if (c == '{' || c == '}') output += "\\" + std::string(1, c);
        else if (c == '[' || c == ']') output += "\\" + std::string(1, c);
        else if (c == '(' || c == ')') output += "\\" + std::string(1, c);
        else if (c == '#') output += "\\#";
        else if (c == '+') output += "\\+";
        else if (c == '-') output += "\\-";
        else if (c == '.') output += "\\.";
        else if (c == '!') output += "\\!";
        else output += c;
    }
    return output;
}

class ThreadPool {
public:
    explicit ThreadPool(size_t thread_count) : stop(false) {
        for (size_t i = 0; i < thread_count; ++i) {
            workers.emplace_back([this] {
                while (true) {
                    std::function<void()> task;
                    {
                        std::unique_lock<std::mutex> lock(this->queue_mutex);
                        this->condition.wait(lock, [this] {
                            return this->stop || !this->tasks.empty();
                        });
                        if (this->stop && this->tasks.empty())
                            return;
                        task = std::move(this->tasks.front());
                        this->tasks.pop();
                    }
                    task();
                }
            });
        }
    }

    template<class F>
    void enqueue(F&& task) {
        {
            std::unique_lock<std::mutex> lock(queue_mutex);
            if (stop)
                throw std::runtime_error("enqueue on stopped ThreadPool");
            tasks.emplace(std::forward<F>(task));
        }
        condition.notify_one();
    }

    ~ThreadPool() {
        {
            std::unique_lock<std::mutex> lock(queue_mutex);
            stop = true;
        }
        condition.notify_all();
        for (std::thread &worker : workers)
            worker.join();
    }

private:
    std::vector<std::thread> workers;
    std::queue<std::function<void()>> tasks;
    std::mutex queue_mutex;
    std::condition_variable condition;
    bool stop;
};

template <typename ...Args>
void safe_println(Args&& ...args) {
    static std::mutex print_mutex;
    std::lock_guard<std::mutex> lock(print_mutex);
    println(std::forward<Args>(args)...);
}

// UTC+8
std::tm get_beijing_time() {
    auto now = std::time(nullptr);
    now += 8 * 3600;
    return *std::gmtime(&now);
}


int main(int argc, char *argv[]) {
    auto print_help = [&argv] {
        println("Usage: {} [options]", argv[0]);
        println("Options:");
        println("  -b, --backend       Test backend.");
        println("  -d, --data          Test data directory.");
        println("  -p, --para [Param]  Run with gnalc parameter.");
        println("  -s, --sha [SHA]     Commit SHA for test metadata.");
        println("  -l, --sylib         Specify sylib.c.");
        println("  -r, --report [Path] Path to save test report.");
        println("  -h, --help          Print this help message.");
    };

    bool only_frontend = true;
    std::string testdata_dir;
    std::string gnalc_params;
    std::string commit_sha;
    std::string sylibc = cfg::sylibc;
    std::string report_path = "test_report.md";

    for (int i = 1; i < argc; i++) {
        std::string arg = argv[i];
        if (arg == "--backend" || arg == "-b")
            only_frontend = false;
        else if (arg == "--data" || arg == "-d") {
            if (i + 1 >= argc) {
                println("Error: Expected a directory.");
                print_help();
                return -1;
            }
            testdata_dir = argv[i + 1];
            ++i;
        } else if (arg == "--help" || arg == "-h") {
            print_help();
            return 0;
        } else if (arg == "--para" || arg == "-p") {
            if (i + 1 >= argc) {
                println("Error: Expected a parameter.");
                print_help();
                return -1;
            }
            gnalc_params += " " + std::string(argv[++i]);
        } else if (arg == "--sha" || arg == "-s") {
            if (i + 1 >= argc) {
                println("Error: Expected a commit SHA.");
                print_help();
                return -1;
            }
            commit_sha = argv[++i];
        } else if (arg == "--sylib" || arg == "-l") {
            if (i + 1 >= argc) {
                println("Error: Expected a sylib.c");
                print_help();
                return -1;
            }
            sylibc = argv[++i];
        } else if (arg == "--report" || arg == "-r") {
            if (i + 1 >= argc) {
                println("Error: Expected a report path.");
                print_help();
                return -1;
            }
            report_path = argv[++i];
        } else {
            println("Error: Unrecognized option '{}'", arg);
            print_help();
            return -1;
        }
    }

    println("GNALC test started. (GitHub Action)");
    create_directories(cfg::global_temp_dir);

    auto sylib_to_link = prepare_sylib(cfg::global_temp_dir, only_frontend, sylibc);

    std::vector<Entry> entries;
    std::string line;
    while (std::getline(std::cin, line)) {
        if (!line.empty()) {
            path path(line);
            if ((path.extension() == ".s" && only_frontend) || (path.extension() == ".ll" && !only_frontend))
                continue;

            auto parent_path = path.parent_path();
            bool is_final = parent_path.parent_path().stem() == "final";
            auto base_path = testdata_dir + "/" +
                (is_final  ? "final/" : "")
                + parent_path.stem().string() + "/" + path.stem().string();
            entries.emplace_back(Entry{
                .id = (is_final ? "final-" : "") + parent_path.stem().string() + "-" + path.stem().string(),
                .ir_or_asm = path,
                .testcase_out = base_path + ".out",
                .testcase_in = base_path + ".in",
            });
        }
    }

    std::vector<Result> results(entries.size());
    std::atomic<size_t> test_counter{0};
    size_t num_threads = std::thread::hardware_concurrency();
    if (num_threads == 0) num_threads = 2;

    {
        ThreadPool pool(num_threads);
        for (size_t i = 0; i < entries.size(); ++i) {
            pool.enqueue([i, &entries, &results, only_frontend, &sylib_to_link, &test_counter] {
                const auto& curr_test = entries[i];
                size_t curr = test_counter.fetch_add(1) + 1;
                safe_println("<{}> Test {}", curr, curr_test.id);

                try {
                    auto curr_temp_dir = cfg::global_temp_dir + "/" + curr_test.id;
                    create_directories(curr_temp_dir);

                    CheckIRAsmData data = {
                        .id = curr_test.id,
                        .ir_or_asm = curr_test.ir_or_asm,
                        .sylib = sylib_to_link,
                        .temp_dir = curr_temp_dir,
                        .input = curr_test.testcase_in,
                    };

                    auto res = check_ir_asm(data, only_frontend);
                    auto expected_syout = read_file(curr_test.testcase_out);
                    fix_newline(expected_syout);

                    results[i] = Result{
                        .id = curr_test.id,
                        .file_path = curr_test.ir_or_asm,
                        .time_elapsed = res.time_elapsed,
                        .expected_output = expected_syout,
                        .actual_output = res.output,
                        .passed = (res.output == expected_syout)
                    };
                } catch (const std::exception& e) {
                    results[i] = Result{
                        .id = curr_test.id,
                        .file_path = curr_test.ir_or_asm,
                        .time_elapsed = 0,
                        .expected_output = "",
                        .actual_output = "Exception: " + std::string(e.what()),
                        .passed = false
                    };
                } catch (...) {
                    results[i] = Result{
                        .id = curr_test.id,
                        .file_path = curr_test.ir_or_asm,
                        .time_elapsed = 0,
                        .expected_output = "",
                        .actual_output = "Unknown exception",
                        .passed = false
                    };
                }
            });
        }
    }

    std::ofstream report(report_path);
    if (!report) {
        println("Error: Failed to open report file: {}", report_path);
        return -1;
    }

    auto tm = get_beijing_time();
    report << "## Test Results - " << std::put_time(&tm, "%Y-%m-%d %H:%M:%S") << "\n\n";
    auto build_md_url = [](const std::string& sha) {
        return "[" + sha + "](https://github.com/Althra/gnalc/commit/" + sha + ")";
    };
    report << "- **Artifacts Commit:** " << (commit_sha.empty() ? "N/A" : build_md_url(commit_sha)) << "\n";
    report << "- **Total Tests:** " << entries.size() << "\n";
    report << "- **Mode:** " << (only_frontend ? "Frontend only" : "With backend") << "\n\n";

    size_t passed = 0;
    std::vector<std::string> failed_tests;
    for (const auto& tres : results) {
        report << "#### Test: " << tres.id << "\n";
        report << "- **File:** " << tres.file_path << "\n";
        report << "- **Time Elapsed:** " << tres.time_elapsed << "us\n";
        report << "- **Status:** ";

        if (tres.passed) {
            ++passed;
            report << "✅ PASSED\n";
        } else {
            failed_tests.push_back(tres.id);
            report << "❌ FAILED\n";
            report << "- **Expected:** " << (tres.expected_output.size() > 512 ?
                "<output too long>" : escape_md(tres.expected_output)) << "\n";
            report << "- **Actual:** " << (tres.actual_output.size() > 512 ?
                "<output too long>" : escape_md(tres.actual_output)) << "\n";
        }
        report << "\n";
    }

    if (!failed_tests.empty()) {
        report << "\n### Failed Tests\n\n";
        for (const auto& test : failed_tests) {
            report << "- " << test << "\n";
        }
    }

    report << "### Summary\n\n";
    report << "| Status | Count |\n";
    report << "|--------|-------|\n";
    report << "| ✅ Passed | " << passed << " |\n";
    report << "| ❌ Failed | " << failed_tests.size() << " |\n";
    report << "| **Total** | **" << entries.size() << "** |\n";

    report.close();
    return 0;
}