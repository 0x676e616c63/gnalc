// A Bison parser, made by GNU Bison 3.8.2.

// Skeleton interface for Bison LALR(1) parsers in C++

// Copyright (C) 2002-2015, 2018-2021 Free Software Foundation, Inc.

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

// As a special exception, you may create a larger work that contains
// part or all of the Bison parser skeleton and distribute that work
// under terms of your choice, so long as that work isn't itself a
// parser generator using the skeleton or a modified version thereof
// as a parser skeleton.  Alternatively, if you modify or redistribute
// the parser skeleton itself, you may (at your option) remove this
// special exception, which will cause the skeleton and the resulting
// Bison output files to be licensed under the GNU General Public
// License without this special exception.

// This special exception was added by the Free Software Foundation in
// version 2.2 of Bison.

/**
 ** \file include/parser/parser.hpp
 ** Define the yy::parser class.
 */

// C++ LALR(1) parser skeleton written by Akim Demaille.

// DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
// especially those whose name start with YY_ or yy_.  They are
// private implementation details that can be changed or removed.

#ifndef YY_YY_INCLUDE_PARSER_PARSER_HPP_INCLUDED
#define YY_YY_INCLUDE_PARSER_PARSER_HPP_INCLUDED
// "%code requires" blocks.
#line 14 "./lib/parser/parser.y"

#include "ast.hpp"
using namespace AST;

#line 54 "include/parser/parser.hpp"

#include <cassert>
#include <cstdlib> // std::abort
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>

#if defined __cplusplus
#define YY_CPLUSPLUS __cplusplus
#else
#define YY_CPLUSPLUS 199711L
#endif

// Support move semantics when possible.
#if 201103L <= YY_CPLUSPLUS
#define YY_MOVE std::move
#define YY_MOVE_OR_COPY move
#define YY_MOVE_REF(Type) Type &&
#define YY_RVREF(Type) Type &&
#define YY_COPY(Type) Type
#else
#define YY_MOVE
#define YY_MOVE_OR_COPY copy
#define YY_MOVE_REF(Type) Type &
#define YY_RVREF(Type) const Type &
#define YY_COPY(Type) const Type &
#endif

// Support noexcept when possible.
#if 201103L <= YY_CPLUSPLUS
#define YY_NOEXCEPT noexcept
#define YY_NOTHROW
#else
#define YY_NOEXCEPT
#define YY_NOTHROW throw()
#endif

// Support constexpr when possible.
#if 201703 <= YY_CPLUSPLUS
#define YY_CONSTEXPR constexpr
#else
#define YY_CONSTEXPR
#endif

#include <typeinfo>
#ifndef YY_ASSERT
#include <cassert>
#define YY_ASSERT assert
#endif

#ifndef YY_ATTRIBUTE_PURE
#if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#define YY_ATTRIBUTE_PURE __attribute__((__pure__))
#else
#define YY_ATTRIBUTE_PURE
#endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
#if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#define YY_ATTRIBUTE_UNUSED __attribute__((__unused__))
#else
#define YY_ATTRIBUTE_UNUSED
#endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if !defined lint || defined __GNUC__
#define YY_USE(E) ((void)(E))
#else
#define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && !defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
#if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                                                                            \
    _Pragma("GCC diagnostic push") _Pragma("GCC diagnostic ignored \"-Wuninitialized\"")
