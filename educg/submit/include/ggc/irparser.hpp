// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_GGC
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
 ** \file ../../include/ggc/irparser.hpp
 ** Define the yyy::parser class.
 */

// C++ LALR(1) parser skeleton written by Akim Demaille.

// DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
// especially those whose name start with YY_ or yy_.  They are
// private implementation details that can be changed or removed.

#ifndef YY_YY_INCLUDE_GGC_IRPARSER_HPP_INCLUDED
# define YY_YY_INCLUDE_GGC_IRPARSER_HPP_INCLUDED
// "%code requires" blocks.
#line 11 "irparser.y"

#include "irparsertool.hpp"

#line 53 "../../include/ggc/irparser.hpp"

# include <cassert>
# include <cstdlib> // std::abort
# include <iostream>
# include <stdexcept>
# include <string>
# include <vector>

#if defined __cplusplus
# define YY_CPLUSPLUS __cplusplus
#else
# define YY_CPLUSPLUS 199711L
#endif

// Support move semantics when possible.
#if 201103L <= YY_CPLUSPLUS
# define YY_MOVE           std::move
# define YY_MOVE_OR_COPY   move
# define YY_MOVE_REF(Type) Type&&
# define YY_RVREF(Type)    Type&&
# define YY_COPY(Type)     Type
#else
# define YY_MOVE
# define YY_MOVE_OR_COPY   copy
# define YY_MOVE_REF(Type) Type&
# define YY_RVREF(Type)    const Type&
# define YY_COPY(Type)     const Type&
#endif

// Support noexcept when possible.
#if 201103L <= YY_CPLUSPLUS
# define YY_NOEXCEPT noexcept
# define YY_NOTHROW
#else
# define YY_NOEXCEPT
# define YY_NOTHROW throw ()
#endif

// Support constexpr when possible.
#if 201703 <= YY_CPLUSPLUS
# define YY_CONSTEXPR constexpr
#else
# define YY_CONSTEXPR
#endif

#include <typeinfo>
#ifndef YY_ASSERT
# include <cassert>
# define YY_ASSERT assert
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

#line 22 "irparser.y"
namespace yyy {
#line 194 "../../include/ggc/irparser.hpp"




  /// A Bison parser.
  class parser
  {
  public:
#ifdef YYSTYPE
# ifdef __GNUC__
#  pragma GCC message "bison: do not #define YYSTYPE in C++, use %define api.value.type"
# endif
    typedef YYSTYPE value_type;
#else
  /// A buffer to store and retrieve objects.
  ///
  /// Sort of a variant, but does not keep track of the nature
  /// of the stored data, since that knowledge is available
  /// via the current parser state.
  class value_type
  {
  public:
    /// Type of *this.
    typedef value_type self_type;

    /// Empty construction.
    value_type () YY_NOEXCEPT
      : yyraw_ ()
      , yytypeid_ (YY_NULLPTR)
    {}

    /// Construct and fill.
    template <typename T>
    value_type (YY_RVREF (T) t)
      : yytypeid_ (&typeid (T))
    {
      YY_ASSERT (sizeof (T) <= size);
      new (yyas_<T> ()) T (YY_MOVE (t));
    }

#if 201103L <= YY_CPLUSPLUS
    /// Non copyable.
    value_type (const self_type&) = delete;
    /// Non copyable.
    self_type& operator= (const self_type&) = delete;
#endif

    /// Destruction, allowed only if empty.
    ~value_type () YY_NOEXCEPT
    {
      YY_ASSERT (!yytypeid_);
    }

# if 201103L <= YY_CPLUSPLUS
    /// Instantiate a \a T in here from \a t.
    template <typename T, typename... U>
    T&
    emplace (U&&... u)
    {
      YY_ASSERT (!yytypeid_);
      YY_ASSERT (sizeof (T) <= size);
      yytypeid_ = & typeid (T);
      return *new (yyas_<T> ()) T (std::forward <U>(u)...);
    }
# else
    /// Instantiate an empty \a T in here.
    template <typename T>
    T&
    emplace ()
    {
      YY_ASSERT (!yytypeid_);
      YY_ASSERT (sizeof (T) <= size);
      yytypeid_ = & typeid (T);
      return *new (yyas_<T> ()) T ();
    }

    /// Instantiate a \a T in here from \a t.
    template <typename T>
    T&
    emplace (const T& t)
    {
      YY_ASSERT (!yytypeid_);
      YY_ASSERT (sizeof (T) <= size);
      yytypeid_ = & typeid (T);
      return *new (yyas_<T> ()) T (t);
    }
# endif

    /// Instantiate an empty \a T in here.
    /// Obsolete, use emplace.
    template <typename T>
    T&
    build ()
    {
      return emplace<T> ();
    }

    /// Instantiate a \a T in here from \a t.
    /// Obsolete, use emplace.
    template <typename T>
    T&
    build (const T& t)
    {
      return emplace<T> (t);
    }

    /// Accessor to a built \a T.
    template <typename T>
    T&
    as () YY_NOEXCEPT
    {
      YY_ASSERT (yytypeid_);
      YY_ASSERT (*yytypeid_ == typeid (T));
      YY_ASSERT (sizeof (T) <= size);
      return *yyas_<T> ();
    }

    /// Const accessor to a built \a T (for %printer).
    template <typename T>
    const T&
    as () const YY_NOEXCEPT
    {
      YY_ASSERT (yytypeid_);
      YY_ASSERT (*yytypeid_ == typeid (T));
      YY_ASSERT (sizeof (T) <= size);
      return *yyas_<T> ();
    }

    /// Swap the content with \a that, of same type.
    ///
    /// Both variants must be built beforehand, because swapping the actual
    /// data requires reading it (with as()), and this is not possible on
    /// unconstructed variants: it would require some dynamic testing, which
    /// should not be the variant's responsibility.
    /// Swapping between built and (possibly) non-built is done with
    /// self_type::move ().
    template <typename T>
    void
    swap (self_type& that) YY_NOEXCEPT
    {
      YY_ASSERT (yytypeid_);
      YY_ASSERT (*yytypeid_ == *that.yytypeid_);
      std::swap (as<T> (), that.as<T> ());
    }

    /// Move the content of \a that to this.
    ///
    /// Destroys \a that.
    template <typename T>
    void
    move (self_type& that)
    {
# if 201103L <= YY_CPLUSPLUS
      emplace<T> (std::move (that.as<T> ()));
# else
      emplace<T> ();
      swap<T> (that);
# endif
      that.destroy<T> ();
    }

# if 201103L <= YY_CPLUSPLUS
    /// Move the content of \a that to this.
    template <typename T>
    void
    move (self_type&& that)
    {
      emplace<T> (std::move (that.as<T> ()));
      that.destroy<T> ();
    }
#endif

    /// Copy the content of \a that to this.
    template <typename T>
    void
    copy (const self_type& that)
    {
      emplace<T> (that.as<T> ());
    }

    /// Destroy the stored \a T.
    template <typename T>
    void
    destroy ()
    {
      as<T> ().~T ();
      yytypeid_ = YY_NULLPTR;
    }

  private:
#if YY_CPLUSPLUS < 201103L
    /// Non copyable.
    value_type (const self_type&);
    /// Non copyable.
    self_type& operator= (const self_type&);
#endif

    /// Accessor to raw memory as \a T.
    template <typename T>
    T*
    yyas_ () YY_NOEXCEPT
    {
      void *yyp = yyraw_;
      return static_cast<T*> (yyp);
     }

    /// Const accessor to raw memory as \a T.
    template <typename T>
    const T*
    yyas_ () const YY_NOEXCEPT
    {
      const void *yyp = yyraw_;
      return static_cast<const T*> (yyp);
     }

    /// An auxiliary type to compute the largest semantic type.
    union union_type
    {
      // FcmpOp
      char dummy1[sizeof (FCMPOP)];

      // GVIniter
      char dummy2[sizeof (GVIniter)];

      // IcmpOp
      char dummy3[sizeof (ICMPOP)];

      // BinaryOp
      char dummy4[sizeof (OP)];

      // Storage
      char dummy5[sizeof (STOCLASS)];

      // IRNUM_FLOAT
      char dummy6[sizeof (float)];

      // IRNUM_INT
      char dummy7[sizeof (int)];

      // BB
      char dummy8[sizeof (pBlock)];

      // DefParam
      char dummy9[sizeof (pFormalParam)];

      // FunctionDefinition
      char dummy10[sizeof (pFunc)];

      // FunctionDeclaration
      char dummy11[sizeof (pFuncDecl)];

      // GlobalVariable
      char dummy12[sizeof (pGlobalVar)];

