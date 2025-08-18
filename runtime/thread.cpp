// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Gnalc Thread Runtime
#include <atomic>
#include <cmath>
#include <cstdint>
#include <sched.h>
#include <sys/mman.h>

#ifdef GNALC_DEBUG
#include <cstdio>
#include <unistd.h>
#endif

// This is specified by "CG-FPGA15EG ARMCortex-A53MPCore硬件技术规范"
// https://gitlab.eduxiji.net/csc1/nscscc/compiler2025/-/blob/main/CG-FPGA15EG_ARM_Cortex-A53_MPCore_%E7%A1%AC%E4%BB%B6%E6%8A%80%E6%9C%AF%E8%A7%84%E8%8C%83.pdf
static constexpr auto main_cpu = 2;
static constexpr auto worker_cpu = 3;

#ifndef GNALC_DEBUG
static constexpr int32_t small_task_threshold = 16;
#else
static constexpr int32_t small_task_threshold = 0;
#endif

static constexpr auto stack_size = 64 * 1024;
static constexpr int32_t cache_line_size = 64;

using Task = void (*)(int32_t beg, int32_t end);

struct ParallelState {
    alignas(cache_line_size) Task task;
    int32_t worker_beg;
    int32_t worker_end;

    alignas(cache_line_size) std::atomic_bool task_ready;

    alignas(cache_line_size) std::atomic_bool worker_done;

    struct ShutdownFlags {
        std::atomic_bool shutdown;
        std::atomic_bool worker_exited;
    };
    alignas(cache_line_size) ShutdownFlags shutdown_flags;
};

static ParallelState state;
static pid_t worker_pid;
static void *worker_stack;

static int worker_entry(void *) {
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    CPU_SET(worker_cpu, &cpuset);
    sched_setaffinity(0, sizeof(cpuset), &cpuset);

    while (true) {
        while (!state.task_ready.load(std::memory_order_acquire)) {
            if (state.shutdown_flags.shutdown.load(std::memory_order_acquire)) {
                state.shutdown_flags.worker_exited.store(true, std::memory_order_release);
                return 0;
            }
        }

#ifdef GNALC_DEBUG
        fprintf(stderr, "[Worker %d] Running task from %d to %d.\n", worker_pid, state.worker_beg, state.worker_end);
#endif
        state.task(state.worker_beg, state.worker_end);
#ifdef GNALC_DEBUG
        fprintf(stderr, "[Worker %d] Task from %d to %d done\n", worker_pid, state.worker_beg, state.worker_end);
#endif

        state.worker_done.store(true, std::memory_order_release);
        state.task_ready.store(false, std::memory_order_release);
    }
}

extern "C" {
__attribute__((constructor)) void gnalc_thread_init() {
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    CPU_SET(main_cpu, &cpuset);
    sched_setaffinity(0, sizeof(cpuset), &cpuset);

    state.task_ready.store(false, std::memory_order_release);
    state.worker_done.store(false, std::memory_order_release);
    state.shutdown_flags.shutdown.store(false, std::memory_order_release);

    worker_stack = mmap(nullptr, stack_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
    worker_pid = clone(worker_entry, static_cast<char *>(worker_stack) + stack_size,
                       CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM, nullptr);

#ifdef GNALC_DEBUG
    fprintf(stderr, "Worker %d started\n", worker_pid);
#endif
}

__attribute__((destructor)) void gnalc_thread_deinit() {
    state.shutdown_flags.shutdown.store(true, std::memory_order_release);

    while (!state.shutdown_flags.worker_exited.load(std::memory_order_acquire))
        ;

    munmap(worker_stack, stack_size);

#ifdef GNALC_DEBUG
    fprintf(stderr, "Worker %d exited\n", worker_pid);
#endif
}

void gnalc_parallel_for(int32_t beg, int32_t end, Task func) {
    const int32_t size = end - beg;

    if (size <= small_task_threshold) {
#ifdef GNALC_DEBUG
        fprintf(stderr, "[Main %d] Small task from %d to %d detected, running it directly.\n", getpid(), beg, end);
#endif
        func(beg, end);
        return;
    }

    const int32_t mid = beg + size / 2;

    state.worker_beg = mid;
    state.worker_end = end;
    state.task = func;

    state.worker_done.store(false, std::memory_order_relaxed);
    std::atomic_thread_fence(std::memory_order_release);
    state.task_ready.store(true, std::memory_order_release);

#ifdef GNALC_DEBUG
    fprintf(stderr, "[Main %d] Running task from %d to %d\n", getpid(), beg, mid);
#endif
    func(beg, mid);
#ifdef GNALC_DEBUG
    fprintf(stderr, "[Main %d] Task from %d to %d done\n", getpid(), beg, mid);
#endif

    while (!state.worker_done.load(std::memory_order_acquire))
        ;
}

void gnalc_atomic_add_i32(std::atomic_int32_t &x, int32_t val) { x += val; }

// WARNING:
// Note that the function itself performs exact float32 additions (no loss of precision)
// However, when used across threads, the out‑of‑order of these atomic additions can
// introduce loss of precision.
// (a + b) + c != a + (b + c)
void gnalc_atomic_add_f32(std::atomic<float> &x, float val) {
    float base = x.load();
    while (!x.compare_exchange_weak(base, base + val))
        ;
}
}