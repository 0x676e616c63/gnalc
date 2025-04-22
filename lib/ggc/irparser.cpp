#ifdef GNALC_EXTENSION_GGC
// A Bison parser, made by GNU Bison 3.8.2.

// Skeleton implementation for Bison LALR(1) parsers in C++

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

// DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
// especially those whose name start with YY_ or yy_.  They are
// private implementation details that can be changed or removed.





#include "irparser.hpp"


// Unqualified %code blocks.
#line 1 "irparser.y"

#include "../../include/ggc/irparsertool.hpp"
extern yyy::parser::symbol_type yylex ();
extern int yylineno;
IR::Module& inode = IRParser::IRGenerator::get_module();
using namespace IRParser;
using namespace IR;
IRPT tool;

#line 56 "irparser.cpp"


#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> // FIXME: INFRINGES ON USER NAME SPACE.
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif


// Whether we are compiled with exception support.
#ifndef YY_EXCEPTIONS
# if defined __GNUC__ && !defined __EXCEPTIONS
#  define YY_EXCEPTIONS 0
# else
#  define YY_EXCEPTIONS 1
# endif
#endif



// Enable debugging if requested.
#if YYDEBUG

// A pseudo ostream that takes yydebug_ into account.
# define YYCDEBUG if (yydebug_) (*yycdebug_)

# define YY_SYMBOL_PRINT(Title, Symbol)         \
  do {                                          \
    if (yydebug_)                               \
    {                                           \
      *yycdebug_ << Title << ' ';               \
      yy_print_ (*yycdebug_, Symbol);           \
      *yycdebug_ << '\n';                       \
    }                                           \
  } while (false)

# define YY_REDUCE_PRINT(Rule)          \
  do {                                  \
    if (yydebug_)                       \
      yy_reduce_print_ (Rule);          \
  } while (false)

# define YY_STACK_PRINT()               \
  do {                                  \
    if (yydebug_)                       \
      yy_stack_print_ ();                \
  } while (false)

#else // !YYDEBUG

# define YYCDEBUG if (false) std::cerr
# define YY_SYMBOL_PRINT(Title, Symbol)  YY_USE (Symbol)
# define YY_REDUCE_PRINT(Rule)           static_cast<void> (0)
# define YY_STACK_PRINT()                static_cast<void> (0)

#endif // !YYDEBUG

#define yyerrok         (yyerrstatus_ = 0)
#define yyclearin       (yyla.clear ())

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYRECOVERING()  (!!yyerrstatus_)

#line 22 "irparser.y"
namespace yyy {
#line 130 "irparser.cpp"

  /// Build a parser object.
  parser::parser ()
#if YYDEBUG
    : yydebug_ (false),
      yycdebug_ (&std::cerr)
#else

#endif
  {}

  parser::~parser ()
  {}

  parser::syntax_error::~syntax_error () YY_NOEXCEPT YY_NOTHROW
  {}

  /*---------.
  | symbol.  |
  `---------*/



  // by_state.
  parser::by_state::by_state () YY_NOEXCEPT
    : state (empty_state)
  {}

  parser::by_state::by_state (const by_state& that) YY_NOEXCEPT
    : state (that.state)
  {}

  void
  parser::by_state::clear () YY_NOEXCEPT
  {
    state = empty_state;
  }

  void
  parser::by_state::move (by_state& that)
  {
    state = that.state;
    that.clear ();
  }

  parser::by_state::by_state (state_type s) YY_NOEXCEPT
    : state (s)
  {}

  parser::symbol_kind_type
  parser::by_state::kind () const YY_NOEXCEPT
  {
    if (state == empty_state)
      return symbol_kind::S_YYEMPTY;
    else
      return YY_CAST (symbol_kind_type, yystos_[+state]);
  }

  parser::stack_symbol_type::stack_symbol_type ()
  {}

  parser::stack_symbol_type::stack_symbol_type (YY_RVREF (stack_symbol_type) that)
    : super_type (YY_MOVE (that.state))
  {
    switch (that.kind ())
    {
      case symbol_kind::S_FcmpOp: // FcmpOp
        value.YY_MOVE_OR_COPY< FCMPOP > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_GVIniter: // GVIniter
        value.YY_MOVE_OR_COPY< GVIniter > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_IcmpOp: // IcmpOp
        value.YY_MOVE_OR_COPY< ICMPOP > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_BinaryOp: // BinaryOp
        value.YY_MOVE_OR_COPY< OP > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Storage: // Storage
        value.YY_MOVE_OR_COPY< STOCLASS > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_IRNUM_FLOAT: // IRNUM_FLOAT
        value.YY_MOVE_OR_COPY< float > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_IRNUM_INT: // IRNUM_INT
        value.YY_MOVE_OR_COPY< int > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_BB: // BB
        value.YY_MOVE_OR_COPY< pBlock > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_DefParam: // DefParam
        value.YY_MOVE_OR_COPY< pFormalParam > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FunctionDefinition: // FunctionDefinition
        value.YY_MOVE_OR_COPY< pFunc > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FunctionDeclaration: // FunctionDeclaration
        value.YY_MOVE_OR_COPY< pFuncDecl > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_GlobalVariable: // GlobalVariable
        value.YY_MOVE_OR_COPY< pGlobalVar > (YY_MOVE (that.value));
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
        value.YY_MOVE_OR_COPY< pInst > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Type: // Type
      case symbol_kind::S_BType: // BType
      case symbol_kind::S_PtrType: // PtrType
      case symbol_kind::S_ArrayType: // ArrayType
      case symbol_kind::S_DeclParam: // DeclParam
      case symbol_kind::S_RETType: // RETType
        value.YY_MOVE_OR_COPY< pType > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Constant: // Constant
      case symbol_kind::S_TypeValue: // TypeValue
      case symbol_kind::S_Value: // Value
      case symbol_kind::S_Arg: // Arg
        value.YY_MOVE_OR_COPY< pVal > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_InstList: // InstList
        value.YY_MOVE_OR_COPY< std::list<pInst> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_PhiOper: // PhiOper
        value.YY_MOVE_OR_COPY< std::pair<pVal, pBlock> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_I_ID: // I_ID
      case symbol_kind::S_I_BLKID: // I_BLKID
        value.YY_MOVE_OR_COPY< std::string > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_GVIniters: // GVIniters
        value.YY_MOVE_OR_COPY< std::vector<GVIniter> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_BBList: // BBList
        value.YY_MOVE_OR_COPY< std::vector<pBlock> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_DefParamList: // DefParamList
        value.YY_MOVE_OR_COPY< std::vector<pFormalParam> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_DeclParamList: // DeclParamList
        value.YY_MOVE_OR_COPY< std::vector<pType> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ArgList: // ArgList
      case symbol_kind::S_IndexList: // IndexList
        value.YY_MOVE_OR_COPY< std::vector<pVal> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_PhiOpers: // PhiOpers
        value.YY_MOVE_OR_COPY< std::vector<std::pair<pVal, pBlock>> > (YY_MOVE (that.value));
        break;

      default:
        break;
    }

#if 201103L <= YY_CPLUSPLUS
    // that is emptied.
    that.state = empty_state;
#endif
  }

  parser::stack_symbol_type::stack_symbol_type (state_type s, YY_MOVE_REF (symbol_type) that)
    : super_type (s)
  {
    switch (that.kind ())
    {
      case symbol_kind::S_FcmpOp: // FcmpOp
        value.move< FCMPOP > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_GVIniter: // GVIniter
        value.move< GVIniter > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_IcmpOp: // IcmpOp
        value.move< ICMPOP > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_BinaryOp: // BinaryOp
        value.move< OP > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Storage: // Storage
        value.move< STOCLASS > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_IRNUM_FLOAT: // IRNUM_FLOAT
        value.move< float > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_IRNUM_INT: // IRNUM_INT
        value.move< int > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_BB: // BB
        value.move< pBlock > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_DefParam: // DefParam
        value.move< pFormalParam > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FunctionDefinition: // FunctionDefinition
        value.move< pFunc > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FunctionDeclaration: // FunctionDeclaration
        value.move< pFuncDecl > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_GlobalVariable: // GlobalVariable
        value.move< pGlobalVar > (YY_MOVE (that.value));
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
        value.move< pInst > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Type: // Type
      case symbol_kind::S_BType: // BType
      case symbol_kind::S_PtrType: // PtrType
      case symbol_kind::S_ArrayType: // ArrayType
      case symbol_kind::S_DeclParam: // DeclParam
      case symbol_kind::S_RETType: // RETType
        value.move< pType > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Constant: // Constant
      case symbol_kind::S_TypeValue: // TypeValue
      case symbol_kind::S_Value: // Value
      case symbol_kind::S_Arg: // Arg
        value.move< pVal > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_InstList: // InstList
        value.move< std::list<pInst> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_PhiOper: // PhiOper
        value.move< std::pair<pVal, pBlock> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_I_ID: // I_ID
      case symbol_kind::S_I_BLKID: // I_BLKID
        value.move< std::string > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_GVIniters: // GVIniters
        value.move< std::vector<GVIniter> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_BBList: // BBList
        value.move< std::vector<pBlock> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_DefParamList: // DefParamList
        value.move< std::vector<pFormalParam> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_DeclParamList: // DeclParamList
        value.move< std::vector<pType> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ArgList: // ArgList
      case symbol_kind::S_IndexList: // IndexList
        value.move< std::vector<pVal> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_PhiOpers: // PhiOpers
        value.move< std::vector<std::pair<pVal, pBlock>> > (YY_MOVE (that.value));
        break;

      default:
        break;
    }

    // that is emptied.
    that.kind_ = symbol_kind::S_YYEMPTY;
  }

#if YY_CPLUSPLUS < 201103L
  parser::stack_symbol_type&
  parser::stack_symbol_type::operator= (const stack_symbol_type& that)
  {
    state = that.state;
    switch (that.kind ())
    {
      case symbol_kind::S_FcmpOp: // FcmpOp
        value.copy< FCMPOP > (that.value);
        break;

      case symbol_kind::S_GVIniter: // GVIniter
        value.copy< GVIniter > (that.value);
        break;

      case symbol_kind::S_IcmpOp: // IcmpOp
        value.copy< ICMPOP > (that.value);
        break;

      case symbol_kind::S_BinaryOp: // BinaryOp
        value.copy< OP > (that.value);
        break;

      case symbol_kind::S_Storage: // Storage
        value.copy< STOCLASS > (that.value);
        break;

      case symbol_kind::S_IRNUM_FLOAT: // IRNUM_FLOAT
        value.copy< float > (that.value);
        break;

      case symbol_kind::S_IRNUM_INT: // IRNUM_INT
        value.copy< int > (that.value);
        break;

      case symbol_kind::S_BB: // BB
        value.copy< pBlock > (that.value);
        break;

      case symbol_kind::S_DefParam: // DefParam
        value.copy< pFormalParam > (that.value);
        break;

      case symbol_kind::S_FunctionDefinition: // FunctionDefinition
        value.copy< pFunc > (that.value);
        break;

      case symbol_kind::S_FunctionDeclaration: // FunctionDeclaration
        value.copy< pFuncDecl > (that.value);
        break;

      case symbol_kind::S_GlobalVariable: // GlobalVariable
        value.copy< pGlobalVar > (that.value);
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
        value.copy< pInst > (that.value);
        break;

      case symbol_kind::S_Type: // Type
      case symbol_kind::S_BType: // BType
      case symbol_kind::S_PtrType: // PtrType
      case symbol_kind::S_ArrayType: // ArrayType
      case symbol_kind::S_DeclParam: // DeclParam
      case symbol_kind::S_RETType: // RETType
        value.copy< pType > (that.value);
        break;

      case symbol_kind::S_Constant: // Constant
      case symbol_kind::S_TypeValue: // TypeValue
      case symbol_kind::S_Value: // Value
      case symbol_kind::S_Arg: // Arg
        value.copy< pVal > (that.value);
        break;

      case symbol_kind::S_InstList: // InstList
        value.copy< std::list<pInst> > (that.value);
        break;

      case symbol_kind::S_PhiOper: // PhiOper
        value.copy< std::pair<pVal, pBlock> > (that.value);
        break;

      case symbol_kind::S_I_ID: // I_ID
      case symbol_kind::S_I_BLKID: // I_BLKID
        value.copy< std::string > (that.value);
        break;

      case symbol_kind::S_GVIniters: // GVIniters
        value.copy< std::vector<GVIniter> > (that.value);
        break;

      case symbol_kind::S_BBList: // BBList
        value.copy< std::vector<pBlock> > (that.value);
        break;

      case symbol_kind::S_DefParamList: // DefParamList
        value.copy< std::vector<pFormalParam> > (that.value);
        break;

      case symbol_kind::S_DeclParamList: // DeclParamList
        value.copy< std::vector<pType> > (that.value);
        break;

      case symbol_kind::S_ArgList: // ArgList
      case symbol_kind::S_IndexList: // IndexList
        value.copy< std::vector<pVal> > (that.value);
        break;

      case symbol_kind::S_PhiOpers: // PhiOpers
        value.copy< std::vector<std::pair<pVal, pBlock>> > (that.value);
        break;

      default:
        break;
    }

    return *this;
  }

