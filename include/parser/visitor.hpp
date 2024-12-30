/**
 * @brief AST Visitor
 */
#ifndef GNALC_AST_VISITOR_HPP
#define GNALC_AST_VISITOR_HPP
#pragma once



#include "ast.hpp"
#include "symbol_table/symbol_table.hpp"
#include "ir/constantpool.hpp"
#include "ir/module.hpp"
#include "ir/instructions/memory.hpp"

namespace AST {

class Printer : public ASTVisitor {
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
    // Constant Pool Destructs Last
    // https://en.cppreference.com/w/cpp/language/destructor
    IR::ConstantPool constant_pool;
    // ------
    IR::Module module;
    std::shared_ptr<IR::Value> curr_val;
    std::shared_ptr<IR::Function> curr_func;
    bool curr_func_params_inited{false};
    Sym::SymbolTable symbol_table;
    size_t next_temp_id{1};

    struct Initializer {
        using list_t = std::vector<Initializer>;
        using val_t = std::variant<int, float, std::shared_ptr<IR::Value>>;
        std::variant<std::monostate, list_t, val_t> initializer;
        IR::IRBTYPE base_type;
        Initializer* parent;

        Initializer()
            : initializer(std::monostate{}), parent(nullptr), base_type(IR::IRBTYPE::UNDEFINED) {}
        explicit Initializer(Initializer* parent_, IR::IRBTYPE btype)
            : initializer(std::monostate{}), parent(parent_), base_type(btype) {}
        explicit Initializer(int a, Initializer* parent_)
            : base_type(IR::IRBTYPE::I32), initializer(val_t{a}), parent(parent_) {}
        explicit Initializer(float a, Initializer* parent_)
            : base_type(IR::IRBTYPE::FLOAT), initializer(val_t{a}), parent(parent_) {}
        explicit Initializer(std::shared_ptr<IR::Value> a, Initializer* parent_)
            : initializer(val_t{a}), parent(parent_) {
            auto bt = IR::toBType(a->getType());
            Err::gassert(bt != nullptr
                && (bt->getInner() == IR::IRBTYPE::I32 || bt->getInner() == IR::IRBTYPE::FLOAT),
                "Invalid initializer");
            base_type = bt->getInner();
        }

        bool isList() const {
            return initializer.index() == 1;
        }

        bool isVal() const {
            return initializer.index() == 2;
        }

        template <typename T>
        void add(T&& a) {
            Err::gassert(isList());
            Initializer tmp(std::forward<T>(a), this);
            Err::gassert(base_type == tmp.base_type || base_type == IR::IRBTYPE::UNDEFINED,
                "Initializer type inconsistent.");
            base_type = tmp.base_type;
            std::get<1>(initializer).emplace_back(tmp);
        }

        Initializer* addList() {
            Err::gassert(isList());
            std::get<1>(initializer).emplace_back(this, base_type);
            return std::get<1>(initializer).back().makeList();
        }

        template <typename T>
        void setVal(T&& a) {
            Initializer tmp{std::forward<T>(a), this};
            base_type = tmp.base_type;
            initializer = tmp.initializer;
        }

        Initializer* makeList() {
            Err::gassert(empty());
            initializer.emplace<list_t>();
            return this;
        }

        bool empty() const {
            return initializer.index() == 0;
        }

        void reset(IR::IRBTYPE irbtype) {
            parent = nullptr;
            base_type = irbtype;
            initializer.emplace<std::monostate>();
        }

        // TODO: flat initializer support
        // {1, 2, 3, 4} -> {{1, 2}, {3, 4}
        // {1, 2, {1 , 2}} -> {1, 2, 1, 2}
        // {1, {3}} -> {1, 3, 0, 0}
        std::vector<val_t> flatten(const std::shared_ptr<IR::Type>& type) const {
            Err::gassert(type != nullptr);

            if (empty())
            {
                if (type->getTrait() == IR::IRCTYPE::BASIC)
                {
                    auto bty = IR::toBType(type)->getInner();
                    Err::gassert(bty == base_type);
                    if (bty == IR::IRBTYPE::I32) return {0};
                    else return {0.0f};
                }
                else if (type->getTrait() == IR::IRCTYPE::ARRAY)
                {
                    std::vector<val_t> ret;
                    auto arrty = std::dynamic_pointer_cast<IR::ArrayType>(type);
                    Err::gassert(type->getTrait() == IR::IRCTYPE::ARRAY && arrty != nullptr);
                    for (int j = 0; j < arrty->getBytes() / getBytes(base_type); ++j)
                    {
                        if (base_type == IR::IRBTYPE::I32)
                            ret.emplace_back(0);
                        else
                            ret.emplace_back(0.0f);
                    }
                    return ret;
                }
            }

            if (isVal())
            {
                Err::gassert(type->getTrait() == IR::IRCTYPE::BASIC
                    && IR::toBType(type)->getInner() == base_type);
                return {std::get<val_t>(initializer)};
            }

            auto arrty = std::dynamic_pointer_cast<IR::ArrayType>(type);
            Err::gassert(type->getTrait() == IR::IRCTYPE::ARRAY && arrty != nullptr);
            std::vector<val_t> ret;

            size_t len = 0;
            if (arrty->getElmType()->getTrait() == IR::IRCTYPE::ARRAY)
            {
                auto subarrty = std::dynamic_pointer_cast<IR::ArrayType>(arrty->getElmType());
                Err::gassert(subarrty != nullptr);
                for (const auto& elem : std::get<list_t>(initializer))
                {
                    auto tmp = elem.flatten(subarrty);
                    ret.insert(ret.end(),
                        std::make_move_iterator(tmp.begin()),
                         std::make_move_iterator(tmp.end()));
                    ++len;
                }

                for (; len < arrty->getArraySize(); ++len)
                {
                    auto num = arrty->getElmType()->getBytes() / getBytes(base_type);
                    for (int i = 0; i < num; ++i)
                    {
                        if (base_type == IR::IRBTYPE::I32)
                            ret.emplace_back(0);
                        else
                            ret.emplace_back(0.0f);
                    }
                }
            }
            else if (arrty->getElmType()->getTrait() == IR::IRCTYPE::BASIC)
            {
                for (const auto& elem : std::get<list_t>(initializer))
                {
                    ret.emplace_back(elem.flatten(arrty->getElmType())[0]);
                    ++len;
                }

                for (; len < arrty->getArraySize(); ++len)
                {
                    if (base_type == IR::IRBTYPE::I32)
                        ret.emplace_back(0);
                    else
                        ret.emplace_back(0.0f);
                }
            }

            return ret;
        }
    };

    Initializer curr_initializer;
    Initializer* curr_making_initializer;
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
private:
    std::string get_temp_name();
    // Failed will return val back
    std::shared_ptr<IR::Value> try_type_cast(std::shared_ptr<IR::Value> val, IR::IRBTYPE dest);
};

}


#endif
