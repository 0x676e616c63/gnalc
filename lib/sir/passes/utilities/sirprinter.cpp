#include "sir/passes/utilities/sirprinter.hpp"
#include "ir/formatter.hpp"
#include "sir/base.hpp"

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
    if (auto if_inst = node.as_raw<IFInst>()) {
        visitCondInst(*if_inst->getCond());
        indent();
        write("if (");
        visitCondValue(*if_inst->getCond());
        writeln(") {");
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
        write(IRFormatter::formatValue(*while_inst->getCondInsts().back()));
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
        writeln(") {");
        ++indentLevel;
        for (auto &i : while_inst->getBodyInsts())
            visit(*i);
        --indentLevel;
        indent();
        writeln("}");
    } else if (auto for_inst = node.as_raw<FORInst>()) {
        indent();
        write("for (", for_inst->getBase(), " to ", for_inst->getBound(), " step ", for_inst->getStep());
        writeln(") {");
        ++indentLevel;
        for (auto &i : for_inst->getBodyInsts())
            visit(*i);
        --indentLevel;
        indent();
        writeln("}");
    } else if (node.is<BREAKInst>()) {
        indent();
        writeln("break");
    } else if (node.is<CONTINUEInst>()) {
        indent();
        writeln("continue");
    } else {
        indent();
        writeln(IRFormatter::formatInst(node));
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

PM::PreservedAnalyses PrintLinearFunctionPass::run(LinearFunction &func, FAM &fam) {
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
} // namespace SIR
