// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/ir/passes/utilities/cfg_export.hpp"
#include "../../../../include/ir/passes/utilities/irprinter.hpp"

#include <filesystem>
#include <fstream>
#include <sstream>

namespace IR {
namespace fs = std::filesystem;

void writeDot(std::ostream &out_stream, const Function &function) {
    auto func_name = function.getName().substr(1);
    out_stream << "digraph " << func_name << " {\n";
    out_stream << "  label = \"CFG for '" << func_name << "' function\";\n";
    out_stream << "  labelloc = bottom;\n";
    std::unordered_map<pBlock, std::string> bb_map;
    size_t id = 0;

    for (const auto &bb : function) {
        bb_map[bb] = "b" + std::to_string(++id);

        // Build instruction string
        std::ostringstream instStream;
        IRPrinter printer(instStream);
        for (const auto &inst : bb->phis())
            inst->Instruction::accept(printer);
        for (const auto &inst : bb->getInsts())
            inst->Instruction::accept(printer);
        std::string instStr = instStream.str();

        // Replace newlines with \l for DOT multi-line labels
        size_t pos = 0;
        while ((pos = instStr.find('\n', pos)) != std::string::npos) {
            instStr.replace(pos, 1, "\\l");
            pos += 2;
        }

        // Construct label in record format: {name:\l instructions\l}
        std::string label =
            "{" + bb->getName().substr(1) + ":\\l|" + instStr + (bb->getNumSuccs() == 2 ? "|{<T>T|<F>F}}" : "}");

        // Escape double quotes in label
        size_t quotePos = 0;
        while ((quotePos = label.find('"', quotePos)) != std::string::npos) {
            label.replace(quotePos, 1, "\\\"");
            quotePos += 2;
        }

        // Set color based on block type
        std::string colorAttr;
        if (bb->getIndex() == 0)
            colorAttr = ", color = sienna";
        else if (bb->getRETInst())
            colorAttr = ", color = red";
        else
            colorAttr = "";

        out_stream << "  " << bb_map[bb] << " [shape = record" << colorAttr << ", label = \"" << label << "\"];\n";
    }

    for (const auto &bb : function) {
        if (auto br = bb->getBRInst()) {
            if (br->isConditional()) {
                out_stream << "  " << bb_map[bb] << ":T -> " << bb_map[br->getTrueDest()] << ";\n";
                out_stream << "  " << bb_map[bb] << ":F -> " << bb_map[br->getFalseDest()] << ";\n";
            } else
                out_stream << "  " << bb_map[bb] << " -> " << bb_map[br->getDest()] << ";\n";
        }
    }

    out_stream << "}" << std::endl;
}

void writePng(const std::string& output_path, const Function &function) {
    std::stringstream dot;
    writeDot(dot, function);
    auto dot_command = "echo '" + dot.str() + "' | ""dot -Tpng -o " + output_path;
    // Logger::logInfo("[PngCFG]: Running '", dot_command, "'.");
    std::system(dot_command.c_str());
}

PM::PreservedAnalyses DotCFGPass::run(Function &function, FAM &fam) {
    writeDot(out_stream, function);
    return PreserveAll();
}
PM::PreservedAnalyses DotCFGPass::run(Module &module, MAM &mam) {
    for (auto &function : module)
        writeDot(out_stream, *function);
    return PreserveAll();
}

PM::PreservedAnalyses PngCFGPass::run(Function &function, FAM &fam) {
    static size_t name_cnt = 0;
    if (!fs::exists(output_dir))
        fs::create_directory(output_dir);
    auto path = output_dir + "/" + function.getName().substr(1) + "_" + std::to_string(name_cnt++) + ".png";
    writePng(path, function);
    return PreserveAll();
}

PM::PreservedAnalyses PngCFGPass::run(Module &module, MAM &manager) {
    if (!fs::exists(output_dir))
        fs::create_directory(output_dir);
    for (const auto &function : module) {
        auto path = output_dir + "/" + function->getName().substr(1) + ".png";
        writePng(path, *function);
    }
    return PreserveAll();
}
} // namespace IR
