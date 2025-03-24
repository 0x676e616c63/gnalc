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
#line 57 "irparser.y"
                         {}
#line 1101 "irparser.cpp"
    break;

  case 3: // GlobalEntities: GlobalEntities GlobalVariable
#line 60 "irparser.y"
                                                        { inode.addGlobalVar(yystack_[0].value.as < pGlobalVar > ()); }
#line 1107 "irparser.cpp"
    break;

  case 4: // GlobalEntities: GlobalEntities FunctionDefinition
#line 61 "irparser.y"
                                                        { inode.addFunction(yystack_[0].value.as < pFunc > ()); }
#line 1113 "irparser.cpp"
    break;

  case 5: // GlobalEntities: GlobalEntities FunctionDeclaration
#line 62 "irparser.y"
                                                        { inode.addFunctionDecl(yystack_[0].value.as < pFuncDecl > ()); }
#line 1119 "irparser.cpp"
    break;

  case 6: // GlobalEntities: GlobalVariable
#line 63 "irparser.y"
                                                        { inode.addGlobalVar(yystack_[0].value.as < pGlobalVar > ()); }
#line 1125 "irparser.cpp"
    break;

  case 7: // GlobalEntities: FunctionDefinition
#line 64 "irparser.y"
                                                        { inode.addFunction(yystack_[0].value.as < pFunc > ()); }
#line 1131 "irparser.cpp"
    break;

  case 8: // GlobalEntities: FunctionDeclaration
#line 65 "irparser.y"
                                                        { inode.addFunctionDecl(yystack_[0].value.as < pFuncDecl > ()); }
#line 1137 "irparser.cpp"
    break;

  case 9: // GlobalVariable: I_ID I_EQUAL I_DSO_LOCAL Storage GVIniter I_COMMA I_ALIGN IRNUM_INT
#line 68 "irparser.y"
                                                                                        { yylhs.value.as < pGlobalVar > () = tool.newGV(yystack_[4].value.as < STOCLASS > (), yystack_[3].value.as < GVIniter > ().getIniterType(), yystack_[7].value.as < std::string > (), yystack_[3].value.as < GVIniter > (), yystack_[0].value.as < int > ()); }
#line 1143 "irparser.cpp"
    break;

  case 10: // Storage: I_CONSTANT
#line 71 "irparser.y"
                        { yylhs.value.as < STOCLASS > () = STOCLASS::CONSTANT; }
#line 1149 "irparser.cpp"
    break;

  case 11: // Storage: I_GLOBAL
#line 72 "irparser.y"
                        { yylhs.value.as < STOCLASS > () = STOCLASS::GLOBAL; }
#line 1155 "irparser.cpp"
    break;

  case 12: // Type: BType
#line 75 "irparser.y"
                    { yylhs.value.as < pType > () = yystack_[0].value.as < pType > (); }
#line 1161 "irparser.cpp"
    break;

  case 13: // Type: PtrType
#line 76 "irparser.y"
                    { yylhs.value.as < pType > () = yystack_[0].value.as < pType > (); }
#line 1167 "irparser.cpp"
    break;

  case 14: // Type: ArrayType
#line 77 "irparser.y"
                    { yylhs.value.as < pType > () = yystack_[0].value.as < pType > (); }
#line 1173 "irparser.cpp"
    break;

  case 15: // BType: I_I1
#line 80 "irparser.y"
                    { yylhs.value.as < pType > () = makeBType(IRBTYPE::I1); }
#line 1179 "irparser.cpp"
    break;

  case 16: // BType: I_I8
#line 81 "irparser.y"
                    { yylhs.value.as < pType > () = makeBType(IRBTYPE::I8); }
#line 1185 "irparser.cpp"
    break;

  case 17: // BType: I_I32
#line 82 "irparser.y"
                    { yylhs.value.as < pType > () = makeBType(IRBTYPE::I32); }
#line 1191 "irparser.cpp"
    break;

  case 18: // BType: I_FLOAT
#line 83 "irparser.y"
                    { yylhs.value.as < pType > () = makeBType(IRBTYPE::FLOAT); }
#line 1197 "irparser.cpp"
    break;

  case 19: // BType: I_VOID
#line 84 "irparser.y"
                    { yylhs.value.as < pType > () = makeBType(IRBTYPE::VOID); }
#line 1203 "irparser.cpp"
    break;

  case 20: // PtrType: Type I_STAR
#line 87 "irparser.y"
                        { yylhs.value.as < pType > () = makePtrType(yystack_[1].value.as < pType > ()); }
#line 1209 "irparser.cpp"
    break;

  case 21: // ArrayType: I_LSQUARE IRNUM_INT I_X Type I_RBRACKET
#line 90 "irparser.y"
                                                        { yylhs.value.as < pType > () = makeArrayType(yystack_[1].value.as < pType > (), yystack_[3].value.as < int > ()); }
#line 1215 "irparser.cpp"
    break;

  case 22: // Constant: IRNUM_INT
#line 93 "irparser.y"
                            { yylhs.value.as < pVal > () = inode.getConst(yystack_[0].value.as < int > ()); }
#line 1221 "irparser.cpp"
    break;

  case 23: // Constant: IRNUM_FLOAT
#line 94 "irparser.y"
                            { yylhs.value.as < pVal > () = inode.getConst(yystack_[0].value.as < float > ()); }
#line 1227 "irparser.cpp"
    break;

  case 24: // GVIniter: Type I_ZEROINITER
#line 97 "irparser.y"
                                                    { yylhs.value.as < GVIniter > () = GVIniter(yystack_[1].value.as < pType > ()); }
#line 1233 "irparser.cpp"
    break;

  case 25: // GVIniter: Type I_LSQUARE GVIniters I_RSQUARE
#line 98 "irparser.y"
                                                    { yylhs.value.as < GVIniter > () = GVIniter(yystack_[3].value.as < pType > (), yystack_[1].value.as < std::vector<GVIniter> > ()); }
