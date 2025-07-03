// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/pass_manager.hpp"
#include "ir/passes/transforms/namenormalizer.hpp"
#include "ir/passes/utilities/irprinter.hpp"
#include "parser/ast.hpp"
#include "parser/irgen.hpp"
#include "parser/parser.hpp"

#include <fstream>
#include <iostream>
#include <memory>
#include <string>

size_t analysis_running_cnt = 0;
struct TestResult {
    int get() { return analysis_running_cnt; }
};
class TestAnalysis : public PM::AnalysisInfo<TestAnalysis> {
public:
    using Result = TestResult;

    TestResult run(IR::Function &func, IR::FAM &fam) {
        analysis_running_cnt++;
        std::cout << "TestAnalysis::run: func_name: " << func.getName() << std::endl;
        return TestResult{};
    }

private:
    friend AnalysisInfo<TestAnalysis>;
    static PM::UniqueKey Key;
};

PM::UniqueKey TestAnalysis::Key;

class TestFunctionPass : public PM::PassInfo<TestFunctionPass> {
public:
    PM::PreservedAnalyses run(IR::Function &f, IR::FAM &fam) {
        std::cout << "TestFunctionPass::run: func_name: " << f.getName() << std::endl;
        auto res = fam.getResult<TestAnalysis>(f);
        std::cout << "Got result: " << res.get() << std::endl;
        return PM::PreservedAnalyses::all();
    }
};

class TestNoPreservedFunctionPass : public PM::PassInfo<TestNoPreservedFunctionPass> {
public:
    PM::PreservedAnalyses run(IR::Function &f, IR::FAM &fam) {
        std::cout << "TestNoPreservedFunctionPass::run: func_name: " << f.getName() << std::endl;
        auto res = fam.getResult<TestAnalysis>(f);
        std::cout << "Got result: " << res.get() << std::endl;
        return PM::PreservedAnalyses::none();
    }
};

PM::AnalysisStorage<IR::Function> fas;


class TestStoreAnalysisPass : public PM::PassInfo<TestStoreAnalysisPass> {
public:
    PM::PreservedAnalyses run(IR::Function &f, IR::FAM &fam) {
        std::cout << "TestStoreAnalysisPass::run: func_name: " << f.getName() << std::endl;
        auto res = fam.getResult<TestAnalysis>(f);
        std::cout << "Stored result: " << res.get() << std::endl;
        fas.storeResult<TestAnalysis>(f, res);
        return PM::PreservedAnalyses::none();
    }
};

std::shared_ptr<AST::CompUnit> node = nullptr;

int main() {
    yy::parser parser;

    if (parser.parse()) {
        std::cerr << "Syntax Error" << std::endl;
        return -1;
    }

    Parser::IRGenerator irgen;
    irgen.visit(*node);

    IR::FAM fam;
    IR::FPM fpm;
    IR::MAM mam;
    IR::MPM mpm;
    fam.registerPass([] { return TestAnalysis(); });
    fpm.addPass(TestFunctionPass());
    fpm.addPass(TestFunctionPass());
    fpm.addPass(TestNoPreservedFunctionPass());
    fpm.addPass(TestNoPreservedFunctionPass());
    fpm.addPass(TestFunctionPass());
    fpm.addPass(TestFunctionPass());
    fpm.addPass(TestStoreAnalysisPass());
    fpm.addPass(IR::NameNormalizePass(true));
    mpm.addPass(IR::makeModulePass(std::move(fpm)));
    mpm.addPass(IR::PrintModulePass(std::cout));
    mam.registerPass([&] { return IR::FAMProxy(fam); });
    mpm.run(irgen.get_module(), mam);

    for (auto &func : irgen.get_module().getFunctions()) {
        auto res = fas.getStoredResult<TestAnalysis>(*func);
        if (res)
            std::cout << "Got stored result: " << res->get() << std::endl;
        else
            std::cout << "No stored result" << std::endl;
    }
    return 0;
}