  parser::stack_symbol_type&
  parser::stack_symbol_type::operator= (stack_symbol_type& that)
  {
    state = that.state;
    switch (that.kind ())
    {
      case symbol_kind::S_FcmpOp: // FcmpOp
        value.move< FCMPOP > (that.value);
        break;

      case symbol_kind::S_GVIniter: // GVIniter
        value.move< GVIniter > (that.value);
        break;

      case symbol_kind::S_IcmpOp: // IcmpOp
        value.move< ICMPOP > (that.value);
        break;

      case symbol_kind::S_BinaryOp: // BinaryOp
        value.move< OP > (that.value);
        break;

      case symbol_kind::S_Storage: // Storage
        value.move< STOCLASS > (that.value);
        break;

      case symbol_kind::S_IRNUM_FLOAT: // IRNUM_FLOAT
        value.move< float > (that.value);
        break;

      case symbol_kind::S_IRNUM_INT: // IRNUM_INT
        value.move< int > (that.value);
        break;

      case symbol_kind::S_BB: // BB
        value.move< pBlock > (that.value);
        break;

      case symbol_kind::S_DefParam: // DefParam
        value.move< pFormalParam > (that.value);
        break;

      case symbol_kind::S_FunctionDefinition: // FunctionDefinition
        value.move< pFunc > (that.value);
        break;

      case symbol_kind::S_FunctionDeclaration: // FunctionDeclaration
        value.move< pFuncDecl > (that.value);
        break;

      case symbol_kind::S_GlobalVariable: // GlobalVariable
        value.move< pGlobalVar > (that.value);
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
        value.move< pInst > (that.value);
        break;

      case symbol_kind::S_Type: // Type
      case symbol_kind::S_BType: // BType
      case symbol_kind::S_PtrType: // PtrType
      case symbol_kind::S_ArrayType: // ArrayType
      case symbol_kind::S_DeclParam: // DeclParam
      case symbol_kind::S_RETType: // RETType
        value.move< pType > (that.value);
        break;

      case symbol_kind::S_Constant: // Constant
      case symbol_kind::S_TypeValue: // TypeValue
      case symbol_kind::S_Value: // Value
      case symbol_kind::S_Arg: // Arg
        value.move< pVal > (that.value);
        break;

      case symbol_kind::S_InstList: // InstList
        value.move< std::list<pInst> > (that.value);
        break;

      case symbol_kind::S_PhiOper: // PhiOper
        value.move< std::pair<pVal, pBlock> > (that.value);
        break;

      case symbol_kind::S_I_ID: // I_ID
      case symbol_kind::S_I_BLKID: // I_BLKID
        value.move< std::string > (that.value);
        break;

      case symbol_kind::S_GVIniters: // GVIniters
        value.move< std::vector<GVIniter> > (that.value);
        break;

      case symbol_kind::S_BBList: // BBList
        value.move< std::vector<pBlock> > (that.value);
        break;

      case symbol_kind::S_DefParamList: // DefParamList
        value.move< std::vector<pFormalParam> > (that.value);
        break;

      case symbol_kind::S_DeclParamList: // DeclParamList
        value.move< std::vector<pType> > (that.value);
        break;

      case symbol_kind::S_ArgList: // ArgList
      case symbol_kind::S_IndexList: // IndexList
        value.move< std::vector<pVal> > (that.value);
        break;

      case symbol_kind::S_PhiOpers: // PhiOpers
        value.move< std::vector<std::pair<pVal, pBlock>> > (that.value);
        break;

      default:
        break;
    }

    // that is emptied.
    that.state = empty_state;
    return *this;
  }
#endif

  template <typename Base>
  void
  parser::yy_destroy_ (const char* yymsg, basic_symbol<Base>& yysym) const
  {
    if (yymsg)
      YY_SYMBOL_PRINT (yymsg, yysym);
  }

#if YYDEBUG
  template <typename Base>
  void
  parser::yy_print_ (std::ostream& yyo, const basic_symbol<Base>& yysym) const
  {
    std::ostream& yyoutput = yyo;
    YY_USE (yyoutput);
    if (yysym.empty ())
      yyo << "empty symbol";
    else
      {
        symbol_kind_type yykind = yysym.kind ();
        yyo << (yykind < YYNTOKENS ? "token" : "nterm")
            << ' ' << yysym.name () << " (";
        YY_USE (yykind);
        yyo << ')';
      }
  }
#endif

  void
  parser::yypush_ (const char* m, YY_MOVE_REF (stack_symbol_type) sym)
  {
    if (m)
      YY_SYMBOL_PRINT (m, sym);
    yystack_.push (YY_MOVE (sym));
  }

  void
  parser::yypush_ (const char* m, state_type s, YY_MOVE_REF (symbol_type) sym)
  {
#if 201103L <= YY_CPLUSPLUS
    yypush_ (m, stack_symbol_type (s, std::move (sym)));
#else
    stack_symbol_type ss (s, sym);
    yypush_ (m, ss);
#endif
  }

  void
  parser::yypop_ (int n) YY_NOEXCEPT
  {
    yystack_.pop (n);
  }

#if YYDEBUG
  std::ostream&
  parser::debug_stream () const
  {
    return *yycdebug_;
  }

  void
  parser::set_debug_stream (std::ostream& o)
  {
    yycdebug_ = &o;
  }


  parser::debug_level_type
  parser::debug_level () const
  {
    return yydebug_;
  }

  void
  parser::set_debug_level (debug_level_type l)
  {
    yydebug_ = l;
  }
#endif // YYDEBUG

  parser::state_type
  parser::yy_lr_goto_state_ (state_type yystate, int yysym)
  {
    int yyr = yypgoto_[yysym - YYNTOKENS] + yystate;
    if (0 <= yyr && yyr <= yylast_ && yycheck_[yyr] == yystate)
      return yytable_[yyr];
    else
      return yydefgoto_[yysym - YYNTOKENS];
  }

  bool
  parser::yy_pact_value_is_default_ (int yyvalue) YY_NOEXCEPT
  {
    return yyvalue == yypact_ninf_;
  }

  bool
  parser::yy_table_value_is_error_ (int yyvalue) YY_NOEXCEPT
  {
    return yyvalue == yytable_ninf_;
  }

  int
  parser::operator() ()
  {
    return parse ();
  }