#line 1239 "irparser.cpp"
    break;

  case 26: // GVIniter: Type Constant
#line 99 "irparser.y"
                                                    { yylhs.value.as < GVIniter > () = GVIniter(yystack_[1].value.as < pType > (), yystack_[0].value.as < pVal > ()); }
#line 1245 "irparser.cpp"
    break;

  case 27: // GVIniters: GVIniter
#line 102 "irparser.y"
                                            { yylhs.value.as < std::vector<GVIniter> > () = { yystack_[0].value.as < GVIniter > () }; }
#line 1251 "irparser.cpp"
    break;

  case 28: // GVIniters: GVIniters I_COMMA GVIniter
#line 103 "irparser.y"
                                            { yylhs.value.as < std::vector<GVIniter> > () = yystack_[2].value.as < std::vector<GVIniter> > (); yylhs.value.as < std::vector<GVIniter> > ().emplace_back(yystack_[0].value.as < GVIniter > ()); }
#line 1257 "irparser.cpp"
    break;

  case 29: // FunctionDeclaration: I_DECLARE Type I_ID I_LPAR DeclParamList I_RPAR
#line 106 "irparser.y"
                                                                                    { yylhs.value.as < pFuncDecl > () = tool.newFuncDecl(yystack_[3].value.as < std::string > (), yystack_[1].value.as < std::vector<pType> > (), yystack_[4].value.as < pType > ()); }
#line 1263 "irparser.cpp"
    break;

  case 30: // FunctionDeclaration: I_DECLARE Type I_ID I_LPAR DeclParamList I_DOTDOTDOT I_RPAR
#line 107 "irparser.y"
                                                                                    { yylhs.value.as < pFuncDecl > () = tool.newFuncDecl(yystack_[4].value.as < std::string > (), yystack_[2].value.as < std::vector<pType> > (), yystack_[5].value.as < pType > (), true); }
#line 1269 "irparser.cpp"
    break;

  case 31: // FunctionDeclaration: I_DECLARE Type I_ID I_LPAR I_RPAR
#line 108 "irparser.y"
                                                                                    { yylhs.value.as < pFuncDecl > () = tool.newFuncDecl(yystack_[2].value.as < std::string > (), {}, yystack_[3].value.as < pType > ()); }
#line 1275 "irparser.cpp"
    break;

  case 32: // FunctionDeclaration: I_DECLARE Type I_ID I_LPAR I_DOTDOTDOT I_RPAR
#line 109 "irparser.y"
                                                                                    { yylhs.value.as < pFuncDecl > () = tool.newFuncDecl(yystack_[3].value.as < std::string > (), {}, yystack_[4].value.as < pType > (), true); }
#line 1281 "irparser.cpp"
    break;

  case 33: // DeclParamList: DeclParamList I_COMMA DeclParam
#line 112 "irparser.y"
                                                    { yylhs.value.as < std::vector<pType> > () = yystack_[2].value.as < std::vector<pType> > (); yylhs.value.as < std::vector<pType> > ().emplace_back(yystack_[0].value.as < pType > ()); }
#line 1287 "irparser.cpp"
    break;

  case 34: // DeclParamList: DeclParam
#line 113 "irparser.y"
                                                    { yylhs.value.as < std::vector<pType> > () = { yystack_[0].value.as < pType > () }; }
#line 1293 "irparser.cpp"
    break;

  case 35: // DeclParam: Type I_NOUNDEF
#line 116 "irparser.y"
                                { yylhs.value.as < pType > () = yystack_[1].value.as < pType > (); }
#line 1299 "irparser.cpp"
    break;

  case 36: // DefParamList: DefParamList I_COMMA DefParam
#line 119 "irparser.y"
                                                { yylhs.value.as < std::vector<pFormalParam> > () = yystack_[2].value.as < std::vector<pFormalParam> > (); yylhs.value.as < std::vector<pFormalParam> > ().emplace_back(yystack_[0].value.as < pFormalParam > ()); }
#line 1305 "irparser.cpp"
    break;

  case 37: // DefParamList: DefParam
#line 120 "irparser.y"
                                                { yylhs.value.as < std::vector<pFormalParam> > () = { yystack_[0].value.as < pFormalParam > () }; }
#line 1311 "irparser.cpp"
    break;

  case 38: // DefParam: Type I_NOUNDEF I_ID
#line 123 "irparser.y"
                                    { yylhs.value.as < pFormalParam > () = tool.vmake<FormalParam>(yystack_[0].value.as < std::string > (), yystack_[0].value.as < std::string > (), yystack_[2].value.as < pType > (), 0); }
#line 1317 "irparser.cpp"
    break;

  case 39: // FunctionDefinition: I_DEFINE I_DSO_LOCAL Type I_ID I_LPAR DefParamList I_RPAR I_LBRACKET BBList I_RBRACKET
#line 126 "irparser.y"
                                                                                                                { yylhs.value.as < pFunc > () = tool.newFunc(yystack_[6].value.as < std::string > (), yystack_[4].value.as < std::vector<pFormalParam> > (), yystack_[7].value.as < pType > (), &inode.getConstantPool(), yystack_[1].value.as < std::vector<pBlock> > ()); }
#line 1323 "irparser.cpp"
    break;

  case 40: // FunctionDefinition: I_DEFINE I_DSO_LOCAL Type I_ID I_LPAR I_RPAR I_LBRACKET BBList I_RBRACKET
#line 127 "irparser.y"
                                                                                                                { yylhs.value.as < pFunc > () = tool.newFunc(yystack_[5].value.as < std::string > (), {}, yystack_[6].value.as < pType > (), &inode.getConstantPool(), yystack_[1].value.as < std::vector<pBlock> > ()); }
#line 1329 "irparser.cpp"
    break;

  case 41: // BBList: BB