      // Inst
      // BinaryInst
      // FnegInst
      // CastInst
      // IcmpInst
      // FcmpInst
      // RetInst
      // BrInst
      // CallInst
      // AllocaInst
      // LoadInst
      // StoreInst
      // GepInst
      // PhiInst
      char dummy13[sizeof (pInst)];

      // Type
      // BType
      // PtrType
      // ArrayType
      // DeclParam
      // RETType
      char dummy14[sizeof (pType)];

      // Constant
      // TypeValue
      // Value
      // Arg
      char dummy15[sizeof (pVal)];

      // InstList
      char dummy16[sizeof (std::list<pInst>)];

      // PhiOper
      char dummy17[sizeof (std::pair<pVal, pBlock>)];

      // I_ID
      // I_BLKID
      char dummy18[sizeof (std::string)];

      // GVIniters
      char dummy19[sizeof (std::vector<GVIniter>)];

      // BBList
      char dummy20[sizeof (std::vector<pBlock>)];

      // DefParamList
      char dummy21[sizeof (std::vector<pFormalParam>)];

      // DeclParamList
      char dummy22[sizeof (std::vector<pType>)];

      // ArgList
      // IndexList
      char dummy23[sizeof (std::vector<pVal>)];

      // PhiOpers
      char dummy24[sizeof (std::vector<std::pair<pVal, pBlock>>)];
    };

    /// The size of the largest semantic type.
    enum { size = sizeof (union_type) };

    /// A buffer to store semantic values.
    union
    {
      /// Strongest alignment constraints.
      long double yyalign_me_;
      /// A buffer large enough to store any of the semantic values.
      char yyraw_[size];
    };

    /// Whether the content is built: if defined, the name of the stored type.
    const std::type_info *yytypeid_;
  };

#endif
    /// Backward compatibility (Bison 3.8).
    typedef value_type semantic_type;


    /// Syntax errors thrown from user actions.
    struct syntax_error : std::runtime_error
    {
      syntax_error (const std::string& m)
        : std::runtime_error (m)
      {}

      syntax_error (const syntax_error& s)
        : std::runtime_error (s.what ())
      {}

      ~syntax_error () YY_NOEXCEPT YY_NOTHROW;
    };

    /// Token kinds.
    struct token
    {
      enum token_kind_type
      {
        YYEMPTY = -2,
    YYEOF = 0,                     // "end of file"
    YYerror = 1,                   // error
    YYUNDEF = 2,                   // "invalid token"
    I_RET = 3,                     // I_RET
    I_BR = 4,                      // I_BR
    I_FNEG = 5,                    // I_FNEG
    I_ADD = 6,                     // I_ADD
    I_FADD = 7,                    // I_FADD
    I_SUB = 8,                     // I_SUB
    I_FSUB = 9,                    // I_FSUB
    I_MUL = 10,                    // I_MUL
    I_FMUL = 11,                   // I_FMUL
    I_DIV = 12,                    // I_DIV
    I_FDIV = 13,                   // I_FDIV
    I_REM = 14,                    // I_REM
    I_FREM = 15,                   // I_FREM
    I_AND = 16,                    // I_AND
    I_OR = 17,                     // I_OR
    I_ALLOCA = 18,                 // I_ALLOCA
    I_LOAD = 19,                   // I_LOAD
    I_STORE = 20,                  // I_STORE
    I_GEP = 21,                    // I_GEP
    I_FPTOSI = 22,                 // I_FPTOSI
    I_SITOFP = 23,                 // I_SITOFP
    I_ZEXT = 24,                   // I_ZEXT
    I_BITCAST = 25,                // I_BITCAST
    I_ICMP = 26,                   // I_ICMP
    I_FCMP = 27,                   // I_FCMP
    I_PHI = 28,                    // I_PHI
    I_CALL = 29,                   // I_CALL
    I_DEFINE = 30,                 // I_DEFINE
    I_DECLARE = 31,                // I_DECLARE
    I_DSO_LOCAL = 32,              // I_DSO_LOCAL
    I_GLOBAL = 33,                 // I_GLOBAL
    I_CONSTANT = 34,               // I_CONSTANT
    I_ALIGN = 35,                  // I_ALIGN
    I_NOUNDEF = 36,                // I_NOUNDEF
    I_LABEL = 37,                  // I_LABEL
    I_TAIL = 38,                   // I_TAIL
    I_TO = 39,                     // I_TO
    I_EQ = 40,                     // I_EQ
    I_NE = 41,                     // I_NE
    I_SGT = 42,                    // I_SGT
    I_SGE = 43,                    // I_SGE
    I_SLT = 44,                    // I_SLT
    I_SLE = 45,                    // I_SLE
    I_OEQ = 46,                    // I_OEQ
    I_OGT = 47,                    // I_OGT
    I_OGE = 48,                    // I_OGE
    I_OLT = 49,                    // I_OLT
    I_OLE = 50,                    // I_OLE
    I_ONE = 51,                    // I_ONE
    I_ORD = 52,                    // I_ORD
    I_I1 = 53,                     // I_I1
    I_I8 = 54,                     // I_I8
    I_I32 = 55,                    // I_I32
    I_FLOAT = 56,                  // I_FLOAT
    I_VOID = 57,                   // I_VOID
    I_STAR = 58,                   // I_STAR
    I_X = 59,                      // I_X
    I_ZEROINITER = 60,             // I_ZEROINITER
    I_DOTDOTDOT = 61,              // I_DOTDOTDOT
    I_LPAR = 62,                   // I_LPAR
    I_RPAR = 63,                   // I_RPAR
    I_LBRACKET = 64,               // I_LBRACKET
    I_RBRACKET = 65,               // I_RBRACKET
    I_LSQUARE = 66,                // I_LSQUARE
    I_RSQUARE = 67,                // I_RSQUARE
    I_COMMA = 68,                  // I_COMMA
    I_EQUAL = 69,                  // I_EQUAL
    I_ID = 70,                     // I_ID
    I_BLKID = 71,                  // I_BLKID
    IRNUM_INT = 72,                // IRNUM_INT
    IRNUM_FLOAT = 73               // IRNUM_FLOAT
      };
      /// Backward compatibility alias (Bison 3.6).
      typedef token_kind_type yytokentype;
    };

    /// Token kind, as returned by yylex.
    typedef token::token_kind_type token_kind_type;

    /// Backward compatibility alias (Bison 3.6).
    typedef token_kind_type token_type;