  int
  parser::parse ()
  {
    int yyn;
    /// Length of the RHS of the rule being reduced.
    int yylen = 0;

    // Error handling.
    int yynerrs_ = 0;
    int yyerrstatus_ = 0;

    /// The lookahead symbol.
    symbol_type yyla;

    /// The return value of parse ().
    int yyresult;

#if YY_EXCEPTIONS
    try
#endif // YY_EXCEPTIONS
      {
    YYCDEBUG << "Starting parse\n";


    /* Initialize the stack.  The initial state will be set in
       yynewstate, since the latter expects the semantical and the
       location values to have been already stored, initialize these
       stacks with a primary value.  */
    yystack_.clear ();
    yypush_ (YY_NULLPTR, 0, YY_MOVE (yyla));

  /*-----------------------------------------------.
  | yynewstate -- push a new symbol on the stack.  |
  `-----------------------------------------------*/
  yynewstate:
    YYCDEBUG << "Entering state " << int (yystack_[0].state) << '\n';
    YY_STACK_PRINT ();

    // Accept?
    if (yystack_[0].state == yyfinal_)
      YYACCEPT;

    goto yybackup;


  /*-----------.
  | yybackup.  |
  `-----------*/
  yybackup:
    // Try to take a decision without lookahead.
    yyn = yypact_[+yystack_[0].state];
    if (yy_pact_value_is_default_ (yyn))
      goto yydefault;

    // Read a lookahead token.
    if (yyla.empty ())
      {
        YYCDEBUG << "Reading a token\n";
#if YY_EXCEPTIONS
        try
#endif // YY_EXCEPTIONS
          {
            symbol_type yylookahead (yylex ());
            yyla.move (yylookahead);
          }
#if YY_EXCEPTIONS
        catch (const syntax_error& yyexc)
          {
            YYCDEBUG << "Caught exception: " << yyexc.what() << '\n';
            error (yyexc);
            goto yyerrlab1;
          }
#endif // YY_EXCEPTIONS
      }
    YY_SYMBOL_PRINT ("Next token is", yyla);

    if (yyla.kind () == symbol_kind::S_YYerror)
    {
      // The scanner already issued an error message, process directly
      // to error recovery.  But do not keep the error token as
      // lookahead, it is too special and may lead us to an endless
      // loop in error recovery. */
      yyla.kind_ = symbol_kind::S_YYUNDEF;
      goto yyerrlab1;
    }

    /* If the proper action on seeing token YYLA.TYPE is to reduce or
       to detect an error, take that action.  */
    yyn += yyla.kind ();
    if (yyn < 0 || yylast_ < yyn || yycheck_[yyn] != yyla.kind ())
      {
        goto yydefault;
      }

    // Reduce or error.
    yyn = yytable_[yyn];
    if (yyn <= 0)
      {
        if (yy_table_value_is_error_ (yyn))
          goto yyerrlab;
        yyn = -yyn;
        goto yyreduce;
      }

    // Count tokens shifted since error; after three, turn off error status.
    if (yyerrstatus_)
      --yyerrstatus_;

    // Shift the lookahead token.
    yypush_ ("Shifting", state_type (yyn), YY_MOVE (yyla));
    goto yynewstate;


  /*-----------------------------------------------------------.
  | yydefault -- do the default action for the current state.  |
  `-----------------------------------------------------------*/
  yydefault:
    yyn = yydefact_[+yystack_[0].state];
    if (yyn == 0)
      goto yyerrlab;
    goto yyreduce;


  /*-----------------------------.
  | yyreduce -- do a reduction.  |
  `-----------------------------*/
  yyreduce:
    yylen = yyr2_[yyn];
    {
      stack_symbol_type yylhs;
      yylhs.state = yy_lr_goto_state_ (yystack_[yylen].state, yyr1_[yyn]);
      /* Variants are always initialized to an empty instance of the
         correct type. The default '$$ = $1' action is NOT applied
         when using variants.  */
      switch (yyr1_[yyn])
    {
      case symbol_kind::S_FcmpOp: // FcmpOp
        yylhs.value.emplace< FCMPOP > ();
        break;

      case symbol_kind::S_GVIniter: // GVIniter
        yylhs.value.emplace< GVIniter > ();
        break;

      case symbol_kind::S_IcmpOp: // IcmpOp
        yylhs.value.emplace< ICMPOP > ();
        break;

      case symbol_kind::S_BinaryOp: // BinaryOp
        yylhs.value.emplace< OP > ();
        break;

      case symbol_kind::S_Storage: // Storage
        yylhs.value.emplace< STOCLASS > ();
        break;

      case symbol_kind::S_IRNUM_FLOAT: // IRNUM_FLOAT
        yylhs.value.emplace< float > ();
        break;

      case symbol_kind::S_IRNUM_INT: // IRNUM_INT
        yylhs.value.emplace< int > ();
        break;

      case symbol_kind::S_BB: // BB
        yylhs.value.emplace< pBlock > ();
        break;

      case symbol_kind::S_DefParam: // DefParam
        yylhs.value.emplace< pFormalParam > ();
        break;

      case symbol_kind::S_FunctionDefinition: // FunctionDefinition
        yylhs.value.emplace< pFunc > ();
        break;

      case symbol_kind::S_FunctionDeclaration: // FunctionDeclaration
        yylhs.value.emplace< pFuncDecl > ();
        break;

      case symbol_kind::S_GlobalVariable: // GlobalVariable
        yylhs.value.emplace< pGlobalVar > ();
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
        yylhs.value.emplace< pInst > ();
        break;

      case symbol_kind::S_Type: // Type
      case symbol_kind::S_BType: // BType
      case symbol_kind::S_PtrType: // PtrType
      case symbol_kind::S_ArrayType: // ArrayType
      case symbol_kind::S_DeclParam: // DeclParam
      case symbol_kind::S_RETType: // RETType
        yylhs.value.emplace< pType > ();
        break;

      case symbol_kind::S_Constant: // Constant
      case symbol_kind::S_TypeValue: // TypeValue
      case symbol_kind::S_Value: // Value
      case symbol_kind::S_Arg: // Arg
        yylhs.value.emplace< pVal > ();
        break;

      case symbol_kind::S_InstList: // InstList
        yylhs.value.emplace< std::list<pInst> > ();
        break;

      case symbol_kind::S_PhiOper: // PhiOper
        yylhs.value.emplace< std::pair<pVal, pBlock> > ();
        break;

      case symbol_kind::S_I_ID: // I_ID
      case symbol_kind::S_I_BLKID: // I_BLKID
        yylhs.value.emplace< std::string > ();
        break;

      case symbol_kind::S_GVIniters: // GVIniters
        yylhs.value.emplace< std::vector<GVIniter> > ();
        break;

      case symbol_kind::S_BBList: // BBList
        yylhs.value.emplace< std::vector<pBlock> > ();
        break;

      case symbol_kind::S_DefParamList: // DefParamList
        yylhs.value.emplace< std::vector<pFormalParam> > ();
        break;

      case symbol_kind::S_DeclParamList: // DeclParamList
        yylhs.value.emplace< std::vector<pType> > ();
        break;

      case symbol_kind::S_ArgList: // ArgList
      case symbol_kind::S_IndexList: // IndexList
        yylhs.value.emplace< std::vector<pVal> > ();
        break;

      case symbol_kind::S_PhiOpers: // PhiOpers
        yylhs.value.emplace< std::vector<std::pair<pVal, pBlock>> > ();
        break;

      default:
        break;
    }



      // Perform the reduction.
      YY_REDUCE_PRINT (yyn);
#if YY_EXCEPTIONS
      try
#endif // YY_EXCEPTIONS
        {
          switch (yyn)
            {
  case 2: // Module: GlobalEntities
#line 58 "irparser.y"
                         {}
#line 1106 "irparser.cpp"
    break;

  case 3: // GlobalEntities: GlobalEntities GlobalVariable
#line 61 "irparser.y"
                                                        { inode.addGlobalVar(yystack_[0].value.as < pGlobalVar > ()); }
#line 1112 "irparser.cpp"
    break;

  case 4: // GlobalEntities: GlobalEntities FunctionDefinition
#line 62 "irparser.y"
                                                        { inode.addFunction(yystack_[0].value.as < pFunc > ()); }
#line 1118 "irparser.cpp"
    break;

  case 5: // GlobalEntities: GlobalEntities FunctionDeclaration
#line 63 "irparser.y"
                                                        { inode.addFunctionDecl(yystack_[0].value.as < pFuncDecl > ()); }
#line 1124 "irparser.cpp"
    break;

  case 6: // GlobalEntities: GlobalVariable
#line 64 "irparser.y"
                                                        { inode.addGlobalVar(yystack_[0].value.as < pGlobalVar > ()); }
#line 1130 "irparser.cpp"
    break;

  case 7: // GlobalEntities: FunctionDefinition
#line 65 "irparser.y"
                                                        { inode.addFunction(yystack_[0].value.as < pFunc > ()); }
#line 1136 "irparser.cpp"
    break;

  case 8: // GlobalEntities: FunctionDeclaration
#line 66 "irparser.y"
                                                        { inode.addFunctionDecl(yystack_[0].value.as < pFuncDecl > ()); }
#line 1142 "irparser.cpp"
    break;

  case 9: // GlobalVariable: I_ID I_EQUAL I_DSO_LOCAL Storage GVIniter I_COMMA I_ALIGN IRNUM_INT
#line 69 "irparser.y"
                                                                                        { yylhs.value.as < pGlobalVar > () = tool.newGV(yystack_[4].value.as < STOCLASS > (), yystack_[3].value.as < GVIniter > ().getIniterType(), yystack_[7].value.as < std::string > (), yystack_[3].value.as < GVIniter > (), yystack_[0].value.as < int > ()); }
#line 1148 "irparser.cpp"
    break;

  case 10: // Storage: I_CONSTANT
#line 72 "irparser.y"
                        { yylhs.value.as < STOCLASS > () = STOCLASS::CONSTANT; }
#line 1154 "irparser.cpp"
    break;

  case 11: // Storage: I_GLOBAL
#line 73 "irparser.y"
                        { yylhs.value.as < STOCLASS > () = STOCLASS::GLOBAL; }
#line 1160 "irparser.cpp"
    break;

  case 12: // Type: BType
#line 76 "irparser.y"
                    { yylhs.value.as < pType > () = yystack_[0].value.as < pType > (); }
#line 1166 "irparser.cpp"
    break;

  case 13: // Type: PtrType
#line 77 "irparser.y"
                    { yylhs.value.as < pType > () = yystack_[0].value.as < pType > (); }
#line 1172 "irparser.cpp"
    break;

  case 14: // Type: ArrayType
#line 78 "irparser.y"
                    { yylhs.value.as < pType > () = yystack_[0].value.as < pType > (); }
#line 1178 "irparser.cpp"
    break;

  case 15: // BType: I_I1
#line 81 "irparser.y"
                    { yylhs.value.as < pType > () = makeBType(IRBTYPE::I1); }
#line 1184 "irparser.cpp"
    break;

  case 16: // BType: I_I8
#line 82 "irparser.y"
                    { yylhs.value.as < pType > () = makeBType(IRBTYPE::I8); }
#line 1190 "irparser.cpp"
    break;

  case 17: // BType: I_I32
#line 83 "irparser.y"
                    { yylhs.value.as < pType > () = makeBType(IRBTYPE::I32); }
#line 1196 "irparser.cpp"
    break;

  case 18: // BType: I_FLOAT
#line 84 "irparser.y"
                    { yylhs.value.as < pType > () = makeBType(IRBTYPE::FLOAT); }
#line 1202 "irparser.cpp"
    break;

  case 19: // BType: I_VOID
#line 85 "irparser.y"
                    { yylhs.value.as < pType > () = makeBType(IRBTYPE::VOID); }
#line 1208 "irparser.cpp"
    break;

  case 20: // PtrType: Type I_STAR
#line 88 "irparser.y"
                        { yylhs.value.as < pType > () = makePtrType(yystack_[1].value.as < pType > ()); }
#line 1214 "irparser.cpp"
    break;

  case 21: // ArrayType: I_LSQUARE IRNUM_INT I_X Type I_RSQUARE
#line 91 "irparser.y"
                                                       { yylhs.value.as < pType > () = makeArrayType(yystack_[1].value.as < pType > (), yystack_[3].value.as < int > ()); }
#line 1220 "irparser.cpp"
    break;

  case 22: // Constant: IRNUM_INT
#line 94 "irparser.y"
                            { yylhs.value.as < pVal > () = inode.getConst(int(yystack_[0].value.as < int > ())); }
#line 1226 "irparser.cpp"
    break;

  case 23: // Constant: IRNUM_FLOAT
#line 95 "irparser.y"
                            { yylhs.value.as < pVal > () = inode.getConst(float(yystack_[0].value.as < float > ())); }
#line 1232 "irparser.cpp"
    break;

  case 24: // GVIniter: Type I_ZEROINITER
#line 98 "irparser.y"
                                                    { yylhs.value.as < GVIniter > () = GVIniter(yystack_[1].value.as < pType > ()); }
#line 1238 "irparser.cpp"
    break;

  case 25: // GVIniter: Type I_LSQUARE GVIniters I_RSQUARE
#line 99 "irparser.y"
                                                    { yylhs.value.as < GVIniter > () = GVIniter(yystack_[3].value.as < pType > (), yystack_[1].value.as < std::vector<GVIniter> > ()); }
#line 1244 "irparser.cpp"
    break;

  case 26: // GVIniter: Type Constant
#line 100 "irparser.y"
                                                    { yylhs.value.as < GVIniter > () = GVIniter(yystack_[1].value.as < pType > (), yystack_[0].value.as < pVal > ()); }
#line 1250 "irparser.cpp"
    break;

  case 27: // GVIniters: GVIniter
#line 103 "irparser.y"
                                            { yylhs.value.as < std::vector<GVIniter> > () = { yystack_[0].value.as < GVIniter > () }; }
#line 1256 "irparser.cpp"
    break;

  case 28: // GVIniters: GVIniters I_COMMA GVIniter
#line 104 "irparser.y"
                                            { yylhs.value.as < std::vector<GVIniter> > () = yystack_[2].value.as < std::vector<GVIniter> > (); yylhs.value.as < std::vector<GVIniter> > ().emplace_back(yystack_[0].value.as < GVIniter > ()); }
#line 1262 "irparser.cpp"
    break;

  case 29: // FunctionDeclaration: I_DECLARE Type I_ID I_LPAR DeclParamList I_RPAR
#line 107 "irparser.y"
                                                                                    { yylhs.value.as < pFuncDecl > () = tool.newFuncDecl(yystack_[3].value.as < std::string > (), yystack_[1].value.as < std::vector<pType> > (), yystack_[4].value.as < pType > ()); }
#line 1268 "irparser.cpp"
    break;

  case 30: // FunctionDeclaration: I_DECLARE Type I_ID I_LPAR DeclParamList I_COMMA I_DOTDOTDOT I_RPAR
#line 108 "irparser.y"
                                                                                            { yylhs.value.as < pFuncDecl > () = tool.newFuncDecl(yystack_[5].value.as < std::string > (), yystack_[3].value.as < std::vector<pType> > (), yystack_[6].value.as < pType > (), true); }
#line 1274 "irparser.cpp"
    break;

  case 31: // FunctionDeclaration: I_DECLARE Type I_ID I_LPAR I_RPAR
#line 109 "irparser.y"
                                                                                    { yylhs.value.as < pFuncDecl > () = tool.newFuncDecl(yystack_[2].value.as < std::string > (), {}, yystack_[3].value.as < pType > ()); }
#line 1280 "irparser.cpp"
    break;

  case 32: // FunctionDeclaration: I_DECLARE Type I_ID I_LPAR I_DOTDOTDOT I_RPAR
#line 110 "irparser.y"
                                                                                    { yylhs.value.as < pFuncDecl > () = tool.newFuncDecl(yystack_[3].value.as < std::string > (), {}, yystack_[4].value.as < pType > (), true); }
#line 1286 "irparser.cpp"
    break;

  case 33: // DeclParamList: DeclParamList I_COMMA DeclParam
#line 113 "irparser.y"
                                                    { yylhs.value.as < std::vector<pType> > () = yystack_[2].value.as < std::vector<pType> > (); yylhs.value.as < std::vector<pType> > ().emplace_back(yystack_[0].value.as < pType > ()); }
#line 1292 "irparser.cpp"
    break;

  case 34: // DeclParamList: DeclParam
#line 114 "irparser.y"
                                                    { yylhs.value.as < std::vector<pType> > () = { yystack_[0].value.as < pType > () }; }
#line 1298 "irparser.cpp"
    break;

  case 35: // DeclParam: Type I_NOUNDEF
#line 117 "irparser.y"
                                { yylhs.value.as < pType > () = yystack_[1].value.as < pType > (); }
#line 1304 "irparser.cpp"
    break;

  case 36: // DefParamList: DefParamList I_COMMA DefParam
#line 120 "irparser.y"
                                                { yylhs.value.as < std::vector<pFormalParam> > () = yystack_[2].value.as < std::vector<pFormalParam> > (); yylhs.value.as < std::vector<pFormalParam> > ().emplace_back(yystack_[0].value.as < pFormalParam > ()); }
#line 1310 "irparser.cpp"
    break;

  case 37: // DefParamList: DefParam
#line 121 "irparser.y"
                                                { yylhs.value.as < std::vector<pFormalParam> > () = { yystack_[0].value.as < pFormalParam > () }; }
#line 1316 "irparser.cpp"
    break;

  case 38: // DefParam: Type I_NOUNDEF I_ID
#line 124 "irparser.y"
                                    { yylhs.value.as < pFormalParam > () = tool.vmake<FormalParam>(yystack_[0].value.as < std::string > (), yystack_[0].value.as < std::string > (), yystack_[2].value.as < pType > (), 0); }
#line 1322 "irparser.cpp"
    break;

  case 39: // FunctionDefinition: I_DEFINE I_DSO_LOCAL Type I_ID I_LPAR DefParamList I_RPAR I_LBRACKET BBList I_RBRACKET
#line 127 "irparser.y"
                                                                                                                { yylhs.value.as < pFunc > () = tool.newFunc(yystack_[6].value.as < std::string > (), yystack_[4].value.as < std::vector<pFormalParam> > (), yystack_[7].value.as < pType > (), &inode.getConstantPool(), yystack_[1].value.as < std::vector<pBlock> > ()); }
#line 1328 "irparser.cpp"
    break;

  case 40: // FunctionDefinition: I_DEFINE I_DSO_LOCAL Type I_ID I_LPAR I_RPAR I_LBRACKET BBList I_RBRACKET
#line 128 "irparser.y"
                                                                                                                { yylhs.value.as < pFunc > () = tool.newFunc(yystack_[5].value.as < std::string > (), {}, yystack_[6].value.as < pType > (), &inode.getConstantPool(), yystack_[1].value.as < std::vector<pBlock> > ()); }
#line 1334 "irparser.cpp"
    break;

  case 41: // BBList: BB
#line 131 "irparser.y"
                        { yylhs.value.as < std::vector<pBlock> > () = { yystack_[0].value.as < pBlock > () }; }
#line 1340 "irparser.cpp"
    break;

  case 42: // BBList: BBList BB
#line 132 "irparser.y"
                        { yylhs.value.as < std::vector<pBlock> > () = yystack_[1].value.as < std::vector<pBlock> > (); yylhs.value.as < std::vector<pBlock> > ().emplace_back(yystack_[0].value.as < pBlock > ()); }
#line 1346 "irparser.cpp"
    break;

  case 43: // BB: I_BLKID InstList
#line 135 "irparser.y"
                        { yylhs.value.as < pBlock > () = tool.newBB(yystack_[1].value.as < std::string > (), yystack_[0].value.as < std::list<pInst> > ()); }
#line 1352 "irparser.cpp"
    break;

  case 44: // InstList: Inst
#line 138 "irparser.y"
                            { yylhs.value.as < std::list<pInst> > () = { yystack_[0].value.as < pInst > () }; }
#line 1358 "irparser.cpp"
    break;

  case 45: // InstList: InstList Inst
#line 139 "irparser.y"
                            { yylhs.value.as < std::list<pInst> > () = yystack_[1].value.as < std::list<pInst> > (); yylhs.value.as < std::list<pInst> > ().emplace_back(yystack_[0].value.as < pInst > ()); }
#line 1364 "irparser.cpp"
    break;

  case 46: // Inst: BinaryInst
#line 142 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1370 "irparser.cpp"
    break;

  case 47: // Inst: CastInst
#line 143 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1376 "irparser.cpp"
    break;

  case 48: // Inst: FnegInst
#line 144 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1382 "irparser.cpp"
    break;

  case 49: // Inst: IcmpInst
#line 145 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1388 "irparser.cpp"
    break;

  case 50: // Inst: FcmpInst
#line 146 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1394 "irparser.cpp"
    break;

  case 51: // Inst: RetInst
#line 147 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1400 "irparser.cpp"
    break;

  case 52: // Inst: BrInst
#line 148 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1406 "irparser.cpp"
    break;

  case 53: // Inst: CallInst
#line 149 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1412 "irparser.cpp"
    break;

  case 54: // Inst: AllocaInst
#line 150 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1418 "irparser.cpp"
    break;

  case 55: // Inst: LoadInst
#line 151 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1424 "irparser.cpp"
    break;

  case 56: // Inst: StoreInst
#line 152 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1430 "irparser.cpp"
    break;

  case 57: // Inst: GepInst
#line 153 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1436 "irparser.cpp"
    break;

  case 58: // Inst: PhiInst
#line 154 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1442 "irparser.cpp"
    break;

  case 59: // BinaryInst: I_ID I_EQUAL BinaryOp Type Value I_COMMA Value
#line 157 "irparser.y"
                                                                { yylhs.value.as < pInst > () = tool.vmake<BinaryInst>(yystack_[6].value.as < std::string > (), yystack_[6].value.as < std::string > (), yystack_[4].value.as < OP > (), yystack_[2].value.as < pVal > (), yystack_[0].value.as < pVal > ()); }
#line 1448 "irparser.cpp"
    break;

  case 60: // TypeValue: Type I_ID
#line 160 "irparser.y"
                                            { yylhs.value.as < pVal > () = tool.getV(yystack_[0].value.as < std::string > ()); }
#line 1454 "irparser.cpp"
    break;

  case 61: // TypeValue: I_I1 IRNUM_INT
#line 161 "irparser.y"
                                            { yylhs.value.as < pVal > () = inode.getConst(bool(yystack_[0].value.as < int > ())); }
#line 1460 "irparser.cpp"
    break;

  case 62: // TypeValue: I_I8 IRNUM_INT
#line 162 "irparser.y"
                                            { yylhs.value.as < pVal > () = inode.getConst(char(yystack_[0].value.as < int > ())); }
#line 1466 "irparser.cpp"
    break;

  case 63: // TypeValue: I_I32 IRNUM_INT
#line 163 "irparser.y"
                                            { yylhs.value.as < pVal > () = inode.getConst(int(yystack_[0].value.as < int > ())); }
#line 1472 "irparser.cpp"
    break;

  case 64: // TypeValue: I_FLOAT IRNUM_FLOAT
#line 164 "irparser.y"
                                            { yylhs.value.as < pVal > () = inode.getConst(float(yystack_[0].value.as < float > ())); }
#line 1478 "irparser.cpp"
    break;

  case 65: // Value: I_ID
#line 167 "irparser.y"
                    { yylhs.value.as < pVal > () = tool.getV(yystack_[0].value.as < std::string > ()); }
#line 1484 "irparser.cpp"
    break;

  case 66: // Value: Constant
#line 168 "irparser.y"
                    { yylhs.value.as < pVal > () = yystack_[0].value.as < pVal > (); }
#line 1490 "irparser.cpp"
    break;

  case 67: // BinaryOp: I_ADD
#line 171 "irparser.y"
                        { yylhs.value.as < OP > () = OP::ADD; }
#line 1496 "irparser.cpp"
    break;

  case 68: // BinaryOp: I_FADD
#line 172 "irparser.y"
                        { yylhs.value.as < OP > () = OP::FADD; }
#line 1502 "irparser.cpp"
    break;

  case 69: // BinaryOp: I_SUB
#line 173 "irparser.y"
                        { yylhs.value.as < OP > () = OP::SUB; }
#line 1508 "irparser.cpp"
    break;

  case 70: // BinaryOp: I_FSUB
#line 174 "irparser.y"
                        { yylhs.value.as < OP > () = OP::FSUB; }
#line 1514 "irparser.cpp"
    break;

  case 71: // BinaryOp: I_MUL
#line 175 "irparser.y"
                        { yylhs.value.as < OP > () = OP::MUL; }
#line 1520 "irparser.cpp"
    break;

  case 72: // BinaryOp: I_FMUL
#line 176 "irparser.y"
                        { yylhs.value.as < OP > () = OP::FMUL; }
#line 1526 "irparser.cpp"
    break;

  case 73: // BinaryOp: I_DIV
#line 177 "irparser.y"
                        { yylhs.value.as < OP > () = OP::DIV; }
#line 1532 "irparser.cpp"
    break;

  case 74: // BinaryOp: I_FDIV
#line 178 "irparser.y"
                        { yylhs.value.as < OP > () = OP::FDIV; }
#line 1538 "irparser.cpp"
    break;

  case 75: // BinaryOp: I_REM
#line 179 "irparser.y"
                        { yylhs.value.as < OP > () = OP::REM; }
#line 1544 "irparser.cpp"
    break;

  case 76: // BinaryOp: I_FREM
#line 180 "irparser.y"
                        { yylhs.value.as < OP > () = OP::FREM; }
#line 1550 "irparser.cpp"
    break;

  case 77: // FnegInst: I_ID I_EQUAL I_FNEG TypeValue
#line 183 "irparser.y"
                                                { yylhs.value.as < pInst > () = tool.vmake<FNEGInst>(yystack_[3].value.as < std::string > (), yystack_[3].value.as < std::string > (), yystack_[0].value.as < pVal > ()); }
#line 1556 "irparser.cpp"
    break;

  case 78: // CastInst: I_ID I_EQUAL I_FPTOSI Type Value I_TO Type
#line 186 "irparser.y"
                                                            { yylhs.value.as < pInst > () = tool.vmake<FPTOSIInst>(yystack_[6].value.as < std::string > (), yystack_[6].value.as < std::string > (), yystack_[2].value.as < pVal > ()); }
#line 1562 "irparser.cpp"
    break;

  case 79: // CastInst: I_ID I_EQUAL I_SITOFP Type Value I_TO Type
#line 187 "irparser.y"
                                                            { yylhs.value.as < pInst > () = tool.vmake<SITOFPInst>(yystack_[6].value.as < std::string > (), yystack_[6].value.as < std::string > (), yystack_[2].value.as < pVal > ()); }
#line 1568 "irparser.cpp"
    break;

  case 80: // CastInst: I_ID I_EQUAL I_ZEXT TypeValue I_TO Type
#line 188 "irparser.y"
                                                            { yylhs.value.as < pInst > () = tool.vmake<ZEXTInst>(yystack_[5].value.as < std::string > (), yystack_[5].value.as < std::string > (), yystack_[2].value.as < pVal > (), toBType(yystack_[0].value.as < pType > ())->getInner()); }
#line 1574 "irparser.cpp"
    break;

  case 81: // CastInst: I_ID I_EQUAL I_BITCAST TypeValue I_TO Type
#line 189 "irparser.y"
                                                            { yylhs.value.as < pInst > () = tool.vmake<BITCASTInst>(yystack_[5].value.as < std::string > (), yystack_[5].value.as < std::string > (), yystack_[2].value.as < pVal > (), yystack_[0].value.as < pType > ()); }
#line 1580 "irparser.cpp"
    break;

  case 82: // IcmpInst: I_ID I_EQUAL I_ICMP IcmpOp Type Value I_COMMA Value
#line 192 "irparser.y"
                                                                    { yylhs.value.as < pInst > () = tool.vmake<ICMPInst>(yystack_[7].value.as < std::string > (), yystack_[7].value.as < std::string > (), yystack_[4].value.as < ICMPOP > (), yystack_[2].value.as < pVal > (), yystack_[0].value.as < pVal > ()); }
#line 1586 "irparser.cpp"
    break;

  case 83: // IcmpOp: I_EQ
#line 195 "irparser.y"
                { yylhs.value.as < ICMPOP > () = ICMPOP::eq; }
#line 1592 "irparser.cpp"
    break;

  case 84: // IcmpOp: I_NE
#line 196 "irparser.y"
                { yylhs.value.as < ICMPOP > () = ICMPOP::ne; }
#line 1598 "irparser.cpp"
    break;

  case 85: // IcmpOp: I_SGT
#line 197 "irparser.y"
                { yylhs.value.as < ICMPOP > () = ICMPOP::sgt; }
#line 1604 "irparser.cpp"
    break;

  case 86: // IcmpOp: I_SGE
#line 198 "irparser.y"
                { yylhs.value.as < ICMPOP > () = ICMPOP::sge; }
#line 1610 "irparser.cpp"
    break;

  case 87: // IcmpOp: I_SLT
#line 199 "irparser.y"
                { yylhs.value.as < ICMPOP > () = ICMPOP::slt; }
#line 1616 "irparser.cpp"
    break;

  case 88: // IcmpOp: I_SLE
#line 200 "irparser.y"
                { yylhs.value.as < ICMPOP > () = ICMPOP::sle; }
#line 1622 "irparser.cpp"
    break;

  case 89: // FcmpInst: I_ID I_EQUAL I_FCMP FcmpOp Type Value I_COMMA Value
#line 203 "irparser.y"
                                                                    { yylhs.value.as < pInst > () = tool.vmake<FCMPInst>(yystack_[7].value.as < std::string > (), yystack_[7].value.as < std::string > (), yystack_[4].value.as < FCMPOP > (), yystack_[2].value.as < pVal > (), yystack_[0].value.as < pVal > ()); }
#line 1628 "irparser.cpp"
    break;

  case 90: // FcmpOp: I_OEQ
#line 206 "irparser.y"
                { yylhs.value.as < FCMPOP > () = FCMPOP::oeq; }
#line 1634 "irparser.cpp"
    break;

  case 91: // FcmpOp: I_OGT
#line 207 "irparser.y"
                { yylhs.value.as < FCMPOP > () = FCMPOP::ogt; }
#line 1640 "irparser.cpp"
    break;

  case 92: // FcmpOp: I_OGE
#line 208 "irparser.y"
                { yylhs.value.as < FCMPOP > () = FCMPOP::oge; }
#line 1646 "irparser.cpp"
    break;

  case 93: // FcmpOp: I_OLT
#line 209 "irparser.y"
                { yylhs.value.as < FCMPOP > () = FCMPOP::olt; }
#line 1652 "irparser.cpp"
    break;

  case 94: // FcmpOp: I_OLE
#line 210 "irparser.y"
                { yylhs.value.as < FCMPOP > () = FCMPOP::ole; }
#line 1658 "irparser.cpp"
    break;

  case 95: // FcmpOp: I_ONE
#line 211 "irparser.y"
                { yylhs.value.as < FCMPOP > () = FCMPOP::one; }
#line 1664 "irparser.cpp"
    break;

  case 96: // FcmpOp: I_ORD
#line 212 "irparser.y"
                { yylhs.value.as < FCMPOP > () = FCMPOP::ord; }
#line 1670 "irparser.cpp"
    break;

  case 97: // RetInst: I_RET RETType Value
#line 215 "irparser.y"
                                { yylhs.value.as < pInst > () = tool.make<RETInst>(yystack_[0].value.as < pVal > ()); }
#line 1676 "irparser.cpp"
    break;

  case 98: // RetInst: I_RET I_VOID
#line 216 "irparser.y"
                                { yylhs.value.as < pInst > () = tool.make<RETInst>(); }
#line 1682 "irparser.cpp"
    break;

  case 99: // RETType: I_I32
#line 219 "irparser.y"
                    { yylhs.value.as < pType > () = makeBType(IRBTYPE::I32); }
#line 1688 "irparser.cpp"
    break;

  case 100: // RETType: I_FLOAT
#line 220 "irparser.y"
                    { yylhs.value.as < pType > () = makeBType(IRBTYPE::FLOAT); }
#line 1694 "irparser.cpp"
    break;

  case 101: // BrInst: I_BR I_LABEL I_ID
#line 223 "irparser.y"
                                                                    { yylhs.value.as < pInst > () = tool.make<BRInst>(tool.getB(yystack_[0].value.as < std::string > ())); }
#line 1700 "irparser.cpp"
    break;

  case 102: // BrInst: I_BR TypeValue I_COMMA I_LABEL I_ID I_COMMA I_LABEL I_ID
#line 224 "irparser.y"
                                                                    { yylhs.value.as < pInst > () = tool.make<BRInst>(yystack_[6].value.as < pVal > (), tool.getB(yystack_[3].value.as < std::string > ()), tool.getB(yystack_[0].value.as < std::string > ())); }
#line 1706 "irparser.cpp"
    break;

  case 103: // CallInst: I_CALL Type I_ID I_LPAR ArgList I_RPAR
#line 227 "irparser.y"
                                                                            { yylhs.value.as < pInst > () = tool.make<CALLInst>(tool.getF(yystack_[3].value.as < std::string > ()), yystack_[1].value.as < std::vector<pVal> > ()); }
#line 1712 "irparser.cpp"
    break;

  case 104: // CallInst: I_ID I_EQUAL I_CALL Type I_ID I_LPAR ArgList I_RPAR
#line 228 "irparser.y"
                                                                            { yylhs.value.as < pInst > () = tool.vmake<CALLInst>(yystack_[7].value.as < std::string > (), yystack_[7].value.as < std::string > (), tool.getF(yystack_[3].value.as < std::string > ()), yystack_[1].value.as < std::vector<pVal> > ()); }
#line 1718 "irparser.cpp"
    break;

  case 105: // CallInst: I_TAIL I_CALL Type I_ID I_LPAR ArgList I_RPAR
#line 229 "irparser.y"
                                                                            { yylhs.value.as < pInst > () = tool.make<CALLInst>(tool.getF(yystack_[3].value.as < std::string > ()), yystack_[1].value.as < std::vector<pVal> > ()); }
#line 1724 "irparser.cpp"
    break;

  case 106: // CallInst: I_ID I_EQUAL I_TAIL I_CALL Type I_ID I_LPAR ArgList I_RPAR
#line 230 "irparser.y"
                                                                            { yylhs.value.as < pInst > () = tool.vmake<CALLInst>(yystack_[8].value.as < std::string > (), yystack_[8].value.as < std::string > (), tool.getF(yystack_[3].value.as < std::string > ()), yystack_[1].value.as < std::vector<pVal> > ()); }
#line 1730 "irparser.cpp"
    break;

  case 107: // ArgList: ArgList I_COMMA Arg
#line 233 "irparser.y"
                                { yylhs.value.as < std::vector<pVal> > () = yystack_[2].value.as < std::vector<pVal> > (); yylhs.value.as < std::vector<pVal> > ().emplace_back(yystack_[0].value.as < pVal > ()); }
#line 1736 "irparser.cpp"
    break;

  case 108: // ArgList: Arg
#line 234 "irparser.y"
                                { yylhs.value.as < std::vector<pVal> > () = { yystack_[0].value.as < pVal > () }; }
#line 1742 "irparser.cpp"
    break;

  case 109: // ArgList: %empty
#line 235 "irparser.y"
                                { yylhs.value.as < std::vector<pVal> > () = {}; }
#line 1748 "irparser.cpp"
    break;

  case 110: // Arg: I_I1 I_NOUNDEF IRNUM_INT
#line 238 "irparser.y"
                                    { yylhs.value.as < pVal > () = inode.getConst(bool(yystack_[0].value.as < int > ())); }
#line 1754 "irparser.cpp"
    break;

  case 111: // Arg: I_I8 I_NOUNDEF IRNUM_INT
#line 239 "irparser.y"
                                    { yylhs.value.as < pVal > () = inode.getConst(char(yystack_[0].value.as < int > ())); }
#line 1760 "irparser.cpp"
    break;

  case 112: // Arg: I_I32 I_NOUNDEF IRNUM_INT
#line 240 "irparser.y"
                                    { yylhs.value.as < pVal > () = inode.getConst(int(yystack_[0].value.as < int > ())); }
#line 1766 "irparser.cpp"
    break;

  case 113: // Arg: I_FLOAT I_NOUNDEF IRNUM_FLOAT
#line 241 "irparser.y"
                                    { yylhs.value.as < pVal > () = inode.getConst(float(yystack_[0].value.as < float > ())); }
#line 1772 "irparser.cpp"
    break;

  case 114: // Arg: I_I1 I_NOUNDEF I_ID
#line 242 "irparser.y"
                                    { yylhs.value.as < pVal > () = tool.getV(yystack_[0].value.as < std::string > ()); }
#line 1778 "irparser.cpp"
    break;

  case 115: // Arg: I_I8 I_NOUNDEF I_ID
#line 243 "irparser.y"
                                    { yylhs.value.as < pVal > () = tool.getV(yystack_[0].value.as < std::string > ()); }
#line 1784 "irparser.cpp"
    break;

  case 116: // Arg: I_I32 I_NOUNDEF I_ID
#line 244 "irparser.y"
                                    { yylhs.value.as < pVal > () = tool.getV(yystack_[0].value.as < std::string > ()); }
#line 1790 "irparser.cpp"
    break;

  case 117: // Arg: I_FLOAT I_NOUNDEF I_ID
#line 245 "irparser.y"
                                    { yylhs.value.as < pVal > () = tool.getV(yystack_[0].value.as < std::string > ()); }
#line 1796 "irparser.cpp"
    break;

  case 118: // Arg: PtrType I_NOUNDEF I_ID
#line 246 "irparser.y"
                                    { yylhs.value.as < pVal > () = tool.getV(yystack_[0].value.as < std::string > ()); }
#line 1802 "irparser.cpp"
    break;

  case 119: // Arg: ArrayType I_NOUNDEF I_ID
#line 247 "irparser.y"
                                    { yylhs.value.as < pVal > () = tool.getV(yystack_[0].value.as < std::string > ()); }
#line 1808 "irparser.cpp"
    break;

  case 120: // AllocaInst: I_ID I_EQUAL I_ALLOCA Type I_COMMA I_ALIGN IRNUM_INT
#line 250 "irparser.y"
                                                                    { yylhs.value.as < pInst > () = tool.vmake<ALLOCAInst>(yystack_[6].value.as < std::string > (), yystack_[6].value.as < std::string > (), yystack_[3].value.as < pType > (), yystack_[0].value.as < int > ()); }
#line 1814 "irparser.cpp"
    break;

  case 121: // LoadInst: I_ID I_EQUAL I_LOAD Type I_COMMA TypeValue I_COMMA I_ALIGN IRNUM_INT
#line 253 "irparser.y"
                                                                                    { yylhs.value.as < pInst > () = tool.vmake<LOADInst>(yystack_[8].value.as < std::string > (), yystack_[8].value.as < std::string > (), yystack_[3].value.as < pVal > (), yystack_[0].value.as < int > ()); }
#line 1820 "irparser.cpp"
    break;

  case 122: // StoreInst: I_STORE TypeValue I_COMMA TypeValue I_COMMA I_ALIGN IRNUM_INT
#line 256 "irparser.y"
                                                                            { yylhs.value.as < pInst > () = tool.make<STOREInst>(yystack_[5].value.as < pVal > (), yystack_[3].value.as < pVal > (), yystack_[0].value.as < int > ()); }
#line 1826 "irparser.cpp"
    break;

  case 123: // GepInst: I_ID I_EQUAL I_GEP Type I_COMMA TypeValue IndexList
#line 259 "irparser.y"
                                                                { yylhs.value.as < pInst > () = tool.vmake<GEPInst>(yystack_[6].value.as < std::string > (), yystack_[6].value.as < std::string > (), yystack_[1].value.as < pVal > (), yystack_[0].value.as < std::vector<pVal> > ()); }
#line 1832 "irparser.cpp"
    break;

  case 124: // IndexList: I_COMMA Type Value
#line 262 "irparser.y"
                                            { yylhs.value.as < std::vector<pVal> > () = { yystack_[0].value.as < pVal > () }; }
#line 1838 "irparser.cpp"
    break;

  case 125: // IndexList: IndexList I_COMMA Type Value
#line 263 "irparser.y"
                                            { yylhs.value.as < std::vector<pVal> > () = yystack_[3].value.as < std::vector<pVal> > (); yylhs.value.as < std::vector<pVal> > ().emplace_back(yystack_[0].value.as < pVal > ()); }
#line 1844 "irparser.cpp"
    break;

  case 126: // PhiInst: I_ID I_EQUAL I_PHI Type PhiOpers
#line 266 "irparser.y"
                                            { yylhs.value.as < pInst > () = tool.newPhi(yystack_[4].value.as < std::string > (), yystack_[1].value.as < pType > (), yystack_[0].value.as < std::vector<std::pair<pVal, pBlock>> > ()); }
#line 1850 "irparser.cpp"
    break;

  case 127: // PhiOpers: PhiOper
#line 269 "irparser.y"
                                        { yylhs.value.as < std::vector<std::pair<pVal, pBlock>> > () = { yystack_[0].value.as < std::pair<pVal, pBlock> > () }; }
#line 1856 "irparser.cpp"
    break;

  case 128: // PhiOpers: PhiOpers I_COMMA PhiOper
#line 270 "irparser.y"
                                        { yylhs.value.as < std::vector<std::pair<pVal, pBlock>> > () = yystack_[2].value.as < std::vector<std::pair<pVal, pBlock>> > (); yylhs.value.as < std::vector<std::pair<pVal, pBlock>> > ().emplace_back(yystack_[0].value.as < std::pair<pVal, pBlock> > ()); }
#line 1862 "irparser.cpp"
    break;

  case 129: // PhiOper: I_LSQUARE Value I_COMMA I_ID I_RSQUARE
#line 273 "irparser.y"
                                                    { yylhs.value.as < std::pair<pVal, pBlock> > () = std::make_pair(yystack_[3].value.as < pVal > (), tool.getB(yystack_[1].value.as < std::string > ())); }
#line 1868 "irparser.cpp"
    break;


#line 1872 "irparser.cpp"

            default:
              break;
            }
        }
#if YY_EXCEPTIONS
      catch (const syntax_error& yyexc)
        {
          YYCDEBUG << "Caught exception: " << yyexc.what() << '\n';
          error (yyexc);
          YYERROR;
        }
#endif // YY_EXCEPTIONS
      YY_SYMBOL_PRINT ("-> $$ =", yylhs);
      yypop_ (yylen);
      yylen = 0;

      // Shift the result of the reduction.
      yypush_ (YY_NULLPTR, YY_MOVE (yylhs));
    }
    goto yynewstate;


  /*--------------------------------------.
  | yyerrlab -- here on detecting error.  |
  `--------------------------------------*/
  yyerrlab:
    // If not already recovering from an error, report this error.
    if (!yyerrstatus_)
      {
        ++yynerrs_;
        std::string msg = YY_("syntax error");
        error (YY_MOVE (msg));
      }


    if (yyerrstatus_ == 3)
      {
        /* If just tried and failed to reuse lookahead token after an
           error, discard it.  */

        // Return failure if at end of input.
        if (yyla.kind () == symbol_kind::S_YYEOF)
          YYABORT;
        else if (!yyla.empty ())
          {
            yy_destroy_ ("Error: discarding", yyla);
            yyla.clear ();
          }
      }

    // Else will try to reuse lookahead token after shifting the error token.
    goto yyerrlab1;


  /*---------------------------------------------------.
  | yyerrorlab -- error raised explicitly by YYERROR.  |
  `---------------------------------------------------*/
  yyerrorlab:
    /* Pacify compilers when the user code never invokes YYERROR and
       the label yyerrorlab therefore never appears in user code.  */
    if (false)
      YYERROR;

    /* Do not reclaim the symbols of the rule whose action triggered
       this YYERROR.  */
    yypop_ (yylen);
    yylen = 0;
    YY_STACK_PRINT ();
    goto yyerrlab1;


  /*-------------------------------------------------------------.
  | yyerrlab1 -- common code for both syntax error and YYERROR.  |
  `-------------------------------------------------------------*/
  yyerrlab1:
    yyerrstatus_ = 3;   // Each real token shifted decrements this.
    // Pop stack until we find a state that shifts the error token.
    for (;;)
      {
        yyn = yypact_[+yystack_[0].state];
        if (!yy_pact_value_is_default_ (yyn))
          {
            yyn += symbol_kind::S_YYerror;
            if (0 <= yyn && yyn <= yylast_
                && yycheck_[yyn] == symbol_kind::S_YYerror)
              {
                yyn = yytable_[yyn];
                if (0 < yyn)
                  break;
              }
          }

        // Pop the current state because it cannot handle the error token.
        if (yystack_.size () == 1)
          YYABORT;

        yy_destroy_ ("Error: popping", yystack_[0]);
        yypop_ ();
        YY_STACK_PRINT ();
      }
    {
      stack_symbol_type error_token;


      // Shift the error token.
      error_token.state = state_type (yyn);
      yypush_ ("Shifting", YY_MOVE (error_token));
    }
    goto yynewstate;


  /*-------------------------------------.
  | yyacceptlab -- YYACCEPT comes here.  |
  `-------------------------------------*/
  yyacceptlab:
    yyresult = 0;
    goto yyreturn;


  /*-----------------------------------.
  | yyabortlab -- YYABORT comes here.  |
  `-----------------------------------*/
  yyabortlab:
    yyresult = 1;
    goto yyreturn;


  /*-----------------------------------------------------.
  | yyreturn -- parsing is finished, return the result.  |
  `-----------------------------------------------------*/
  yyreturn:
    if (!yyla.empty ())
      yy_destroy_ ("Cleanup: discarding lookahead", yyla);

    /* Do not reclaim the symbols of the rule whose action triggered
       this YYABORT or YYACCEPT.  */
    yypop_ (yylen);
    YY_STACK_PRINT ();
    while (1 < yystack_.size ())
      {
        yy_destroy_ ("Cleanup: popping", yystack_[0]);
        yypop_ ();
      }

    return yyresult;
  }
#if YY_EXCEPTIONS
    catch (...)
      {
        YYCDEBUG << "Exception caught: cleaning lookahead and stack\n";
        // Do not try to display the values of the reclaimed symbols,
        // as their printers might throw an exception.
        if (!yyla.empty ())
          yy_destroy_ (YY_NULLPTR, yyla);

        while (1 < yystack_.size ())
          {
            yy_destroy_ (YY_NULLPTR, yystack_[0]);
            yypop_ ();
          }
        throw;
      }
#endif // YY_EXCEPTIONS
  }

