#include "../include/utils/logger.hpp"
#include "../include/irvisitors/irprinter.hpp"
#include <string>

int main(int argc, char* argv[]) {
    LogLevel level = LogLevel::NONE;
    std::string output_file;
    for (int i = 1; i < argc; ++i) {
        if (std::string(argv[i]) == "-v" || std::string(argv[i]) == "--verbose") {
            level = LogLevel::DEBUG;
        } else if (std::string(argv[i]) == "-i" || std::string(argv[i]) == "--info") {
            level = LogLevel::INFO;
        } else if (std::string(argv[i]) == "-o" || std::string(argv[i]) == "--output") {
            ++i;
            output_file = std::string(argv[i]);
        } else {
            Logger::logInfo("Unknown option: " + std::string(argv[i]));
        }
    }
    Logger::setLogLevel(level);

    IR::LIRPrinter printer(output_file);

    IR::Module module("test");

    printer.printout(module);

    return 0;
}