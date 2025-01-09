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





#include "parser.hpp"


// Unqualified %code blocks.
#line 6 "./lib/parser/parser.y"

#include "../../include/parser/ast.hpp"
extern std::shared_ptr<AST::CompUnit> node;
using namespace AST;
extern yy::parser::symbol_type yylex ();
extern int yylineno;

#line 54 "./lib/parser/parser.cpp"


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

namespace yy {
#line 127 "./lib/parser/parser.cpp"

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
      case symbol_kind::S_Type: // Type
        value.YY_MOVE_OR_COPY< AST::dtype > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_num_FLOAT: // num_FLOAT
        value.YY_MOVE_OR_COPY< AST::float32 > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_num_INT: // num_INT
        value.YY_MOVE_OR_COPY< AST::int32 > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        value.YY_MOVE_OR_COPY< AST::string > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstAS: // ConstAS
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
        value.YY_MOVE_OR_COPY< std::shared_ptr<ArraySubscript> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Block: // Block
      case symbol_kind::S_BlockItems: // BlockItems
        value.YY_MOVE_OR_COPY< std::shared_ptr<CompStmt> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_CompUnit: // CompUnit
        value.YY_MOVE_OR_COPY< std::shared_ptr<CompUnit> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstDecl: // ConstDecl
      case symbol_kind::S_VarDecl: // VarDecl
        value.YY_MOVE_OR_COPY< std::shared_ptr<DeclStmt> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstExp: // ConstExp
      case symbol_kind::S_Exp: // Exp
      case symbol_kind::S_LVal: // LVal
      case symbol_kind::S_PrimaryExp: // PrimaryExp
      case symbol_kind::S_Number: // Number
      case symbol_kind::S_UnaryExp: // UnaryExp
      case symbol_kind::S_MulExp: // MulExp
      case symbol_kind::S_AddExp: // AddExp
      case symbol_kind::S_RelExp: // RelExp
      case symbol_kind::S_EqExp: // EqExp
      case symbol_kind::S_LAndExp: // LAndExp
      case symbol_kind::S_LOrExp: // LOrExp
        value.YY_MOVE_OR_COPY< std::shared_ptr<Exp> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FuncDef: // FuncDef
        value.YY_MOVE_OR_COPY< std::shared_ptr<FuncDef> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FuncFParams: // FuncFParams
      case symbol_kind::S_FuncFParam: // FuncFParam
        value.YY_MOVE_OR_COPY< std::shared_ptr<FuncFParam> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FuncRParams: // FuncRParams
        value.YY_MOVE_OR_COPY< std::shared_ptr<FuncRParam> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVal: // InitVal
      case symbol_kind::S_InitVals: // InitVals
        value.YY_MOVE_OR_COPY< std::shared_ptr<InitVal> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_BlockItem: // BlockItem
      case symbol_kind::S_Stmt: // Stmt
        value.YY_MOVE_OR_COPY< std::shared_ptr<Stmt> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstDefs: // ConstDefs
      case symbol_kind::S_ConstDef: // ConstDef
      case symbol_kind::S_VarDefs: // VarDefs
      case symbol_kind::S_VarDef: // VarDef
        value.YY_MOVE_OR_COPY< std::shared_ptr<VarDef> > (YY_MOVE (that.value));
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
      case symbol_kind::S_Type: // Type
        value.move< AST::dtype > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_num_FLOAT: // num_FLOAT
        value.move< AST::float32 > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_num_INT: // num_INT
        value.move< AST::int32 > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        value.move< AST::string > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstAS: // ConstAS
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
        value.move< std::shared_ptr<ArraySubscript> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Block: // Block
      case symbol_kind::S_BlockItems: // BlockItems
        value.move< std::shared_ptr<CompStmt> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_CompUnit: // CompUnit
        value.move< std::shared_ptr<CompUnit> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstDecl: // ConstDecl
      case symbol_kind::S_VarDecl: // VarDecl
        value.move< std::shared_ptr<DeclStmt> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstExp: // ConstExp
      case symbol_kind::S_Exp: // Exp
      case symbol_kind::S_LVal: // LVal
      case symbol_kind::S_PrimaryExp: // PrimaryExp
      case symbol_kind::S_Number: // Number
      case symbol_kind::S_UnaryExp: // UnaryExp
      case symbol_kind::S_MulExp: // MulExp
      case symbol_kind::S_AddExp: // AddExp
      case symbol_kind::S_RelExp: // RelExp
      case symbol_kind::S_EqExp: // EqExp
      case symbol_kind::S_LAndExp: // LAndExp
      case symbol_kind::S_LOrExp: // LOrExp
        value.move< std::shared_ptr<Exp> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FuncDef: // FuncDef
        value.move< std::shared_ptr<FuncDef> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FuncFParams: // FuncFParams
      case symbol_kind::S_FuncFParam: // FuncFParam
        value.move< std::shared_ptr<FuncFParam> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FuncRParams: // FuncRParams
        value.move< std::shared_ptr<FuncRParam> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVal: // InitVal
      case symbol_kind::S_InitVals: // InitVals
        value.move< std::shared_ptr<InitVal> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_BlockItem: // BlockItem
      case symbol_kind::S_Stmt: // Stmt
        value.move< std::shared_ptr<Stmt> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstDefs: // ConstDefs
      case symbol_kind::S_ConstDef: // ConstDef
      case symbol_kind::S_VarDefs: // VarDefs
      case symbol_kind::S_VarDef: // VarDef
        value.move< std::shared_ptr<VarDef> > (YY_MOVE (that.value));
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
      case symbol_kind::S_Type: // Type
        value.copy< AST::dtype > (that.value);
        break;

      case symbol_kind::S_num_FLOAT: // num_FLOAT
        value.copy< AST::float32 > (that.value);
        break;

      case symbol_kind::S_num_INT: // num_INT
        value.copy< AST::int32 > (that.value);
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        value.copy< AST::string > (that.value);
        break;

      case symbol_kind::S_ConstAS: // ConstAS
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
        value.copy< std::shared_ptr<ArraySubscript> > (that.value);
        break;

      case symbol_kind::S_Block: // Block
      case symbol_kind::S_BlockItems: // BlockItems
        value.copy< std::shared_ptr<CompStmt> > (that.value);
        break;

      case symbol_kind::S_CompUnit: // CompUnit
        value.copy< std::shared_ptr<CompUnit> > (that.value);
        break;

      case symbol_kind::S_ConstDecl: // ConstDecl
      case symbol_kind::S_VarDecl: // VarDecl
        value.copy< std::shared_ptr<DeclStmt> > (that.value);
        break;

      case symbol_kind::S_ConstExp: // ConstExp
      case symbol_kind::S_Exp: // Exp
      case symbol_kind::S_LVal: // LVal
      case symbol_kind::S_PrimaryExp: // PrimaryExp
      case symbol_kind::S_Number: // Number
      case symbol_kind::S_UnaryExp: // UnaryExp
      case symbol_kind::S_MulExp: // MulExp
      case symbol_kind::S_AddExp: // AddExp
      case symbol_kind::S_RelExp: // RelExp
      case symbol_kind::S_EqExp: // EqExp
      case symbol_kind::S_LAndExp: // LAndExp
      case symbol_kind::S_LOrExp: // LOrExp
        value.copy< std::shared_ptr<Exp> > (that.value);
        break;

      case symbol_kind::S_FuncDef: // FuncDef
        value.copy< std::shared_ptr<FuncDef> > (that.value);
        break;