#else
#define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                                                                            \
    _Pragma("GCC diagnostic push") _Pragma("GCC diagnostic ignored \"-Wuninitialized\"")                               \
        _Pragma("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
#endif
#define YY_IGNORE_MAYBE_UNINITIALIZED_END _Pragma("GCC diagnostic pop")
#else
#define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
#define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
#define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
#define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && !defined __ICC && 6 <= __GNUC__
#define YY_IGNORE_USELESS_CAST_BEGIN _Pragma("GCC diagnostic push") _Pragma("GCC diagnostic ignored \"-Wuseless-cast\"")
#define YY_IGNORE_USELESS_CAST_END _Pragma("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
#define YY_IGNORE_USELESS_CAST_BEGIN
#define YY_IGNORE_USELESS_CAST_END
#endif

#ifndef YY_CAST
#ifdef __cplusplus
#define YY_CAST(Type, Val) static_cast<Type>(Val)
#define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type>(Val)
#else
#define YY_CAST(Type, Val) ((Type)(Val))
#define YY_REINTERPRET_CAST(Type, Val) ((Type)(Val))
#endif
#endif
#ifndef YY_NULLPTR
#if defined __cplusplus
#if 201103L <= __cplusplus
#define YY_NULLPTR nullptr
#else
#define YY_NULLPTR 0
#endif
#else
#define YY_NULLPTR ((void *)0)
#endif
#endif

/* Debug traces.  */
#ifndef YYDEBUG
#define YYDEBUG 0
#endif

namespace yy {
#line 194 "include/parser/parser.hpp"

/// A Bison parser.
class parser {
public:
#ifdef YYSTYPE
#ifdef __GNUC__
#pragma GCC message "bison: do not #define YYSTYPE in C++, use %define api.value.type"
#endif
    typedef YYSTYPE value_type;
#else
    /// A buffer to store and retrieve objects.
    ///
    /// Sort of a variant, but does not keep track of the nature
    /// of the stored data, since that knowledge is available
    /// via the current parser state.
    class value_type {
    public:
        /// Type of *this.
        typedef value_type self_type;

        /// Empty construction.
        value_type() YY_NOEXCEPT : yyraw_(), yytypeid_(YY_NULLPTR) {}

        /// Construct and fill.
        template <typename T> value_type(YY_RVREF(T) t) : yytypeid_(&typeid(T)) {
            YY_ASSERT(sizeof(T) <= size);
            new (yyas_<T>()) T(YY_MOVE(t));
        }

#if 201103L <= YY_CPLUSPLUS
        /// Non copyable.
        value_type(const self_type &) = delete;
        /// Non copyable.
        self_type &operator=(const self_type &) = delete;
#endif

        /// Destruction, allowed only if empty.
        ~value_type() YY_NOEXCEPT { YY_ASSERT(!yytypeid_); }

#if 201103L <= YY_CPLUSPLUS
        /// Instantiate a \a T in here from \a t.
        template <typename T, typename... U> T &emplace(U &&...u) {
            YY_ASSERT(!yytypeid_);
            YY_ASSERT(sizeof(T) <= size);
            yytypeid_ = &typeid(T);
            return *new (yyas_<T>()) T(std::forward<U>(u)...);
        }
#else
        /// Instantiate an empty \a T in here.
        template <typename T> T &emplace() {
            YY_ASSERT(!yytypeid_);
            YY_ASSERT(sizeof(T) <= size);
            yytypeid_ = &typeid(T);
            return *new (yyas_<T>()) T();
        }

        /// Instantiate a \a T in here from \a t.
        template <typename T> T &emplace(const T &t) {
            YY_ASSERT(!yytypeid_);
            YY_ASSERT(sizeof(T) <= size);
            yytypeid_ = &typeid(T);
            return *new (yyas_<T>()) T(t);
        }
#endif

        /// Instantiate an empty \a T in here.
        /// Obsolete, use emplace.
        template <typename T> T &build() { return emplace<T>(); }

        /// Instantiate a \a T in here from \a t.
        /// Obsolete, use emplace.
        template <typename T> T &build(const T &t) { return emplace<T>(t); }

        /// Accessor to a built \a T.
        template <typename T> T &as() YY_NOEXCEPT {
            YY_ASSERT(yytypeid_);
            YY_ASSERT(*yytypeid_ == typeid(T));
            YY_ASSERT(sizeof(T) <= size);
            return *yyas_<T>();
        }

        /// Const accessor to a built \a T (for %printer).
        template <typename T> const T &as() const YY_NOEXCEPT {
            YY_ASSERT(yytypeid_);
            YY_ASSERT(*yytypeid_ == typeid(T));
            YY_ASSERT(sizeof(T) <= size);
            return *yyas_<T>();
        }

        /// Swap the content with \a that, of same type.
        ///
        /// Both variants must be built beforehand, because swapping the actual
        /// data requires reading it (with as()), and this is not possible on
        /// unconstructed variants: it would require some dynamic testing, which
        /// should not be the variant's responsibility.
        /// Swapping between built and (possibly) non-built is done with
        /// self_type::move ().
        template <typename T> void swap(self_type &that) YY_NOEXCEPT {
            YY_ASSERT(yytypeid_);
            YY_ASSERT(*yytypeid_ == *that.yytypeid_);
            std::swap(as<T>(), that.as<T>());
        }

        /// Move the content of \a that to this.
        ///
        /// Destroys \a that.
        template <typename T> void move(self_type &that) {
#if 201103L <= YY_CPLUSPLUS
            emplace<T>(std::move(that.as<T>()));
#else
            emplace<T>();
            swap<T>(that);
#endif
            that.destroy<T>();
        }

#if 201103L <= YY_CPLUSPLUS
        /// Move the content of \a that to this.
        template <typename T> void move(self_type &&that) {
            emplace<T>(std::move(that.as<T>()));
            that.destroy<T>();
        }
#endif

        /// Copy the content of \a that to this.
        template <typename T> void copy(const self_type &that) { emplace<T>(that.as<T>()); }

        /// Destroy the stored \a T.
        template <typename T> void destroy() {
            as<T>().~T();
            yytypeid_ = YY_NULLPTR;
        }

    private:
#if YY_CPLUSPLUS < 201103L
        /// Non copyable.
        value_type(const self_type &);
        /// Non copyable.
        self_type &operator=(const self_type &);
#endif

        /// Accessor to raw memory as \a T.
        template <typename T> T *yyas_() YY_NOEXCEPT {
            void *yyp = yyraw_;
            return static_cast<T *>(yyp);
        }

        /// Const accessor to raw memory as \a T.
        template <typename T> const T *yyas_() const YY_NOEXCEPT {
            const void *yyp = yyraw_;
            return static_cast<const T *>(yyp);
        }

        /// An auxiliary type to compute the largest semantic type.
        union union_type {
            // Type
            char dummy1[sizeof(AST::dtype)];

            // num_FLOAT
            char dummy2[sizeof(AST::float32)];

            // num_INT
            char dummy3[sizeof(AST::int32)];

            // Y_ID
            char dummy4[sizeof(AST::string)];

            // ConstAS
            // ArraySubscripts
            char dummy5[sizeof(std::shared_ptr<ArraySubscript>)];

            // Block
            // BlockItems
            char dummy6[sizeof(std::shared_ptr<CompStmt>)];

            // CompUnit
            char dummy7[sizeof(std::shared_ptr<CompUnit>)];

            // ConstDecl
            // VarDecl
            char dummy8[sizeof(std::shared_ptr<DeclStmt>)];

            // ConstExp
            // Exp
            // LVal
            // PrimaryExp
            // Number
            // UnaryExp
            // MulExp
            // AddExp
            // RelExp
            // EqExp
            // LAndExp
            // LOrExp
            char dummy9[sizeof(std::shared_ptr<Exp>)];

            // FuncDef
            char dummy10[sizeof(std::shared_ptr<FuncDef>)];

            // FuncFParams
            // FuncFParam
            char dummy11[sizeof(std::shared_ptr<FuncFParam>)];

            // FuncRParams
            char dummy12[sizeof(std::shared_ptr<FuncRParam>)];

            // ConstInitVal
            // ConstInitVals
            // InitVal
            // InitVals
            char dummy13[sizeof(std::shared_ptr<InitVal>)];

            // Decl
            // BlockItem
            // Stmt
            char dummy14[sizeof(std::shared_ptr<Stmt>)];

            // ConstDefs
            // ConstDef
            // VarDefs
            // VarDef
            char dummy15[sizeof(std::shared_ptr<VarDef>)];
        };

        /// The size of the largest semantic type.
        enum { size = sizeof(union_type) };

        /// A buffer to store semantic values.
        union {
            /// Strongest alignment constraints.
            long double yyalign_me_;
            /// A buffer large enough to store any of the semantic values.
            char yyraw_[size];
        };

        /// Whether the content is built: if defined, the name of the stored
        /// type.
        const std::type_info *yytypeid_;
    };

#endif
    /// Backward compatibility (Bison 3.8).
    typedef value_type semantic_type;

    /// Syntax errors thrown from user actions.
    struct syntax_error : std::runtime_error {
        syntax_error(const std::string &m) : std::runtime_error(m) {}

        syntax_error(const syntax_error &s) : std::runtime_error(s.what()) {}

        ~syntax_error() YY_NOEXCEPT YY_NOTHROW;
    };

    /// Token kinds.
    struct token {
        enum token_kind_type {
            YYEMPTY = -2,
            YYEOF = 0,        // "end of file"
            YYerror = 1,      // error
            YYUNDEF = 2,      // "invalid token"
            Y_INT = 3,        // Y_INT
            Y_VOID = 4,       // Y_VOID
            Y_CONST = 5,      // Y_CONST
            Y_IF = 6,         // Y_IF
            Y_ELSE = 7,       // Y_ELSE
            Y_WHILE = 8,      // Y_WHILE
            Y_BREAK = 9,      // Y_BREAK
            Y_CONTINUE = 10,  // Y_CONTINUE
            Y_RETURN = 11,    // Y_RETURN
            Y_ADD = 12,       // Y_ADD
            Y_SUB = 13,       // Y_SUB
            Y_MUL = 14,       // Y_MUL
            Y_DIV = 15,       // Y_DIV
            Y_MODULO = 16,    // Y_MODULO
            Y_LESS = 17,      // Y_LESS
            Y_LESSEQ = 18,    // Y_LESSEQ
            Y_GREAT = 19,     // Y_GREAT
            Y_GREATEQ = 20,   // Y_GREATEQ
            Y_NOTEQ = 21,     // Y_NOTEQ
            Y_EQ = 22,        // Y_EQ
            Y_NOT = 23,       // Y_NOT
            Y_AND = 24,       // Y_AND
            Y_OR = 25,        // Y_OR
            Y_ASSIGN = 26,    // Y_ASSIGN
            Y_LPAR = 27,      // Y_LPAR
            Y_RPAR = 28,      // Y_RPAR
            Y_LBRACKET = 29,  // Y_LBRACKET
            Y_RBRACKET = 30,  // Y_RBRACKET
            Y_LSQUARE = 31,   // Y_LSQUARE
            Y_RSQUARE = 32,   // Y_RSQUARE
            Y_COMMA = 33,     // Y_COMMA
            Y_SEMICOLON = 34, // Y_SEMICOLON
            Y_FLOAT = 35,     // Y_FLOAT
            num_INT = 36,     // num_INT
            num_FLOAT = 37,   // num_FLOAT
            Y_ID = 38         // Y_ID
        };
        /// Backward compatibility alias (Bison 3.6).
        typedef token_kind_type yytokentype;
    };

    /// Token kind, as returned by yylex.
    typedef token::token_kind_type token_kind_type;

    /// Backward compatibility alias (Bison 3.6).
    typedef token_kind_type token_type;

    /// Symbol kinds.
    struct symbol_kind {
        enum symbol_kind_type {
            YYNTOKENS = 39, ///< Number of tokens.
            S_YYEMPTY = -2,
            S_YYEOF = 0,            // "end of file"
            S_YYerror = 1,          // error
            S_YYUNDEF = 2,          // "invalid token"
            S_Y_INT = 3,            // Y_INT
            S_Y_VOID = 4,           // Y_VOID
            S_Y_CONST = 5,          // Y_CONST
            S_Y_IF = 6,             // Y_IF
            S_Y_ELSE = 7,           // Y_ELSE
            S_Y_WHILE = 8,          // Y_WHILE
            S_Y_BREAK = 9,          // Y_BREAK
            S_Y_CONTINUE = 10,      // Y_CONTINUE
            S_Y_RETURN = 11,        // Y_RETURN
            S_Y_ADD = 12,           // Y_ADD
            S_Y_SUB = 13,           // Y_SUB
            S_Y_MUL = 14,           // Y_MUL
            S_Y_DIV = 15,           // Y_DIV
            S_Y_MODULO = 16,        // Y_MODULO
            S_Y_LESS = 17,          // Y_LESS
            S_Y_LESSEQ = 18,        // Y_LESSEQ
            S_Y_GREAT = 19,         // Y_GREAT
            S_Y_GREATEQ = 20,       // Y_GREATEQ
            S_Y_NOTEQ = 21,         // Y_NOTEQ
            S_Y_EQ = 22,            // Y_EQ
            S_Y_NOT = 23,           // Y_NOT
            S_Y_AND = 24,           // Y_AND
            S_Y_OR = 25,            // Y_OR
            S_Y_ASSIGN = 26,        // Y_ASSIGN
            S_Y_LPAR = 27,          // Y_LPAR
            S_Y_RPAR = 28,          // Y_RPAR
            S_Y_LBRACKET = 29,      // Y_LBRACKET
            S_Y_RBRACKET = 30,      // Y_RBRACKET
            S_Y_LSQUARE = 31,       // Y_LSQUARE
            S_Y_RSQUARE = 32,       // Y_RSQUARE
            S_Y_COMMA = 33,         // Y_COMMA
            S_Y_SEMICOLON = 34,     // Y_SEMICOLON
            S_Y_FLOAT = 35,         // Y_FLOAT
            S_num_INT = 36,         // num_INT
            S_num_FLOAT = 37,       // num_FLOAT
            S_Y_ID = 38,            // Y_ID
            S_YYACCEPT = 39,        // $accept
            S_CompileUnit = 40,     // CompileUnit
            S_CompUnit = 41,        // CompUnit
            S_Decl = 42,            // Decl
            S_Type = 43,            // Type
            S_ConstDecl = 44,       // ConstDecl
            S_ConstDefs = 45,       // ConstDefs
            S_ConstDef = 46,        // ConstDef
            S_ConstAS = 47,         // ConstAS
            S_ConstExp = 48,        // ConstExp
            S_ConstInitVal = 49,    // ConstInitVal
            S_ConstInitVals = 50,   // ConstInitVals
            S_VarDecl = 51,         // VarDecl
            S_VarDefs = 52,         // VarDefs
            S_VarDef = 53,          // VarDef
            S_InitVal = 54,         // InitVal
            S_InitVals = 55,        // InitVals
            S_FuncDef = 56,         // FuncDef
            S_FuncFParams = 57,     // FuncFParams
            S_FuncFParam = 58,      // FuncFParam
            S_ArraySubscripts = 59, // ArraySubscripts
            S_Block = 60,           // Block
            S_BlockItems = 61,      // BlockItems
            S_BlockItem = 62,       // BlockItem
            S_Stmt = 63,            // Stmt
            S_Exp = 64,             // Exp
            S_LVal = 65,            // LVal
            S_PrimaryExp = 66,      // PrimaryExp
            S_Number = 67,          // Number
            S_UnaryExp = 68,        // UnaryExp
            S_FuncRParams = 69,     // FuncRParams
            S_MulExp = 70,          // MulExp
            S_AddExp = 71,          // AddExp
            S_RelExp = 72,          // RelExp
            S_EqExp = 73,           // EqExp
            S_LAndExp = 74,         // LAndExp
            S_LOrExp = 75           // LOrExp
        };
    };

    /// (Internal) symbol kind.
    typedef symbol_kind::symbol_kind_type symbol_kind_type;

    /// The number of tokens.
    static const symbol_kind_type YYNTOKENS = symbol_kind::YYNTOKENS;

    /// A complete symbol.
    ///
    /// Expects its Base type to provide access to the symbol kind
    /// via kind ().
    ///
    /// Provide access to semantic value.
    template <typename Base> struct basic_symbol : Base {
        /// Alias to Base.
        typedef Base super_type;

        /// Default constructor.
        basic_symbol() YY_NOEXCEPT : value() {}

#if 201103L <= YY_CPLUSPLUS
        /// Move constructor.
        basic_symbol(basic_symbol &&that) : Base(std::move(that)), value() {
            switch (this->kind()) {
            case symbol_kind::S_Type: // Type
                value.move<AST::dtype>(std::move(that.value));
                break;

            case symbol_kind::S_num_FLOAT: // num_FLOAT
                value.move<AST::float32>(std::move(that.value));
                break;

            case symbol_kind::S_num_INT: // num_INT
                value.move<AST::int32>(std::move(that.value));
                break;

            case symbol_kind::S_Y_ID: // Y_ID
                value.move<AST::string>(std::move(that.value));
                break;

            case symbol_kind::S_ConstAS:         // ConstAS
            case symbol_kind::S_ArraySubscripts: // ArraySubscripts
                value.move<std::shared_ptr<ArraySubscript>>(std::move(that.value));
                break;

            case symbol_kind::S_Block:      // Block
            case symbol_kind::S_BlockItems: // BlockItems
                value.move<std::shared_ptr<CompStmt>>(std::move(that.value));
                break;

            case symbol_kind::S_CompUnit: // CompUnit
                value.move<std::shared_ptr<CompUnit>>(std::move(that.value));
                break;

            case symbol_kind::S_ConstDecl: // ConstDecl
            case symbol_kind::S_VarDecl:   // VarDecl
                value.move<std::shared_ptr<DeclStmt>>(std::move(that.value));
                break;

            case symbol_kind::S_ConstExp:   // ConstExp
            case symbol_kind::S_Exp:        // Exp
            case symbol_kind::S_LVal:       // LVal
            case symbol_kind::S_PrimaryExp: // PrimaryExp
            case symbol_kind::S_Number:     // Number
            case symbol_kind::S_UnaryExp:   // UnaryExp
            case symbol_kind::S_MulExp:     // MulExp
            case symbol_kind::S_AddExp:     // AddExp
            case symbol_kind::S_RelExp:     // RelExp
            case symbol_kind::S_EqExp:      // EqExp
            case symbol_kind::S_LAndExp:    // LAndExp
            case symbol_kind::S_LOrExp:     // LOrExp
                value.move<std::shared_ptr<Exp>>(std::move(that.value));
                break;

            case symbol_kind::S_FuncDef: // FuncDef
                value.move<std::shared_ptr<FuncDef>>(std::move(that.value));
                break;

            case symbol_kind::S_FuncFParams: // FuncFParams
            case symbol_kind::S_FuncFParam:  // FuncFParam
                value.move<std::shared_ptr<FuncFParam>>(std::move(that.value));
                break;

            case symbol_kind::S_FuncRParams: // FuncRParams
                value.move<std::shared_ptr<FuncRParam>>(std::move(that.value));
                break;

            case symbol_kind::S_ConstInitVal:  // ConstInitVal
            case symbol_kind::S_ConstInitVals: // ConstInitVals
            case symbol_kind::S_InitVal:       // InitVal
            case symbol_kind::S_InitVals:      // InitVals
                value.move<std::shared_ptr<InitVal>>(std::move(that.value));
                break;

            case symbol_kind::S_Decl:      // Decl
            case symbol_kind::S_BlockItem: // BlockItem
            case symbol_kind::S_Stmt:      // Stmt
                value.move<std::shared_ptr<Stmt>>(std::move(that.value));
                break;

            case symbol_kind::S_ConstDefs: // ConstDefs
            case symbol_kind::S_ConstDef:  // ConstDef
            case symbol_kind::S_VarDefs:   // VarDefs
            case symbol_kind::S_VarDef:    // VarDef
                value.move<std::shared_ptr<VarDef>>(std::move(that.value));
                break;

            default:
                break;
            }
        }
#endif

        /// Copy constructor.
        basic_symbol(const basic_symbol &that);

        /// Constructors for typed symbols.
#if 201103L <= YY_CPLUSPLUS
        basic_symbol(typename Base::kind_type t) : Base(t) {}
#else
        basic_symbol(typename Base::kind_type t) : Base(t) {}
#endif

#if 201103L <= YY_CPLUSPLUS
        basic_symbol(typename Base::kind_type t, AST::dtype &&v) : Base(t), value(std::move(v)) {}
#else
        basic_symbol(typename Base::kind_type t, const AST::dtype &v) : Base(t), value(v) {}
#endif

#if 201103L <= YY_CPLUSPLUS
        basic_symbol(typename Base::kind_type t, AST::float32 &&v) : Base(t), value(std::move(v)) {}
#else
        basic_symbol(typename Base::kind_type t, const AST::float32 &v) : Base(t), value(v) {}
#endif

#if 201103L <= YY_CPLUSPLUS
        basic_symbol(typename Base::kind_type t, AST::int32 &&v) : Base(t), value(std::move(v)) {}
#else
        basic_symbol(typename Base::kind_type t, const AST::int32 &v) : Base(t), value(v) {}
#endif

#if 201103L <= YY_CPLUSPLUS
        basic_symbol(typename Base::kind_type t, AST::string &&v) : Base(t), value(std::move(v)) {}
#else
        basic_symbol(typename Base::kind_type t, const AST::string &v) : Base(t), value(v) {}
#endif

#if 201103L <= YY_CPLUSPLUS
        basic_symbol(typename Base::kind_type t, std::shared_ptr<ArraySubscript> &&v) : Base(t), value(std::move(v)) {}
#else
        basic_symbol(typename Base::kind_type t, const std::shared_ptr<ArraySubscript> &v) : Base(t), value(v) {}
#endif

#if 201103L <= YY_CPLUSPLUS
        basic_symbol(typename Base::kind_type t, std::shared_ptr<CompStmt> &&v) : Base(t), value(std::move(v)) {}
#else
        basic_symbol(typename Base::kind_type t, const std::shared_ptr<CompStmt> &v) : Base(t), value(v) {}
#endif

#if 201103L <= YY_CPLUSPLUS
        basic_symbol(typename Base::kind_type t, std::shared_ptr<CompUnit> &&v) : Base(t), value(std::move(v)) {}
#else
        basic_symbol(typename Base::kind_type t, const std::shared_ptr<CompUnit> &v) : Base(t), value(v) {}
#endif

#if 201103L <= YY_CPLUSPLUS
        basic_symbol(typename Base::kind_type t, std::shared_ptr<DeclStmt> &&v) : Base(t), value(std::move(v)) {}
#else
        basic_symbol(typename Base::kind_type t, const std::shared_ptr<DeclStmt> &v) : Base(t), value(v) {}
#endif

#if 201103L <= YY_CPLUSPLUS
        basic_symbol(typename Base::kind_type t, std::shared_ptr<Exp> &&v) : Base(t), value(std::move(v)) {}
#else
        basic_symbol(typename Base::kind_type t, const std::shared_ptr<Exp> &v) : Base(t), value(v) {}
#endif

#if 201103L <= YY_CPLUSPLUS
        basic_symbol(typename Base::kind_type t, std::shared_ptr<FuncDef> &&v) : Base(t), value(std::move(v)) {}
#else
        basic_symbol(typename Base::kind_type t, const std::shared_ptr<FuncDef> &v) : Base(t), value(v) {}
#endif

#if 201103L <= YY_CPLUSPLUS
        basic_symbol(typename Base::kind_type t, std::shared_ptr<FuncFParam> &&v) : Base(t), value(std::move(v)) {}
#else
        basic_symbol(typename Base::kind_type t, const std::shared_ptr<FuncFParam> &v) : Base(t), value(v) {}
#endif

#if 201103L <= YY_CPLUSPLUS
        basic_symbol(typename Base::kind_type t, std::shared_ptr<FuncRParam> &&v) : Base(t), value(std::move(v)) {}
#else
        basic_symbol(typename Base::kind_type t, const std::shared_ptr<FuncRParam> &v) : Base(t), value(v) {}
#endif

#if 201103L <= YY_CPLUSPLUS
        basic_symbol(typename Base::kind_type t, std::shared_ptr<InitVal> &&v) : Base(t), value(std::move(v)) {}
#else
        basic_symbol(typename Base::kind_type t, const std::shared_ptr<InitVal> &v) : Base(t), value(v) {}
#endif

#if 201103L <= YY_CPLUSPLUS
        basic_symbol(typename Base::kind_type t, std::shared_ptr<Stmt> &&v) : Base(t), value(std::move(v)) {}
#else
        basic_symbol(typename Base::kind_type t, const std::shared_ptr<Stmt> &v) : Base(t), value(v) {}
#endif

#if 201103L <= YY_CPLUSPLUS
        basic_symbol(typename Base::kind_type t, std::shared_ptr<VarDef> &&v) : Base(t), value(std::move(v)) {}
#else
        basic_symbol(typename Base::kind_type t, const std::shared_ptr<VarDef> &v) : Base(t), value(v) {}
#endif

        /// Destroy the symbol.
        ~basic_symbol() { clear(); }

        /// Destroy contents, and record that is empty.
        void clear() YY_NOEXCEPT {
            // User destructor.
            symbol_kind_type yykind = this->kind();
            basic_symbol<Base> &yysym = *this;
            (void)yysym;
            switch (yykind) {
            default:
                break;
            }

            // Value type destructor.
            switch (yykind) {
            case symbol_kind::S_Type: // Type
                value.template destroy<AST::dtype>();
                break;

            case symbol_kind::S_num_FLOAT: // num_FLOAT
                value.template destroy<AST::float32>();
                break;

            case symbol_kind::S_num_INT: // num_INT
                value.template destroy<AST::int32>();
                break;

            case symbol_kind::S_Y_ID: // Y_ID
                value.template destroy<AST::string>();
                break;

            case symbol_kind::S_ConstAS:         // ConstAS
            case symbol_kind::S_ArraySubscripts: // ArraySubscripts
                value.template destroy<std::shared_ptr<ArraySubscript>>();
                break;

            case symbol_kind::S_Block:      // Block
            case symbol_kind::S_BlockItems: // BlockItems
                value.template destroy<std::shared_ptr<CompStmt>>();
                break;

            case symbol_kind::S_CompUnit: // CompUnit
                value.template destroy<std::shared_ptr<CompUnit>>();
                break;

            case symbol_kind::S_ConstDecl: // ConstDecl
            case symbol_kind::S_VarDecl:   // VarDecl
                value.template destroy<std::shared_ptr<DeclStmt>>();
                break;

            case symbol_kind::S_ConstExp:   // ConstExp
            case symbol_kind::S_Exp:        // Exp
            case symbol_kind::S_LVal:       // LVal
            case symbol_kind::S_PrimaryExp: // PrimaryExp
            case symbol_kind::S_Number:     // Number
            case symbol_kind::S_UnaryExp:   // UnaryExp
            case symbol_kind::S_MulExp:     // MulExp
            case symbol_kind::S_AddExp:     // AddExp
            case symbol_kind::S_RelExp:     // RelExp
            case symbol_kind::S_EqExp:      // EqExp
            case symbol_kind::S_LAndExp:    // LAndExp
            case symbol_kind::S_LOrExp:     // LOrExp
                value.template destroy<std::shared_ptr<Exp>>();
                break;

            case symbol_kind::S_FuncDef: // FuncDef
                value.template destroy<std::shared_ptr<FuncDef>>();
                break;

            case symbol_kind::S_FuncFParams: // FuncFParams
            case symbol_kind::S_FuncFParam:  // FuncFParam
                value.template destroy<std::shared_ptr<FuncFParam>>();
                break;

            case symbol_kind::S_FuncRParams: // FuncRParams
                value.template destroy<std::shared_ptr<FuncRParam>>();
                break;

            case symbol_kind::S_ConstInitVal:  // ConstInitVal
            case symbol_kind::S_ConstInitVals: // ConstInitVals
            case symbol_kind::S_InitVal:       // InitVal
            case symbol_kind::S_InitVals:      // InitVals
                value.template destroy<std::shared_ptr<InitVal>>();
                break;

            case symbol_kind::S_Decl:      // Decl
            case symbol_kind::S_BlockItem: // BlockItem
            case symbol_kind::S_Stmt:      // Stmt
                value.template destroy<std::shared_ptr<Stmt>>();
                break;

            case symbol_kind::S_ConstDefs: // ConstDefs
            case symbol_kind::S_ConstDef:  // ConstDef
            case symbol_kind::S_VarDefs:   // VarDefs
            case symbol_kind::S_VarDef:    // VarDef
                value.template destroy<std::shared_ptr<VarDef>>();
                break;

            default:
                break;
            }

            Base::clear();
        }

#if YYDEBUG || 0
        /// The user-facing name of this symbol.
        const char *name() const YY_NOEXCEPT { return parser::symbol_name(this->kind()); }
#endif // #if YYDEBUG || 0

        /// Backward compatibility (Bison 3.6).
        symbol_kind_type type_get() const YY_NOEXCEPT;

        /// Whether empty.
        bool empty() const YY_NOEXCEPT;

        /// Destructive move, \a s is emptied into this.
        void move(basic_symbol &s);

        /// The semantic value.
        value_type value;

    private:
#if YY_CPLUSPLUS < 201103L
        /// Assignment operator.
        basic_symbol &operator=(const basic_symbol &that);
#endif
    };

    /// Type access provider for token (enum) based symbols.
    struct by_kind {
        /// The symbol kind as needed by the constructor.
        typedef token_kind_type kind_type;

        /// Default constructor.
        by_kind() YY_NOEXCEPT;

#if 201103L <= YY_CPLUSPLUS
        /// Move constructor.
        by_kind(by_kind &&that) YY_NOEXCEPT;
#endif

        /// Copy constructor.
        by_kind(const by_kind &that) YY_NOEXCEPT;

        /// Constructor from (external) token numbers.
        by_kind(kind_type t) YY_NOEXCEPT;

        /// Record that this symbol is empty.
        void clear() YY_NOEXCEPT;

        /// Steal the symbol kind from \a that.
        void move(by_kind &that);

        /// The (internal) type number (corresponding to \a type).
        /// \a empty when empty.
        symbol_kind_type kind() const YY_NOEXCEPT;

        /// Backward compatibility (Bison 3.6).
        symbol_kind_type type_get() const YY_NOEXCEPT;

        /// The symbol kind.
        /// \a S_YYEMPTY when empty.
        symbol_kind_type kind_;
    };

    /// Backward compatibility for a private implementation detail (Bison 3.6).
    typedef by_kind by_type;

    /// "External" symbols: returned by the scanner.
    struct symbol_type : basic_symbol<by_kind> {
        /// Superclass.
        typedef basic_symbol<by_kind> super_type;

        /// Empty symbol.
        symbol_type() YY_NOEXCEPT {}

        /// Constructor for valueless symbols, and symbols from each type.
#if 201103L <= YY_CPLUSPLUS
        symbol_type(int tok)
            : super_type(token_kind_type(tok))
#else
        symbol_type(int tok)
            : super_type(token_kind_type(tok))
#endif
        {
#if !defined _MSC_VER || defined __clang__
            YY_ASSERT(tok == token::YYEOF || (token::YYerror <= tok && tok <= token::Y_FLOAT));
#endif
        }
#if 201103L <= YY_CPLUSPLUS
        symbol_type(int tok, AST::float32 v)
            : super_type(token_kind_type(tok), std::move(v))
#else
        symbol_type(int tok, const AST::float32 &v)
            : super_type(token_kind_type(tok), v)
#endif
        {
#if !defined _MSC_VER || defined __clang__
            YY_ASSERT(tok == token::num_FLOAT);
#endif
        }
#if 201103L <= YY_CPLUSPLUS
        symbol_type(int tok, AST::int32 v)
            : super_type(token_kind_type(tok), std::move(v))
#else
        symbol_type(int tok, const AST::int32 &v)
            : super_type(token_kind_type(tok), v)
#endif
        {
#if !defined _MSC_VER || defined __clang__
            YY_ASSERT(tok == token::num_INT);
#endif
        }
#if 201103L <= YY_CPLUSPLUS
        symbol_type(int tok, AST::string v)
            : super_type(token_kind_type(tok), std::move(v))
#else
        symbol_type(int tok, const AST::string &v)
            : super_type(token_kind_type(tok), v)
#endif
        {
#if !defined _MSC_VER || defined __clang__
            YY_ASSERT(tok == token::Y_ID);
#endif
        }
    };

    /// Build a parser object.
    parser();
    virtual ~parser();

#if 201103L <= YY_CPLUSPLUS
    /// Non copyable.
    parser(const parser &) = delete;
    /// Non copyable.
    parser &operator=(const parser &) = delete;
#endif

    /// Parse.  An alias for parse ().
    /// \returns  0 iff parsing succeeded.
    int operator()();

    /// Parse.
    /// \returns  0 iff parsing succeeded.
    virtual int parse();

#if YYDEBUG
    /// The current debugging stream.
    std::ostream &debug_stream() const YY_ATTRIBUTE_PURE;
    /// Set the current debugging stream.
    void set_debug_stream(std::ostream &);

    /// Type for debugging levels.
    typedef int debug_level_type;
    /// The current debugging level.
    debug_level_type debug_level() const YY_ATTRIBUTE_PURE;
    /// Set the current debugging level.
    void set_debug_level(debug_level_type l);
#endif

    /// Report a syntax error.
    /// \param msg    a description of the syntax error.
    virtual void error(const std::string &msg);

    /// Report a syntax error.
    void error(const syntax_error &err);

#if YYDEBUG || 0
    /// The user-facing name of the symbol whose (internal) number is
    /// YYSYMBOL.  No bounds checking.
    static const char *symbol_name(symbol_kind_type yysymbol);
#endif // #if YYDEBUG || 0

    // Implementation of make_symbol for each token kind.
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_YYEOF() { return symbol_type(token::YYEOF); }
#else
    static symbol_type make_YYEOF() { return symbol_type(token::YYEOF); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_YYerror() { return symbol_type(token::YYerror); }
#else
    static symbol_type make_YYerror() { return symbol_type(token::YYerror); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_YYUNDEF() { return symbol_type(token::YYUNDEF); }
#else
    static symbol_type make_YYUNDEF() { return symbol_type(token::YYUNDEF); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_INT() { return symbol_type(token::Y_INT); }
#else
    static symbol_type make_Y_INT() { return symbol_type(token::Y_INT); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_VOID() { return symbol_type(token::Y_VOID); }
#else
    static symbol_type make_Y_VOID() { return symbol_type(token::Y_VOID); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_CONST() { return symbol_type(token::Y_CONST); }
#else
    static symbol_type make_Y_CONST() { return symbol_type(token::Y_CONST); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_IF() { return symbol_type(token::Y_IF); }
#else
    static symbol_type make_Y_IF() { return symbol_type(token::Y_IF); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_ELSE() { return symbol_type(token::Y_ELSE); }
#else
    static symbol_type make_Y_ELSE() { return symbol_type(token::Y_ELSE); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_WHILE() { return symbol_type(token::Y_WHILE); }
#else
    static symbol_type make_Y_WHILE() { return symbol_type(token::Y_WHILE); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_BREAK() { return symbol_type(token::Y_BREAK); }
#else
    static symbol_type make_Y_BREAK() { return symbol_type(token::Y_BREAK); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_CONTINUE() { return symbol_type(token::Y_CONTINUE); }
#else
    static symbol_type make_Y_CONTINUE() { return symbol_type(token::Y_CONTINUE); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_RETURN() { return symbol_type(token::Y_RETURN); }
#else
    static symbol_type make_Y_RETURN() { return symbol_type(token::Y_RETURN); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_ADD() { return symbol_type(token::Y_ADD); }
#else
    static symbol_type make_Y_ADD() { return symbol_type(token::Y_ADD); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_SUB() { return symbol_type(token::Y_SUB); }
#else
    static symbol_type make_Y_SUB() { return symbol_type(token::Y_SUB); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_MUL() { return symbol_type(token::Y_MUL); }
#else
    static symbol_type make_Y_MUL() { return symbol_type(token::Y_MUL); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_DIV() { return symbol_type(token::Y_DIV); }
#else
    static symbol_type make_Y_DIV() { return symbol_type(token::Y_DIV); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_MODULO() { return symbol_type(token::Y_MODULO); }
#else
    static symbol_type make_Y_MODULO() { return symbol_type(token::Y_MODULO); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_LESS() { return symbol_type(token::Y_LESS); }
#else
    static symbol_type make_Y_LESS() { return symbol_type(token::Y_LESS); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_LESSEQ() { return symbol_type(token::Y_LESSEQ); }
#else
    static symbol_type make_Y_LESSEQ() { return symbol_type(token::Y_LESSEQ); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_GREAT() { return symbol_type(token::Y_GREAT); }
#else
    static symbol_type make_Y_GREAT() { return symbol_type(token::Y_GREAT); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_GREATEQ() { return symbol_type(token::Y_GREATEQ); }
#else
    static symbol_type make_Y_GREATEQ() { return symbol_type(token::Y_GREATEQ); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_NOTEQ() { return symbol_type(token::Y_NOTEQ); }
#else
    static symbol_type make_Y_NOTEQ() { return symbol_type(token::Y_NOTEQ); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_EQ() { return symbol_type(token::Y_EQ); }
#else
    static symbol_type make_Y_EQ() { return symbol_type(token::Y_EQ); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_NOT() { return symbol_type(token::Y_NOT); }
#else
    static symbol_type make_Y_NOT() { return symbol_type(token::Y_NOT); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_AND() { return symbol_type(token::Y_AND); }
#else
    static symbol_type make_Y_AND() { return symbol_type(token::Y_AND); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_OR() { return symbol_type(token::Y_OR); }
#else
    static symbol_type make_Y_OR() { return symbol_type(token::Y_OR); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_ASSIGN() { return symbol_type(token::Y_ASSIGN); }
#else
    static symbol_type make_Y_ASSIGN() { return symbol_type(token::Y_ASSIGN); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_LPAR() { return symbol_type(token::Y_LPAR); }
#else
    static symbol_type make_Y_LPAR() { return symbol_type(token::Y_LPAR); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_RPAR() { return symbol_type(token::Y_RPAR); }
#else
    static symbol_type make_Y_RPAR() { return symbol_type(token::Y_RPAR); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_LBRACKET() { return symbol_type(token::Y_LBRACKET); }
#else
    static symbol_type make_Y_LBRACKET() { return symbol_type(token::Y_LBRACKET); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_RBRACKET() { return symbol_type(token::Y_RBRACKET); }
#else
    static symbol_type make_Y_RBRACKET() { return symbol_type(token::Y_RBRACKET); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_LSQUARE() { return symbol_type(token::Y_LSQUARE); }
#else
    static symbol_type make_Y_LSQUARE() { return symbol_type(token::Y_LSQUARE); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_RSQUARE() { return symbol_type(token::Y_RSQUARE); }
#else
    static symbol_type make_Y_RSQUARE() { return symbol_type(token::Y_RSQUARE); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_COMMA() { return symbol_type(token::Y_COMMA); }
#else
    static symbol_type make_Y_COMMA() { return symbol_type(token::Y_COMMA); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_SEMICOLON() { return symbol_type(token::Y_SEMICOLON); }
#else
    static symbol_type make_Y_SEMICOLON() { return symbol_type(token::Y_SEMICOLON); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_FLOAT() { return symbol_type(token::Y_FLOAT); }
#else
    static symbol_type make_Y_FLOAT() { return symbol_type(token::Y_FLOAT); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_num_INT(AST::int32 v) { return symbol_type(token::num_INT, std::move(v)); }
#else
    static symbol_type make_num_INT(const AST::int32 &v) { return symbol_type(token::num_INT, v); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_num_FLOAT(AST::float32 v) { return symbol_type(token::num_FLOAT, std::move(v)); }
#else
    static symbol_type make_num_FLOAT(const AST::float32 &v) { return symbol_type(token::num_FLOAT, v); }
#endif
#if 201103L <= YY_CPLUSPLUS
    static symbol_type make_Y_ID(AST::string v) { return symbol_type(token::Y_ID, std::move(v)); }
#else
    static symbol_type make_Y_ID(const AST::string &v) { return symbol_type(token::Y_ID, v); }
#endif

private:
#if YY_CPLUSPLUS < 201103L
    /// Non copyable.
    parser(const parser &);
    /// Non copyable.
    parser &operator=(const parser &);
#endif

    /// Stored state numbers (used for stacks).
    typedef unsigned char state_type;

    /// Compute post-reduction state.
    /// \param yystate   the current state
    /// \param yysym     the nonterminal to push on the stack
    static state_type yy_lr_goto_state_(state_type yystate, int yysym);

    /// Whether the given \c yypact_ value indicates a defaulted state.
    /// \param yyvalue   the value to check
    static bool yy_pact_value_is_default_(int yyvalue) YY_NOEXCEPT;

    /// Whether the given \c yytable_ value indicates a syntax error.
    /// \param yyvalue   the value to check
    static bool yy_table_value_is_error_(int yyvalue) YY_NOEXCEPT;

    static const short yypact_ninf_;
    static const signed char yytable_ninf_;

    /// Convert a scanner token kind \a t to a symbol kind.
    /// In theory \a t should be a token_kind_type, but character literals
    /// are valid, yet not members of the token_kind_type enum.
    static symbol_kind_type yytranslate_(int t) YY_NOEXCEPT;

#if YYDEBUG || 0
    /// For a symbol, its name in clear.
    static const char *const yytname_[];
#endif // #if YYDEBUG || 0

    // Tables.
    // YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
    // STATE-NUM.
    static const short yypact_[];

    // YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
    // Performed when YYTABLE does not specify something else to do.  Zero
    // means the default is an error.
    static const signed char yydefact_[];

    // YYPGOTO[NTERM-NUM].
    static const short yypgoto_[];

    // YYDEFGOTO[NTERM-NUM].
    static const unsigned char yydefgoto_[];

    // YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
    // positive, shift that token.  If negative, reduce the rule whose
    // number is the opposite.  If YYTABLE_NINF, syntax error.
    static const unsigned char yytable_[];

    static const short yycheck_[];

    // YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
    // state STATE-NUM.
    static const signed char yystos_[];

    // YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.
    static const signed char yyr1_[];

    // YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule
    // RULE-NUM.
    static const signed char yyr2_[];

#if YYDEBUG
    // YYRLINE[YYN] -- Source line where rule number YYN was defined.
    static const unsigned char yyrline_[];
    /// Report on the debug stream that the rule \a r is going to be reduced.
    virtual void yy_reduce_print_(int r) const;
    /// Print the state stack on the debug stream.
    virtual void yy_stack_print_() const;

    /// Debugging level.
    int yydebug_;
    /// Debug stream.
    std::ostream *yycdebug_;

    /// \brief Display a symbol kind, value and location.
    /// \param yyo    The output stream.
    /// \param yysym  The symbol.
    template <typename Base> void yy_print_(std::ostream &yyo, const basic_symbol<Base> &yysym) const;
#endif

    /// \brief Reclaim the memory associated to a symbol.
    /// \param yymsg     Why this token is reclaimed.
    ///                  If null, print nothing.
    /// \param yysym     The symbol.
    template <typename Base> void yy_destroy_(const char *yymsg, basic_symbol<Base> &yysym) const;

private:
    /// Type access provider for state based symbols.
    struct by_state {
        /// Default constructor.
        by_state() YY_NOEXCEPT;

        /// The symbol kind as needed by the constructor.
        typedef state_type kind_type;

        /// Constructor.
        by_state(kind_type s) YY_NOEXCEPT;

        /// Copy constructor.
        by_state(const by_state &that) YY_NOEXCEPT;

        /// Record that this symbol is empty.
        void clear() YY_NOEXCEPT;

        /// Steal the symbol kind from \a that.
        void move(by_state &that);

        /// The symbol kind (corresponding to \a state).
        /// \a symbol_kind::S_YYEMPTY when empty.
        symbol_kind_type kind() const YY_NOEXCEPT;

        /// The state number used to denote an empty symbol.
        /// We use the initial state, as it does not have a value.
        enum { empty_state = 0 };

        /// The state.
        /// \a empty when empty.
        state_type state;
    };

    /// "Internal" symbol: element of the stack.
    struct stack_symbol_type : basic_symbol<by_state> {
        /// Superclass.
        typedef basic_symbol<by_state> super_type;
        /// Construct an empty symbol.
        stack_symbol_type();
        /// Move or copy construction.
        stack_symbol_type(YY_RVREF(stack_symbol_type) that);
        /// Steal the contents from \a sym to build this.
        stack_symbol_type(state_type s, YY_MOVE_REF(symbol_type) sym);
#if YY_CPLUSPLUS < 201103L
        /// Assignment, needed by push_back by some old implementations.
        /// Moves the contents of that.
        stack_symbol_type &operator=(stack_symbol_type &that);

        /// Assignment, needed by push_back by other implementations.
        /// Needed by some other old implementations.
        stack_symbol_type &operator=(const stack_symbol_type &that);
#endif
    };

    /// A stack with random access from its top.
    template <typename T, typename S = std::vector<T>> class stack {
    public:
        // Hide our reversed order.
        typedef typename S::iterator iterator;
        typedef typename S::const_iterator const_iterator;
        typedef typename S::size_type size_type;
        typedef typename std::ptrdiff_t index_type;

        stack(size_type n = 200) YY_NOEXCEPT : seq_(n) {}

#if 201103L <= YY_CPLUSPLUS
        /// Non copyable.
        stack(const stack &) = delete;
        /// Non copyable.
        stack &operator=(const stack &) = delete;
#endif

        /// Random access.
        ///
        /// Index 0 returns the topmost element.
        const T &operator[](index_type i) const { return seq_[size_type(size() - 1 - i)]; }

        /// Random access.
        ///
        /// Index 0 returns the topmost element.
        T &operator[](index_type i) { return seq_[size_type(size() - 1 - i)]; }

        /// Steal the contents of \a t.
        ///
        /// Close to move-semantics.
        void push(YY_MOVE_REF(T) t) {
            seq_.push_back(T());
            operator[](0).move(t);
        }

        /// Pop elements from the stack.
        void pop(std::ptrdiff_t n = 1) YY_NOEXCEPT {
            for (; 0 < n; --n)
                seq_.pop_back();
        }

        /// Pop all elements from the stack.
        void clear() YY_NOEXCEPT { seq_.clear(); }

        /// Number of elements on the stack.
        index_type size() const YY_NOEXCEPT { return index_type(seq_.size()); }

        /// Iterator on top of the stack (going downwards).
        const_iterator begin() const YY_NOEXCEPT { return seq_.begin(); }

        /// Bottom of the stack.
        const_iterator end() const YY_NOEXCEPT { return seq_.end(); }

        /// Present a slice of the top of a stack.
        class slice {
        public:
            slice(const stack &stack, index_type range) YY_NOEXCEPT : stack_(stack), range_(range) {}

            const T &operator[](index_type i) const { return stack_[range_ - i]; }

        private:
            const stack &stack_;
            index_type range_;
        };

    private:
#if YY_CPLUSPLUS < 201103L
        /// Non copyable.
        stack(const stack &);
        /// Non copyable.
        stack &operator=(const stack &);
#endif
        /// The wrapped container.
        S seq_;
    };

    /// Stack type.
    typedef stack<stack_symbol_type> stack_type;

    /// The stack.
    stack_type yystack_;

    /// Push a new state on the stack.
    /// \param m    a debug message to display
    ///             if null, no trace is output.
    /// \param sym  the symbol
    /// \warning the contents of \a s.value is stolen.
    void yypush_(const char *m, YY_MOVE_REF(stack_symbol_type) sym);

    /// Push a new look ahead token on the state on the stack.
    /// \param m    a debug message to display
    ///             if null, no trace is output.
    /// \param s    the state
    /// \param sym  the symbol (for its value and location).
    /// \warning the contents of \a sym.value is stolen.
    void yypush_(const char *m, state_type s, YY_MOVE_REF(symbol_type) sym);

    /// Pop \a n symbols from the stack.
    void yypop_(int n = 1) YY_NOEXCEPT;

    /// Constants.
    enum {
        yylast_ = 261, ///< Last index in yytable_.
        yynnts_ = 37,  ///< Number of nonterminal symbols.
        yyfinal_ = 13  ///< Termination state number.
    };
};

inline parser::symbol_kind_type parser::yytranslate_(int t) YY_NOEXCEPT { return static_cast<symbol_kind_type>(t); }

// basic_symbol.
template <typename Base> parser::basic_symbol<Base>::basic_symbol(const basic_symbol &that) : Base(that), value() {
    switch (this->kind()) {
    case symbol_kind::S_Type: // Type
        value.copy<AST::dtype>(YY_MOVE(that.value));
        break;

    case symbol_kind::S_num_FLOAT: // num_FLOAT
        value.copy<AST::float32>(YY_MOVE(that.value));
        break;

    case symbol_kind::S_num_INT: // num_INT
        value.copy<AST::int32>(YY_MOVE(that.value));
        break;

    case symbol_kind::S_Y_ID: // Y_ID
        value.copy<AST::string>(YY_MOVE(that.value));
        break;

    case symbol_kind::S_ConstAS:         // ConstAS
    case symbol_kind::S_ArraySubscripts: // ArraySubscripts
        value.copy<std::shared_ptr<ArraySubscript>>(YY_MOVE(that.value));
        break;

    case symbol_kind::S_Block:      // Block
    case symbol_kind::S_BlockItems: // BlockItems
        value.copy<std::shared_ptr<CompStmt>>(YY_MOVE(that.value));
        break;

    case symbol_kind::S_CompUnit: // CompUnit
        value.copy<std::shared_ptr<CompUnit>>(YY_MOVE(that.value));
        break;

    case symbol_kind::S_ConstDecl: // ConstDecl
    case symbol_kind::S_VarDecl:   // VarDecl
        value.copy<std::shared_ptr<DeclStmt>>(YY_MOVE(that.value));
        break;

    case symbol_kind::S_ConstExp:   // ConstExp
    case symbol_kind::S_Exp:        // Exp
    case symbol_kind::S_LVal:       // LVal
    case symbol_kind::S_PrimaryExp: // PrimaryExp
    case symbol_kind::S_Number:     // Number
    case symbol_kind::S_UnaryExp:   // UnaryExp
    case symbol_kind::S_MulExp:     // MulExp
    case symbol_kind::S_AddExp:     // AddExp
    case symbol_kind::S_RelExp:     // RelExp
    case symbol_kind::S_EqExp:      // EqExp
    case symbol_kind::S_LAndExp:    // LAndExp
    case symbol_kind::S_LOrExp:     // LOrExp
        value.copy<std::shared_ptr<Exp>>(YY_MOVE(that.value));
        break;

    case symbol_kind::S_FuncDef: // FuncDef
        value.copy<std::shared_ptr<FuncDef>>(YY_MOVE(that.value));
        break;

    case symbol_kind::S_FuncFParams: // FuncFParams
    case symbol_kind::S_FuncFParam:  // FuncFParam
        value.copy<std::shared_ptr<FuncFParam>>(YY_MOVE(that.value));
        break;

    case symbol_kind::S_FuncRParams: // FuncRParams
        value.copy<std::shared_ptr<FuncRParam>>(YY_MOVE(that.value));
        break;

    case symbol_kind::S_ConstInitVal:  // ConstInitVal
    case symbol_kind::S_ConstInitVals: // ConstInitVals
    case symbol_kind::S_InitVal:       // InitVal
    case symbol_kind::S_InitVals:      // InitVals
        value.copy<std::shared_ptr<InitVal>>(YY_MOVE(that.value));
        break;

    case symbol_kind::S_Decl:      // Decl
    case symbol_kind::S_BlockItem: // BlockItem
    case symbol_kind::S_Stmt:      // Stmt
        value.copy<std::shared_ptr<Stmt>>(YY_MOVE(that.value));
        break;

    case symbol_kind::S_ConstDefs: // ConstDefs
    case symbol_kind::S_ConstDef:  // ConstDef
    case symbol_kind::S_VarDefs:   // VarDefs
    case symbol_kind::S_VarDef:    // VarDef
        value.copy<std::shared_ptr<VarDef>>(YY_MOVE(that.value));
        break;

    default:
        break;
    }
}

template <typename Base> parser::symbol_kind_type parser::basic_symbol<Base>::type_get() const YY_NOEXCEPT {
    return this->kind();
}

template <typename Base> bool parser::basic_symbol<Base>::empty() const YY_NOEXCEPT {
    return this->kind() == symbol_kind::S_YYEMPTY;
}

template <typename Base> void parser::basic_symbol<Base>::move(basic_symbol &s) {
    super_type::move(s);
    switch (this->kind()) {
    case symbol_kind::S_Type: // Type
        value.move<AST::dtype>(YY_MOVE(s.value));
        break;

    case symbol_kind::S_num_FLOAT: // num_FLOAT
        value.move<AST::float32>(YY_MOVE(s.value));
        break;

    case symbol_kind::S_num_INT: // num_INT
        value.move<AST::int32>(YY_MOVE(s.value));
        break;

    case symbol_kind::S_Y_ID: // Y_ID
        value.move<AST::string>(YY_MOVE(s.value));
        break;

    case symbol_kind::S_ConstAS:         // ConstAS
    case symbol_kind::S_ArraySubscripts: // ArraySubscripts
        value.move<std::shared_ptr<ArraySubscript>>(YY_MOVE(s.value));
        break;

    case symbol_kind::S_Block:      // Block
    case symbol_kind::S_BlockItems: // BlockItems
        value.move<std::shared_ptr<CompStmt>>(YY_MOVE(s.value));
        break;

    case symbol_kind::S_CompUnit: // CompUnit
        value.move<std::shared_ptr<CompUnit>>(YY_MOVE(s.value));
        break;

    case symbol_kind::S_ConstDecl: // ConstDecl
    case symbol_kind::S_VarDecl:   // VarDecl
        value.move<std::shared_ptr<DeclStmt>>(YY_MOVE(s.value));
        break;

    case symbol_kind::S_ConstExp:   // ConstExp
    case symbol_kind::S_Exp:        // Exp
    case symbol_kind::S_LVal:       // LVal
    case symbol_kind::S_PrimaryExp: // PrimaryExp
    case symbol_kind::S_Number:     // Number
    case symbol_kind::S_UnaryExp:   // UnaryExp
    case symbol_kind::S_MulExp:     // MulExp
    case symbol_kind::S_AddExp:     // AddExp
    case symbol_kind::S_RelExp:     // RelExp
    case symbol_kind::S_EqExp:      // EqExp
    case symbol_kind::S_LAndExp:    // LAndExp
    case symbol_kind::S_LOrExp:     // LOrExp
        value.move<std::shared_ptr<Exp>>(YY_MOVE(s.value));
        break;

    case symbol_kind::S_FuncDef: // FuncDef
        value.move<std::shared_ptr<FuncDef>>(YY_MOVE(s.value));
        break;

    case symbol_kind::S_FuncFParams: // FuncFParams
    case symbol_kind::S_FuncFParam:  // FuncFParam
        value.move<std::shared_ptr<FuncFParam>>(YY_MOVE(s.value));
        break;

    case symbol_kind::S_FuncRParams: // FuncRParams
        value.move<std::shared_ptr<FuncRParam>>(YY_MOVE(s.value));
        break;

    case symbol_kind::S_ConstInitVal:  // ConstInitVal
    case symbol_kind::S_ConstInitVals: // ConstInitVals
    case symbol_kind::S_InitVal:       // InitVal
    case symbol_kind::S_InitVals:      // InitVals
        value.move<std::shared_ptr<InitVal>>(YY_MOVE(s.value));
        break;

    case symbol_kind::S_Decl:      // Decl
    case symbol_kind::S_BlockItem: // BlockItem
    case symbol_kind::S_Stmt:      // Stmt
        value.move<std::shared_ptr<Stmt>>(YY_MOVE(s.value));
        break;

    case symbol_kind::S_ConstDefs: // ConstDefs
    case symbol_kind::S_ConstDef:  // ConstDef
    case symbol_kind::S_VarDefs:   // VarDefs
    case symbol_kind::S_VarDef:    // VarDef
        value.move<std::shared_ptr<VarDef>>(YY_MOVE(s.value));
        break;

    default:
        break;
    }
}

// by_kind.
inline parser::by_kind::by_kind() YY_NOEXCEPT : kind_(symbol_kind::S_YYEMPTY) {}

#if 201103L <= YY_CPLUSPLUS
inline parser::by_kind::by_kind(by_kind &&that) YY_NOEXCEPT : kind_(that.kind_) { that.clear(); }
#endif

inline parser::by_kind::by_kind(const by_kind &that) YY_NOEXCEPT : kind_(that.kind_) {}

inline parser::by_kind::by_kind(token_kind_type t) YY_NOEXCEPT : kind_(yytranslate_(t)) {}

inline void parser::by_kind::clear() YY_NOEXCEPT { kind_ = symbol_kind::S_YYEMPTY; }

inline void parser::by_kind::move(by_kind &that) {
    kind_ = that.kind_;
    that.clear();
}

inline parser::symbol_kind_type parser::by_kind::kind() const YY_NOEXCEPT { return kind_; }

inline parser::symbol_kind_type parser::by_kind::type_get() const YY_NOEXCEPT { return this->kind(); }

} // namespace yy
#line 2443 "include/parser/parser.hpp"

#endif // !YY_YY_INCLUDE_PARSER_PARSER_HPP_INCLUDED
