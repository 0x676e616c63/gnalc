#pragma once
#ifndef GNALC_UTILS_LOGGER_HPP
#define GNALC_UTILS_LOGGER_HPP

#include <iostream>
#include <string>

enum class LogLevel { NONE, INFO, DEBUG };

class Logger {
public:
    static void setLogLevel(LogLevel level) { logLevel = level; }

    static void logInfo(const std::string& message) {
        if (logLevel >= LogLevel::INFO) {
            std::cerr << "[INFO] " << message << std::endl;
        }
    }

    static void logDebug(const std::string& message) {
        if (logLevel >= LogLevel::DEBUG) {
            std::cerr << "[DEBUG] " << message << std::endl;
        }
    }

private:
    static LogLevel logLevel;
};

LogLevel Logger::logLevel = LogLevel::NONE;

#endif