    /// Symbol kinds.
    struct symbol_kind
    {
      enum symbol_kind_type
      {
        YYNTOKENS = 74, ///< Number of tokens.
        S_YYEMPTY = -2,
        S_YYEOF = 0,                             // "end of file"
        S_YYerror = 1,                           // error
        S_YYUNDEF = 2,                           // "invalid token"
        S_I_RET = 3,                             // I_RET
        S_I_BR = 4,                              // I_BR
        S_I_FNEG = 5,                            // I_FNEG
        S_I_ADD = 6,                             // I_ADD
        S_I_FADD = 7,                            // I_FADD
        S_I_SUB = 8,                             // I_SUB
        S_I_FSUB = 9,                            // I_FSUB
        S_I_MUL = 10,                            // I_MUL
        S_I_FMUL = 11,                           // I_FMUL
        S_I_DIV = 12,                            // I_DIV
        S_I_FDIV = 13,                           // I_FDIV
        S_I_REM = 14,                            // I_REM
        S_I_FREM = 15,                           // I_FREM
        S_I_AND = 16,                            // I_AND
        S_I_OR = 17,                             // I_OR
        S_I_ALLOCA = 18,                         // I_ALLOCA
        S_I_LOAD = 19,                           // I_LOAD
        S_I_STORE = 20,                          // I_STORE
        S_I_GEP = 21,                            // I_GEP
        S_I_FPTOSI = 22,                         // I_FPTOSI
        S_I_SITOFP = 23,                         // I_SITOFP
        S_I_ZEXT = 24,                           // I_ZEXT
        S_I_BITCAST = 25,                        // I_BITCAST
        S_I_ICMP = 26,                           // I_ICMP
        S_I_FCMP = 27,                           // I_FCMP
        S_I_PHI = 28,                            // I_PHI
        S_I_CALL = 29,                           // I_CALL
        S_I_DEFINE = 30,                         // I_DEFINE
        S_I_DECLARE = 31,                        // I_DECLARE
        S_I_DSO_LOCAL = 32,                      // I_DSO_LOCAL
        S_I_GLOBAL = 33,                         // I_GLOBAL
        S_I_CONSTANT = 34,                       // I_CONSTANT
        S_I_ALIGN = 35,                          // I_ALIGN
        S_I_NOUNDEF = 36,                        // I_NOUNDEF
        S_I_LABEL = 37,                          // I_LABEL
        S_I_TAIL = 38,                           // I_TAIL
        S_I_TO = 39,                             // I_TO
        S_I_EQ = 40,                             // I_EQ
        S_I_NE = 41,                             // I_NE
        S_I_SGT = 42,                            // I_SGT
        S_I_SGE = 43,                            // I_SGE
        S_I_SLT = 44,                            // I_SLT
        S_I_SLE = 45,                            // I_SLE
        S_I_OEQ = 46,                            // I_OEQ
        S_I_OGT = 47,                            // I_OGT
        S_I_OGE = 48,                            // I_OGE
        S_I_OLT = 49,                            // I_OLT
        S_I_OLE = 50,                            // I_OLE
        S_I_ONE = 51,                            // I_ONE
        S_I_ORD = 52,                            // I_ORD
        S_I_I1 = 53,                             // I_I1
        S_I_I8 = 54,                             // I_I8
        S_I_I32 = 55,                            // I_I32
        S_I_FLOAT = 56,                          // I_FLOAT
        S_I_VOID = 57,                           // I_VOID
        S_I_STAR = 58,                           // I_STAR
        S_I_X = 59,                              // I_X
        S_I_ZEROINITER = 60,                     // I_ZEROINITER
        S_I_DOTDOTDOT = 61,                      // I_DOTDOTDOT
        S_I_LPAR = 62,                           // I_LPAR
        S_I_RPAR = 63,                           // I_RPAR
        S_I_LBRACKET = 64,                       // I_LBRACKET
        S_I_RBRACKET = 65,                       // I_RBRACKET
        S_I_LSQUARE = 66,                        // I_LSQUARE
        S_I_RSQUARE = 67,                        // I_RSQUARE
        S_I_COMMA = 68,                          // I_COMMA
        S_I_EQUAL = 69,                          // I_EQUAL
        S_I_ID = 70,                             // I_ID
        S_I_BLKID = 71,                          // I_BLKID
        S_IRNUM_INT = 72,                        // IRNUM_INT
        S_IRNUM_FLOAT = 73,                      // IRNUM_FLOAT
        S_YYACCEPT = 74,                         // $accept
        S_Module = 75,                           // Module
        S_GlobalEntities = 76,                   // GlobalEntities
        S_GlobalVariable = 77,                   // GlobalVariable
        S_Storage = 78,                          // Storage
        S_Type = 79,                             // Type
        S_BType = 80,                            // BType
        S_PtrType = 81,                          // PtrType
        S_ArrayType = 82,                        // ArrayType
        S_Constant = 83,                         // Constant
        S_GVIniter = 84,                         // GVIniter
        S_GVIniters = 85,                        // GVIniters
        S_FunctionDeclaration = 86,              // FunctionDeclaration
        S_DeclParamList = 87,                    // DeclParamList
        S_DeclParam = 88,                        // DeclParam
        S_DefParamList = 89,                     // DefParamList
        S_DefParam = 90,                         // DefParam
        S_FunctionDefinition = 91,               // FunctionDefinition
        S_BBList = 92,                           // BBList
        S_BB = 93,                               // BB
        S_InstList = 94,                         // InstList
        S_Inst = 95,                             // Inst
        S_BinaryInst = 96,                       // BinaryInst
        S_TypeValue = 97,                        // TypeValue
        S_Value = 98,                            // Value
        S_BinaryOp = 99,                         // BinaryOp
        S_FnegInst = 100,                        // FnegInst
        S_CastInst = 101,                        // CastInst
        S_IcmpInst = 102,                        // IcmpInst
        S_IcmpOp = 103,                          // IcmpOp
        S_FcmpInst = 104,                        // FcmpInst
        S_FcmpOp = 105,                          // FcmpOp
        S_RetInst = 106,                         // RetInst
        S_RETType = 107,                         // RETType
        S_BrInst = 108,                          // BrInst
        S_CallInst = 109,                        // CallInst
        S_ArgList = 110,                         // ArgList
        S_Arg = 111,                             // Arg
        S_AllocaInst = 112,                      // AllocaInst
        S_LoadInst = 113,                        // LoadInst
        S_StoreInst = 114,                       // StoreInst
        S_GepInst = 115,                         // GepInst
        S_IndexList = 116,                       // IndexList
        S_PhiInst = 117,                         // PhiInst
        S_PhiOpers = 118,                        // PhiOpers
        S_PhiOper = 119                          // PhiOper
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
    template <typename Base>
    struct basic_symbol : Base
    {
      /// Alias to Base.
      typedef Base super_type;

      /// Default constructor.
      basic_symbol () YY_NOEXCEPT
        : value ()
      {}

#if 201103L <= YY_CPLUSPLUS
      /// Move constructor.
      basic_symbol (basic_symbol&& that)
        : Base (std::move (that))
        , value ()
      {
        switch (this->kind ())
    {
      case symbol_kind::S_FcmpOp: // FcmpOp
        value.move< FCMPOP > (std::move (that.value));
        break;

      case symbol_kind::S_GVIniter: // GVIniter
        value.move< GVIniter > (std::move (that.value));
        break;

      case symbol_kind::S_IcmpOp: // IcmpOp
        value.move< ICMPOP > (std::move (that.value));
        break;

      case symbol_kind::S_BinaryOp: // BinaryOp
        value.move< OP > (std::move (that.value));
        break;

      case symbol_kind::S_Storage: // Storage
        value.move< STOCLASS > (std::move (that.value));
        break;

      case symbol_kind::S_IRNUM_FLOAT: // IRNUM_FLOAT
        value.move< float > (std::move (that.value));
        break;

      case symbol_kind::S_IRNUM_INT: // IRNUM_INT
        value.move< int > (std::move (that.value));
        break;

      case symbol_kind::S_BB: // BB
        value.move< pBlock > (std::move (that.value));
        break;

      case symbol_kind::S_DefParam: // DefParam
        value.move< pFormalParam > (std::move (that.value));
        break;

      case symbol_kind::S_FunctionDefinition: // FunctionDefinition
        value.move< pFunc > (std::move (that.value));
        break;

      case symbol_kind::S_FunctionDeclaration: // FunctionDeclaration
        value.move< pFuncDecl > (std::move (that.value));
        break;

      case symbol_kind::S_GlobalVariable: // GlobalVariable
        value.move< pGlobalVar > (std::move (that.value));
        break;

      case symbol_kind::S_Inst: // Inst
      case symbol_kind::S_BinaryInst: // BinaryInst
      case symbol_kind::S_FnegInst: // FnegInst
      case symbol_kind::S_CastInst: // CastInst
      case symbol_kind::S_IcmpInst: // IcmpInst
      case symbol_kind::S_FcmpInst: // FcmpInst
      case symbol_kind::S_RetInst: // RetInst
      case symbol_kind::S_BrInst: // BrInst
      case symbol_kind::S_CallInst: // CallInst
      case symbol_kind::S_AllocaInst: // AllocaInst
      case symbol_kind::S_LoadInst: // LoadInst
      case symbol_kind::S_StoreInst: // StoreInst
      case symbol_kind::S_GepInst: // GepInst
      case symbol_kind::S_PhiInst: // PhiInst
        value.move< pInst > (std::move (that.value));
        break;

      case symbol_kind::S_Type: // Type
      case symbol_kind::S_BType: // BType
      case symbol_kind::S_PtrType: // PtrType
      case symbol_kind::S_ArrayType: // ArrayType
      case symbol_kind::S_DeclParam: // DeclParam
      case symbol_kind::S_RETType: // RETType
        value.move< pType > (std::move (that.value));
        break;

      case symbol_kind::S_Constant: // Constant
      case symbol_kind::S_TypeValue: // TypeValue
      case symbol_kind::S_Value: // Value
      case symbol_kind::S_Arg: // Arg
        value.move< pVal > (std::move (that.value));
        break;

      case symbol_kind::S_InstList: // InstList
        value.move< std::list<pInst> > (std::move (that.value));
        break;

      case symbol_kind::S_PhiOper: // PhiOper
        value.move< std::pair<pVal, pBlock> > (std::move (that.value));
        break;

      case symbol_kind::S_I_ID: // I_ID
      case symbol_kind::S_I_BLKID: // I_BLKID
        value.move< std::string > (std::move (that.value));
        break;

      case symbol_kind::S_GVIniters: // GVIniters
        value.move< std::vector<GVIniter> > (std::move (that.value));
        break;

      case symbol_kind::S_BBList: // BBList
        value.move< std::vector<pBlock> > (std::move (that.value));
        break;

      case symbol_kind::S_DefParamList: // DefParamList
        value.move< std::vector<pFormalParam> > (std::move (that.value));
        break;

      case symbol_kind::S_DeclParamList: // DeclParamList
        value.move< std::vector<pType> > (std::move (that.value));
        break;

      case symbol_kind::S_ArgList: // ArgList
      case symbol_kind::S_IndexList: // IndexList
        value.move< std::vector<pVal> > (std::move (that.value));
        break;

      case symbol_kind::S_PhiOpers: // PhiOpers
        value.move< std::vector<std::pair<pVal, pBlock>> > (std::move (that.value));
        break;

      default:
        break;
    }

      }
#endif