  void
  parser::error (const syntax_error& yyexc)
  {
    error (yyexc.what ());
  }

#if YYDEBUG || 0
  const char *
  parser::symbol_name (symbol_kind_type yysymbol)
  {
    return yytname_[yysymbol];
  }
#endif // #if YYDEBUG || 0









  const short parser::yypact_ninf_ = -200;

  const signed char parser::yytable_ninf_ = -1;

  const short
  parser::yypact_[] =
  {
     -14,   -11,   122,     9,    93,   -14,  -200,  -200,  -200,   122,
    -200,  -200,  -200,  -200,  -200,    16,   -47,  -200,  -200,  -200,
      76,  -200,  -200,  -200,  -200,   -46,    45,  -200,    59,   132,
      79,   122,    56,  -200,  -200,   122,    72,   -45,    55,  -200,
     -30,    68,  -200,    29,    62,   109,   -18,    69,  -200,  -200,
    -200,  -200,  -200,   106,  -200,   122,  -200,  -200,  -200,   145,
     113,    63,   130,   122,    94,  -200,  -200,   119,   123,     6,
     -29,  -200,  -200,   113,  -200,  -200,  -200,   122,  -200,     7,
      28,   136,   122,   167,   128,     6,  -200,  -200,  -200,  -200,
    -200,  -200,  -200,  -200,  -200,  -200,  -200,  -200,  -200,  -200,
    -200,  -200,    25,  -200,  -200,  -200,  -200,    98,   129,   131,
     146,   148,   127,   -43,   133,   154,   -38,   122,   265,  -200,
    -200,  -200,  -200,  -200,  -200,  -200,  -200,  -200,  -200,  -200,
     184,   136,   162,   -27,   136,  -200,  -200,  -200,  -200,  -200,
    -200,  -200,  -200,  -200,  -200,   122,   122,   122,   122,   122,
     136,   136,   190,   165,   122,   122,   196,   122,   156,   159,
     153,   175,  -200,    -9,     0,     2,    33,    33,   199,   200,
    -200,  -200,  -200,  -200,  -200,  -200,   122,  -200,  -200,  -200,
    -200,  -200,  -200,  -200,   122,     8,   -20,   122,    33,   172,
     206,   207,   208,   209,   210,   189,   212,   213,    71,  -200,
     153,   215,   136,   136,   203,   214,   122,   122,    33,    33,
      98,   183,  -200,   192,    -1,   188,   220,   180,    70,    78,
     111,    27,   191,   193,  -200,   153,    86,   186,   194,   197,
     122,   122,   189,   189,   198,   217,   227,   201,   153,   219,
      98,   226,  -200,  -200,  -200,  -200,  -200,  -200,  -200,  -200,
    -200,  -200,  -200,  -200,  -200,  -200,   224,   122,   229,   189,
     189,    98,    98,   228,  -200,    88,   153,  -200,  -200,   230,
      33,   122,  -200,  -200,   232,  -200,   101,  -200,  -200,    33,
    -200,  -200,  -200
  };