#line 130 "irparser.y"
                        { yylhs.value.as < std::vector<pBlock> > () = { yystack_[0].value.as < pBlock > () }; }
#line 1335 "irparser.cpp"
    break;

  case 42: // BBList: BBList BB
#line 131 "irparser.y"
                        { yylhs.value.as < std::vector<pBlock> > () = yystack_[1].value.as < std::vector<pBlock> > (); yylhs.value.as < std::vector<pBlock> > ().emplace_back(yystack_[0].value.as < pBlock > ()); }
#line 1341 "irparser.cpp"
    break;

  case 43: // BB: I_BLKID InstList
#line 134 "irparser.y"
                        { yylhs.value.as < pBlock > () = tool.newBB(yystack_[1].value.as < std::string > (), yystack_[0].value.as < std::list<pInst> > ()); }
#line 1347 "irparser.cpp"
    break;

  case 44: // InstList: Inst
#line 137 "irparser.y"
                            { yylhs.value.as < std::list<pInst> > () = { yystack_[0].value.as < pInst > () }; }
#line 1353 "irparser.cpp"
    break;

  case 45: // InstList: InstList Inst
#line 138 "irparser.y"
                            { yylhs.value.as < std::list<pInst> > () = yystack_[1].value.as < std::list<pInst> > (); yylhs.value.as < std::list<pInst> > ().emplace_back(yystack_[0].value.as < pInst > ()); }
#line 1359 "irparser.cpp"
    break;

  case 46: // Inst: BinaryInst
#line 141 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1365 "irparser.cpp"
    break;

  case 47: // Inst: CastInst
#line 142 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1371 "irparser.cpp"
    break;

  case 48: // Inst: FnegInst
#line 143 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1377 "irparser.cpp"
    break;

  case 49: // Inst: IcmpInst
#line 144 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1383 "irparser.cpp"
    break;

  case 50: // Inst: FcmpInst
#line 145 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1389 "irparser.cpp"
    break;

  case 51: // Inst: RetInst
#line 146 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1395 "irparser.cpp"
    break;

  case 52: // Inst: BrInst
#line 147 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1401 "irparser.cpp"
    break;

  case 53: // Inst: CallInst
#line 148 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1407 "irparser.cpp"
    break;

  case 54: // Inst: AllocaInst
#line 149 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1413 "irparser.cpp"
    break;

  case 55: // Inst: LoadInst
#line 150 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1419 "irparser.cpp"
    break;

  case 56: // Inst: StoreInst
#line 151 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1425 "irparser.cpp"
    break;

  case 57: // Inst: GepInst
#line 152 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1431 "irparser.cpp"
    break;

  case 58: // Inst: PhiInst
#line 153 "irparser.y"
                        { yylhs.value.as < pInst > () = yystack_[0].value.as < pInst > (); }
#line 1437 "irparser.cpp"
    break;

  case 59: // BinaryInst: I_ID I_EQUAL BinaryOp Type Value I_COMMA Value
#line 156 "irparser.y"
                                                                { yylhs.value.as < pInst > () = tool.vmake<BinaryInst>(yystack_[6].value.as < std::string > (), yystack_[6].value.as < std::string > (), yystack_[4].value.as < OP > (), yystack_[2].value.as < pVal > (), yystack_[0].value.as < pVal > ()); }
#line 1443 "irparser.cpp"
    break;

  case 60: // Value: I_ID
#line 159 "irparser.y"
                    { yylhs.value.as < pVal > () = tool.getV(yystack_[0].value.as < std::string > ()); }
#line 1449 "irparser.cpp"
    break;

  case 61: // Value: Constant
#line 160 "irparser.y"
                    { yylhs.value.as < pVal > () = yystack_[0].value.as < pVal > (); }
#line 1455 "irparser.cpp"
    break;

  case 62: // BinaryOp: I_ADD
#line 163 "irparser.y"
                        { yylhs.value.as < OP > () = OP::ADD; }
#line 1461 "irparser.cpp"
    break;

  case 63: // BinaryOp: I_FADD
#line 164 "irparser.y"
                        { yylhs.value.as < OP > () = OP::FADD; }
#line 1467 "irparser.cpp"
    break;

  case 64: // BinaryOp: I_SUB
#line 165 "irparser.y"
                        { yylhs.value.as < OP > () = OP::SUB; }
#line 1473 "irparser.cpp"
    break;

  case 65: // BinaryOp: I_FSUB
#line 166 "irparser.y"
                        { yylhs.value.as < OP > () = OP::FSUB; }
#line 1479 "irparser.cpp"
    break;

  case 66: // BinaryOp: I_MUL
#line 167 "irparser.y"
                        { yylhs.value.as < OP > () = OP::MUL; }
#line 1485 "irparser.cpp"
    break;

  case 67: // BinaryOp: I_FMUL
#line 168 "irparser.y"
                        { yylhs.value.as < OP > () = OP::FMUL; }
#line 1491 "irparser.cpp"
    break;

  case 68: // BinaryOp: I_DIV
#line 169 "irparser.y"
                        { yylhs.value.as < OP > () = OP::DIV; }
#line 1497 "irparser.cpp"
    break;

  case 69: // BinaryOp: I_FDIV
#line 170 "irparser.y"
                        { yylhs.value.as < OP > () = OP::FDIV; }
#line 1503 "irparser.cpp"
    break;

  case 70: // BinaryOp: I_REM
#line 171 "irparser.y"
                        { yylhs.value.as < OP > () = OP::REM; }
#line 1509 "irparser.cpp"
    break;

  case 71: // BinaryOp: I_FREM
#line 172 "irparser.y"
                        { yylhs.value.as < OP > () = OP::FREM; }
#line 1515 "irparser.cpp"
    break;

  case 72: // FnegInst: I_ID I_EQUAL I_FNEG Type Value