      case symbol_kind::S_FuncFParams: // FuncFParams
      case symbol_kind::S_FuncFParam: // FuncFParam
        value.copy< std::shared_ptr<FuncFParam> > (that.value);
        break;

      case symbol_kind::S_FuncRParams: // FuncRParams
        value.copy< std::shared_ptr<FuncRParam> > (that.value);
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVal: // InitVal
      case symbol_kind::S_InitVals: // InitVals
        value.copy< std::shared_ptr<InitVal> > (that.value);
        break;

      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_BlockItem: // BlockItem
      case symbol_kind::S_Stmt: // Stmt
        value.copy< std::shared_ptr<Stmt> > (that.value);
        break;

      case symbol_kind::S_ConstDefs: // ConstDefs
      case symbol_kind::S_ConstDef: // ConstDef
      case symbol_kind::S_VarDefs: // VarDefs
      case symbol_kind::S_VarDef: // VarDef
        value.copy< std::shared_ptr<VarDef> > (that.value);
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
      case symbol_kind::S_Type: // Type
        value.move< AST::dtype > (that.value);
        break;

      case symbol_kind::S_num_FLOAT: // num_FLOAT
        value.move< AST::float32 > (that.value);
        break;

      case symbol_kind::S_num_INT: // num_INT
        value.move< AST::int32 > (that.value);
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        value.move< AST::string > (that.value);
        break;

      case symbol_kind::S_ConstAS: // ConstAS
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
        value.move< std::shared_ptr<ArraySubscript> > (that.value);
        break;

      case symbol_kind::S_Block: // Block
      case symbol_kind::S_BlockItems: // BlockItems
        value.move< std::shared_ptr<CompStmt> > (that.value);
        break;

      case symbol_kind::S_CompUnit: // CompUnit
        value.move< std::shared_ptr<CompUnit> > (that.value);
        break;

      case symbol_kind::S_ConstDecl: // ConstDecl
      case symbol_kind::S_VarDecl: // VarDecl
        value.move< std::shared_ptr<DeclStmt> > (that.value);
        break;

      case symbol_kind::S_ConstExp: // ConstExp
      case symbol_kind::S_Exp: // Exp
      case symbol_kind::S_LVal: // LVal
      case symbol_kind::S_PrimaryExp: // PrimaryExp
      case symbol_kind::S_Number: // Number
      case symbol_kind::S_UnaryExp: // UnaryExp
      case symbol_kind::S_MulExp: // MulExp
      case symbol_kind::S_AddExp: // AddExp
      case symbol_kind::S_RelExp: // RelExp
      case symbol_kind::S_EqExp: // EqExp
      case symbol_kind::S_LAndExp: // LAndExp
      case symbol_kind::S_LOrExp: // LOrExp
        value.move< std::shared_ptr<Exp> > (that.value);
        break;

      case symbol_kind::S_FuncDef: // FuncDef
        value.move< std::shared_ptr<FuncDef> > (that.value);
        break;

      case symbol_kind::S_FuncFParams: // FuncFParams
      case symbol_kind::S_FuncFParam: // FuncFParam
        value.move< std::shared_ptr<FuncFParam> > (that.value);
        break;

      case symbol_kind::S_FuncRParams: // FuncRParams
        value.move< std::shared_ptr<FuncRParam> > (that.value);
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVal: // InitVal
      case symbol_kind::S_InitVals: // InitVals
        value.move< std::shared_ptr<InitVal> > (that.value);
        break;

      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_BlockItem: // BlockItem
      case symbol_kind::S_Stmt: // Stmt
        value.move< std::shared_ptr<Stmt> > (that.value);
        break;

      case symbol_kind::S_ConstDefs: // ConstDefs
      case symbol_kind::S_ConstDef: // ConstDef
      case symbol_kind::S_VarDefs: // VarDefs
      case symbol_kind::S_VarDef: // VarDef
        value.move< std::shared_ptr<VarDef> > (that.value);
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
      case symbol_kind::S_Type: // Type
        yylhs.value.emplace< AST::dtype > ();
        break;

      case symbol_kind::S_num_FLOAT: // num_FLOAT
        yylhs.value.emplace< AST::float32 > ();
        break;

      case symbol_kind::S_num_INT: // num_INT
        yylhs.value.emplace< AST::int32 > ();
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        yylhs.value.emplace< AST::string > ();
        break;

      case symbol_kind::S_ConstAS: // ConstAS
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
        yylhs.value.emplace< std::shared_ptr<ArraySubscript> > ();
        break;

      case symbol_kind::S_Block: // Block
      case symbol_kind::S_BlockItems: // BlockItems
        yylhs.value.emplace< std::shared_ptr<CompStmt> > ();
        break;

      case symbol_kind::S_CompUnit: // CompUnit
        yylhs.value.emplace< std::shared_ptr<CompUnit> > ();
        break;

      case symbol_kind::S_ConstDecl: // ConstDecl
      case symbol_kind::S_VarDecl: // VarDecl
        yylhs.value.emplace< std::shared_ptr<DeclStmt> > ();
        break;

      case symbol_kind::S_ConstExp: // ConstExp
      case symbol_kind::S_Exp: // Exp
      case symbol_kind::S_LVal: // LVal
      case symbol_kind::S_PrimaryExp: // PrimaryExp
      case symbol_kind::S_Number: // Number
      case symbol_kind::S_UnaryExp: // UnaryExp
      case symbol_kind::S_MulExp: // MulExp
      case symbol_kind::S_AddExp: // AddExp
      case symbol_kind::S_RelExp: // RelExp
      case symbol_kind::S_EqExp: // EqExp
      case symbol_kind::S_LAndExp: // LAndExp
      case symbol_kind::S_LOrExp: // LOrExp
        yylhs.value.emplace< std::shared_ptr<Exp> > ();
        break;

      case symbol_kind::S_FuncDef: // FuncDef
        yylhs.value.emplace< std::shared_ptr<FuncDef> > ();
        break;

      case symbol_kind::S_FuncFParams: // FuncFParams
      case symbol_kind::S_FuncFParam: // FuncFParam
        yylhs.value.emplace< std::shared_ptr<FuncFParam> > ();
        break;

      case symbol_kind::S_FuncRParams: // FuncRParams
        yylhs.value.emplace< std::shared_ptr<FuncRParam> > ();
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVal: // InitVal
      case symbol_kind::S_InitVals: // InitVals
        yylhs.value.emplace< std::shared_ptr<InitVal> > ();
        break;

      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_BlockItem: // BlockItem
      case symbol_kind::S_Stmt: // Stmt
        yylhs.value.emplace< std::shared_ptr<Stmt> > ();
        break;

      case symbol_kind::S_ConstDefs: // ConstDefs
      case symbol_kind::S_ConstDef: // ConstDef
      case symbol_kind::S_VarDefs: // VarDefs
      case symbol_kind::S_VarDef: // VarDef
        yylhs.value.emplace< std::shared_ptr<VarDef> > ();
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
  case 2: // CompileUnit: CompUnit
#line 48 "./lib/parser/parser.y"
                        { node = yystack_[0].value.as < std::shared_ptr<CompUnit> > (); }
#line 923 "./lib/parser/parser.cpp"
    break;

  case 3: // CompUnit: CompUnit Decl
#line 51 "./lib/parser/parser.y"
                                { yystack_[1].value.as < std::shared_ptr<CompUnit> > ()->addNode(yystack_[0].value.as < std::shared_ptr<Stmt> > ()); yylhs.value.as < std::shared_ptr<CompUnit> > () = yystack_[1].value.as < std::shared_ptr<CompUnit> > (); }
#line 929 "./lib/parser/parser.cpp"
    break;