  const unsigned char
  parser::yydefact_[] =
  {
       0,     0,     0,     0,     0,     2,     6,     8,     7,     0,
      15,    16,    17,    18,    19,     0,     0,    12,    13,    14,
       0,     1,     3,     5,     4,     0,     0,    20,     0,     0,
       0,     0,     0,    11,    10,     0,     0,     0,     0,    31,
       0,     0,    34,     0,     0,     0,     0,     0,    37,    21,
      32,    35,    29,     0,    24,     0,    22,    23,    26,     0,
       0,     0,     0,     0,     0,    33,    27,     0,     0,     0,
       0,    41,    38,     0,    36,    30,    25,     0,     9,     0,
       0,     0,     0,     0,     0,    43,    44,    46,    48,    47,
      49,    50,    51,    52,    53,    54,    55,    56,    57,    58,
      40,    42,     0,    28,    99,   100,    98,     0,     0,    15,
      16,    17,    18,     0,     0,     0,     0,     0,     0,    45,
      39,    65,    66,    97,   101,    61,    62,    63,    64,    60,
       0,     0,     0,     0,     0,    67,    68,    69,    70,    71,
      72,    73,    74,    75,    76,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     109,     0,    77,     0,     0,     0,     0,     0,     0,     0,
      83,    84,    85,    86,    87,    88,     0,    90,    91,    92,
      93,    94,    95,    96,     0,     0,     0,     0,     0,     0,
       0,    15,    16,    17,    18,     0,    13,    14,     0,   108,
     109,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,   126,   127,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,   103,     0,     0,     0,     0,     0,
       0,     0,    80,    81,     0,     0,     0,     0,   109,     0,
       0,     0,   122,   114,   110,   115,   111,   116,   112,   117,
     113,   118,   119,   107,   105,   120,     0,     0,   123,    78,
      79,     0,     0,     0,   128,     0,   109,    59,   102,     0,
       0,     0,    82,    89,     0,   104,     0,   121,   124,     0,
     129,   106,   125
  };