#line 175 "irparser.y"
                                                { yylhs.value.as < pInst > () = tool.vmake<FNEGInst>(yystack_[4].value.as < std::string > (), yystack_[4].value.as < std::string > (), yystack_[0].value.as < pVal > ()); }
#line 1521 "irparser.cpp"
    break;

  case 73: // CastInst: I_ID I_EQUAL I_FPTOSI Type Value I_TO Type
#line 178 "irparser.y"
                                                            { yylhs.value.as < pInst > () = tool.vmake<FPTOSIInst>(yystack_[6].value.as < std::string > (), yystack_[6].value.as < std::string > (), yystack_[2].value.as < pVal > ()); }
#line 1527 "irparser.cpp"
    break;

  case 74: // CastInst: I_ID I_EQUAL I_SITOFP Type Value I_TO Type
#line 179 "irparser.y"
                                                            { yylhs.value.as < pInst > () = tool.vmake<SITOFPInst>(yystack_[6].value.as < std::string > (), yystack_[6].value.as < std::string > (), yystack_[2].value.as < pVal > ()); }
#line 1533 "irparser.cpp"
    break;

  case 75: // CastInst: I_ID I_EQUAL I_ZEXT Type Value I_TO Type
#line 180 "irparser.y"
                                                            { yylhs.value.as < pInst > () = tool.vmake<ZEXTInst>(yystack_[6].value.as < std::string > (), yystack_[6].value.as < std::string > (), yystack_[2].value.as < pVal > (), toBType(yystack_[0].value.as < pType > ())->getInner()); }
#line 1539 "irparser.cpp"
    break;

  case 76: // CastInst: I_ID I_EQUAL I_BITCAST Type Value I_TO Type
#line 181 "irparser.y"
                                                            { yylhs.value.as < pInst > () = tool.vmake<BITCASTInst>(yystack_[6].value.as < std::string > (), yystack_[6].value.as < std::string > (), yystack_[2].value.as < pVal > (), yystack_[0].value.as < pType > ()); }
#line 1545 "irparser.cpp"
    break;

  case 77: // IcmpInst: I_ID I_EQUAL I_ICMP IcmpOp Type Value I_COMMA Value
#line 184 "irparser.y"
                                                                    { yylhs.value.as < pInst > () = tool.vmake<ICMPInst>(yystack_[7].value.as < std::string > (), yystack_[7].value.as < std::string > (), yystack_[4].value.as < ICMPOP > (), yystack_[2].value.as < pVal > (), yystack_[0].value.as < pVal > ()); }
#line 1551 "irparser.cpp"
    break;

  case 78: // IcmpOp: I_EQ
#line 187 "irparser.y"
                { yylhs.value.as < ICMPOP > () = ICMPOP::eq; }
#line 1557 "irparser.cpp"
    break;

  case 79: // IcmpOp: I_NE
#line 188 "irparser.y"
                { yylhs.value.as < ICMPOP > () = ICMPOP::ne; }
#line 1563 "irparser.cpp"
    break;

  case 80: // IcmpOp: I_SGT
#line 189 "irparser.y"
                { yylhs.value.as < ICMPOP > () = ICMPOP::sgt; }
#line 1569 "irparser.cpp"
    break;

  case 81: // IcmpOp: I_SGE
#line 190 "irparser.y"
                { yylhs.value.as < ICMPOP > () = ICMPOP::sge; }
#line 1575 "irparser.cpp"
    break;

  case 82: // IcmpOp: I_SLT
#line 191 "irparser.y"
                { yylhs.value.as < ICMPOP > () = ICMPOP::slt; }
#line 1581 "irparser.cpp"
    break;

  case 83: // IcmpOp: I_SLE
#line 192 "irparser.y"
                { yylhs.value.as < ICMPOP > () = ICMPOP::sle; }
#line 1587 "irparser.cpp"
    break;

  case 84: // FcmpInst: I_ID I_EQUAL I_FCMP FcmpOp Type Value I_COMMA Value
#line 195 "irparser.y"
                                                                    { yylhs.value.as < pInst > () = tool.vmake<FCMPInst>(yystack_[7].value.as < std::string > (), yystack_[7].value.as < std::string > (), yystack_[4].value.as < FCMPOP > (), yystack_[2].value.as < pVal > (), yystack_[0].value.as < pVal > ()); }
#line 1593 "irparser.cpp"
    break;

  case 85: // FcmpOp: I_OEQ
#line 198 "irparser.y"
                { yylhs.value.as < FCMPOP > () = FCMPOP::oeq; }
#line 1599 "irparser.cpp"
    break;

  case 86: // FcmpOp: I_OGT
#line 199 "irparser.y"
                { yylhs.value.as < FCMPOP > () = FCMPOP::ogt; }
#line 1605 "irparser.cpp"
    break;

  case 87: // FcmpOp: I_OGE
#line 200 "irparser.y"
                { yylhs.value.as < FCMPOP > () = FCMPOP::oge; }
#line 1611 "irparser.cpp"
    break;

  case 88: // FcmpOp: I_OLT
#line 201 "irparser.y"
                { yylhs.value.as < FCMPOP > () = FCMPOP::olt; }
#line 1617 "irparser.cpp"
    break;

  case 89: // FcmpOp: I_OLE
#line 202 "irparser.y"
                { yylhs.value.as < FCMPOP > () = FCMPOP::ole; }
#line 1623 "irparser.cpp"
    break;

  case 90: // FcmpOp: I_ONE
#line 203 "irparser.y"
                { yylhs.value.as < FCMPOP > () = FCMPOP::one; }
#line 1629 "irparser.cpp"
    break;

  case 91: // FcmpOp: I_ORD
#line 204 "irparser.y"
                { yylhs.value.as < FCMPOP > () = FCMPOP::ord; }
#line 1635 "irparser.cpp"
    break;

  case 92: // RetInst: I_RET RETType Value