  case 4: // CompUnit: CompUnit FuncDef
#line 52 "./lib/parser/parser.y"
                                { yystack_[1].value.as < std::shared_ptr<CompUnit> > ()->addNode(yystack_[0].value.as < std::shared_ptr<FuncDef> > ()); yylhs.value.as < std::shared_ptr<CompUnit> > () = yystack_[1].value.as < std::shared_ptr<CompUnit> > (); }
#line 935 "./lib/parser/parser.cpp"
    break;

  case 5: // CompUnit: Decl
#line 53 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<CompUnit> > () = std::make_shared<CompUnit>(yystack_[0].value.as < std::shared_ptr<Stmt> > ()); }
#line 941 "./lib/parser/parser.cpp"
    break;

  case 6: // CompUnit: FuncDef
#line 54 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<CompUnit> > () = std::make_shared<CompUnit>(yystack_[0].value.as < std::shared_ptr<FuncDef> > ()); }
#line 947 "./lib/parser/parser.cpp"
    break;

  case 7: // Decl: ConstDecl
#line 58 "./lib/parser/parser.y"
                    { yylhs.value.as < std::shared_ptr<Stmt> > () = yystack_[0].value.as < std::shared_ptr<DeclStmt> > (); }
#line 953 "./lib/parser/parser.cpp"
    break;

  case 8: // Decl: VarDecl
#line 59 "./lib/parser/parser.y"
                    { yylhs.value.as < std::shared_ptr<Stmt> > () = yystack_[0].value.as < std::shared_ptr<DeclStmt> > (); }
#line 959 "./lib/parser/parser.cpp"
    break;

  case 9: // Type: Y_INT
#line 62 "./lib/parser/parser.y"
                { yylhs.value.as < AST::dtype > () = dtype::INT; }
#line 965 "./lib/parser/parser.cpp"
    break;

  case 10: // Type: Y_FLOAT
#line 63 "./lib/parser/parser.y"
                { yylhs.value.as < AST::dtype > () = dtype::FLOAT; }
#line 971 "./lib/parser/parser.cpp"
    break;

  case 11: // Type: Y_VOID
#line 64 "./lib/parser/parser.y"
                { yylhs.value.as < AST::dtype > () = dtype::VOID; }
#line 977 "./lib/parser/parser.cpp"
    break;

  case 12: // ConstDecl: Y_CONST Type ConstDefs Y_SEMICOLON
#line 68 "./lib/parser/parser.y"
                                                 { yylhs.value.as < std::shared_ptr<DeclStmt> > () = std::make_shared<DeclStmt>(true, yystack_[2].value.as < AST::dtype > (), yystack_[1].value.as < std::shared_ptr<VarDef> > ()); }
#line 983 "./lib/parser/parser.cpp"
    break;

  case 13: // ConstDefs: ConstDef
#line 71 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<VarDef> > () = yystack_[0].value.as < std::shared_ptr<VarDef> > (); }
#line 989 "./lib/parser/parser.cpp"
    break;

  case 14: // ConstDefs: ConstDef Y_COMMA ConstDefs
#line 72 "./lib/parser/parser.y"
                                        { yystack_[2].value.as < std::shared_ptr<VarDef> > ()->next = yystack_[0].value.as < std::shared_ptr<VarDef> > (); yylhs.value.as < std::shared_ptr<VarDef> > () = yystack_[2].value.as < std::shared_ptr<VarDef> > (); }
#line 995 "./lib/parser/parser.cpp"
    break;

  case 15: // ConstDef: Y_ID Y_ASSIGN ConstInitVal
#line 75 "./lib/parser/parser.y"
                                                { yylhs.value.as < std::shared_ptr<VarDef> > () = std::make_shared<VarDef>(yystack_[2].value.as < AST::string > (), yystack_[0].value.as < std::shared_ptr<InitVal> > ()); }
#line 1001 "./lib/parser/parser.cpp"
    break;

  case 16: // ConstDef: Y_ID ConstAS Y_ASSIGN ConstInitVal
#line 76 "./lib/parser/parser.y"
                                                { yylhs.value.as < std::shared_ptr<VarDef> > () = std::make_shared<VarDef>(yystack_[3].value.as < AST::string > (), yystack_[2].value.as < std::shared_ptr<ArraySubscript> > (), yystack_[0].value.as < std::shared_ptr<InitVal> > ()); }
#line 1007 "./lib/parser/parser.cpp"
    break;

  case 17: // ConstAS: Y_LSQUARE ConstExp Y_RSQUARE
#line 79 "./lib/parser/parser.y"
                                                  { yylhs.value.as < std::shared_ptr<ArraySubscript> > () = std::make_shared<ArraySubscript>(yystack_[1].value.as < std::shared_ptr<Exp> > ()); }
#line 1013 "./lib/parser/parser.cpp"
    break;

  case 18: // ConstAS: Y_LSQUARE ConstExp Y_RSQUARE ConstAS
#line 80 "./lib/parser/parser.y"
                                                  { auto p = std::make_shared<ArraySubscript>(yystack_[2].value.as < std::shared_ptr<Exp> > ()); p->next = yystack_[0].value.as < std::shared_ptr<ArraySubscript> > (); yylhs.value.as < std::shared_ptr<ArraySubscript> > () = p; }
#line 1019 "./lib/parser/parser.cpp"
    break;

  case 19: // ConstExp: AddExp
#line 83 "./lib/parser/parser.y"
                        { yylhs.value.as < std::shared_ptr<Exp> > () = yystack_[0].value.as < std::shared_ptr<Exp> > (); }
#line 1025 "./lib/parser/parser.cpp"
    break;