  const short
  parser::yypgoto_[] =
  {
    -200,  -200,  -200,   255,  -200,    -2,  -200,  -152,  -146,   225,
     -36,  -200,   277,  -200,   247,  -200,   238,   299,   233,   -65,
    -200,   222,  -200,   -79,  -163,  -200,  -200,  -200,  -200,  -200,
    -200,  -200,  -200,  -200,  -200,  -200,  -199,    80,  -200,  -200,
    -200,  -200,  -200,  -200,  -200,    73
  };

  const short
  parser::yydefgoto_[] =
  {
       0,     4,     5,     6,    35,   113,    17,    18,    19,   122,
      44,    67,     7,    41,    42,    47,    48,     8,    70,    71,
      85,    86,    87,   114,   123,   157,    88,    89,    90,   176,
      91,   184,    92,   107,    93,    94,   198,   199,    95,    96,
      97,    98,   258,    99,   211,   212
  };

  const short
  parser::yytable_[] =
  {
      16,   226,   115,   204,   205,   101,    51,    25,   196,    79,
      80,    27,    27,    27,   197,    27,     1,     2,    61,    66,
      27,     9,    49,    28,    30,   215,    81,   129,    27,    37,
      40,    27,   132,    43,    46,    82,   100,   101,    27,   265,
      27,   103,    69,   161,    83,   234,   235,   236,   196,    27,
     213,    40,   159,    43,   197,   162,     3,    27,    27,   201,
      27,    46,   104,   105,   106,   108,    27,   276,   202,   239,
     203,   168,   169,   196,   210,    43,    84,   267,    20,   197,
     116,   109,   110,   111,   112,    14,   196,    27,    26,    54,
     120,    27,   197,    21,    15,    55,    69,   249,   272,   273,
     250,    56,    57,   121,    31,    56,    57,   278,    29,    10,
      11,    12,    13,    14,   196,   133,   282,    38,    50,    39,
     197,    32,    15,   228,   229,    10,    11,    12,    13,    14,
      59,    52,    62,    72,   224,    45,    53,    63,    15,   225,
     243,    36,   244,   163,   164,   165,   166,   167,   245,   254,
     246,   275,   185,   186,   225,   188,   225,    75,   195,    10,
      11,    12,    13,    14,   281,    33,    34,    64,   121,   225,
      56,    57,    15,    60,   208,    10,    11,    12,    13,    14,
      68,   247,   209,   248,    69,   214,    76,    77,    15,   109,
     110,   111,   112,    14,    73,    78,   117,   118,   195,   124,
     128,   130,    15,   125,   232,   233,   191,   192,   193,   194,
      14,   177,   178,   179,   180,   181,   182,   183,   126,    15,
     127,   158,   131,   195,   160,   187,   189,   190,   259,   260,
     170,   171,   172,   173,   174,   175,   195,   200,   206,   207,
     216,   217,   230,   218,   219,   220,   221,    27,   222,   223,
     227,   237,   242,   231,   238,   270,   240,   241,   255,   269,
      22,   251,   256,   252,   195,   257,   261,   210,    58,   279,
     134,   135,   136,   137,   138,   139,   140,   141,   142,   143,
     144,   266,    23,   145,   146,   262,   147,   148,   149,   150,
     151,   152,   153,   154,   155,   263,   268,   271,   274,   280,
      65,    74,   277,   156,    24,   253,   102,   119,     0,     0,
     264
  };

