// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/utilities/sirprinter.hpp"
#include "ir/formatter.hpp"
#include "sir/base.hpp"
#include "sir/passes/analysis/affine_alias_analysis.hpp"

namespace SIR {
void LinearPrinterBase::indent() {
    for (size_t i = 0; i < indentLevel; i++) {
        outStream << "  ";
    }
}

void LinearPrinterBase::visit(GlobalVariable &node) { writeln(IRFormatter::formatGV(node)); }

void LinearPrinterBase::visit(FunctionDecl &node) { write(IRFormatter::formatFuncDecl(node)); }

void LinearPrinterBase::visitCondInst(Value &value) {
    if (auto cond_value = value.as_raw<CONDValue>()) {
        if (!cond_value->getRHSInsts().empty()) {
            indent();
            write("cond ");
            write(IRFormatter::formatValue(*cond_value->getRHSInsts().back()));
            writeln(" {");
            ++indentLevel;
            for (auto &i : cond_value->getRHSInsts())
                visit(*i);
            --indentLevel;
            indent();
            writeln("}");
        }
        visitCondInst(*cond_value->getRHS());
        visitCondInst(*cond_value->getLHS());
    }
}

void LinearPrinterBase::visitCondValue(Value &value, bool is_first) {
    if (auto cond_value = value.as_raw<CONDValue>()) {
        switch (cond_value->getCondType()) {
        case CONDTY::AND:
            if (!is_first)
                write("(");
            visitCondValue(*cond_value->getLHS(), false);
            write(" && ");
            visitCondValue(*cond_value->getRHS(), false);
            if (!is_first)
                write(")");
            break;
        case CONDTY::OR:
            if (!is_first)
                write("(");
            visitCondValue(*cond_value->getLHS(), false);
            write(" || ");
            visitCondValue(*cond_value->getRHS(), false);
            if (!is_first)
                write(")");
            break;
        }
    } else
        write(IRFormatter::formatValue(value));
}

void LinearPrinterBase::visit(Instruction &node) {
    auto write_dbg_msg = [&] {
        const auto& dbg = node.getDbgData();
        if (!dbg.empty()) {
            write("        ;", dbg[0]);
            for (size_t i = 1; i < dbg.size(); ++i)
                write(", ", dbg[i]);
        }
    };
    auto write_dbg_msg_ln = [&] {
        write_dbg_msg();
        writeln("");
    };
    if (auto if_inst = node.as_raw<IFInst>()) {
        visitCondInst(*if_inst->getCond());
        indent();
        write("if (");
        visitCondValue(*if_inst->getCond());
        write(") {");
        write_dbg_msg_ln();
        ++indentLevel;
        for (auto &i : if_inst->getBodyInsts())
            visit(*i);
        --indentLevel;
        indent();
        write("}");
        if (if_inst->hasElse()) {
            writeln(" else {");
            ++indentLevel;
            for (auto &i : if_inst->getElseInsts())
                visit(*i);
            --indentLevel;
            indent();
            writeln("}");
        } else
            writeln("");
    } else if (auto while_inst = node.as_raw<WHILEInst>()) {
        indent();
        write("cond ");
        write(IRFormatter::formatValue(*while_inst->getCond()));
        writeln(" {");
        ++indentLevel;
        for (auto &i : while_inst->getCondInsts())
            visit(*i);
        --indentLevel;
        indent();
        writeln("}");

        visitCondInst(*while_inst->getCond());

        indent();
        write("while (");
        visitCondValue(*while_inst->getCond());
        write(") {");
        write_dbg_msg_ln();
        ++indentLevel;
        for (auto &i : while_inst->getBodyInsts())
            visit(*i);
        --indentLevel;
        indent();
        writeln("}");
    } else if (auto for_inst = node.as_raw<FORInst>()) {
        indent();
        write("for (", for_inst->getIndVar()->getName(), " in [", for_inst->getBase()->getName(), ", ",
              for_inst->getBound()->getName(), ") step ", for_inst->getStep()->getName());
        write(") {");
        write_dbg_msg_ln();
        ++indentLevel;
        for (auto &i : for_inst->getBodyInsts())
            visit(*i);
        --indentLevel;
        indent();
        writeln("}");
    } else if (node.is<BREAKInst>()) {
        indent();
        write("break");
        write_dbg_msg_ln();
    } else if (node.is<CONTINUEInst>()) {
        indent();
        write("continue");
        write_dbg_msg_ln();
    } else {
        indent();
        write(IRFormatter::formatInst(node));
        write_dbg_msg_ln();
    }
}

void LinearPrinterBase::visit(LinearFunction &node) {
    write(IRFormatter::formatLinearFunc(node));
    ++indentLevel;
    writeln(" {");

    for (auto &i : node.getInsts())
        visit(*i);

    writeln("}");
    --indentLevel;
}

PM::PreservedAnalyses PrintLinearFunctionPass::run(LinearFunction &func, LFAM &fam) {
    func.accept(*this);
    return PreserveAll();
}

PM::PreservedAnalyses PrintLinearModulePass::run(Module &module, MAM &mam) {
    writeln("; Module: " + module.getName());
    writeln("");

    for (auto &gv : module.getGlobalVars())
        gv->accept(*this);

    writeln("");

    for (auto &func : module.getLinearFunctions()) {
        func->accept(*this);
        writeln("");
    }

    for (auto &func_decl : module.getFunctionDecls()) {
        func_decl->accept(*this);
        writeln("");
    }

    return PreserveAll();
}

PM::PreservedAnalyses PrintAffineAAPass::run(LinearFunction &lfunc, LFAM &lfam) {
    auto& laa_res = lfam.getResult<AffineAliasAnalysis>(lfunc);
    writeln("AffineAAResult for ", lfunc.getName(), ":");

    auto print_set = [&](const auto& set) {
        for (const auto& read : set) {
            write("    ", read->getName(), " = ");
            const auto& ptr = laa_res.queryPointer(read);
            if (!ptr)
                write("Unknown");
            else if (ptr->isArray()) {
                auto arr = ptr->array();
                write(arr);
            }
            else if (ptr->isScalar()) {
                write(ptr->scalar().base->getName());
            }
            else Err::unreachable();
            writeln("");
        }
    };

    for (const auto& inst : lfunc.nested_insts()) {
        if (auto for_inst = inst->as<FORInst>()) {
            const auto& rw = laa_res.queryInstRW(for_inst);
            if (!rw)
                continue;
            writeln("FORInst: ", for_inst->getIndVar()->getName(), ":");
            writeln("  Read:");
            print_set(rw->read);
            writeln("  Write:");
            print_set(rw->write);
        } else if (auto call_inst = inst->as<CALLInst>()) {
            const auto& rw = laa_res.queryInstRW(call_inst);
            if (!rw)
                continue;
            writeln("CALLInst: ", call_inst->getName(), " '", call_inst->getFuncName(), "':");
            writeln("  Read:");
            print_set(rw->read);
            writeln("  Write:");
            print_set(rw->write);
        }
    }
    return PreserveAll();
}

} // namespace SIR