      /// Copy constructor.
      basic_symbol (const basic_symbol& that);

      /// Constructors for typed symbols.
#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t)
        : Base (t)
      {}
#else
      basic_symbol (typename Base::kind_type t)
        : Base (t)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, FCMPOP&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const FCMPOP& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, GVIniter&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const GVIniter& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, ICMPOP&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const ICMPOP& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, OP&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const OP& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, STOCLASS&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const STOCLASS& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, float&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const float& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, int&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const int& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, pBlock&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const pBlock& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, pFormalParam&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const pFormalParam& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, pFunc&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const pFunc& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, pFuncDecl&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const pFuncDecl& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, pGlobalVar&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const pGlobalVar& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, pInst&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const pInst& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, pType&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const pType& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, pVal&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const pVal& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, std::list<pInst>&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const std::list<pInst>& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, std::pair<pVal, pBlock>&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const std::pair<pVal, pBlock>& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, std::string&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const std::string& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, std::vector<GVIniter>&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const std::vector<GVIniter>& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, std::vector<pBlock>&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const std::vector<pBlock>& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, std::vector<pFormalParam>&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const std::vector<pFormalParam>& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, std::vector<pType>&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const std::vector<pType>& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, std::vector<pVal>&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const std::vector<pVal>& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, std::vector<std::pair<pVal, pBlock>>&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const std::vector<std::pair<pVal, pBlock>>& v)
        : Base (t)
        , value (v)
      {}
#endif

      /// Destroy the symbol.
      ~basic_symbol ()
      {
        clear ();
      }



      /// Destroy contents, and record that is empty.
      void clear () YY_NOEXCEPT
      {
        // User destructor.
        symbol_kind_type yykind = this->kind ();
        basic_symbol<Base>& yysym = *this;
        (void) yysym;
        switch (yykind)
        {
       default:
          break;
        }

        // Value type destructor.
switch (yykind)
    {
      case symbol_kind::S_FcmpOp: // FcmpOp
        value.template destroy< FCMPOP > ();
        break;

      case symbol_kind::S_GVIniter: // GVIniter
        value.template destroy< GVIniter > ();
        break;

      case symbol_kind::S_IcmpOp: // IcmpOp
        value.template destroy< ICMPOP > ();
        break;

      case symbol_kind::S_BinaryOp: // BinaryOp
        value.template destroy< OP > ();
        break;

      case symbol_kind::S_Storage: // Storage
        value.template destroy< STOCLASS > ();
        break;

      case symbol_kind::S_IRNUM_FLOAT: // IRNUM_FLOAT
        value.template destroy< float > ();
        break;

      case symbol_kind::S_IRNUM_INT: // IRNUM_INT
        value.template destroy< int > ();
        break;

      case symbol_kind::S_BB: // BB
        value.template destroy< pBlock > ();
        break;

      case symbol_kind::S_DefParam: // DefParam
        value.template destroy< pFormalParam > ();
        break;

      case symbol_kind::S_FunctionDefinition: // FunctionDefinition
        value.template destroy< pFunc > ();
        break;

      case symbol_kind::S_FunctionDeclaration: // FunctionDeclaration
        value.template destroy< pFuncDecl > ();
        break;

      case symbol_kind::S_GlobalVariable: // GlobalVariable
        value.template destroy< pGlobalVar > ();
        break;

      case symbol_kind::S_Inst: // Inst
      case symbol_kind::S_BinaryInst: // BinaryInst
      case symbol_kind::S_FnegInst: // FnegInst
      case symbol_kind::S_CastInst: // CastInst
      case symbol_kind::S_IcmpInst: // IcmpInst
      case symbol_kind::S_FcmpInst: // FcmpInst
      case symbol_kind::S_RetInst: // RetInst
      case symbol_kind::S_BrInst: // BrInst
      case symbol_kind::S_CallInst: // CallInst
      case symbol_kind::S_AllocaInst: // AllocaInst
      case symbol_kind::S_LoadInst: // LoadInst
      case symbol_kind::S_StoreInst: // StoreInst
      case symbol_kind::S_GepInst: // GepInst
      case symbol_kind::S_PhiInst: // PhiInst
        value.template destroy< pInst > ();
        break;

      case symbol_kind::S_Type: // Type
      case symbol_kind::S_BType: // BType
      case symbol_kind::S_PtrType: // PtrType
      case symbol_kind::S_ArrayType: // ArrayType
      case symbol_kind::S_DeclParam: // DeclParam
      case symbol_kind::S_RETType: // RETType
        value.template destroy< pType > ();
        break;

      case symbol_kind::S_Constant: // Constant
      case symbol_kind::S_TypeValue: // TypeValue
      case symbol_kind::S_Value: // Value
      case symbol_kind::S_Arg: // Arg
        value.template destroy< pVal > ();
        break;

      case symbol_kind::S_InstList: // InstList
        value.template destroy< std::list<pInst> > ();
        break;

      case symbol_kind::S_PhiOper: // PhiOper
        value.template destroy< std::pair<pVal, pBlock> > ();
        break;

      case symbol_kind::S_I_ID: // I_ID
      case symbol_kind::S_I_BLKID: // I_BLKID
        value.template destroy< std::string > ();
        break;

      case symbol_kind::S_GVIniters: // GVIniters
        value.template destroy< std::vector<GVIniter> > ();
        break;

      case symbol_kind::S_BBList: // BBList
        value.template destroy< std::vector<pBlock> > ();
        break;

      case symbol_kind::S_DefParamList: // DefParamList
        value.template destroy< std::vector<pFormalParam> > ();
        break;

      case symbol_kind::S_DeclParamList: // DeclParamList
        value.template destroy< std::vector<pType> > ();
        break;

      case symbol_kind::S_ArgList: // ArgList
      case symbol_kind::S_IndexList: // IndexList
        value.template destroy< std::vector<pVal> > ();
        break;

      case symbol_kind::S_PhiOpers: // PhiOpers
        value.template destroy< std::vector<std::pair<pVal, pBlock>> > ();
        break;

      default:
        break;
    }

        Base::clear ();
      }

#if YYDEBUG || 0
      /// The user-facing name of this symbol.
      const char *name () const YY_NOEXCEPT
      {
        return parser::symbol_name (this->kind ());
      }
#endif // #if YYDEBUG || 0


      /// Backward compatibility (Bison 3.6).
      symbol_kind_type type_get () const YY_NOEXCEPT;

      /// Whether empty.
      bool empty () const YY_NOEXCEPT;

      /// Destructive move, \a s is emptied into this.
      void move (basic_symbol& s);

      /// The semantic value.
      value_type value;

    private:
#if YY_CPLUSPLUS < 201103L
      /// Assignment operator.
      basic_symbol& operator= (const basic_symbol& that);
#endif
    };

    /// Type access provider for token (enum) based symbols.
    struct by_kind
    {
      /// The symbol kind as needed by the constructor.
      typedef token_kind_type kind_type;

      /// Default constructor.
      by_kind () YY_NOEXCEPT;

#if 201103L <= YY_CPLUSPLUS
      /// Move constructor.
      by_kind (by_kind&& that) YY_NOEXCEPT;
#endif

      /// Copy constructor.
      by_kind (const by_kind& that) YY_NOEXCEPT;

      /// Constructor from (external) token numbers.
      by_kind (kind_type t) YY_NOEXCEPT;



      /// Record that this symbol is empty.
      void clear () YY_NOEXCEPT;

      /// Steal the symbol kind from \a that.
      void move (by_kind& that);

      /// The (internal) type number (corresponding to \a type).
      /// \a empty when empty.
      symbol_kind_type kind () const YY_NOEXCEPT;

      /// Backward compatibility (Bison 3.6).
      symbol_kind_type type_get () const YY_NOEXCEPT;

      /// The symbol kind.
      /// \a S_YYEMPTY when empty.
      symbol_kind_type kind_;
    };

    /// Backward compatibility for a private implementation detail (Bison 3.6).
    typedef by_kind by_type;

