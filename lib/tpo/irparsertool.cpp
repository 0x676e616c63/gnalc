#include "../../include/tpo/irparsertool.hpp"

IR::Module IRParser::IRGenerator::module;

IRParser::IRGenerator::IRGenerator(const std::string &module_name) {
    module.setName(module_name);
}