#line 207 "irparser.y"
                               { yylhs.value.as < pInst > () = tool.make<RETInst>(yystack_[0].value.as < pVal > ()); }
#line 1641 "irparser.cpp"
    break;

  case 93: // RetInst: I_RET I_VOID
#line 208 "irparser.y"
                            { yylhs.value.as < pInst > () = tool.make<RETInst>(); }
#line 1647 "irparser.cpp"
    break;

  case 94: // RETType: I_I1
#line 211 "irparser.y"
                    { yylhs.value.as < pType > () = makeBType(IRBTYPE::I1); }
#line 1653 "irparser.cpp"
    break;

  case 95: // RETType: I_I8
#line 212 "irparser.y"
                    { yylhs.value.as < pType > () = makeBType(IRBTYPE::I8); }
#line 1659 "irparser.cpp"
    break;

  case 96: // RETType: I_I32
#line 213 "irparser.y"
                    { yylhs.value.as < pType > () = makeBType(IRBTYPE::I32); }
#line 1665 "irparser.cpp"
    break;

  case 97: // RETType: I_FLOAT
#line 214 "irparser.y"
                    { yylhs.value.as < pType > () = makeBType(IRBTYPE::FLOAT); }
#line 1671 "irparser.cpp"
    break;

  case 98: // BrInst: I_BR I_LABEL I_ID
#line 217 "irparser.y"
                                                                    { yylhs.value.as < pInst > () = tool.make<BRInst>(tool.getB(yystack_[0].value.as < std::string > ())); }
#line 1677 "irparser.cpp"
    break;

  case 99: // BrInst: I_BR Type Value I_COMMA I_LABEL I_ID I_COMMA I_LABEL I_ID
#line 218 "irparser.y"
                                                                    { yylhs.value.as < pInst > () = tool.make<BRInst>(yystack_[6].value.as < pVal > (), tool.getB(yystack_[3].value.as < std::string > ()), tool.getB(yystack_[0].value.as < std::string > ())); }
#line 1683 "irparser.cpp"
    break;

  case 100: // CallInst: I_CALL Type I_ID I_LPAR ArgList I_RPAR
#line 221 "irparser.y"
                                                                            { yylhs.value.as < pInst > () = tool.make<CALLInst>(tool.getF(yystack_[3].value.as < std::string > ()), yystack_[1].value.as < std::vector<pVal> > ()); }
#line 1689 "irparser.cpp"
    break;

  case 101: // CallInst: I_ID I_EQUAL I_CALL Type I_ID I_LPAR ArgList I_RPAR
#line 222 "irparser.y"
                                                                            { yylhs.value.as < pInst > () = tool.vmake<CALLInst>(yystack_[7].value.as < std::string > (), yystack_[7].value.as < std::string > (), tool.getF(yystack_[3].value.as < std::string > ()), yystack_[1].value.as < std::vector<pVal> > ()); }
#line 1695 "irparser.cpp"
    break;

  case 102: // CallInst: I_TAIL I_CALL Type I_ID I_LPAR ArgList I_RPAR
#line 223 "irparser.y"
                                                                            { yylhs.value.as < pInst > () = tool.make<CALLInst>(tool.getF(yystack_[3].value.as < std::string > ()), yystack_[1].value.as < std::vector<pVal> > ()); }
#line 1701 "irparser.cpp"
    break;

  case 103: // CallInst: I_ID I_EQUAL I_TAIL I_CALL Type I_ID I_LPAR ArgList I_RPAR
#line 224 "irparser.y"
                                                                            { yylhs.value.as < pInst > () = tool.vmake<CALLInst>(yystack_[8].value.as < std::string > (), yystack_[8].value.as < std::string > (), tool.getF(yystack_[3].value.as < std::string > ()), yystack_[1].value.as < std::vector<pVal> > ()); }
#line 1707 "irparser.cpp"
    break;

  case 104: // ArgList: ArgList I_COMMA Arg
#line 227 "irparser.y"
                                { yylhs.value.as < std::vector<pVal> > () = yystack_[2].value.as < std::vector<pVal> > (); yylhs.value.as < std::vector<pVal> > ().emplace_back(yystack_[0].value.as < pVal > ()); }
#line 1713 "irparser.cpp"
    break;

  case 105: // ArgList: Arg
#line 228 "irparser.y"
                                { yylhs.value.as < std::vector<pVal> > () = { yystack_[0].value.as < pVal > () }; }
#line 1719 "irparser.cpp"
    break;

  case 106: // Arg: Type I_NOUNDEF Value
#line 231 "irparser.y"
                            { yylhs.value.as < pVal > () = yystack_[0].value.as < pVal > (); }
#line 1725 "irparser.cpp"
    break;

  case 107: // AllocaInst: I_ID I_EQUAL I_ALLOCA Type I_COMMA I_ALIGN IRNUM_INT
#line 234 "irparser.y"
                                                                    { yylhs.value.as < pInst > () = tool.vmake<ALLOCAInst>(yystack_[6].value.as < std::string > (), yystack_[6].value.as < std::string > (), yystack_[3].value.as < pType > (), yystack_[0].value.as < int > ()); }
#line 1731 "irparser.cpp"
    break;

  case 108: // LoadInst: I_ID I_EQUAL I_LOAD Type I_COMMA Type Value I_COMMA I_ALIGN IRNUM_INT
#line 237 "irparser.y"
                                                                                    { yylhs.value.as < pInst > () = tool.vmake<LOADInst>(yystack_[9].value.as < std::string > (), yystack_[9].value.as < std::string > (), yystack_[3].value.as < pVal > (), yystack_[0].value.as < int > ()); }
#line 1737 "irparser.cpp"
    break;

  case 109: // StoreInst: I_STORE Type Value I_COMMA Type Value I_COMMA I_ALIGN IRNUM_INT