    /// "External" symbols: returned by the scanner.
    struct symbol_type : basic_symbol<by_kind>
    {
      /// Superclass.
      typedef basic_symbol<by_kind> super_type;

      /// Empty symbol.
      symbol_type () YY_NOEXCEPT {}

      /// Constructor for valueless symbols, and symbols from each type.
#if 201103L <= YY_CPLUSPLUS
      symbol_type (int tok)
        : super_type (token_kind_type (tok))
#else
      symbol_type (int tok)
        : super_type (token_kind_type (tok))
#endif
      {
#if !defined _MSC_VER || defined __clang__
        YY_ASSERT (tok == token::YYEOF
                   || (token::YYerror <= tok && tok <= token::I_EQUAL));
#endif
      }
#if 201103L <= YY_CPLUSPLUS
      symbol_type (int tok, float v)
        : super_type (token_kind_type (tok), std::move (v))
#else
      symbol_type (int tok, const float& v)
        : super_type (token_kind_type (tok), v)
#endif
      {
#if !defined _MSC_VER || defined __clang__
        YY_ASSERT (tok == token::IRNUM_FLOAT);
#endif
      }
#if 201103L <= YY_CPLUSPLUS
      symbol_type (int tok, int v)
        : super_type (token_kind_type (tok), std::move (v))
#else
      symbol_type (int tok, const int& v)
        : super_type (token_kind_type (tok), v)
#endif
      {
#if !defined _MSC_VER || defined __clang__
        YY_ASSERT (tok == token::IRNUM_INT);
#endif
      }
#if 201103L <= YY_CPLUSPLUS
      symbol_type (int tok, std::string v)
        : super_type (token_kind_type (tok), std::move (v))
#else
      symbol_type (int tok, const std::string& v)
        : super_type (token_kind_type (tok), v)
#endif
      {
#if !defined _MSC_VER || defined __clang__
        YY_ASSERT ((token::I_ID <= tok && tok <= token::I_BLKID));
#endif
      }
    };

    /// Build a parser object.
    parser ();
    virtual ~parser ();

#if 201103L <= YY_CPLUSPLUS
    /// Non copyable.
    parser (const parser&) = delete;
    /// Non copyable.
    parser& operator= (const parser&) = delete;
#endif

    /// Parse.  An alias for parse ().
    /// \returns  0 iff parsing succeeded.
    int operator() ();

    /// Parse.
    /// \returns  0 iff parsing succeeded.
    virtual int parse ();

#if YYDEBUG
    /// The current debugging stream.
    std::ostream& debug_stream () const YY_ATTRIBUTE_PURE;
    /// Set the current debugging stream.
    void set_debug_stream (std::ostream &);

    /// Type for debugging levels.
    typedef int debug_level_type;
    /// The current debugging level.
    debug_level_type debug_level () const YY_ATTRIBUTE_PURE;
    /// Set the current debugging level.
    void set_debug_level (debug_level_type l);
#endif

    /// Report a syntax error.
    /// \param msg    a description of the syntax error.
    virtual void error (const std::string& msg);

    /// Report a syntax error.
    void error (const syntax_error& err);

#if YYDEBUG || 0
    /// The user-facing name of the symbol whose (internal) number is
    /// YYSYMBOL.  No bounds checking.
    static const char *symbol_name (symbol_kind_type yysymbol);
#endif // #if YYDEBUG || 0


