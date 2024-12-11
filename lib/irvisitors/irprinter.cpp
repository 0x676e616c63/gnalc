#include "../../include/irvisitors/irprinter.hpp"
#include "../../include/utils/exception.hpp"
#include "../../include/utils/logger.hpp"

namespace IR {

LIRPrinter::LIRPrinter(const std::string& filename) {
    Logger::logDebug("Opening file: " + filename);
    outFile.open(filename, std::ios::out);
    Err::assert(outFile.is_open(), "Failed to open file: " + filename);
}

LIRPrinter::~LIRPrinter() {
    if (outFile.is_open()) {
        outFile.close();
        Logger::logDebug("Closed file.");
    }
}

void LIRPrinter::write(const std::string& str) {
    if (outFile.is_open()) {
        outFile << str;
    }
}

void LIRPrinter::writeln(const std::string& str) {
    if (outFile.is_open()) {
        outFile << str << std::endl;
    }
}



}