#line 240 "irparser.y"
                                                                                { yylhs.value.as < pInst > () = tool.make<STOREInst>(yystack_[6].value.as < pVal > (), yystack_[3].value.as < pVal > (), yystack_[0].value.as < int > ()); }
#line 1743 "irparser.cpp"
    break;

  case 110: // GepInst: I_ID I_EQUAL I_GEP Type I_COMMA Type Value IndexList
#line 243 "irparser.y"
                                                                { yylhs.value.as < pInst > () = tool.vmake<GEPInst>(yystack_[7].value.as < std::string > (), yystack_[7].value.as < std::string > (), yystack_[1].value.as < pVal > (), yystack_[0].value.as < std::vector<pVal> > ()); }
#line 1749 "irparser.cpp"
    break;

  case 111: // IndexList: I_COMMA Type Value
#line 246 "irparser.y"
                                            { yylhs.value.as < std::vector<pVal> > () = { yystack_[0].value.as < pVal > () }; }
#line 1755 "irparser.cpp"
    break;

  case 112: // IndexList: IndexList I_COMMA Type Value
#line 247 "irparser.y"
                                            { yylhs.value.as < std::vector<pVal> > () = yystack_[3].value.as < std::vector<pVal> > (); yylhs.value.as < std::vector<pVal> > ().emplace_back(yystack_[0].value.as < pVal > ()); }
#line 1761 "irparser.cpp"
    break;

  case 113: // PhiInst: I_ID I_EQUAL I_PHI Type PhiOpers
#line 250 "irparser.y"
                                            { yylhs.value.as < pInst > () = tool.newPhi(yystack_[4].value.as < std::string > (), yystack_[1].value.as < pType > (), yystack_[0].value.as < std::vector<std::pair<pVal, pBlock>> > ()); }
#line 1767 "irparser.cpp"
    break;

  case 114: // PhiOpers: PhiOper
#line 253 "irparser.y"
                                        { yylhs.value.as < std::vector<std::pair<pVal, pBlock>> > () = { yystack_[0].value.as < std::pair<pVal, pBlock> > () }; }
#line 1773 "irparser.cpp"
    break;

  case 115: // PhiOpers: PhiOpers I_COMMA PhiOper
#line 254 "irparser.y"
                                        { yylhs.value.as < std::vector<std::pair<pVal, pBlock>> > () = yystack_[2].value.as < std::vector<std::pair<pVal, pBlock>> > (); yylhs.value.as < std::vector<std::pair<pVal, pBlock>> > ().emplace_back(yystack_[0].value.as < std::pair<pVal, pBlock> > ()); }
#line 1779 "irparser.cpp"
    break;

  case 116: // PhiOper: I_LSQUARE Value I_COMMA I_ID I_RSQUARE
#line 257 "irparser.y"
                                                    { yylhs.value.as < std::pair<pVal, pBlock> > () = std::make_pair(yystack_[3].value.as < pVal > (), tool.getB(yystack_[1].value.as < std::string > ())); }
#line 1785 "irparser.cpp"
    break;


