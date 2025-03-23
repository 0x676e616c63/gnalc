#include "../../../include/utils/logger.hpp"
#include <string>

int main(int argc, char *argv[]) {
    LogLevel level = LogLevel::NONE;
    for (int i = 1; i < argc; ++i) {
        if (std::string(argv[i]) == "-v" || std::string(argv[i]) == "--verbose") {
            level = LogLevel::DEBUG;
        } else if (std::string(argv[i]) == "-i" || std::string(argv[i]) == "--info") {
            level = LogLevel::INFO;
        }
    }

    Logger::setLogLevel(level);

    Logger::logInfo("This is an informational message.");
    Logger::logDebug("This is a debug message.");
    return 0;
}
