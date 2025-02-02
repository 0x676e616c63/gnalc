#pragma once
#ifndef GNALC_UTILS_LOGGER_HPP
#define GNALC_UTILS_LOGGER_HPP

#include <iostream>
#include <memory>
#include <string>

enum class LogLevel { NONE, INFO, DEBUG };

class Logger {
    template <typename T> class LoggerGuard {
        T on_destroy;

    public:
        explicit LoggerGuard(T on_destroy)
            : on_destroy(std::move(on_destroy)) {}
        ~LoggerGuard() { on_destroy(); }
    };

public:
    static void setLogLevel(LogLevel level) { logLevel = level; }

    static void logInfo(const std::string &message) {
        if (logLevel >= LogLevel::INFO) {
            std::cerr << "[INFO] " << message << std::endl;
        }
    }

    static void logDebug(const std::string &message) {
        if (logLevel >= LogLevel::DEBUG) {
            std::cerr << "[DEBUG] " << message << std::endl;
        }
    }

    template <typename... Args> static void logInfo(Args &&...args) {
        if (logLevel >= LogLevel::INFO) {
            std::cerr << "[INFO] ";
            (std::cerr << ... << args);
            std::cerr << std::endl;
        }
    }

    template <typename... Args> static void logDebug(Args &&...args) {
        if (logLevel >= LogLevel::DEBUG) {
            std::cerr << "[DEBUG] ";
            (std::cerr << ... << args);
            std::cerr << std::endl;
        }
    }

    static auto scopeDisable() {
        auto lvlbak = logLevel;
        setLogLevel(LogLevel::NONE);
        return LoggerGuard([restore = lvlbak] { setLogLevel(restore); });
    }

private:
    static LogLevel logLevel;
};

#endif