#line 1789 "irparser.cpp"

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









  const short parser::yypact_ninf_ = -186;

  const signed char parser::yytable_ninf_ = -1;

  const short
  parser::yypact_[] =
  {
     -26,   -17,    17,   -57,    63,   -26,  -186,  -186,  -186,    17,
    -186,  -186,  -186,  -186,  -186,   -29,   -48,  -186,  -186,  -186,
      49,  -186,  -186,  -186,  -186,   -45,    59,  -186,    67,     8,
      86,    17,    60,  -186,  -186,    17,   136,     1,    83,  -186,
     -22,    93,  -186,   -49,    82,    61,   -20,   -42,  -186,  -186,
    -186,  -186,    95,  -186,    17,  -186,    17,  -186,  -186,  -186,
     127,   100,   102,   115,    17,  -186,  -186,  -186,    30,   108,
      -1,    57,  -186,  -186,   100,  -186,  -186,    17,  -186,   150,
      -6,    17,    17,   138,   112,    -1,  -186,  -186,  -186,  -186,
    -186,  -186,  -186,  -186,  -186,  -186,  -186,  -186,  -186,  -186,
    -186,  -186,    92,  -186,  -186,  -186,  -186,  -186,  -186,   103,
     116,    -5,    -5,   -38,    17,    81,  -186,  -186,  -186,  -186,
    -186,  -186,   114,   117,   132,   -13,    17,  -186,  -186,  -186,
    -186,  -186,  -186,  -186,  -186,  -186,  -186,    17,    17,    17,
      17,    17,    17,    17,   181,   168,    17,    17,   167,    17,
     160,    17,    17,   139,    -5,    43,    62,    84,    -5,    -5,
      -5,    -5,  -186,  -186,  -186,  -186,  -186,  -186,    17,  -186,
    -186,  -186,  -186,  -186,  -186,  -186,    17,    85,   -12,    17,
      -5,   128,    -5,   -18,    -7,  -186,    17,  -186,   165,    17,
      17,   188,   190,   191,   192,    -5,    -5,   103,   164,  -186,
     171,     6,   169,   170,   172,   103,  -186,    17,    14,   163,
      -5,    -5,    17,    17,    17,    17,   173,   174,   176,   179,
      17,   177,   103,   199,   211,  -186,  -186,  -186,  -186,   180,
     182,   189,   189,   189,   189,   103,   103,   183,  -186,    96,
      17,  -186,   185,   184,   214,    17,   193,  -186,  -186,   195,
    -186,    97,  -186,  -186,   186,    -5,    17,  -186,  -186,  -186,
    -186,    -5,  -186
  };

  const signed char
  parser::yydefact_[] =
  {
       0,     0,     0,     0,     0,     2,     6,     8,     7,     0,
      15,    16,    17,    18,    19,     0,     0,    12,    13,    14,
       0,     1,     3,     5,     4,     0,     0,    20,     0,     0,
       0,     0,     0,    11,    10,     0,     0,     0,     0,    31,
       0,     0,    34,     0,     0,     0,     0,     0,    37,    21,
      32,    35,     0,    29,     0,    24,     0,    22,    23,    26,
       0,     0,     0,     0,     0,    30,    33,    27,     0,     0,
       0,     0,    41,    38,     0,    36,    25,     0,     9,     0,
       0,     0,     0,     0,     0,    43,    44,    46,    48,    47,
      49,    50,    51,    52,    53,    54,    55,    56,    57,    58,
      40,    42,     0,    28,    94,    95,    96,    97,    93,     0,
       0,     0,     0,     0,     0,     0,    45,    39,    60,    61,
      92,    98,     0,     0,     0,     0,     0,    62,    63,    64,
      65,    66,    67,    68,    69,    70,    71,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,    78,    79,    80,    81,    82,    83,     0,    85,
      86,    87,    88,    89,    90,    91,     0,     0,     0,     0,
       0,     0,     0,     0,     0,   105,     0,    72,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,   113,   114,
       0,     0,     0,     0,     0,     0,   100,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,   106,   104,   102,   107,     0,
       0,    73,    74,    75,    76,     0,     0,     0,   115,     0,
       0,    59,     0,     0,     0,     0,   110,    77,    84,     0,
     101,     0,    99,   109,     0,     0,     0,   116,   103,   108,
     111,     0,   112
  };

  const short
  parser::yypgoto_[] =
  {
    -186,  -186,  -186,   246,  -186,    -2,  -186,  -186,  -186,   209,
     -50,  -186,   252,  -186,   205,  -186,   196,   258,   194,   -63,
    -186,   187,  -186,   -27,  -186,  -186,  -186,  -186,  -186,  -186,
    -186,  -186,  -186,  -186,  -186,  -185,    58,  -186,  -186,  -186,
    -186,  -186,  -186,  -186,    45
  };

  const unsigned char
  parser::yydefgoto_[] =
  {
       0,     4,     5,     6,    35,   183,    17,    18,    19,   119,
      44,    68,     7,    41,    42,    47,    48,     8,    71,    72,
      85,    86,    87,   120,   149,    88,    89,    90,   168,    91,
     176,    92,   109,    93,    94,   184,   185,    95,    96,    97,
      98,   246,    99,   198,   199
  };

  const short
  parser::yytable_[] =
  {
      16,   208,    79,    80,     1,     2,    67,    25,   101,    27,
      27,    55,    20,    27,    51,     9,    62,    56,   205,    81,
      27,    63,    28,    57,    58,    30,    64,   103,    82,    37,
      40,   110,   124,    43,    46,   239,    27,    83,    27,   101,
      27,    33,    34,    26,     3,    27,    27,    10,    11,    12,
      13,    14,    40,    27,    43,   251,   206,   153,   200,    27,
      15,   207,    46,    21,    27,   118,    49,    57,    58,    84,
      10,    11,    12,    13,    14,    43,   221,   227,   111,   112,
     113,    29,   207,    15,   122,   123,   126,   127,   128,   129,
     130,   131,   132,   133,   134,   135,   136,    76,    77,   137,
     138,    27,   139,   140,   141,   142,   143,   144,   145,   146,
     147,   188,   125,    10,    11,    12,    13,    14,    31,   148,
      27,    38,   100,    39,   154,    61,    15,   187,    70,    32,
     189,   191,   192,   193,   194,   155,   156,   157,   158,   159,
     160,   161,    27,    27,   177,   178,    50,   180,    36,   182,
      60,   197,   190,   202,    52,   204,    53,   117,    65,   250,
     258,    54,    69,    70,   207,   207,   195,   114,   216,   217,
     218,    70,    73,   118,   196,    57,    58,   201,   225,    74,
      78,   115,   150,   229,   230,   151,   121,   210,   211,    10,
      11,    12,    13,    14,   152,   241,   179,   181,   203,    45,
     209,   186,    15,   104,   105,   106,   107,   108,   247,   248,
     231,   232,   233,   234,   169,   170,   171,   172,   173,   174,
     175,   162,   163,   164,   165,   166,   167,   212,   260,   213,
     214,   215,   219,   220,   262,   228,   242,   222,   223,   240,
     224,   235,   236,   255,   237,   197,   243,    27,   244,   254,
     245,    22,    59,   249,   261,   252,   253,    23,   259,    66,
      75,   256,   257,    24,   238,   226,     0,     0,   102,     0,
       0,     0,   116
  };

  const short
  parser::yycheck_[] =
  {
       2,   186,     3,     4,    30,    31,    56,     9,    71,    58,
      58,    60,    69,    58,    36,    32,    36,    66,    36,    20,
      58,    63,    70,    72,    73,    70,    68,    77,    29,    31,
      32,    37,    70,    35,    36,   220,    58,    38,    58,   102,
      58,    33,    34,    72,    70,    58,    58,    53,    54,    55,
      56,    57,    54,    58,    56,   240,    63,    70,    70,    58,
      66,    68,    64,     0,    58,    70,    65,    72,    73,    70,
      53,    54,    55,    56,    57,    77,    70,    63,    80,    81,
      82,    32,    68,    66,   111,   112,     5,     6,     7,     8,
       9,    10,    11,    12,    13,    14,    15,    67,    68,    18,
      19,    58,    21,    22,    23,    24,    25,    26,    27,    28,
      29,    68,   114,    53,    54,    55,    56,    57,    59,    38,
      58,    61,    65,    63,   126,    64,    66,   154,    71,    62,
      68,   158,   159,   160,   161,   137,   138,   139,   140,   141,
     142,   143,    58,    58,   146,   147,    63,   149,    62,   151,
      68,    66,    68,   180,    61,   182,    63,    65,    63,    63,
      63,    68,    35,    71,    68,    68,   168,    29,   195,   196,
     197,    71,    70,    70,   176,    72,    73,   179,   205,    64,
      72,    69,    68,   210,   211,    68,    70,   189,   190,    53,
      54,    55,    56,    57,    62,   222,    29,    37,    70,    63,
      35,    62,    66,    53,    54,    55,    56,    57,   235,   236,
     212,   213,   214,   215,    46,    47,    48,    49,    50,    51,
      52,    40,    41,    42,    43,    44,    45,    39,   255,    39,
      39,    39,    68,    62,   261,    72,    37,    68,    68,    62,
      68,    68,    68,   245,    68,    66,    35,    58,    68,    35,
      68,     5,    43,    70,   256,    70,    72,     5,    72,    54,
      64,    68,    67,     5,   219,   207,    -1,    -1,    74,    -1,
      -1,    -1,    85
  };

  const signed char
  parser::yystos_[] =
  {
       0,    30,    31,    70,    75,    76,    77,    86,    91,    32,
      53,    54,    55,    56,    57,    66,    79,    80,    81,    82,
      69,     0,    77,    86,    91,    79,    72,    58,    70,    32,
      70,    59,    62,    33,    34,    78,    62,    79,    61,    63,
      79,    87,    88,    79,    84,    63,    79,    89,    90,    65,
      63,    36,    61,    63,    68,    60,    66,    72,    73,    83,
      68,    64,    36,    63,    68,    63,    88,    84,    85,    35,
      71,    92,    93,    70,    64,    90,    67,    68,    72,     3,
       4,    20,    29,    38,    70,    94,    95,    96,    99,   100,
     101,   103,   105,   107,   108,   111,   112,   113,   114,   116,
      65,    93,    92,    84,    53,    54,    55,    56,    57,   106,
      37,    79,    79,    79,    29,    69,    95,    65,    70,    83,
      97,    70,    97,    97,    70,    79,     5,     6,     7,     8,
       9,    10,    11,    12,    13,    14,    15,    18,    19,    21,
      22,    23,    24,    25,    26,    27,    28,    29,    38,    98,
      68,    68,    62,    70,    79,    79,    79,    79,    79,    79,
      79,    79,    40,    41,    42,    43,    44,    45,   102,    46,
      47,    48,    49,    50,    51,    52,   104,    79,    79,    29,
      79,    37,    79,    79,   109,   110,    62,    97,    68,    68,
      68,    97,    97,    97,    97,    79,    79,    66,   117,   118,
      70,    79,    97,    70,    97,    36,    63,    68,   109,    35,
      79,    79,    39,    39,    39,    39,    97,    97,    97,    68,
      62,    70,    68,    68,    68,    97,   110,    63,    72,    97,
      97,    79,    79,    79,    79,    68,    68,    68,   118,   109,
      62,    97,    37,    35,    68,    68,   115,    97,    97,    70,
      63,   109,    70,    72,    35,    79,    68,    67,    63,    72,
      97,    79,    97
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
      97,    97,    98,    98,    98,    98,    98,    98,    98,    98,
      98,    98,    99,   100,   100,   100,   100,   101,   102,   102,
     102,   102,   102,   102,   103,   104,   104,   104,   104,   104,
     104,   104,   105,   105,   106,   106,   106,   106,   107,   107,
     108,   108,   108,   108,   109,   109,   110,   111,   112,   113,
     114,   115,   115,   116,   117,   117,   118
  };

  const signed char
  parser::yyr2_[] =
  {
       0,     2,     1,     2,     2,     2,     1,     1,     1,     8,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       2,     5,     1,     1,     2,     4,     2,     1,     3,     6,
       7,     5,     6,     3,     1,     2,     3,     1,     3,    10,
       9,     1,     2,     2,     1,     2,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     7,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     5,     7,     7,     7,     7,     8,     1,     1,
       1,     1,     1,     1,     8,     1,     1,     1,     1,     1,
       1,     1,     3,     2,     1,     1,     1,     1,     3,     9,
       6,     8,     7,     9,     3,     1,     3,     7,    10,     9,
       8,     3,     4,     5,     1,     3,     5
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
  "BinaryInst", "Value", "BinaryOp", "FnegInst", "CastInst", "IcmpInst",
  "IcmpOp", "FcmpInst", "FcmpOp", "RetInst", "RETType", "BrInst",
  "CallInst", "ArgList", "Arg", "AllocaInst", "LoadInst", "StoreInst",
  "GepInst", "IndexList", "PhiInst", "PhiOpers", "PhiOper", YY_NULLPTR
  };
