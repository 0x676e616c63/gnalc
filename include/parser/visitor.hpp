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
            std::get<list_t>(initializer).emplace_back(tmp);
        }

        Initializer* addList() {
            Err::gassert(isList());
            std::get<list_t>(initializer).emplace_back(this, base_type);
            return std::get<list_t>(initializer).back().makeList();
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

        // See: https://en.cppreference.com/w/c/language/array_initialization
        std::vector<val_t> flatten(const std::shared_ptr<IR::Type>& type) const {
            Err::gassert(type != nullptr);

            if (empty() || (isList() && std::get<list_t>(initializer).empty()))
            {
                if (type->getTrait() == IR::IRCTYPE::BASIC)
                {
                    auto bty = IR::toBType(type)->getInner();
                    Err::gassert(bty == base_type);
                    return { make_zero() };
                }
                if (type->getTrait() == IR::IRCTYPE::ARRAY)
                {
                    auto arrty = std::dynamic_pointer_cast<IR::ArrayType>(type);
                    return std::vector{arrty->getBytes() / getBytes(base_type), make_zero()};
                }
                Err::unreachable();
            }
            else if (isVal())
            {
                if (type->getTrait() == IR::IRCTYPE::BASIC)
                    return {std::get<val_t>(initializer) };
                if (type->getTrait() == IR::IRCTYPE::ARRAY)
                {
                    auto arrty = std::dynamic_pointer_cast<IR::ArrayType>(type);
                    std::vector ret{arrty->getBytes() / getBytes(base_type), make_zero()};
                    ret[0] = std::get<val_t>(initializer);
                    return ret;
                }
                Err::unreachable();
            }
            else if (isList())
            {
                const auto& list = std::get<list_t>(initializer);
                Err::gassert(!list.empty());
                if (type->getTrait() == IR::IRCTYPE::BASIC)
                    return list[0].flatten(type);
                if (type->getTrait() == IR::IRCTYPE::ARRAY)
                {
                    size_t len = 0;
                    auto arrty = std::dynamic_pointer_cast<IR::ArrayType>(type);
                    auto elmty = IR::getElm(arrty);
                    if (elmty->getTrait() == IR::IRCTYPE::BASIC)
                    {
                        std::vector<val_t> ret;
                        for (auto& subiniter : list)
                        {
                            auto tmp = subiniter.flatten(elmty);
                            ret.insert(ret.end(),
                                std::make_move_iterator(tmp.begin()),
                                std::make_move_iterator(tmp.end()));
                            ++len;
                        }
                        for (size_t i = len; i < arrty->getArraySize(); ++i)
                            ret.emplace_back(make_zero());
                        return ret;
                    }
                    if (elmty->getTrait() == IR::IRCTYPE::ARRAY)
                    {
                        std::vector<val_t> ret;
                        for (auto curr_sub = list.begin(); curr_sub != list.end(); ++curr_sub)
                        {
                            // If the nested initializer begins with an opening brace, the entire nested
                            // initializer up to its closing brace initializes the corresponding array element:
                            if (curr_sub->isList() || curr_sub->empty())
                            {
                                auto tmp = curr_sub->flatten(elmty);
                                ret.insert(ret.end(),
                                    std::make_move_iterator(tmp.begin()),
                                    std::make_move_iterator(tmp.end()));
                                ++len;
                            }
                            // If the nested initializer does not begin with an opening brace,
                            // only enough initializers from the list are taken to account for the
                            // elements or members of the sub-array, struct or union; any remaining
                            // initializers are left to initialize the next array element:
                            else if (curr_sub->isVal())
                            {
                                Initializer helper(nullptr, base_type);
                                helper.makeList();
                                for (size_t i = 0; i < elmty->getBytes() / IR::getBytes(base_type); ++i)
                                {
                                    std::get<list_t>(helper.initializer).emplace_back(*curr_sub);
                                    ++curr_sub;
                                    if (curr_sub == list.end())
                                        break;
                                }
                                --curr_sub;
                                auto tmp = helper.flatten(elmty);
                                ret.insert(ret.end(),
                                    std::make_move_iterator(tmp.begin()),
                                    std::make_move_iterator(tmp.end()));
                                ++len;
                            }
                        }

                        for (size_t i = len; i < arrty->getArraySize(); ++i)
                        {
                            Initializer helper(nullptr, base_type);
                            auto tmp = helper.flatten(elmty);
                            ret.insert(ret.end(),
                                std::make_move_iterator(tmp.begin()),
                                std::make_move_iterator(tmp.end()));
                        }
                        return ret;
                    }
                    Err::unreachable();
                }
                Err::unreachable();
            }
            Err::unreachable();
            return {};
        }

    private:
        val_t make_zero() const {
            if (base_type == IR::IRBTYPE::I32)
                return {0};
            else
                return {0.0f};
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
