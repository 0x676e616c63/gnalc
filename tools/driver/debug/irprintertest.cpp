#include "../../../include/irvisitors/irprinter.hpp"
#include "../../../include/ir/constantpool.hpp"
#include "../../../include/utils/logger.hpp"
#include <iostream>
#include <string>

IR::Module irgenfortest();
void testConstPool();

IR::ConstantPool cp;

int main(int argc, char *argv[]) {
    LogLevel level = LogLevel::NONE;
    std::string output_file = "fkir.ll";
    for (int i = 1; i < argc; ++i) {
        if (std::string(argv[i]) == "-v" ||
            std::string(argv[i]) == "--verbose") {
            level = LogLevel::DEBUG;
        } else if (std::string(argv[i]) == "-i" ||
                   std::string(argv[i]) == "--info") {
            level = LogLevel::INFO;
        } else if (std::string(argv[i]) == "-o" ||
                   std::string(argv[i]) == "--output") {
            ++i;
            output_file = std::string(argv[i]);
        } else {
            Logger::logInfo("Unknown option: " + std::string(argv[i]));
        }
    }
    Logger::setLogLevel(level);

    testConstPool();

    std::ofstream out(output_file);
    Err::gassert(out.is_open(), "Invalid File");
    IR::LIRPrinter printer(out);

    IR::Module module = std::move(irgenfortest());
    printer.printout(module);

    return 0;
}

IR::Module irgenfortest() {
    IR::Module module("test");
    module.addFunction(std::make_shared<IR::Function>(
        "@main", std::vector<std::shared_ptr<IR::Value>>{},
        IR::makeBType(IR::IRBTYPE::VOID)));
    module.addGlobalVar(std::make_shared<IR::GlobalVariable>(
        IR::STOCLASS::GLOBAL, IR::makeBType(IR::IRBTYPE::I32), "@test",
        IR::GVIniter(IR::makeBType(IR::IRBTYPE::I32), cp.getConst(1)), 4));
    return module;
}

void testConstPool() {
    IR::ConstantPool cpt;
    {
        auto intConst1 = cpt.getConst(42);
        auto intConst2 = cpt.getConst(42);

        auto floatConst = cpt.getConst((float)3.14);

        std::cout << "intConst1 address: " << intConst1.get() << std::endl;
        std::cout << "intConst2 address: " << intConst2.get() << std::endl;
        std::cout << "floatConst address: " << floatConst.get() << std::endl;

        if (intConst1 == intConst2) {
            std::cout << "intConst1 and intConst2 are the same instance."
                      << std::endl;
        }
        std::cout << "clean pool count:" << cpt.cleanPool() << std::endl;
    }
    std::cout << "clean pool count:" << cpt.cleanPool() << std::endl;
}