  const short
  parser::yycheck_[] =
  {
       2,   200,    81,   166,   167,    70,    36,     9,   160,     3,
       4,    58,    58,    58,   160,    58,    30,    31,    36,    55,
      58,    32,    67,    70,    70,   188,    20,    70,    58,    31,
      32,    58,    70,    35,    36,    29,    65,   102,    58,   238,
      58,    77,    71,    70,    38,   208,   209,   210,   200,    58,
      70,    53,   131,    55,   200,   134,    70,    58,    58,    68,
      58,    63,    55,    56,    57,    37,    58,   266,    68,    70,
      68,   150,   151,   225,    66,    77,    70,   240,    69,   225,
      82,    53,    54,    55,    56,    57,   238,    58,    72,    60,
      65,    58,   238,     0,    66,    66,    71,    70,   261,   262,
      73,    72,    73,    70,    59,    72,    73,   270,    32,    53,
      54,    55,    56,    57,   266,   117,   279,    61,    63,    63,
     266,    62,    66,   202,   203,    53,    54,    55,    56,    57,
      68,    63,    63,    70,    63,    63,    68,    68,    66,    68,
      70,    62,    72,   145,   146,   147,   148,   149,    70,    63,
      72,    63,   154,   155,    68,   157,    68,    63,   160,    53,
      54,    55,    56,    57,    63,    33,    34,    61,    70,    68,
      72,    73,    66,    64,   176,    53,    54,    55,    56,    57,
      35,    70,   184,    72,    71,   187,    67,    68,    66,    53,
      54,    55,    56,    57,    64,    72,    29,    69,   200,    70,
      73,    68,    66,    72,   206,   207,    53,    54,    55,    56,
      57,    46,    47,    48,    49,    50,    51,    52,    72,    66,
      72,    37,    68,   225,    62,    29,    70,    68,   230,   231,
      40,    41,    42,    43,    44,    45,   238,    62,    39,    39,
      68,    35,    39,    36,    36,    36,    36,    58,    36,    36,
      35,    68,    72,    39,    62,   257,    68,    37,    72,    35,
       5,    70,    68,    70,   266,    68,    68,    66,    43,   271,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    62,     5,    18,    19,    68,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    68,    70,    68,    70,    67,
      53,    63,    72,    38,     5,   225,    73,    85,    -1,    -1,
     237
  };