  case 20: // ConstInitVal: ConstExp
#line 86 "./lib/parser/parser.y"
                                                                { yylhs.value.as < std::shared_ptr<InitVal> > () = std::make_shared<InitVal>(yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1031 "./lib/parser/parser.cpp"
    break;

  case 21: // ConstInitVal: Y_LBRACKET Y_RBRACKET
#line 87 "./lib/parser/parser.y"
                                                                { yylhs.value.as < std::shared_ptr<InitVal> > () = std::make_shared<InitVal>(); }
#line 1037 "./lib/parser/parser.cpp"
    break;

  case 22: // ConstInitVal: Y_LBRACKET ConstInitVals Y_RBRACKET
#line 88 "./lib/parser/parser.y"
                                                                { yylhs.value.as < std::shared_ptr<InitVal> > () = std::make_shared<InitVal>(yystack_[1].value.as < std::shared_ptr<InitVal> > ()); }
#line 1043 "./lib/parser/parser.cpp"
    break;

  case 23: // ConstInitVals: ConstInitVal
#line 91 "./lib/parser/parser.y"
                                                        { yylhs.value.as < std::shared_ptr<InitVal> > () = yystack_[0].value.as < std::shared_ptr<InitVal> > (); }
#line 1049 "./lib/parser/parser.cpp"
    break;

  case 24: // ConstInitVals: ConstInitVal Y_COMMA ConstInitVals
#line 92 "./lib/parser/parser.y"
                                                        { yystack_[2].value.as < std::shared_ptr<InitVal> > ()->next = yystack_[0].value.as < std::shared_ptr<InitVal> > (); yylhs.value.as < std::shared_ptr<InitVal> > () = yystack_[2].value.as < std::shared_ptr<InitVal> > (); }
#line 1055 "./lib/parser/parser.cpp"
    break;

  case 25: // VarDecl: Type VarDefs Y_SEMICOLON
#line 96 "./lib/parser/parser.y"
                                             { yylhs.value.as < std::shared_ptr<DeclStmt> > () = std::make_shared<DeclStmt>(false, yystack_[2].value.as < AST::dtype > (), yystack_[1].value.as < std::shared_ptr<VarDef> > ()); }
#line 1061 "./lib/parser/parser.cpp"
    break;

  case 26: // VarDefs: VarDef
#line 99 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<VarDef> > () = yystack_[0].value.as < std::shared_ptr<VarDef> > (); }
#line 1067 "./lib/parser/parser.cpp"
    break;

  case 27: // VarDefs: VarDef Y_COMMA VarDefs
#line 100 "./lib/parser/parser.y"
                                        { yystack_[2].value.as < std::shared_ptr<VarDef> > ()->next = yystack_[0].value.as < std::shared_ptr<VarDef> > (); yylhs.value.as < std::shared_ptr<VarDef> > () = yystack_[2].value.as < std::shared_ptr<VarDef> > (); }
#line 1073 "./lib/parser/parser.cpp"
    break;

  case 28: // VarDef: Y_ID
#line 103 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<VarDef> > () = std::make_shared<VarDef>(yystack_[0].value.as < AST::string > ()); }
#line 1079 "./lib/parser/parser.cpp"
    break;

  case 29: // VarDef: Y_ID ConstAS
#line 104 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<VarDef> > () = std::make_shared<VarDef>(yystack_[1].value.as < AST::string > (), yystack_[0].value.as < std::shared_ptr<ArraySubscript> > ()); }
#line 1085 "./lib/parser/parser.cpp"
    break;

  case 30: // VarDef: Y_ID Y_ASSIGN InitVal
#line 105 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<VarDef> > () = std::make_shared<VarDef>(yystack_[2].value.as < AST::string > (), yystack_[0].value.as < std::shared_ptr<InitVal> > ()); }
#line 1091 "./lib/parser/parser.cpp"
    break;

  case 31: // VarDef: Y_ID ConstAS Y_ASSIGN InitVal
#line 106 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<VarDef> > () = std::make_shared<VarDef>(yystack_[3].value.as < AST::string > (), yystack_[2].value.as < std::shared_ptr<ArraySubscript> > (), yystack_[0].value.as < std::shared_ptr<InitVal> > ()); }
#line 1097 "./lib/parser/parser.cpp"
    break;

  case 32: // InitVal: Exp
#line 109 "./lib/parser/parser.y"
                                                { yylhs.value.as < std::shared_ptr<InitVal> > () = std::make_shared<InitVal>(yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1103 "./lib/parser/parser.cpp"
    break;

  case 33: // InitVal: Y_LBRACKET Y_RBRACKET
#line 110 "./lib/parser/parser.y"
                                                { yylhs.value.as < std::shared_ptr<InitVal> > () = std::make_shared<InitVal>(); }
#line 1109 "./lib/parser/parser.cpp"
    break;

  case 34: // InitVal: Y_LBRACKET InitVals Y_RBRACKET
#line 111 "./lib/parser/parser.y"
                                                { yylhs.value.as < std::shared_ptr<InitVal> > () = std::make_shared<InitVal>(yystack_[1].value.as < std::shared_ptr<InitVal> > ()); }
#line 1115 "./lib/parser/parser.cpp"
    break;

  case 35: // InitVals: InitVal
#line 114 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<InitVal> > () = yystack_[0].value.as < std::shared_ptr<InitVal> > (); }
#line 1121 "./lib/parser/parser.cpp"
    break;

  case 36: // InitVals: InitVal Y_COMMA InitVals
#line 115 "./lib/parser/parser.y"
                                        { yystack_[2].value.as < std::shared_ptr<InitVal> > ()->next = yystack_[0].value.as < std::shared_ptr<InitVal> > (); yylhs.value.as < std::shared_ptr<InitVal> > () = yystack_[2].value.as < std::shared_ptr<InitVal> > (); }
#line 1127 "./lib/parser/parser.cpp"
    break;

  case 37: // FuncDef: Type Y_ID Y_LPAR Y_RPAR Block
#line 119 "./lib/parser/parser.y"
                                                        { yylhs.value.as < std::shared_ptr<FuncDef> > () = std::make_shared<FuncDef>(yystack_[4].value.as < AST::dtype > (), yystack_[3].value.as < AST::string > (), yystack_[0].value.as < std::shared_ptr<CompStmt> > ()); }
#line 1133 "./lib/parser/parser.cpp"
    break;

  case 38: // FuncDef: Type Y_ID Y_LPAR FuncFParams Y_RPAR Block
#line 120 "./lib/parser/parser.y"
                                                        { yylhs.value.as < std::shared_ptr<FuncDef> > () = std::make_shared<FuncDef>(yystack_[5].value.as < AST::dtype > (), yystack_[4].value.as < AST::string > (), yystack_[2].value.as < std::shared_ptr<FuncFParam> > (), yystack_[0].value.as < std::shared_ptr<CompStmt> > ()); }
#line 1139 "./lib/parser/parser.cpp"
    break;

  case 39: // FuncFParams: FuncFParam
#line 123 "./lib/parser/parser.y"
                                              { yylhs.value.as < std::shared_ptr<FuncFParam> > () = yystack_[0].value.as < std::shared_ptr<FuncFParam> > (); }
#line 1145 "./lib/parser/parser.cpp"
    break;

  case 40: // FuncFParams: FuncFParam Y_COMMA FuncFParams
#line 124 "./lib/parser/parser.y"
                                              { yystack_[2].value.as < std::shared_ptr<FuncFParam> > ()->next = yystack_[0].value.as < std::shared_ptr<FuncFParam> > (); yylhs.value.as < std::shared_ptr<FuncFParam> > () = yystack_[2].value.as < std::shared_ptr<FuncFParam> > (); }
#line 1151 "./lib/parser/parser.cpp"
    break;

  case 41: // FuncFParam: Type Y_ID
#line 127 "./lib/parser/parser.y"
                                                                { yylhs.value.as < std::shared_ptr<FuncFParam> > () = std::make_shared<FuncFParam>(yystack_[1].value.as < AST::dtype > (), yystack_[0].value.as < AST::string > ()); }
#line 1157 "./lib/parser/parser.cpp"
    break;

  case 42: // FuncFParam: Type Y_ID Y_LSQUARE Y_RSQUARE
#line 128 "./lib/parser/parser.y"
                                                                { yylhs.value.as < std::shared_ptr<FuncFParam> > () = std::make_shared<FuncFParam>(yystack_[3].value.as < AST::dtype > (), yystack_[2].value.as < AST::string > (), true); }
#line 1163 "./lib/parser/parser.cpp"
    break;

  case 43: // FuncFParam: Type Y_ID Y_LSQUARE Y_RSQUARE ArraySubscripts
#line 129 "./lib/parser/parser.y"
                                                                { yylhs.value.as < std::shared_ptr<FuncFParam> > () = std::make_shared<FuncFParam>(yystack_[4].value.as < AST::dtype > (), yystack_[3].value.as < AST::string > (), yystack_[0].value.as < std::shared_ptr<ArraySubscript> > ()); }
#line 1169 "./lib/parser/parser.cpp"
    break;

  case 44: // ArraySubscripts: Y_LSQUARE Exp Y_RSQUARE
#line 132 "./lib/parser/parser.y"
                                                                { yylhs.value.as < std::shared_ptr<ArraySubscript> > () = std::make_shared<ArraySubscript>(yystack_[1].value.as < std::shared_ptr<Exp> > ()); }
#line 1175 "./lib/parser/parser.cpp"
    break;

  case 45: // ArraySubscripts: Y_LSQUARE Exp Y_RSQUARE ArraySubscripts
#line 133 "./lib/parser/parser.y"
                                                                { auto p = std::make_shared<ArraySubscript>(yystack_[2].value.as < std::shared_ptr<Exp> > ()); p->next = yystack_[0].value.as < std::shared_ptr<ArraySubscript> > (); yylhs.value.as < std::shared_ptr<ArraySubscript> > () = p; }
#line 1181 "./lib/parser/parser.cpp"
    break;

  case 46: // Block: Y_LBRACKET Y_RBRACKET
#line 136 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<CompStmt> > () = std::make_shared<CompStmt>(); }
#line 1187 "./lib/parser/parser.cpp"
    break;

  case 47: // Block: Y_LBRACKET BlockItems Y_RBRACKET
#line 137 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<CompStmt> > () = yystack_[1].value.as < std::shared_ptr<CompStmt> > (); }
#line 1193 "./lib/parser/parser.cpp"
    break;

  case 48: // BlockItems: BlockItem
#line 140 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<CompStmt> > () = std::make_shared<CompStmt>(yystack_[0].value.as < std::shared_ptr<Stmt> > ()); }
#line 1199 "./lib/parser/parser.cpp"
    break;

  case 49: // BlockItems: BlockItems BlockItem
#line 141 "./lib/parser/parser.y"
                                        { yystack_[1].value.as < std::shared_ptr<CompStmt> > ()->addItem(yystack_[0].value.as < std::shared_ptr<Stmt> > ()); yylhs.value.as < std::shared_ptr<CompStmt> > () = yystack_[1].value.as < std::shared_ptr<CompStmt> > (); }
#line 1205 "./lib/parser/parser.cpp"
    break;

  case 50: // BlockItem: Decl
#line 144 "./lib/parser/parser.y"
                { yylhs.value.as < std::shared_ptr<Stmt> > () = yystack_[0].value.as < std::shared_ptr<Stmt> > (); }
#line 1211 "./lib/parser/parser.cpp"
    break;

  case 51: // BlockItem: Stmt
#line 145 "./lib/parser/parser.y"
                { yylhs.value.as < std::shared_ptr<Stmt> > () = yystack_[0].value.as < std::shared_ptr<Stmt> > (); }
#line 1217 "./lib/parser/parser.cpp"
    break;

  case 52: // Stmt: LVal Y_ASSIGN Exp Y_SEMICOLON
#line 148 "./lib/parser/parser.y"
                                                        { yylhs.value.as < std::shared_ptr<Stmt> > () = std::make_shared<BinaryOp>(BiOp::ASSIGN, yystack_[3].value.as < std::shared_ptr<Exp> > (), yystack_[1].value.as < std::shared_ptr<Exp> > ()); }
#line 1223 "./lib/parser/parser.cpp"
    break;

  case 53: // Stmt: Y_SEMICOLON
#line 149 "./lib/parser/parser.y"
                                                        { yylhs.value.as < std::shared_ptr<Stmt> > () = std::make_shared<NullStmt>(); }
#line 1229 "./lib/parser/parser.cpp"
    break;

  case 54: // Stmt: Exp Y_SEMICOLON
#line 150 "./lib/parser/parser.y"
                                                        { yylhs.value.as < std::shared_ptr<Stmt> > () = yystack_[1].value.as < std::shared_ptr<Exp> > (); }
#line 1235 "./lib/parser/parser.cpp"
    break;

  case 55: // Stmt: Block
#line 151 "./lib/parser/parser.y"
                                                        { yylhs.value.as < std::shared_ptr<Stmt> > () = yystack_[0].value.as < std::shared_ptr<CompStmt> > (); }
#line 1241 "./lib/parser/parser.cpp"
    break;

  case 56: // Stmt: Y_IF Y_LPAR LOrExp Y_RPAR Stmt
#line 152 "./lib/parser/parser.y"
                                                        { yylhs.value.as < std::shared_ptr<Stmt> > () = std::make_shared<IfStmt>(yystack_[2].value.as < std::shared_ptr<Exp> > (), yystack_[0].value.as < std::shared_ptr<Stmt> > ()); }
#line 1247 "./lib/parser/parser.cpp"
    break;

  case 57: // Stmt: Y_IF Y_LPAR LOrExp Y_RPAR Stmt Y_ELSE Stmt
#line 153 "./lib/parser/parser.y"
                                                        { yylhs.value.as < std::shared_ptr<Stmt> > () = std::make_shared<IfStmt>(yystack_[4].value.as < std::shared_ptr<Exp> > (), yystack_[2].value.as < std::shared_ptr<Stmt> > (), yystack_[0].value.as < std::shared_ptr<Stmt> > ()); }
#line 1253 "./lib/parser/parser.cpp"
    break;

  case 58: // Stmt: Y_WHILE Y_LPAR LOrExp Y_RPAR Stmt
#line 154 "./lib/parser/parser.y"
                                                        { yylhs.value.as < std::shared_ptr<Stmt> > () = std::make_shared<WhileStmt>(yystack_[2].value.as < std::shared_ptr<Exp> > (), yystack_[0].value.as < std::shared_ptr<Stmt> > ()); }
#line 1259 "./lib/parser/parser.cpp"
    break;

  case 59: // Stmt: Y_BREAK Y_SEMICOLON
#line 155 "./lib/parser/parser.y"
                                                        { yylhs.value.as < std::shared_ptr<Stmt> > () = std::make_shared<BreakStmt>(); }
#line 1265 "./lib/parser/parser.cpp"
    break;

  case 60: // Stmt: Y_CONTINUE Y_SEMICOLON
#line 156 "./lib/parser/parser.y"
                                                        { yylhs.value.as < std::shared_ptr<Stmt> > () = std::make_shared<ContinueStmt>(); }
#line 1271 "./lib/parser/parser.cpp"
    break;

  case 61: // Stmt: Y_RETURN Y_SEMICOLON
#line 157 "./lib/parser/parser.y"
                                                        { yylhs.value.as < std::shared_ptr<Stmt> > () = std::make_shared<ReturnStmt>(); }
#line 1277 "./lib/parser/parser.cpp"
    break;

  case 62: // Stmt: Y_RETURN Exp Y_SEMICOLON
#line 158 "./lib/parser/parser.y"
                                                        { yylhs.value.as < std::shared_ptr<Stmt> > () = std::make_shared<ReturnStmt>(yystack_[1].value.as < std::shared_ptr<Exp> > ()); }
#line 1283 "./lib/parser/parser.cpp"
    break;

  case 63: // Exp: AddExp
#line 161 "./lib/parser/parser.y"
                { yylhs.value.as < std::shared_ptr<Exp> > () = yystack_[0].value.as < std::shared_ptr<Exp> > (); }
#line 1289 "./lib/parser/parser.cpp"
    break;

  case 64: // LVal: Y_ID
#line 164 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<DeclRef>(yystack_[0].value.as < AST::string > ()); }
#line 1295 "./lib/parser/parser.cpp"
    break;

  case 65: // LVal: Y_ID ArraySubscripts
#line 165 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<ArrayExp>(std::make_shared<DeclRef>(yystack_[1].value.as < AST::string > ()), yystack_[0].value.as < std::shared_ptr<ArraySubscript> > ()); }
#line 1301 "./lib/parser/parser.cpp"
    break;

  case 66: // PrimaryExp: Y_LPAR Exp Y_RPAR
#line 168 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<ParenExp>(yystack_[1].value.as < std::shared_ptr<Exp> > ()); }
#line 1307 "./lib/parser/parser.cpp"
    break;

  case 67: // PrimaryExp: LVal
#line 169 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = yystack_[0].value.as < std::shared_ptr<Exp> > (); }
#line 1313 "./lib/parser/parser.cpp"
    break;

  case 68: // PrimaryExp: Number
#line 170 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = yystack_[0].value.as < std::shared_ptr<Exp> > (); }
#line 1319 "./lib/parser/parser.cpp"
    break;

  case 69: // Number: num_INT
#line 173 "./lib/parser/parser.y"
                            { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<IntLiteral>(yystack_[0].value.as < AST::int32 > ()); }
#line 1325 "./lib/parser/parser.cpp"
    break;

  case 70: // Number: num_FLOAT
#line 174 "./lib/parser/parser.y"
                            { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<FloatLiteral>(yystack_[0].value.as < AST::float32 > ()); }
#line 1331 "./lib/parser/parser.cpp"
    break;

  case 71: // UnaryExp: PrimaryExp
#line 177 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<Exp> > () = yystack_[0].value.as < std::shared_ptr<Exp> > (); }
#line 1337 "./lib/parser/parser.cpp"
    break;

  case 72: // UnaryExp: Y_ID Y_LPAR Y_RPAR
#line 178 "./lib/parser/parser.y"
                                        {
                                            if(yystack_[2].value.as < AST::string > () == "starttime")
                                            {
                                                yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<CallExp>(std::make_shared<DeclRef>("_sysy_starttime"), std::make_shared<FuncRParam>(std::make_shared<IntLiteral>(yylineno)));
                                            }
                                            else if(yystack_[2].value.as < AST::string > () == "stoptime")
                                            {
                                                yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<CallExp>(std::make_shared<DeclRef>("_sysy_stoptime"), std::make_shared<FuncRParam>(std::make_shared<IntLiteral>(yylineno)));
                                            }
                                            else
                                            {
                                                yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<CallExp>(std::make_shared<DeclRef>(yystack_[2].value.as < AST::string > ()));
                                            }
                                        }
#line 1356 "./lib/parser/parser.cpp"
    break;

  case 73: // UnaryExp: Y_ID Y_LPAR FuncRParams Y_RPAR
#line 192 "./lib/parser/parser.y"
                                         { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<CallExp>(std::make_shared<DeclRef>(yystack_[3].value.as < AST::string > ()), yystack_[1].value.as < std::shared_ptr<FuncRParam> > ()); }
#line 1362 "./lib/parser/parser.cpp"
    break;

  case 74: // UnaryExp: Y_ADD UnaryExp
#line 193 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<UnaryOp>(UnOp::ADD, yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1368 "./lib/parser/parser.cpp"
    break;

  case 75: // UnaryExp: Y_SUB UnaryExp
#line 194 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<UnaryOp>(UnOp::SUB, yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1374 "./lib/parser/parser.cpp"
    break;

  case 76: // UnaryExp: Y_NOT UnaryExp
#line 195 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<UnaryOp>(UnOp::NOT, yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1380 "./lib/parser/parser.cpp"
    break;

  case 77: // FuncRParams: Exp
#line 198 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<FuncRParam> > () = std::make_shared<FuncRParam>(yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1386 "./lib/parser/parser.cpp"
    break;

  case 78: // FuncRParams: Exp Y_COMMA FuncRParams
#line 199 "./lib/parser/parser.y"
                                        { auto p = std::make_shared<FuncRParam>(yystack_[2].value.as < std::shared_ptr<Exp> > ()); p->next = yystack_[0].value.as < std::shared_ptr<FuncRParam> > (); yylhs.value.as < std::shared_ptr<FuncRParam> > () = p; }
#line 1392 "./lib/parser/parser.cpp"
    break;

  case 79: // MulExp: UnaryExp
#line 202 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<Exp> > () = yystack_[0].value.as < std::shared_ptr<Exp> > (); }
#line 1398 "./lib/parser/parser.cpp"
    break;

  case 80: // MulExp: MulExp Y_MUL UnaryExp
#line 203 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<BinaryOp>(BiOp::MUL, yystack_[2].value.as < std::shared_ptr<Exp> > (), yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1404 "./lib/parser/parser.cpp"
    break;

  case 81: // MulExp: MulExp Y_DIV UnaryExp
#line 204 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<BinaryOp>(BiOp::DIV, yystack_[2].value.as < std::shared_ptr<Exp> > (), yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1410 "./lib/parser/parser.cpp"
    break;

  case 82: // MulExp: MulExp Y_MODULO UnaryExp
#line 205 "./lib/parser/parser.y"
                                        { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<BinaryOp>(BiOp::MOD, yystack_[2].value.as < std::shared_ptr<Exp> > (), yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1416 "./lib/parser/parser.cpp"
    break;

  case 83: // AddExp: MulExp
#line 208 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = yystack_[0].value.as < std::shared_ptr<Exp> > (); }
#line 1422 "./lib/parser/parser.cpp"
    break;

  case 84: // AddExp: AddExp Y_ADD MulExp
#line 209 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<BinaryOp>(BiOp::ADD, yystack_[2].value.as < std::shared_ptr<Exp> > (), yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1428 "./lib/parser/parser.cpp"
    break;

  case 85: // AddExp: AddExp Y_SUB MulExp
#line 210 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<BinaryOp>(BiOp::SUB, yystack_[2].value.as < std::shared_ptr<Exp> > (), yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1434 "./lib/parser/parser.cpp"
    break;

  case 86: // RelExp: AddExp
#line 213 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = yystack_[0].value.as < std::shared_ptr<Exp> > (); }
#line 1440 "./lib/parser/parser.cpp"
    break;

  case 87: // RelExp: RelExp Y_LESS AddExp
#line 214 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<BinaryOp>(BiOp::LESS, yystack_[2].value.as < std::shared_ptr<Exp> > (), yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1446 "./lib/parser/parser.cpp"
    break;

  case 88: // RelExp: RelExp Y_GREAT AddExp
#line 215 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<BinaryOp>(BiOp::GREAT, yystack_[2].value.as < std::shared_ptr<Exp> > (), yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1452 "./lib/parser/parser.cpp"
    break;

  case 89: // RelExp: RelExp Y_LESSEQ AddExp
#line 216 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<BinaryOp>(BiOp::LESSEQ, yystack_[2].value.as < std::shared_ptr<Exp> > (), yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1458 "./lib/parser/parser.cpp"
    break;

  case 90: // RelExp: RelExp Y_GREATEQ AddExp
#line 217 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<BinaryOp>(BiOp::GREATEQ, yystack_[2].value.as < std::shared_ptr<Exp> > (), yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1464 "./lib/parser/parser.cpp"
    break;

  case 91: // EqExp: RelExp
#line 220 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = yystack_[0].value.as < std::shared_ptr<Exp> > (); }
#line 1470 "./lib/parser/parser.cpp"
    break;

  case 92: // EqExp: EqExp Y_EQ RelExp
#line 221 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<BinaryOp>(BiOp::EQ, yystack_[2].value.as < std::shared_ptr<Exp> > (), yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1476 "./lib/parser/parser.cpp"
    break;

  case 93: // EqExp: EqExp Y_NOTEQ RelExp
#line 222 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<BinaryOp>(BiOp::NOTEQ, yystack_[2].value.as < std::shared_ptr<Exp> > (), yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1482 "./lib/parser/parser.cpp"
    break;

  case 94: // LAndExp: EqExp
#line 225 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = yystack_[0].value.as < std::shared_ptr<Exp> > (); }
#line 1488 "./lib/parser/parser.cpp"
    break;

  case 95: // LAndExp: LAndExp Y_AND EqExp
#line 226 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<BinaryOp>(BiOp::AND, yystack_[2].value.as < std::shared_ptr<Exp> > (), yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1494 "./lib/parser/parser.cpp"
    break;

  case 96: // LOrExp: LAndExp
#line 229 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = yystack_[0].value.as < std::shared_ptr<Exp> > (); }
#line 1500 "./lib/parser/parser.cpp"
    break;

  case 97: // LOrExp: LOrExp Y_OR LAndExp
#line 230 "./lib/parser/parser.y"
                                { yylhs.value.as < std::shared_ptr<Exp> > () = std::make_shared<BinaryOp>(BiOp::OR, yystack_[2].value.as < std::shared_ptr<Exp> > (), yystack_[0].value.as < std::shared_ptr<Exp> > ()); }
#line 1506 "./lib/parser/parser.cpp"
    break;


#line 1510 "./lib/parser/parser.cpp"

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









  const short parser::yypact_ninf_ = -139;

  const signed char parser::yytable_ninf_ = -1;

  const short
  parser::yypact_[] =
  {
      20,  -139,  -139,     7,  -139,     8,    20,  -139,   -23,  -139,
    -139,  -139,   -16,  -139,  -139,  -139,    30,    -5,    16,    50,
      29,    47,    55,     2,   223,    74,  -139,    51,   196,    86,
    -139,   -16,   223,   223,   223,   223,    84,  -139,  -139,    63,
    -139,  -139,  -139,  -139,  -139,  -139,   130,    92,    69,    85,
      82,   103,   111,    92,    55,    57,  -139,   184,  -139,  -139,
     196,  -139,  -139,  -139,  -139,   123,  -139,   120,   124,   203,
     223,  -139,   223,   223,   223,   223,   223,   129,  -139,   126,
      69,     7,   131,  -139,  -139,   122,   142,  -139,  -139,    55,
    -139,  -139,   127,   133,   147,  -139,  -139,  -139,   130,   130,
     153,   154,   148,   149,   215,  -139,  -139,  -139,    51,  -139,
     165,  -139,  -139,   150,   159,   155,  -139,  -139,  -139,   196,
    -139,  -139,   223,  -139,   158,   223,   223,  -139,  -139,  -139,
     152,  -139,  -139,  -139,   223,   158,  -139,  -139,  -139,    92,
      99,    17,   166,    49,    81,  -139,   157,  -139,   223,   223,
     223,   223,   223,   223,   223,   223,    35,    35,  -139,    92,
      92,    92,    92,    99,    99,    17,   166,   186,  -139,    35,
    -139
  };

  const signed char
  parser::yydefact_[] =
  {
       0,     9,    11,     0,    10,     0,     2,     5,     0,     7,
       8,     6,     0,     1,     3,     4,    28,     0,    26,     0,
       0,    13,     0,     0,     0,    29,    25,     0,     0,     0,
      12,     0,     0,     0,     0,     0,     0,    69,    70,    64,
      30,    32,    67,    71,    68,    79,    83,    63,     0,     0,
       0,    39,     0,    19,     0,    28,    27,     0,    20,    15,
       0,    14,    74,    75,    76,     0,    33,    35,     0,     0,
       0,    65,     0,     0,     0,     0,     0,     0,    37,    41,
       0,     0,    17,    31,    21,    23,     0,    16,    66,     0,
      34,    72,    77,     0,     0,    80,    81,    82,    84,    85,
       0,     0,     0,     0,     0,    46,    53,    50,     0,    55,
       0,    48,    51,     0,    67,     0,    38,    40,    18,     0,
      22,    36,     0,    73,    44,     0,     0,    59,    60,    61,
       0,    47,    49,    54,     0,    42,    24,    78,    45,    86,
      91,    94,    96,     0,     0,    62,     0,    43,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,    52,    87,
      89,    88,    90,    93,    92,    95,    97,    56,    58,     0,
      57
  };

  const short
  parser::yypgoto_[] =
  {
    -139,  -139,  -139,    26,    -2,  -139,   167,  -139,   -17,   180,
      -1,    87,  -139,   178,  -139,     6,   121,   206,   136,  -139,
    -115,   -14,  -139,   108,  -138,   -19,   -70,  -139,  -139,   -20,
     102,    72,   -24,    -3,    75,    88,   118
  };

  const unsigned char
  parser::yydefgoto_[] =
  {
       0,     5,     6,   107,     8,     9,    20,    21,    25,    58,
      85,    86,    10,    17,    18,    67,    68,    11,    50,    51,
      71,   109,   110,   111,   112,   113,    42,    43,    44,    45,
      93,    46,    47,   140,   141,   142,   143
  };

  const unsigned char
  parser::yytable_[] =
  {
      53,    12,    29,    41,    53,     1,     2,   114,    13,   138,
       1,     2,    62,    63,    64,    16,    65,    41,   167,   168,
     147,    49,    19,     1,     2,     3,     7,    59,    40,    26,
      48,   170,    14,    53,    78,    41,    53,     4,   152,   153,
     114,   100,     4,   101,   102,   103,   104,    32,    33,    27,
      92,    94,    95,    96,    97,     4,    22,    23,    34,    87,
      83,    24,    35,    30,    77,   118,   116,    32,    33,   106,
      41,    37,    38,    39,   155,   108,    28,   156,    34,    49,
      31,    24,    35,    22,    36,   130,   114,   114,    24,    55,
      69,    37,    38,    39,    70,    53,    32,    33,    77,   114,
      54,   139,   139,    92,    75,    76,   155,    34,   108,   157,
      80,    35,    60,    36,    66,   146,   148,   149,   150,   151,
      37,    38,    39,    79,   159,   160,   161,   162,   139,   139,
     139,   139,     1,     2,     3,   100,    81,   101,   102,   103,
     104,    32,    33,    82,    72,    73,    74,    98,    99,   163,
     164,    88,    34,    89,    90,   119,    35,   115,    77,   105,
     122,   123,    24,   106,     4,    37,    38,    39,     1,     2,
       3,   100,   120,   101,   102,   103,   104,    32,    33,   124,
     125,   126,   127,   128,   133,   134,   145,   135,    34,    70,
     154,   158,    35,   169,    77,   131,    32,    33,    61,   106,
       4,    37,    38,    39,    52,    56,   136,    34,    32,    33,
     121,    35,    15,    57,    84,    32,    33,   117,   132,    34,
      37,    38,    39,    35,   137,    57,    34,    32,    33,   165,
      35,    91,    37,    38,    39,    32,    33,     0,    34,    37,
      38,    39,    35,   166,   144,     0,    34,     0,     0,   129,
      35,    37,    38,    39,     0,     0,     0,     0,     0,    37,
      38,    39
  };

  const short
  parser::yycheck_[] =
  {
      24,     3,    19,    22,    28,     3,     4,    77,     0,   124,
       3,     4,    32,    33,    34,    38,    35,    36,   156,   157,
     135,    23,    38,     3,     4,     5,     0,    28,    22,    34,
      28,   169,     6,    57,    48,    54,    60,    35,    21,    22,
     110,     6,    35,     8,     9,    10,    11,    12,    13,    33,
      69,    70,    72,    73,    74,    35,    26,    27,    23,    60,
      54,    31,    27,    34,    29,    82,    80,    12,    13,    34,
      89,    36,    37,    38,    25,    77,    26,    28,    23,    81,
      33,    31,    27,    26,    29,   104,   156,   157,    31,    38,
      27,    36,    37,    38,    31,   119,    12,    13,    29,   169,
      26,   125,   126,   122,    12,    13,    25,    23,   110,    28,
      28,    27,    26,    29,    30,   134,    17,    18,    19,    20,
      36,    37,    38,    38,   148,   149,   150,   151,   152,   153,
     154,   155,     3,     4,     5,     6,    33,     8,     9,    10,
      11,    12,    13,    32,    14,    15,    16,    75,    76,   152,
     153,    28,    23,    33,    30,    33,    27,    31,    29,    30,
      33,    28,    31,    34,    35,    36,    37,    38,     3,     4,
       5,     6,    30,     8,     9,    10,    11,    12,    13,    32,
      27,    27,    34,    34,    34,    26,    34,    32,    23,    31,
      24,    34,    27,     7,    29,    30,    12,    13,    31,    34,
      35,    36,    37,    38,    24,    27,   119,    23,    12,    13,
      89,    27,     6,    29,    30,    12,    13,    81,   110,    23,
      36,    37,    38,    27,   122,    29,    23,    12,    13,   154,
      27,    28,    36,    37,    38,    12,    13,    -1,    23,    36,
      37,    38,    27,   155,   126,    -1,    23,    -1,    -1,    34,
      27,    36,    37,    38,    -1,    -1,    -1,    -1,    -1,    36,
      37,    38
  };

  const signed char
  parser::yystos_[] =
  {
       0,     3,     4,     5,    35,    40,    41,    42,    43,    44,
      51,    56,    43,     0,    42,    56,    38,    52,    53,    38,
      45,    46,    26,    27,    31,    47,    34,    33,    26,    47,
      34,    33,    12,    13,    23,    27,    29,    36,    37,    38,
      54,    64,    65,    66,    67,    68,    70,    71,    28,    43,
      57,    58,    48,    71,    26,    38,    52,    29,    48,    49,
      26,    45,    68,    68,    68,    64,    30,    54,    55,    27,
      31,    59,    14,    15,    16,    12,    13,    29,    60,    38,
      28,    33,    32,    54,    30,    49,    50,    49,    28,    33,
      30,    28,    64,    69,    64,    68,    68,    68,    70,    70,
       6,     8,     9,    10,    11,    30,    34,    42,    43,    60,
      61,    62,    63,    64,    65,    31,    60,    57,    47,    33,
      30,    55,    33,    28,    32,    27,    27,    34,    34,    34,
      64,    30,    62,    34,    26,    32,    50,    69,    59,    71,
      72,    73,    74,    75,    75,    34,    64,    59,    17,    18,
      19,    20,    21,    22,    24,    25,    28,    28,    34,    71,
      71,    71,    71,    72,    72,    73,    74,    63,    63,     7,
      63
  };

  const signed char
  parser::yyr1_[] =
  {
       0,    39,    40,    41,    41,    41,    41,    42,    42,    43,
      43,    43,    44,    45,    45,    46,    46,    47,    47,    48,
      49,    49,    49,    50,    50,    51,    52,    52,    53,    53,
      53,    53,    54,    54,    54,    55,    55,    56,    56,    57,
      57,    58,    58,    58,    59,    59,    60,    60,    61,    61,
      62,    62,    63,    63,    63,    63,    63,    63,    63,    63,
      63,    63,    63,    64,    65,    65,    66,    66,    66,    67,
      67,    68,    68,    68,    68,    68,    68,    69,    69,    70,
      70,    70,    70,    71,    71,    71,    72,    72,    72,    72,
      72,    73,    73,    73,    74,    74,    75,    75
  };

  const signed char
  parser::yyr2_[] =
  {
       0,     2,     1,     2,     2,     1,     1,     1,     1,     1,
       1,     1,     4,     1,     3,     3,     4,     3,     4,     1,
       1,     2,     3,     1,     3,     3,     1,     3,     1,     2,
       3,     4,     1,     2,     3,     1,     3,     5,     6,     1,
       3,     2,     4,     5,     3,     4,     2,     3,     1,     2,
       1,     1,     4,     1,     2,     1,     5,     7,     5,     2,
       2,     2,     3,     1,     1,     2,     3,     1,     1,     1,
       1,     1,     3,     4,     2,     2,     2,     1,     3,     1,
       3,     3,     3,     1,     3,     3,     1,     3,     3,     3,
       3,     1,     3,     3,     1,     3,     1,     3
  };


#if YYDEBUG
  // YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
  // First, the terminals, then, starting at \a YYNTOKENS, nonterminals.
  const char*
  const parser::yytname_[] =
  {
  "\"end of file\"", "error", "\"invalid token\"", "Y_INT", "Y_VOID",
  "Y_CONST", "Y_IF", "Y_ELSE", "Y_WHILE", "Y_BREAK", "Y_CONTINUE",
  "Y_RETURN", "Y_ADD", "Y_SUB", "Y_MUL", "Y_DIV", "Y_MODULO", "Y_LESS",
  "Y_LESSEQ", "Y_GREAT", "Y_GREATEQ", "Y_NOTEQ", "Y_EQ", "Y_NOT", "Y_AND",
  "Y_OR", "Y_ASSIGN", "Y_LPAR", "Y_RPAR", "Y_LBRACKET", "Y_RBRACKET",
  "Y_LSQUARE", "Y_RSQUARE", "Y_COMMA", "Y_SEMICOLON", "Y_FLOAT", "num_INT",
  "num_FLOAT", "Y_ID", "$accept", "CompileUnit", "CompUnit", "Decl",
  "Type", "ConstDecl", "ConstDefs", "ConstDef", "ConstAS", "ConstExp",
  "ConstInitVal", "ConstInitVals", "VarDecl", "VarDefs", "VarDef",
  "InitVal", "InitVals", "FuncDef", "FuncFParams", "FuncFParam",
  "ArraySubscripts", "Block", "BlockItems", "BlockItem", "Stmt", "Exp",
  "LVal", "PrimaryExp", "Number", "UnaryExp", "FuncRParams", "MulExp",
  "AddExp", "RelExp", "EqExp", "LAndExp", "LOrExp", YY_NULLPTR
  };
#endif


#if YYDEBUG
  const unsigned char
  parser::yyrline_[] =
  {
       0,    48,    48,    51,    52,    53,    54,    58,    59,    62,
      63,    64,    68,    71,    72,    75,    76,    79,    80,    83,
      86,    87,    88,    91,    92,    96,    99,   100,   103,   104,
     105,   106,   109,   110,   111,   114,   115,   119,   120,   123,
     124,   127,   128,   129,   132,   133,   136,   137,   140,   141,
     144,   145,   148,   149,   150,   151,   152,   153,   154,   155,
     156,   157,   158,   161,   164,   165,   168,   169,   170,   173,
     174,   177,   178,   192,   193,   194,   195,   198,   199,   202,
     203,   204,   205,   208,   209,   210,   213,   214,   215,   216,
     217,   220,   221,   222,   225,   226,   229,   230
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


} // yy
#line 1953 "./lib/parser/parser.cpp"

#line 233 "./lib/parser/parser.y"


void
yy::parser::error (const std::string& msg) { 
      std::cerr << "Error: " << msg << std::endl; 
}