    // Implementation of make_symbol for each token kind.
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_YYEOF ()
      {
        return symbol_type (token::YYEOF);
      }
#else
      static
      symbol_type
      make_YYEOF ()
      {
        return symbol_type (token::YYEOF);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_YYerror ()
      {
        return symbol_type (token::YYerror);
      }
#else
      static
      symbol_type
      make_YYerror ()
      {
        return symbol_type (token::YYerror);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_YYUNDEF ()
      {
        return symbol_type (token::YYUNDEF);
      }
#else
      static
      symbol_type
      make_YYUNDEF ()
      {
        return symbol_type (token::YYUNDEF);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_RET ()
      {
        return symbol_type (token::I_RET);
      }
#else
      static
      symbol_type
      make_I_RET ()
      {
        return symbol_type (token::I_RET);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_BR ()
      {
        return symbol_type (token::I_BR);
      }
#else
      static
      symbol_type
      make_I_BR ()
      {
        return symbol_type (token::I_BR);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_FNEG ()
      {
        return symbol_type (token::I_FNEG);
      }
#else
      static
      symbol_type
      make_I_FNEG ()
      {
        return symbol_type (token::I_FNEG);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_ADD ()
      {
        return symbol_type (token::I_ADD);
      }
#else
      static
      symbol_type
      make_I_ADD ()
      {
        return symbol_type (token::I_ADD);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_FADD ()
      {
        return symbol_type (token::I_FADD);
      }
#else
      static
      symbol_type
      make_I_FADD ()
      {
        return symbol_type (token::I_FADD);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_SUB ()
      {
        return symbol_type (token::I_SUB);
      }
#else
      static
      symbol_type
      make_I_SUB ()
      {
        return symbol_type (token::I_SUB);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_FSUB ()
      {
        return symbol_type (token::I_FSUB);
      }
#else
      static
      symbol_type
      make_I_FSUB ()
      {
        return symbol_type (token::I_FSUB);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_MUL ()
      {
        return symbol_type (token::I_MUL);
      }
#else
      static
      symbol_type
      make_I_MUL ()
      {
        return symbol_type (token::I_MUL);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_FMUL ()
      {
        return symbol_type (token::I_FMUL);
      }
#else
      static
      symbol_type
      make_I_FMUL ()
      {
        return symbol_type (token::I_FMUL);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_DIV ()
      {
        return symbol_type (token::I_DIV);
      }
#else
      static
      symbol_type
      make_I_DIV ()
      {
        return symbol_type (token::I_DIV);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_FDIV ()
      {
        return symbol_type (token::I_FDIV);
      }
#else
      static
      symbol_type
      make_I_FDIV ()
      {
        return symbol_type (token::I_FDIV);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_REM ()
      {
        return symbol_type (token::I_REM);
      }
#else
      static
      symbol_type
      make_I_REM ()
      {
        return symbol_type (token::I_REM);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_FREM ()
      {
        return symbol_type (token::I_FREM);
      }
#else
      static
      symbol_type
      make_I_FREM ()
      {
        return symbol_type (token::I_FREM);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_AND ()
      {
        return symbol_type (token::I_AND);
      }
#else
      static
      symbol_type
      make_I_AND ()
      {
        return symbol_type (token::I_AND);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_OR ()
      {
        return symbol_type (token::I_OR);
      }
#else
      static
      symbol_type
      make_I_OR ()
      {
        return symbol_type (token::I_OR);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_ALLOCA ()
      {
        return symbol_type (token::I_ALLOCA);
      }
#else
      static
      symbol_type
      make_I_ALLOCA ()
      {
        return symbol_type (token::I_ALLOCA);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_LOAD ()
      {
        return symbol_type (token::I_LOAD);
      }
#else
      static
      symbol_type
      make_I_LOAD ()
      {
        return symbol_type (token::I_LOAD);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_STORE ()
      {
        return symbol_type (token::I_STORE);
      }
#else
      static
      symbol_type
      make_I_STORE ()
      {
        return symbol_type (token::I_STORE);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_GEP ()
      {
        return symbol_type (token::I_GEP);
      }
#else
      static
      symbol_type
      make_I_GEP ()
      {
        return symbol_type (token::I_GEP);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_FPTOSI ()
      {
        return symbol_type (token::I_FPTOSI);
      }
#else
      static
      symbol_type
      make_I_FPTOSI ()
      {
        return symbol_type (token::I_FPTOSI);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_SITOFP ()
      {
        return symbol_type (token::I_SITOFP);
      }
#else
      static
      symbol_type
      make_I_SITOFP ()
      {
        return symbol_type (token::I_SITOFP);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_ZEXT ()
      {
        return symbol_type (token::I_ZEXT);
      }
#else
      static
      symbol_type
      make_I_ZEXT ()
      {
        return symbol_type (token::I_ZEXT);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_BITCAST ()
      {
        return symbol_type (token::I_BITCAST);
      }
#else
      static
      symbol_type
      make_I_BITCAST ()
      {
        return symbol_type (token::I_BITCAST);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_ICMP ()
      {
        return symbol_type (token::I_ICMP);
      }
#else
      static
      symbol_type
      make_I_ICMP ()
      {
        return symbol_type (token::I_ICMP);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_FCMP ()
      {
        return symbol_type (token::I_FCMP);
      }
#else
      static
      symbol_type
      make_I_FCMP ()
      {
        return symbol_type (token::I_FCMP);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_PHI ()
      {
        return symbol_type (token::I_PHI);
      }
#else
      static
      symbol_type
      make_I_PHI ()
      {
        return symbol_type (token::I_PHI);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_CALL ()
      {
        return symbol_type (token::I_CALL);
      }
#else
      static
      symbol_type
      make_I_CALL ()
      {
        return symbol_type (token::I_CALL);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_DEFINE ()
      {
        return symbol_type (token::I_DEFINE);
      }
#else
      static
      symbol_type
      make_I_DEFINE ()
      {
        return symbol_type (token::I_DEFINE);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_DECLARE ()
      {
        return symbol_type (token::I_DECLARE);
      }
#else
      static
      symbol_type
      make_I_DECLARE ()
      {
        return symbol_type (token::I_DECLARE);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_DSO_LOCAL ()
      {
        return symbol_type (token::I_DSO_LOCAL);
      }
#else
      static
      symbol_type
      make_I_DSO_LOCAL ()
      {
        return symbol_type (token::I_DSO_LOCAL);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_GLOBAL ()
      {
        return symbol_type (token::I_GLOBAL);
      }
#else
      static
      symbol_type
      make_I_GLOBAL ()
      {
        return symbol_type (token::I_GLOBAL);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_CONSTANT ()
      {
        return symbol_type (token::I_CONSTANT);
      }
#else
      static
      symbol_type
      make_I_CONSTANT ()
      {
        return symbol_type (token::I_CONSTANT);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_ALIGN ()
      {
        return symbol_type (token::I_ALIGN);
      }
#else
      static
      symbol_type
      make_I_ALIGN ()
      {
        return symbol_type (token::I_ALIGN);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_NOUNDEF ()
      {
        return symbol_type (token::I_NOUNDEF);
      }
#else
      static
      symbol_type
      make_I_NOUNDEF ()
      {
        return symbol_type (token::I_NOUNDEF);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_LABEL ()
      {
        return symbol_type (token::I_LABEL);
      }
#else
      static
      symbol_type
      make_I_LABEL ()
      {
        return symbol_type (token::I_LABEL);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_TAIL ()
      {
        return symbol_type (token::I_TAIL);
      }
#else
      static
      symbol_type
      make_I_TAIL ()
      {
        return symbol_type (token::I_TAIL);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_TO ()
      {
        return symbol_type (token::I_TO);
      }
#else
      static
      symbol_type
      make_I_TO ()
      {
        return symbol_type (token::I_TO);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_EQ ()
      {
        return symbol_type (token::I_EQ);
      }
#else
      static
      symbol_type
      make_I_EQ ()
      {
        return symbol_type (token::I_EQ);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_NE ()
      {
        return symbol_type (token::I_NE);
      }
#else
      static
      symbol_type
      make_I_NE ()
      {
        return symbol_type (token::I_NE);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_SGT ()
      {
        return symbol_type (token::I_SGT);
      }
#else
      static
      symbol_type
      make_I_SGT ()
      {
        return symbol_type (token::I_SGT);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_SGE ()
      {
        return symbol_type (token::I_SGE);
      }
#else
      static
      symbol_type
      make_I_SGE ()
      {
        return symbol_type (token::I_SGE);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_SLT ()
      {
        return symbol_type (token::I_SLT);
      }
#else
      static
      symbol_type
      make_I_SLT ()
      {
        return symbol_type (token::I_SLT);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_SLE ()
      {
        return symbol_type (token::I_SLE);
      }
#else
      static
      symbol_type
      make_I_SLE ()
      {
        return symbol_type (token::I_SLE);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_OEQ ()
      {
        return symbol_type (token::I_OEQ);
      }
#else
      static
      symbol_type
      make_I_OEQ ()
      {
        return symbol_type (token::I_OEQ);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_OGT ()
      {
        return symbol_type (token::I_OGT);
      }
#else
      static
      symbol_type
      make_I_OGT ()
      {
        return symbol_type (token::I_OGT);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_OGE ()
      {
        return symbol_type (token::I_OGE);
      }
#else
      static
      symbol_type
      make_I_OGE ()
      {
        return symbol_type (token::I_OGE);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_OLT ()
      {
        return symbol_type (token::I_OLT);
      }
#else
      static
      symbol_type
      make_I_OLT ()
      {
        return symbol_type (token::I_OLT);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_OLE ()
      {
        return symbol_type (token::I_OLE);
      }
#else
      static
      symbol_type
      make_I_OLE ()
      {
        return symbol_type (token::I_OLE);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_ONE ()
      {
        return symbol_type (token::I_ONE);
      }
#else
      static
      symbol_type
      make_I_ONE ()
      {
        return symbol_type (token::I_ONE);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_ORD ()
      {
        return symbol_type (token::I_ORD);
      }
#else
      static
      symbol_type
      make_I_ORD ()
      {
        return symbol_type (token::I_ORD);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_I1 ()
      {
        return symbol_type (token::I_I1);
      }
#else
      static
      symbol_type
      make_I_I1 ()
      {
        return symbol_type (token::I_I1);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_I8 ()
      {
        return symbol_type (token::I_I8);
      }
#else
      static
      symbol_type
      make_I_I8 ()
      {
        return symbol_type (token::I_I8);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_I32 ()
      {
        return symbol_type (token::I_I32);
      }
#else
      static
      symbol_type
      make_I_I32 ()
      {
        return symbol_type (token::I_I32);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_FLOAT ()
      {
        return symbol_type (token::I_FLOAT);
      }
#else
      static
      symbol_type
      make_I_FLOAT ()
      {
        return symbol_type (token::I_FLOAT);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_VOID ()
      {
        return symbol_type (token::I_VOID);
      }
#else
      static
      symbol_type
      make_I_VOID ()
      {
        return symbol_type (token::I_VOID);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_STAR ()
      {
        return symbol_type (token::I_STAR);
      }
#else
      static
      symbol_type
      make_I_STAR ()
      {
        return symbol_type (token::I_STAR);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_X ()
      {
        return symbol_type (token::I_X);
      }
#else
      static
      symbol_type
      make_I_X ()
      {
        return symbol_type (token::I_X);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_ZEROINITER ()
      {
        return symbol_type (token::I_ZEROINITER);
      }
#else
      static
      symbol_type
      make_I_ZEROINITER ()
      {
        return symbol_type (token::I_ZEROINITER);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_DOTDOTDOT ()
      {
        return symbol_type (token::I_DOTDOTDOT);
      }
#else
      static
      symbol_type
      make_I_DOTDOTDOT ()
      {
        return symbol_type (token::I_DOTDOTDOT);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_LPAR ()
      {
        return symbol_type (token::I_LPAR);
      }
#else
      static
      symbol_type
      make_I_LPAR ()
      {
        return symbol_type (token::I_LPAR);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_RPAR ()
      {
        return symbol_type (token::I_RPAR);
      }
#else
      static
      symbol_type
      make_I_RPAR ()
      {
        return symbol_type (token::I_RPAR);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_LBRACKET ()
      {
        return symbol_type (token::I_LBRACKET);
      }
#else
      static
      symbol_type
      make_I_LBRACKET ()
      {
        return symbol_type (token::I_LBRACKET);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_RBRACKET ()
      {
        return symbol_type (token::I_RBRACKET);
      }
#else
      static
      symbol_type
      make_I_RBRACKET ()
      {
        return symbol_type (token::I_RBRACKET);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_LSQUARE ()
      {
        return symbol_type (token::I_LSQUARE);
      }
#else
      static
      symbol_type
      make_I_LSQUARE ()
      {
        return symbol_type (token::I_LSQUARE);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_RSQUARE ()
      {
        return symbol_type (token::I_RSQUARE);
      }
#else
      static
      symbol_type
      make_I_RSQUARE ()
      {
        return symbol_type (token::I_RSQUARE);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_COMMA ()
      {
        return symbol_type (token::I_COMMA);
      }
#else
      static
      symbol_type
      make_I_COMMA ()
      {
        return symbol_type (token::I_COMMA);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_EQUAL ()
      {
        return symbol_type (token::I_EQUAL);
      }
#else
      static
      symbol_type
      make_I_EQUAL ()
      {
        return symbol_type (token::I_EQUAL);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_ID (std::string v)
      {
        return symbol_type (token::I_ID, std::move (v));
      }
#else
      static
      symbol_type
      make_I_ID (const std::string& v)
      {
        return symbol_type (token::I_ID, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_I_BLKID (std::string v)
      {
        return symbol_type (token::I_BLKID, std::move (v));
      }
#else
      static
      symbol_type
      make_I_BLKID (const std::string& v)
      {
        return symbol_type (token::I_BLKID, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_IRNUM_INT (int v)
      {
        return symbol_type (token::IRNUM_INT, std::move (v));
      }
#else
      static
      symbol_type
      make_IRNUM_INT (const int& v)
      {
        return symbol_type (token::IRNUM_INT, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_IRNUM_FLOAT (float v)
      {
        return symbol_type (token::IRNUM_FLOAT, std::move (v));
      }
#else
      static
      symbol_type
      make_IRNUM_FLOAT (const float& v)
      {
        return symbol_type (token::IRNUM_FLOAT, v);
      }
#endif


  private:
#if YY_CPLUSPLUS < 201103L
    /// Non copyable.
    parser (const parser&);
    /// Non copyable.
    parser& operator= (const parser&);
#endif


    /// Stored state numbers (used for stacks).
    typedef short state_type;

    /// Compute post-reduction state.
    /// \param yystate   the current state
    /// \param yysym     the nonterminal to push on the stack
    static state_type yy_lr_goto_state_ (state_type yystate, int yysym);

    /// Whether the given \c yypact_ value indicates a defaulted state.
    /// \param yyvalue   the value to check
    static bool yy_pact_value_is_default_ (int yyvalue) YY_NOEXCEPT;

    /// Whether the given \c yytable_ value indicates a syntax error.
    /// \param yyvalue   the value to check
    static bool yy_table_value_is_error_ (int yyvalue) YY_NOEXCEPT;

    static const short yypact_ninf_;
    static const signed char yytable_ninf_;

    /// Convert a scanner token kind \a t to a symbol kind.
    /// In theory \a t should be a token_kind_type, but character literals
    /// are valid, yet not members of the token_kind_type enum.
    static symbol_kind_type yytranslate_ (int t) YY_NOEXCEPT;

#if YYDEBUG || 0
    /// For a symbol, its name in clear.
    static const char* const yytname_[];
#endif // #if YYDEBUG || 0


    // Tables.
    // YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
    // STATE-NUM.
    static const short yypact_[];

    // YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
    // Performed when YYTABLE does not specify something else to do.  Zero
    // means the default is an error.
    static const unsigned char yydefact_[];

    // YYPGOTO[NTERM-NUM].
    static const short yypgoto_[];

    // YYDEFGOTO[NTERM-NUM].
    static const short yydefgoto_[];

    // YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
    // positive, shift that token.  If negative, reduce the rule whose
    // number is the opposite.  If YYTABLE_NINF, syntax error.
    static const short yytable_[];

    static const short yycheck_[];

    // YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
    // state STATE-NUM.
    static const signed char yystos_[];

    // YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.
    static const signed char yyr1_[];

    // YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.
    static const signed char yyr2_[];


#if YYDEBUG
    // YYRLINE[YYN] -- Source line where rule number YYN was defined.
    static const short yyrline_[];
    /// Report on the debug stream that the rule \a r is going to be reduced.
    virtual void yy_reduce_print_ (int r) const;
    /// Print the state stack on the debug stream.
    virtual void yy_stack_print_ () const;

    /// Debugging level.
    int yydebug_;
    /// Debug stream.
    std::ostream* yycdebug_;

    /// \brief Display a symbol kind, value and location.
    /// \param yyo    The output stream.
    /// \param yysym  The symbol.
    template <typename Base>
    void yy_print_ (std::ostream& yyo, const basic_symbol<Base>& yysym) const;
#endif

    /// \brief Reclaim the memory associated to a symbol.
    /// \param yymsg     Why this token is reclaimed.
    ///                  If null, print nothing.
    /// \param yysym     The symbol.
    template <typename Base>
    void yy_destroy_ (const char* yymsg, basic_symbol<Base>& yysym) const;

  private:
    /// Type access provider for state based symbols.
    struct by_state
    {
      /// Default constructor.
      by_state () YY_NOEXCEPT;

      /// The symbol kind as needed by the constructor.
      typedef state_type kind_type;

      /// Constructor.
      by_state (kind_type s) YY_NOEXCEPT;

      /// Copy constructor.
      by_state (const by_state& that) YY_NOEXCEPT;

      /// Record that this symbol is empty.
      void clear () YY_NOEXCEPT;

      /// Steal the symbol kind from \a that.
      void move (by_state& that);

      /// The symbol kind (corresponding to \a state).
      /// \a symbol_kind::S_YYEMPTY when empty.
      symbol_kind_type kind () const YY_NOEXCEPT;

      /// The state number used to denote an empty symbol.
      /// We use the initial state, as it does not have a value.
      enum { empty_state = 0 };

      /// The state.
      /// \a empty when empty.
      state_type state;
    };

    /// "Internal" symbol: element of the stack.
    struct stack_symbol_type : basic_symbol<by_state>
    {
      /// Superclass.
      typedef basic_symbol<by_state> super_type;
      /// Construct an empty symbol.
      stack_symbol_type ();
      /// Move or copy construction.
      stack_symbol_type (YY_RVREF (stack_symbol_type) that);
      /// Steal the contents from \a sym to build this.
      stack_symbol_type (state_type s, YY_MOVE_REF (symbol_type) sym);
#if YY_CPLUSPLUS < 201103L
      /// Assignment, needed by push_back by some old implementations.
      /// Moves the contents of that.
      stack_symbol_type& operator= (stack_symbol_type& that);

      /// Assignment, needed by push_back by other implementations.
      /// Needed by some other old implementations.
      stack_symbol_type& operator= (const stack_symbol_type& that);
#endif
    };

    /// A stack with random access from its top.
    template <typename T, typename S = std::vector<T> >
    class stack
    {
    public:
      // Hide our reversed order.
      typedef typename S::iterator iterator;
      typedef typename S::const_iterator const_iterator;
      typedef typename S::size_type size_type;
      typedef typename std::ptrdiff_t index_type;

      stack (size_type n = 200) YY_NOEXCEPT
        : seq_ (n)
      {}

#if 201103L <= YY_CPLUSPLUS
      /// Non copyable.
      stack (const stack&) = delete;
      /// Non copyable.
      stack& operator= (const stack&) = delete;
#endif

      /// Random access.
      ///
      /// Index 0 returns the topmost element.
      const T&
      operator[] (index_type i) const
      {
        return seq_[size_type (size () - 1 - i)];
      }

      /// Random access.
      ///
      /// Index 0 returns the topmost element.
      T&
      operator[] (index_type i)
      {
        return seq_[size_type (size () - 1 - i)];
      }

      /// Steal the contents of \a t.
      ///
      /// Close to move-semantics.
      void
      push (YY_MOVE_REF (T) t)
      {
        seq_.push_back (T ());
        operator[] (0).move (t);
      }

      /// Pop elements from the stack.
      void
      pop (std::ptrdiff_t n = 1) YY_NOEXCEPT
      {
        for (; 0 < n; --n)
          seq_.pop_back ();
      }

      /// Pop all elements from the stack.
      void
      clear () YY_NOEXCEPT
      {
        seq_.clear ();
      }

      /// Number of elements on the stack.
      index_type
      size () const YY_NOEXCEPT
      {
        return index_type (seq_.size ());
      }

      /// Iterator on top of the stack (going downwards).
      const_iterator
      begin () const YY_NOEXCEPT
      {
        return seq_.begin ();
      }

      /// Bottom of the stack.
      const_iterator
      end () const YY_NOEXCEPT
      {
        return seq_.end ();
      }

      /// Present a slice of the top of a stack.
      class slice
      {
      public:
        slice (const stack& stack, index_type range) YY_NOEXCEPT
          : stack_ (stack)
          , range_ (range)
        {}

        const T&
        operator[] (index_type i) const
        {
          return stack_[range_ - i];
        }

      private:
        const stack& stack_;
        index_type range_;
      };

    private:
#if YY_CPLUSPLUS < 201103L
      /// Non copyable.
      stack (const stack&);
      /// Non copyable.
      stack& operator= (const stack&);
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
    void yypush_ (const char* m, YY_MOVE_REF (stack_symbol_type) sym);

    /// Push a new look ahead token on the state on the stack.
    /// \param m    a debug message to display
    ///             if null, no trace is output.
    /// \param s    the state
    /// \param sym  the symbol (for its value and location).
    /// \warning the contents of \a sym.value is stolen.
    void yypush_ (const char* m, state_type s, YY_MOVE_REF (symbol_type) sym);

    /// Pop \a n symbols from the stack.
    void yypop_ (int n = 1) YY_NOEXCEPT;

    /// Constants.
    enum
    {
      yylast_ = 310,     ///< Last index in yytable_.
      yynnts_ = 46,  ///< Number of nonterminal symbols.
      yyfinal_ = 21 ///< Termination state number.
    };



  };

  inline
  parser::symbol_kind_type
  parser::yytranslate_ (int t) YY_NOEXCEPT
  {
    return static_cast<symbol_kind_type> (t);
  }

  // basic_symbol.
  template <typename Base>
  parser::basic_symbol<Base>::basic_symbol (const basic_symbol& that)
    : Base (that)
    , value ()
  {
    switch (this->kind ())
    {
      case symbol_kind::S_FcmpOp: // FcmpOp
        value.copy< FCMPOP > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_GVIniter: // GVIniter
        value.copy< GVIniter > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_IcmpOp: // IcmpOp
        value.copy< ICMPOP > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_BinaryOp: // BinaryOp
        value.copy< OP > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Storage: // Storage
        value.copy< STOCLASS > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_IRNUM_FLOAT: // IRNUM_FLOAT
        value.copy< float > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_IRNUM_INT: // IRNUM_INT
        value.copy< int > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_BB: // BB
        value.copy< pBlock > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_DefParam: // DefParam
        value.copy< pFormalParam > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FunctionDefinition: // FunctionDefinition
        value.copy< pFunc > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FunctionDeclaration: // FunctionDeclaration
        value.copy< pFuncDecl > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_GlobalVariable: // GlobalVariable
        value.copy< pGlobalVar > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Inst: // Inst
      case symbol_kind::S_BinaryInst: // BinaryInst
      case symbol_kind::S_FnegInst: // FnegInst
      case symbol_kind::S_CastInst: // CastInst
      case symbol_kind::S_IcmpInst: // IcmpInst
      case symbol_kind::S_FcmpInst: // FcmpInst
      case symbol_kind::S_RetInst: // RetInst
      case symbol_kind::S_BrInst: // BrInst
      case symbol_kind::S_CallInst: // CallInst
      case symbol_kind::S_AllocaInst: // AllocaInst
      case symbol_kind::S_LoadInst: // LoadInst
      case symbol_kind::S_StoreInst: // StoreInst
      case symbol_kind::S_GepInst: // GepInst
      case symbol_kind::S_PhiInst: // PhiInst
        value.copy< pInst > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Type: // Type
      case symbol_kind::S_BType: // BType
      case symbol_kind::S_PtrType: // PtrType
      case symbol_kind::S_ArrayType: // ArrayType
      case symbol_kind::S_DeclParam: // DeclParam
      case symbol_kind::S_RETType: // RETType
        value.copy< pType > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Constant: // Constant
      case symbol_kind::S_TypeValue: // TypeValue
      case symbol_kind::S_Value: // Value
      case symbol_kind::S_Arg: // Arg
        value.copy< pVal > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_InstList: // InstList
        value.copy< std::list<pInst> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_PhiOper: // PhiOper
        value.copy< std::pair<pVal, pBlock> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_I_ID: // I_ID
      case symbol_kind::S_I_BLKID: // I_BLKID
        value.copy< std::string > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_GVIniters: // GVIniters
        value.copy< std::vector<GVIniter> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_BBList: // BBList
        value.copy< std::vector<pBlock> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_DefParamList: // DefParamList
        value.copy< std::vector<pFormalParam> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_DeclParamList: // DeclParamList
        value.copy< std::vector<pType> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ArgList: // ArgList
      case symbol_kind::S_IndexList: // IndexList
        value.copy< std::vector<pVal> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_PhiOpers: // PhiOpers
        value.copy< std::vector<std::pair<pVal, pBlock>> > (YY_MOVE (that.value));
        break;

      default:
        break;
    }

  }




  template <typename Base>
  parser::symbol_kind_type
  parser::basic_symbol<Base>::type_get () const YY_NOEXCEPT
  {
    return this->kind ();
  }


  template <typename Base>
  bool
  parser::basic_symbol<Base>::empty () const YY_NOEXCEPT
  {
    return this->kind () == symbol_kind::S_YYEMPTY;
  }

  template <typename Base>
  void
  parser::basic_symbol<Base>::move (basic_symbol& s)
  {
    super_type::move (s);
    switch (this->kind ())
    {
      case symbol_kind::S_FcmpOp: // FcmpOp
        value.move< FCMPOP > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_GVIniter: // GVIniter
        value.move< GVIniter > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_IcmpOp: // IcmpOp
        value.move< ICMPOP > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_BinaryOp: // BinaryOp
        value.move< OP > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_Storage: // Storage
        value.move< STOCLASS > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_IRNUM_FLOAT: // IRNUM_FLOAT
        value.move< float > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_IRNUM_INT: // IRNUM_INT
        value.move< int > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_BB: // BB
        value.move< pBlock > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_DefParam: // DefParam
        value.move< pFormalParam > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_FunctionDefinition: // FunctionDefinition
        value.move< pFunc > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_FunctionDeclaration: // FunctionDeclaration
        value.move< pFuncDecl > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_GlobalVariable: // GlobalVariable
        value.move< pGlobalVar > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_Inst: // Inst
      case symbol_kind::S_BinaryInst: // BinaryInst
      case symbol_kind::S_FnegInst: // FnegInst
      case symbol_kind::S_CastInst: // CastInst
      case symbol_kind::S_IcmpInst: // IcmpInst
      case symbol_kind::S_FcmpInst: // FcmpInst
      case symbol_kind::S_RetInst: // RetInst
      case symbol_kind::S_BrInst: // BrInst
      case symbol_kind::S_CallInst: // CallInst
      case symbol_kind::S_AllocaInst: // AllocaInst
      case symbol_kind::S_LoadInst: // LoadInst
      case symbol_kind::S_StoreInst: // StoreInst
      case symbol_kind::S_GepInst: // GepInst
      case symbol_kind::S_PhiInst: // PhiInst
        value.move< pInst > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_Type: // Type
      case symbol_kind::S_BType: // BType
      case symbol_kind::S_PtrType: // PtrType
      case symbol_kind::S_ArrayType: // ArrayType
      case symbol_kind::S_DeclParam: // DeclParam
      case symbol_kind::S_RETType: // RETType
        value.move< pType > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_Constant: // Constant
      case symbol_kind::S_TypeValue: // TypeValue
      case symbol_kind::S_Value: // Value
      case symbol_kind::S_Arg: // Arg
        value.move< pVal > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_InstList: // InstList
        value.move< std::list<pInst> > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_PhiOper: // PhiOper
        value.move< std::pair<pVal, pBlock> > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_I_ID: // I_ID
      case symbol_kind::S_I_BLKID: // I_BLKID
        value.move< std::string > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_GVIniters: // GVIniters
        value.move< std::vector<GVIniter> > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_BBList: // BBList
        value.move< std::vector<pBlock> > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_DefParamList: // DefParamList
        value.move< std::vector<pFormalParam> > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_DeclParamList: // DeclParamList
        value.move< std::vector<pType> > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_ArgList: // ArgList
      case symbol_kind::S_IndexList: // IndexList
        value.move< std::vector<pVal> > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_PhiOpers: // PhiOpers
        value.move< std::vector<std::pair<pVal, pBlock>> > (YY_MOVE (s.value));
        break;

      default:
        break;
    }

  }

  // by_kind.
  inline
  parser::by_kind::by_kind () YY_NOEXCEPT
    : kind_ (symbol_kind::S_YYEMPTY)
  {}

#if 201103L <= YY_CPLUSPLUS
  inline
  parser::by_kind::by_kind (by_kind&& that) YY_NOEXCEPT
    : kind_ (that.kind_)
  {
    that.clear ();
  }
#endif

  inline
  parser::by_kind::by_kind (const by_kind& that) YY_NOEXCEPT
    : kind_ (that.kind_)
  {}

  inline
  parser::by_kind::by_kind (token_kind_type t) YY_NOEXCEPT
    : kind_ (yytranslate_ (t))
  {}



  inline
  void
  parser::by_kind::clear () YY_NOEXCEPT
  {
    kind_ = symbol_kind::S_YYEMPTY;
  }

  inline
  void
  parser::by_kind::move (by_kind& that)
  {
    kind_ = that.kind_;
    that.clear ();
  }

  inline
  parser::symbol_kind_type
  parser::by_kind::kind () const YY_NOEXCEPT
  {
    return kind_;
  }


  inline
  parser::symbol_kind_type
  parser::by_kind::type_get () const YY_NOEXCEPT
  {
    return this->kind ();
  }


#line 22 "irparser.y"
} // yyy
#line 3327 "../../include/ggc/irparser.hpp"




#endif // !YY_YY_INCLUDE_GGC_IRPARSER_HPP_INCLUDED
#endif