#endif


#if YYDEBUG
  const short
  parser::yyrline_[] =
  {
       0,    57,    57,    60,    61,    62,    63,    64,    65,    68,
      71,    72,    75,    76,    77,    80,    81,    82,    83,    84,
      87,    90,    93,    94,    97,    98,    99,   102,   103,   106,
     107,   108,   109,   112,   113,   116,   119,   120,   123,   126,
     127,   130,   131,   134,   137,   138,   141,   142,   143,   144,
     145,   146,   147,   148,   149,   150,   151,   152,   153,   156,
     159,   160,   163,   164,   165,   166,   167,   168,   169,   170,
     171,   172,   175,   178,   179,   180,   181,   184,   187,   188,
     189,   190,   191,   192,   195,   198,   199,   200,   201,   202,
     203,   204,   207,   208,   211,   212,   213,   214,   217,   218,
     221,   222,   223,   224,   227,   228,   231,   234,   237,   240,
     243,   246,   247,   250,   253,   254,   257
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
#line 2277 "irparser.cpp"

#line 260 "irparser.y"


/* void setFileName(const char *name) {
  strcpy(filename, name);
  freopen(filename, "r", stdin);
} */

void
yyy::parser::error (const std::string& msg) { 
      std::cerr << "Error: " << msg << std::endl; 
}
