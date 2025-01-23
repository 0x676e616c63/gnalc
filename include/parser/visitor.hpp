/**
 * @brief AST Visitor
 */
#ifndef GNALC_AST_VISITOR_HPP
#define GNALC_AST_VISITOR_HPP
#pragma once

#include "ast.hpp"
#include "../symbol_table/symbol_table.hpp"
#include "../ir/module.hpp"
#include "../ir/instructions/memory.hpp"
#include "../config/config.hpp"

namespace AST {

class ASTPrinter : public ASTVisitor {
private:
    int nest = 0;
    bool fold_exp = false;

public:
    void PrintType(dtype t) const;
    void PrintBlank() const;
    void PrintOp(BiOp op) const;
    void PrintOp(UnOp op) const;

    void visit(CompUnit& node) override;
    void visit(VarDef& node) override;
    void visit(DeclStmt& node) override;
    void visit(InitVal& node) override;
    void visit(ArraySubscript& node) override;
    void visit(FuncDef& node) override;
    void visit(FuncFParam& node) override;
    void visit(DeclRef& node) override;
    void visit(ArrayExp& node) override;
    void visit(CallExp& node) override;
    void visit(FuncRParam& node) override;
    void visit(BinaryOp& node) override;
    void visit(UnaryOp& node) override;
    void visit(ParenExp& node) override;
    void visit(IntLiteral& node) override;
    void visit(FloatLiteral& node) override;
    void visit(CompStmt& node) override;
    void visit(IfStmt& node) override;
    void visit(WhileStmt& node) override;
    void visit(NullStmt& node) override;
    void visit(BreakStmt& node) override;
    void visit(ContinueStmt& node) override;
    void visit(ReturnStmt& node) override;
};

class IRGenerator : public ASTVisitor {
    IR::Module module;
    std::shared_ptr<IR::Value> curr_val;
    std::vector<std::shared_ptr<IR::Instruction>> curr_insts;
    std::shared_ptr<IR::Function> curr_func;
    Sym::SymbolTable symbol_table;
    bool is_making_lval{false}; // TODO: more sensible

    struct Initializer {
        using list_t = std::vector<Initializer>;
        using val_t = std::variant<int, float, std::shared_ptr<IR::Value>>;
        std::variant<std::monostate, list_t, val_t> initializer;
        IR::IRBTYPE base_type;
        Initializer* parent;

        Initializer();
        explicit Initializer(Initializer* parent_, IR::IRBTYPE btype);
        explicit Initializer(int a, Initializer* parent_);
        explicit Initializer(float a, Initializer* parent_);
        explicit Initializer(std::shared_ptr<IR::Value> a, Initializer* parent_);

        bool isList() const;

        bool isVal() const;

        template <typename T>
        void add(T&& a) {
            Err::gassert(isList());
            Initializer tmp(std::forward<T>(a), this);
            Err::gassert(base_type == tmp.base_type || base_type == IR::IRBTYPE::UNDEFINED,
                "Initializer type inconsistent.");
            base_type = tmp.base_type;
            std::get<list_t>(initializer).emplace_back(tmp);
        }

        Initializer* addList();

        template <typename T>
        void setVal(T&& a) {
            Initializer tmp{std::forward<T>(a), this};
            base_type = tmp.base_type;
            initializer = tmp.initializer;
        }

        Initializer* makeList();

        bool empty() const;

        void reset(IR::IRBTYPE irbtype);

        std::vector<val_t> flatten(const std::shared_ptr<IR::Type>& type) const;

        bool isZeroIniter() const;

        val_t getZeroValue() const;
    };

    Initializer curr_initializer;
    Initializer* curr_making_initializer{};
public:
    IRGenerator() = default;
    void visit(CompUnit& node) override;
    void visit(VarDef& node) override;
    void visit(DeclStmt& node) override;
    void visit(InitVal& node) override;
    void visit(ArraySubscript& node) override;
    void visit(FuncDef& node) override;
    void visit(FuncFParam& node) override;
    void visit(DeclRef& node) override;
    void visit(ArrayExp& node) override;
    void visit(CallExp& node) override;
    void visit(FuncRParam& node) override;
    void visit(BinaryOp& node) override;
    void visit(UnaryOp& node) override;
    void visit(ParenExp& node) override;
    void visit(IntLiteral& node) override;
    void visit(FloatLiteral& node) override;
    void visit(CompStmt& node) override;
    void visit(IfStmt& node) override;
    void visit(WhileStmt& node) override;
    void visit(NullStmt& node) override;
    void visit(BreakStmt& node) override;
    void visit(ContinueStmt& node) override;
    void visit(ReturnStmt& node) override;

    IR::Module& get_module() { return module; }

    static constexpr auto irval_temp_name = Config::IR::REGISTER_TEMP_NAME;
private:
    // Throw exception if failed
    std::shared_ptr<IR::Value> type_cast(const std::shared_ptr<IR::Value>& val, const std::shared_ptr<IR::Type>& dest);
    std::shared_ptr<IR::Value> type_cast(const std::shared_ptr<IR::Value>& val, IR::IRBTYPE dest);
};

}


#endif