  const signed char
  parser::yystos_[] =
  {
       0,    30,    31,    70,    75,    76,    77,    86,    91,    32,
      53,    54,    55,    56,    57,    66,    79,    80,    81,    82,
      69,     0,    77,    86,    91,    79,    72,    58,    70,    32,
      70,    59,    62,    33,    34,    78,    62,    79,    61,    63,
      79,    87,    88,    79,    84,    63,    79,    89,    90,    67,
      63,    36,    63,    68,    60,    66,    72,    73,    83,    68,
      64,    36,    63,    68,    61,    88,    84,    85,    35,    71,
      92,    93,    70,    64,    90,    63,    67,    68,    72,     3,
       4,    20,    29,    38,    70,    94,    95,    96,   100,   101,
     102,   104,   106,   108,   109,   112,   113,   114,   115,   117,
      65,    93,    92,    84,    55,    56,    57,   107,    37,    53,
      54,    55,    56,    79,    97,    97,    79,    29,    69,    95,
      65,    70,    83,    98,    70,    72,    72,    72,    73,    70,
      68,    68,    70,    79,     5,     6,     7,     8,     9,    10,
      11,    12,    13,    14,    15,    18,    19,    21,    22,    23,
      24,    25,    26,    27,    28,    29,    38,    99,    37,    97,
      62,    70,    97,    79,    79,    79,    79,    79,    97,    97,
      40,    41,    42,    43,    44,    45,   103,    46,    47,    48,
      49,    50,    51,    52,   105,    79,    79,    29,    79,    70,
      68,    53,    54,    55,    56,    79,    81,    82,   110,   111,
      62,    68,    68,    68,    98,    98,    39,    39,    79,    79,
      66,   118,   119,    70,    79,    98,    68,    35,    36,    36,
      36,    36,    36,    36,    63,    68,   110,    35,    97,    97,
      39,    39,    79,    79,    98,    98,    98,    68,    62,    70,
      68,    37,    72,    70,    72,    70,    72,    70,    72,    70,
      73,    70,    70,   111,    63,    72,    68,    68,   116,    79,
      79,    68,    68,    68,   119,   110,    62,    98,    70,    35,
      79,    68,    98,    98,    70,    63,   110,    72,    98,    79,
      67,    63,    98
  };

  const signed char
  parser::yyr1_[] =
  {
       0,    74,    75,    76,    76,    76,    76,    76,    76,    77,
      78,    78,    79,    79,    79,    80,    80,    80,    80,    80,
      81,    82,    83,    83,    84,    84,    84,    85,    85,    86,
      86,    86,    86,    87,    87,    88,    89,    89,    90,    91,
      91,    92,    92,    93,    94,    94,    95,    95,    95,    95,
      95,    95,    95,    95,    95,    95,    95,    95,    95,    96,
      97,    97,    97,    97,    97,    98,    98,    99,    99,    99,
      99,    99,    99,    99,    99,    99,    99,   100,   101,   101,
     101,   101,   102,   103,   103,   103,   103,   103,   103,   104,
     105,   105,   105,   105,   105,   105,   105,   106,   106,   107,
     107,   108,   108,   109,   109,   109,   109,   110,   110,   110,
     111,   111,   111,   111,   111,   111,   111,   111,   111,   111,
     112,   113,   114,   115,   116,   116,   117,   118,   118,   119
  };

  const signed char
  parser::yyr2_[] =
  {
       0,     2,     1,     2,     2,     2,     1,     1,     1,     8,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       2,     5,     1,     1,     2,     4,     2,     1,     3,     6,
       8,     5,     6,     3,     1,     2,     3,     1,     3,    10,
       9,     1,     2,     2,     1,     2,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     7,
       2,     2,     2,     2,     2,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     4,     7,     7,
       6,     6,     8,     1,     1,     1,     1,     1,     1,     8,
       1,     1,     1,     1,     1,     1,     1,     3,     2,     1,
       1,     3,     8,     6,     8,     7,     9,     3,     1,     0,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       7,     9,     7,     7,     3,     4,     5,     1,     3,     5
  };


#if YYDEBUG
  // YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
  // First, the terminals, then, starting at \a YYNTOKENS, nonterminals.
  const char*
  const parser::yytname_[] =
  {
  "\"end of file\"", "error", "\"invalid token\"", "I_RET", "I_BR",
  "I_FNEG", "I_ADD", "I_FADD", "I_SUB", "I_FSUB", "I_MUL", "I_FMUL",
  "I_DIV", "I_FDIV", "I_REM", "I_FREM", "I_AND", "I_OR", "I_ALLOCA",
  "I_LOAD", "I_STORE", "I_GEP", "I_FPTOSI", "I_SITOFP", "I_ZEXT",
  "I_BITCAST", "I_ICMP", "I_FCMP", "I_PHI", "I_CALL", "I_DEFINE",
  "I_DECLARE", "I_DSO_LOCAL", "I_GLOBAL", "I_CONSTANT", "I_ALIGN",
  "I_NOUNDEF", "I_LABEL", "I_TAIL", "I_TO", "I_EQ", "I_NE", "I_SGT",
  "I_SGE", "I_SLT", "I_SLE", "I_OEQ", "I_OGT", "I_OGE", "I_OLT", "I_OLE",
  "I_ONE", "I_ORD", "I_I1", "I_I8", "I_I32", "I_FLOAT", "I_VOID", "I_STAR",
  "I_X", "I_ZEROINITER", "I_DOTDOTDOT", "I_LPAR", "I_RPAR", "I_LBRACKET",
  "I_RBRACKET", "I_LSQUARE", "I_RSQUARE", "I_COMMA", "I_EQUAL", "I_ID",
  "I_BLKID", "IRNUM_INT", "IRNUM_FLOAT", "$accept", "Module",
  "GlobalEntities", "GlobalVariable", "Storage", "Type", "BType",
  "PtrType", "ArrayType", "Constant", "GVIniter", "GVIniters",
  "FunctionDeclaration", "DeclParamList", "DeclParam", "DefParamList",
  "DefParam", "FunctionDefinition", "BBList", "BB", "InstList", "Inst",
  "BinaryInst", "TypeValue", "Value", "BinaryOp", "FnegInst", "CastInst",
  "IcmpInst", "IcmpOp", "FcmpInst", "FcmpOp", "RetInst", "RETType",
  "BrInst", "CallInst", "ArgList", "Arg", "AllocaInst", "LoadInst",
  "StoreInst", "GepInst", "IndexList", "PhiInst", "PhiOpers", "PhiOper", YY_NULLPTR
  };
#endif


#if YYDEBUG
  const short
  parser::yyrline_[] =
  {
       0,    58,    58,    61,    62,    63,    64,    65,    66,    69,
      72,    73,    76,    77,    78,    81,    82,    83,    84,    85,
      88,    91,    94,    95,    98,    99,   100,   103,   104,   107,
     108,   109,   110,   113,   114,   117,   120,   121,   124,   127,
     128,   131,   132,   135,   138,   139,   142,   143,   144,   145,
     146,   147,   148,   149,   150,   151,   152,   153,   154,   157,
     160,   161,   162,   163,   164,   167,   168,   171,   172,   173,
     174,   175,   176,   177,   178,   179,   180,   183,   186,   187,
     188,   189,   192,   195,   196,   197,   198,   199,   200,   203,
     206,   207,   208,   209,   210,   211,   212,   215,   216,   219,
     220,   223,   224,   227,   228,   229,   230,   233,   234,   235,
     238,   239,   240,   241,   242,   243,   244,   245,   246,   247,
     250,   253,   256,   259,   262,   263,   266,   269,   270,   273
  };

  void
  parser::yy_stack_print_ () const
  {
    *yycdebug_ << "Stack now";
    for (stack_type::const_iterator
           i = yystack_.begin (),
           i_end = yystack_.end ();
         i != i_end; ++i)
      *yycdebug_ << ' ' << int (i->state);
    *yycdebug_ << '\n';
  }

  void
  parser::yy_reduce_print_ (int yyrule) const
  {
    int yylno = yyrline_[yyrule];
    int yynrhs = yyr2_[yyrule];
    // Print the symbols being reduced, and their result.
    *yycdebug_ << "Reducing stack by rule " << yyrule - 1
               << " (line " << yylno << "):\n";
    // The symbols being reduced.
    for (int yyi = 0; yyi < yynrhs; yyi++)
      YY_SYMBOL_PRINT ("   $" << yyi + 1 << " =",
                       yystack_[(yynrhs) - (yyi + 1)]);
  }
#endif // YYDEBUG


#line 22 "irparser.y"
} // yyy
#line 2377 "irparser.cpp"

#line 276 "irparser.y"


/* void setFileName(const char *name) {
  strcpy(filename, name);
  freopen(filename, "r", stdin);
} */

void
yyy::parser::error (const std::string& msg) { 
      std::cerr << "Error: " << msg << std::endl; 
}
#endif