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





#include "../../include/parser/parser.hpp"


// Unqualified %code blocks.
#line 7 "./lib/parser/parser.y"


#include "../../include/parser/ast.hpp"
extern "C" int yylex();
using namespace AST;


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
      case symbol_kind::S_num_FLOAT: // num_FLOAT
        value.YY_MOVE_OR_COPY< AST::float32 > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_num_INT: // num_INT
        value.YY_MOVE_OR_COPY< AST::int32 > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_CompUnit: // CompUnit
      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_ConstDecl: // ConstDecl
      case symbol_kind::S_ConstDefs: // ConstDefs
      case symbol_kind::S_ConstDef: // ConstDef
      case symbol_kind::S_ConstExps: // ConstExps
      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_VarDecl: // VarDecl
      case symbol_kind::S_VarDecls: // VarDecls
      case symbol_kind::S_VarDef: // VarDef
      case symbol_kind::S_InitVal: // InitVal
      case symbol_kind::S_InitVals: // InitVals
      case symbol_kind::S_FuncDef: // FuncDef
      case symbol_kind::S_FuncParams: // FuncParams
      case symbol_kind::S_FuncParam: // FuncParam
      case symbol_kind::S_Block: // Block
      case symbol_kind::S_BlockItems: // BlockItems
      case symbol_kind::S_BlockItem: // BlockItem
      case symbol_kind::S_Stmt: // Stmt
      case symbol_kind::S_Exp: // Exp
      case symbol_kind::S_LVal: // LVal
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
      case symbol_kind::S_PrimaryExp: // PrimaryExp
      case symbol_kind::S_UnaryExp: // UnaryExp
      case symbol_kind::S_CallParams: // CallParams
      case symbol_kind::S_MulExp: // MulExp
      case symbol_kind::S_AddExp: // AddExp
      case symbol_kind::S_RelExp: // RelExp
      case symbol_kind::S_EqExp: // EqExp
      case symbol_kind::S_LAndExp: // LAndExp
      case symbol_kind::S_LOrExp: // LOrExp
      case symbol_kind::S_ConstExp: // ConstExp
        value.YY_MOVE_OR_COPY< AST::past > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        value.YY_MOVE_OR_COPY< AST::string > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Type: // Type
        value.YY_MOVE_OR_COPY< AST::token_type > (YY_MOVE (that.value));
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
      case symbol_kind::S_num_FLOAT: // num_FLOAT
        value.move< AST::float32 > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_num_INT: // num_INT
        value.move< AST::int32 > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_CompUnit: // CompUnit
      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_ConstDecl: // ConstDecl
      case symbol_kind::S_ConstDefs: // ConstDefs
      case symbol_kind::S_ConstDef: // ConstDef
      case symbol_kind::S_ConstExps: // ConstExps
      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_VarDecl: // VarDecl
      case symbol_kind::S_VarDecls: // VarDecls
      case symbol_kind::S_VarDef: // VarDef
      case symbol_kind::S_InitVal: // InitVal
      case symbol_kind::S_InitVals: // InitVals
      case symbol_kind::S_FuncDef: // FuncDef
      case symbol_kind::S_FuncParams: // FuncParams
      case symbol_kind::S_FuncParam: // FuncParam
      case symbol_kind::S_Block: // Block
      case symbol_kind::S_BlockItems: // BlockItems
      case symbol_kind::S_BlockItem: // BlockItem
      case symbol_kind::S_Stmt: // Stmt
      case symbol_kind::S_Exp: // Exp
      case symbol_kind::S_LVal: // LVal
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
      case symbol_kind::S_PrimaryExp: // PrimaryExp
      case symbol_kind::S_UnaryExp: // UnaryExp
      case symbol_kind::S_CallParams: // CallParams
      case symbol_kind::S_MulExp: // MulExp
      case symbol_kind::S_AddExp: // AddExp
      case symbol_kind::S_RelExp: // RelExp
      case symbol_kind::S_EqExp: // EqExp
      case symbol_kind::S_LAndExp: // LAndExp
      case symbol_kind::S_LOrExp: // LOrExp
      case symbol_kind::S_ConstExp: // ConstExp
        value.move< AST::past > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        value.move< AST::string > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Type: // Type
        value.move< AST::token_type > (YY_MOVE (that.value));
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
      case symbol_kind::S_num_FLOAT: // num_FLOAT
        value.copy< AST::float32 > (that.value);
        break;

      case symbol_kind::S_num_INT: // num_INT
        value.copy< AST::int32 > (that.value);
        break;

      case symbol_kind::S_CompUnit: // CompUnit
      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_ConstDecl: // ConstDecl
      case symbol_kind::S_ConstDefs: // ConstDefs
      case symbol_kind::S_ConstDef: // ConstDef
      case symbol_kind::S_ConstExps: // ConstExps
      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_VarDecl: // VarDecl
      case symbol_kind::S_VarDecls: // VarDecls
      case symbol_kind::S_VarDef: // VarDef
      case symbol_kind::S_InitVal: // InitVal
      case symbol_kind::S_InitVals: // InitVals
      case symbol_kind::S_FuncDef: // FuncDef
      case symbol_kind::S_FuncParams: // FuncParams
      case symbol_kind::S_FuncParam: // FuncParam
      case symbol_kind::S_Block: // Block
      case symbol_kind::S_BlockItems: // BlockItems
      case symbol_kind::S_BlockItem: // BlockItem
      case symbol_kind::S_Stmt: // Stmt
      case symbol_kind::S_Exp: // Exp
      case symbol_kind::S_LVal: // LVal
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
      case symbol_kind::S_PrimaryExp: // PrimaryExp
      case symbol_kind::S_UnaryExp: // UnaryExp
      case symbol_kind::S_CallParams: // CallParams
      case symbol_kind::S_MulExp: // MulExp
      case symbol_kind::S_AddExp: // AddExp
      case symbol_kind::S_RelExp: // RelExp
      case symbol_kind::S_EqExp: // EqExp
      case symbol_kind::S_LAndExp: // LAndExp
      case symbol_kind::S_LOrExp: // LOrExp
      case symbol_kind::S_ConstExp: // ConstExp
        value.copy< AST::past > (that.value);
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        value.copy< AST::string > (that.value);
        break;

      case symbol_kind::S_Type: // Type
        value.copy< AST::token_type > (that.value);
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
      case symbol_kind::S_num_FLOAT: // num_FLOAT
        value.move< AST::float32 > (that.value);
        break;

      case symbol_kind::S_num_INT: // num_INT
        value.move< AST::int32 > (that.value);
        break;

      case symbol_kind::S_CompUnit: // CompUnit
      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_ConstDecl: // ConstDecl
      case symbol_kind::S_ConstDefs: // ConstDefs
      case symbol_kind::S_ConstDef: // ConstDef
      case symbol_kind::S_ConstExps: // ConstExps
      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_VarDecl: // VarDecl
      case symbol_kind::S_VarDecls: // VarDecls
      case symbol_kind::S_VarDef: // VarDef
      case symbol_kind::S_InitVal: // InitVal
      case symbol_kind::S_InitVals: // InitVals
      case symbol_kind::S_FuncDef: // FuncDef
      case symbol_kind::S_FuncParams: // FuncParams
      case symbol_kind::S_FuncParam: // FuncParam
      case symbol_kind::S_Block: // Block
      case symbol_kind::S_BlockItems: // BlockItems
      case symbol_kind::S_BlockItem: // BlockItem
      case symbol_kind::S_Stmt: // Stmt
      case symbol_kind::S_Exp: // Exp
      case symbol_kind::S_LVal: // LVal
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
      case symbol_kind::S_PrimaryExp: // PrimaryExp
      case symbol_kind::S_UnaryExp: // UnaryExp
      case symbol_kind::S_CallParams: // CallParams
      case symbol_kind::S_MulExp: // MulExp
      case symbol_kind::S_AddExp: // AddExp
      case symbol_kind::S_RelExp: // RelExp
      case symbol_kind::S_EqExp: // EqExp
      case symbol_kind::S_LAndExp: // LAndExp
      case symbol_kind::S_LOrExp: // LOrExp
      case symbol_kind::S_ConstExp: // ConstExp
        value.move< AST::past > (that.value);
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        value.move< AST::string > (that.value);
        break;

      case symbol_kind::S_Type: // Type
        value.move< AST::token_type > (that.value);
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
      case symbol_kind::S_num_FLOAT: // num_FLOAT
        yylhs.value.emplace< AST::float32 > ();
        break;

      case symbol_kind::S_num_INT: // num_INT
        yylhs.value.emplace< AST::int32 > ();
        break;

      case symbol_kind::S_CompUnit: // CompUnit
      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_ConstDecl: // ConstDecl
      case symbol_kind::S_ConstDefs: // ConstDefs
      case symbol_kind::S_ConstDef: // ConstDef
      case symbol_kind::S_ConstExps: // ConstExps
      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_VarDecl: // VarDecl
      case symbol_kind::S_VarDecls: // VarDecls
      case symbol_kind::S_VarDef: // VarDef
      case symbol_kind::S_InitVal: // InitVal
      case symbol_kind::S_InitVals: // InitVals
      case symbol_kind::S_FuncDef: // FuncDef
      case symbol_kind::S_FuncParams: // FuncParams
      case symbol_kind::S_FuncParam: // FuncParam
      case symbol_kind::S_Block: // Block
      case symbol_kind::S_BlockItems: // BlockItems
      case symbol_kind::S_BlockItem: // BlockItem
      case symbol_kind::S_Stmt: // Stmt
      case symbol_kind::S_Exp: // Exp
      case symbol_kind::S_LVal: // LVal
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
      case symbol_kind::S_PrimaryExp: // PrimaryExp
      case symbol_kind::S_UnaryExp: // UnaryExp
      case symbol_kind::S_CallParams: // CallParams
      case symbol_kind::S_MulExp: // MulExp
      case symbol_kind::S_AddExp: // AddExp
      case symbol_kind::S_RelExp: // RelExp
      case symbol_kind::S_EqExp: // EqExp
      case symbol_kind::S_LAndExp: // LAndExp
      case symbol_kind::S_LOrExp: // LOrExp
      case symbol_kind::S_ConstExp: // ConstExp
        yylhs.value.emplace< AST::past > ();
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        yylhs.value.emplace< AST::string > ();
        break;

      case symbol_kind::S_Type: // Type
        yylhs.value.emplace< AST::token_type > ();
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
#line 37 "./lib/parser/parser.y"
                        { showAst(yystack_[0].value.as < AST::past > (), 0, true); }
#line 768 "./lib/parser/parser.cpp"
    break;

  case 3: // CompUnit: Decl CompUnit
#line 40 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = addNode(yystack_[1].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 774 "./lib/parser/parser.cpp"
    break;

  case 4: // CompUnit: FuncDef CompUnit
#line 41 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = addNode(yystack_[1].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 780 "./lib/parser/parser.cpp"
    break;

  case 5: // CompUnit: Decl
#line 42 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 786 "./lib/parser/parser.cpp"
    break;

  case 6: // CompUnit: FuncDef
#line 43 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 792 "./lib/parser/parser.cpp"
    break;

  case 7: // Decl: ConstDecl
#line 46 "./lib/parser/parser.y"
                    { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 798 "./lib/parser/parser.cpp"
    break;

  case 8: // Decl: VarDecl
#line 47 "./lib/parser/parser.y"
                    { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 804 "./lib/parser/parser.cpp"
    break;

  case 9: // ConstDecl: Y_CONST Type ConstDef Y_SEMICOLON
#line 50 "./lib/parser/parser.y"
                                                { SetDeclsType(yystack_[1].value.as < AST::past > (), yystack_[2].value.as < AST::token_type > ()); yylhs.value.as < AST::past > () = yystack_[1].value.as < AST::past > (); }
#line 810 "./lib/parser/parser.cpp"
    break;

  case 10: // ConstDecl: Y_CONST Type ConstDefs Y_SEMICOLON
#line 51 "./lib/parser/parser.y"
                                                { SetDeclsType(yystack_[1].value.as < AST::past > (), yystack_[2].value.as < AST::token_type > ()); yylhs.value.as < AST::past > () = yystack_[1].value.as < AST::past > (); }
#line 816 "./lib/parser/parser.cpp"
    break;

  case 11: // ConstDefs: ConstDef Y_COMMA ConstDef
#line 54 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = addNode(yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 822 "./lib/parser/parser.cpp"
    break;

  case 12: // ConstDefs: ConstDefs Y_COMMA ConstDef
#line 55 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = addNode(yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 828 "./lib/parser/parser.cpp"
    break;

  case 13: // ConstDef: Y_ID Y_ASSIGN ConstInitVal
#line 58 "./lib/parser/parser.y"
                                                { yylhs.value.as < AST::past > () = newVarDecl(UNDEFINED, yystack_[2].value.as < AST::string > (), yystack_[0].value.as < AST::past > (), NULL); }
#line 834 "./lib/parser/parser.cpp"
    break;

  case 14: // ConstDef: Y_ID ConstExps Y_ASSIGN ConstInitVal
#line 59 "./lib/parser/parser.y"
                                                { yylhs.value.as < AST::past > () = newVarDecl(UNDEFINED, yystack_[3].value.as < AST::string > (), yystack_[0].value.as < AST::past > (), NULL); }
#line 840 "./lib/parser/parser.cpp"
    break;

  case 15: // ConstExps: Y_LSQUARE ConstExp Y_RSQUARE
#line 62 "./lib/parser/parser.y"
                                                    { yylhs.value.as < AST::past > () = yystack_[1].value.as < AST::past > (); }
#line 846 "./lib/parser/parser.cpp"
    break;

  case 16: // ConstExps: Y_LSQUARE ConstExp Y_RSQUARE ConstExps
#line 63 "./lib/parser/parser.y"
                                                    { yylhs.value.as < AST::past > () = addNode(yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 852 "./lib/parser/parser.cpp"
    break;

  case 17: // ConstInitVal: ConstExp
#line 66 "./lib/parser/parser.y"
                                                                { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 858 "./lib/parser/parser.cpp"
    break;

  case 18: // ConstInitVal: Y_LBRACKET Y_RBRACKET
#line 67 "./lib/parser/parser.y"
                                                                { yylhs.value.as < AST::past > () = newInitList(NULL, NULL); }
#line 864 "./lib/parser/parser.cpp"
    break;

  case 19: // ConstInitVal: Y_LBRACKET ConstInitVal Y_RBRACKET
#line 68 "./lib/parser/parser.y"
                                                                { yylhs.value.as < AST::past > () = newInitList(yystack_[1].value.as < AST::past > (), NULL); }
#line 870 "./lib/parser/parser.cpp"
    break;

  case 20: // ConstInitVal: Y_LBRACKET ConstInitVal ConstInitVals Y_RBRACKET
#line 69 "./lib/parser/parser.y"
                                                                { yylhs.value.as < AST::past > () = newInitList(yystack_[2].value.as < AST::past > (), yystack_[1].value.as < AST::past > ()); }
#line 876 "./lib/parser/parser.cpp"
    break;

  case 21: // ConstInitVals: Y_COMMA ConstInitVal
#line 72 "./lib/parser/parser.y"
                                                    { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 882 "./lib/parser/parser.cpp"
    break;

  case 22: // ConstInitVals: Y_COMMA ConstInitVal ConstInitVals
#line 73 "./lib/parser/parser.y"
                                                    { yylhs.value.as < AST::past > () = addNode(yystack_[1].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 888 "./lib/parser/parser.cpp"
    break;

  case 23: // VarDecl: Type VarDef Y_SEMICOLON
#line 76 "./lib/parser/parser.y"
                                            { SetDeclsType(yystack_[1].value.as < AST::past > (), yystack_[2].value.as < AST::token_type > ()); yylhs.value.as < AST::past > () = yystack_[1].value.as < AST::past > (); }
#line 894 "./lib/parser/parser.cpp"
    break;

  case 24: // VarDecl: Type VarDef VarDecls Y_SEMICOLON
#line 77 "./lib/parser/parser.y"
                                            { addNode(yystack_[2].value.as < AST::past > (), yystack_[1].value.as < AST::past > ()); SetDeclsType(yystack_[2].value.as < AST::past > (), yystack_[3].value.as < AST::token_type > ()); yylhs.value.as < AST::past > () = yystack_[2].value.as < AST::past > (); }
#line 900 "./lib/parser/parser.cpp"
    break;

  case 25: // VarDecls: Y_COMMA VarDef
#line 80 "./lib/parser/parser.y"
                                    { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 906 "./lib/parser/parser.cpp"
    break;

  case 26: // VarDecls: Y_COMMA VarDef VarDecls
#line 81 "./lib/parser/parser.y"
                                    { yylhs.value.as < AST::past > () = addNode(yystack_[1].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 912 "./lib/parser/parser.cpp"
    break;

  case 27: // VarDef: Y_ID
#line 84 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = newVarDecl(UNDEFINED, yystack_[0].value.as < AST::string > (), NULL, NULL); }
#line 918 "./lib/parser/parser.cpp"
    break;

  case 28: // VarDef: Y_ID Y_ASSIGN InitVal
#line 85 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = newVarDecl(UNDEFINED, yystack_[2].value.as < AST::string > (), yystack_[0].value.as < AST::past > (), NULL); }
#line 924 "./lib/parser/parser.cpp"
    break;

  case 29: // VarDef: Y_ID ConstExps
#line 86 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = newVarDecl(UNDEFINED, yystack_[1].value.as < AST::string > (), NULL, NULL); }
#line 930 "./lib/parser/parser.cpp"
    break;

  case 30: // VarDef: Y_ID ConstExps Y_ASSIGN InitVal
#line 87 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = newVarDecl(UNDEFINED, yystack_[3].value.as < AST::string > (), yystack_[0].value.as < AST::past > (), NULL); }
#line 936 "./lib/parser/parser.cpp"
    break;

  case 31: // InitVal: Exp
#line 90 "./lib/parser/parser.y"
                                                { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 942 "./lib/parser/parser.cpp"
    break;

  case 32: // InitVal: Y_LBRACKET Y_RBRACKET
#line 91 "./lib/parser/parser.y"
                                                { yylhs.value.as < AST::past > () = newInitList(NULL, NULL); }
#line 948 "./lib/parser/parser.cpp"
    break;

  case 33: // InitVal: Y_LBRACKET InitVal Y_RBRACKET
#line 92 "./lib/parser/parser.y"
                                                { yylhs.value.as < AST::past > () = newInitList(yystack_[1].value.as < AST::past > (), NULL); }
#line 954 "./lib/parser/parser.cpp"
    break;

  case 34: // InitVal: Y_LBRACKET InitVal InitVals Y_RBRACKET
#line 93 "./lib/parser/parser.y"
                                                { yylhs.value.as < AST::past > () = newInitList(yystack_[2].value.as < AST::past > (), yystack_[1].value.as < AST::past > ()); }
#line 960 "./lib/parser/parser.cpp"
    break;

  case 35: // InitVals: Y_COMMA InitVal
#line 96 "./lib/parser/parser.y"
                                    { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 966 "./lib/parser/parser.cpp"
    break;

  case 36: // InitVals: Y_COMMA InitVal InitVals
#line 97 "./lib/parser/parser.y"
                                    { yylhs.value.as < AST::past > () = addNode(yystack_[1].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 972 "./lib/parser/parser.cpp"
    break;

  case 37: // FuncDef: Type Y_ID Y_LPAR Y_RPAR Block
#line 100 "./lib/parser/parser.y"
                                                    { yylhs.value.as < AST::past > () = newFuncDef(yystack_[4].value.as < AST::token_type > (), yystack_[3].value.as < AST::string > (), NULL, yystack_[0].value.as < AST::past > ()); }
#line 978 "./lib/parser/parser.cpp"
    break;

  case 38: // FuncDef: Type Y_ID Y_LPAR FuncParams Y_RPAR Block
#line 101 "./lib/parser/parser.y"
                                                    { yylhs.value.as < AST::past > () = newFuncDef(yystack_[5].value.as < AST::token_type > (), yystack_[4].value.as < AST::string > (), yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 984 "./lib/parser/parser.cpp"
    break;

  case 39: // FuncParams: FuncParam
#line 104 "./lib/parser/parser.y"
                                            { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 990 "./lib/parser/parser.cpp"
    break;

  case 40: // FuncParams: FuncParams Y_COMMA FuncParam
#line 105 "./lib/parser/parser.y"
                                            { yylhs.value.as < AST::past > () = addNode(yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 996 "./lib/parser/parser.cpp"
    break;

  case 41: // FuncParam: Type Y_ID
#line 108 "./lib/parser/parser.y"
                                                                { yylhs.value.as < AST::past > () = newFuncParam(yystack_[1].value.as < AST::token_type > (), yystack_[0].value.as < AST::string > (), NULL, NULL); }
#line 1002 "./lib/parser/parser.cpp"
    break;

  case 42: // FuncParam: Type Y_ID Y_LSQUARE Y_RSQUARE
#line 109 "./lib/parser/parser.y"
                                                                { yylhs.value.as < AST::past > () = newFuncParam(yystack_[3].value.as < AST::token_type > (), yystack_[2].value.as < AST::string > (), NULL, NULL); }
#line 1008 "./lib/parser/parser.cpp"
    break;

  case 43: // FuncParam: Type Y_ID ArraySubscripts
#line 110 "./lib/parser/parser.y"
                                                                { yylhs.value.as < AST::past > () = newFuncParam(yystack_[2].value.as < AST::token_type > (), yystack_[1].value.as < AST::string > (), NULL, NULL); }
#line 1014 "./lib/parser/parser.cpp"
    break;

  case 44: // FuncParam: Type Y_ID Y_LSQUARE Y_RSQUARE ArraySubscripts
#line 111 "./lib/parser/parser.y"
                                                                { yylhs.value.as < AST::past > () = newFuncParam(yystack_[4].value.as < AST::token_type > (), yystack_[3].value.as < AST::string > (), NULL, NULL); }
#line 1020 "./lib/parser/parser.cpp"
    break;

  case 45: // Block: Y_LBRACKET BlockItems Y_RBRACKET
#line 114 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = newBlock(yystack_[1].value.as < AST::past > ()); }
#line 1026 "./lib/parser/parser.cpp"
    break;

  case 46: // Block: Y_LBRACKET Y_RBRACKET
#line 115 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = newBlock(NULL); }
#line 1032 "./lib/parser/parser.cpp"
    break;

  case 47: // BlockItems: BlockItem
#line 118 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 1038 "./lib/parser/parser.cpp"
    break;

  case 48: // BlockItems: BlockItem BlockItems
#line 119 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = addNode(yystack_[1].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 1044 "./lib/parser/parser.cpp"
    break;

  case 49: // BlockItem: Decl
#line 122 "./lib/parser/parser.y"
                { yylhs.value.as < AST::past > () = newDeclStmt(yystack_[0].value.as < AST::past > ()); }
#line 1050 "./lib/parser/parser.cpp"
    break;

  case 50: // BlockItem: Stmt
#line 123 "./lib/parser/parser.y"
                { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 1056 "./lib/parser/parser.cpp"
    break;

  case 51: // Stmt: LVal Y_ASSIGN Exp Y_SEMICOLON
#line 126 "./lib/parser/parser.y"
                                                        { yylhs.value.as < AST::past > () = newBinaryOp(Y_ASSIGN, yystack_[3].value.as < AST::past > (), yystack_[1].value.as < AST::past > ()); }
#line 1062 "./lib/parser/parser.cpp"
    break;

  case 52: // Stmt: Y_SEMICOLON
#line 127 "./lib/parser/parser.y"
                                                        { yylhs.value.as < AST::past > () = newAstNode(NULL_STMT); }
#line 1068 "./lib/parser/parser.cpp"
    break;

  case 53: // Stmt: Exp Y_SEMICOLON
#line 128 "./lib/parser/parser.y"
                                                        { yylhs.value.as < AST::past > () = yystack_[1].value.as < AST::past > (); }
#line 1074 "./lib/parser/parser.cpp"
    break;

  case 54: // Stmt: Block
#line 129 "./lib/parser/parser.y"
                                                        { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 1080 "./lib/parser/parser.cpp"
    break;

  case 55: // Stmt: Y_WHILE Y_LPAR LOrExp Y_RPAR Stmt
#line 130 "./lib/parser/parser.y"
                                                        { yylhs.value.as < AST::past > () = newWhileStmt(yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 1086 "./lib/parser/parser.cpp"
    break;

  case 56: // Stmt: Y_IF Y_LPAR LOrExp Y_RPAR Stmt
#line 131 "./lib/parser/parser.y"
                                                        { yylhs.value.as < AST::past > () = newIfStmt(yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > (), NULL); }
#line 1092 "./lib/parser/parser.cpp"
    break;

  case 57: // Stmt: Y_IF Y_LPAR LOrExp Y_RPAR Stmt Y_ELSE Stmt
#line 132 "./lib/parser/parser.y"
                                                        { yylhs.value.as < AST::past > () = newIfStmt(yystack_[4].value.as < AST::past > (), yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 1098 "./lib/parser/parser.cpp"
    break;

  case 58: // Stmt: Y_BREAK Y_SEMICOLON
#line 133 "./lib/parser/parser.y"
                                                        { yylhs.value.as < AST::past > () = newAstNode(BREAK_STMT); }
#line 1104 "./lib/parser/parser.cpp"
    break;

  case 59: // Stmt: Y_CONTINUE Y_SEMICOLON
#line 134 "./lib/parser/parser.y"
                                                        { yylhs.value.as < AST::past > () = newAstNode(CONTINUE_STMT); }
#line 1110 "./lib/parser/parser.cpp"
    break;

  case 60: // Stmt: Y_RETURN Exp Y_SEMICOLON
#line 135 "./lib/parser/parser.y"
                                                        { yylhs.value.as < AST::past > () = newReturnStmt(yystack_[1].value.as < AST::past > ()); }
#line 1116 "./lib/parser/parser.cpp"
    break;

  case 61: // Stmt: Y_RETURN Y_SEMICOLON
#line 136 "./lib/parser/parser.y"
                                                        { yylhs.value.as < AST::past > () = newReturnStmt(NULL); }
#line 1122 "./lib/parser/parser.cpp"
    break;

  case 62: // Exp: AddExp
#line 139 "./lib/parser/parser.y"
                { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 1128 "./lib/parser/parser.cpp"
    break;

  case 63: // LVal: Y_ID
#line 142 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = newDeclRef(yystack_[0].value.as < AST::string > (), NULL); }
#line 1134 "./lib/parser/parser.cpp"
    break;

  case 64: // LVal: Y_ID ArraySubscripts
#line 143 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = newArraySubscripts(newDeclRef(yystack_[1].value.as < AST::string > (), NULL), yystack_[0].value.as < AST::past > ()); }
#line 1140 "./lib/parser/parser.cpp"
    break;

  case 65: // ArraySubscripts: Y_LSQUARE Exp Y_RSQUARE
#line 146 "./lib/parser/parser.y"
                                                                { yylhs.value.as < AST::past > () = yystack_[1].value.as < AST::past > (); }
#line 1146 "./lib/parser/parser.cpp"
    break;

  case 66: // ArraySubscripts: Y_LSQUARE Exp Y_RSQUARE ArraySubscripts
#line 147 "./lib/parser/parser.y"
                                                                { yylhs.value.as < AST::past > () = addNode(yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 1152 "./lib/parser/parser.cpp"
    break;

  case 67: // PrimaryExp: Y_LPAR Exp Y_RPAR
#line 150 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = newParenExp(yystack_[1].value.as < AST::past > ()); }
#line 1158 "./lib/parser/parser.cpp"
    break;

  case 68: // PrimaryExp: LVal
#line 151 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 1164 "./lib/parser/parser.cpp"
    break;

  case 69: // PrimaryExp: num_INT
#line 152 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = newInt(yystack_[0].value.as < AST::int32 > ()); }
#line 1170 "./lib/parser/parser.cpp"
    break;

  case 70: // PrimaryExp: num_FLOAT
#line 153 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = newInt((int)yystack_[0].value.as < AST::float32 > ()); }
#line 1176 "./lib/parser/parser.cpp"
    break;

  case 71: // UnaryExp: PrimaryExp
#line 156 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 1182 "./lib/parser/parser.cpp"
    break;

  case 72: // UnaryExp: Y_ID Y_LPAR Y_RPAR
#line 157 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = newCallExp(newDeclRef(yystack_[2].value.as < AST::string > (), NULL), NULL); }
#line 1188 "./lib/parser/parser.cpp"
    break;

  case 73: // UnaryExp: Y_ID Y_LPAR CallParams Y_RPAR
#line 158 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = newCallExp(newDeclRef(yystack_[3].value.as < AST::string > (), NULL), yystack_[1].value.as < AST::past > ()); }
#line 1194 "./lib/parser/parser.cpp"
    break;

  case 74: // UnaryExp: Y_ADD UnaryExp
#line 159 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = newUnaryOp(Y_ADD, yystack_[0].value.as < AST::past > ()); }
#line 1200 "./lib/parser/parser.cpp"
    break;

  case 75: // UnaryExp: Y_SUB UnaryExp
#line 160 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = newUnaryOp(Y_SUB, yystack_[0].value.as < AST::past > ()); }
#line 1206 "./lib/parser/parser.cpp"
    break;

  case 76: // UnaryExp: Y_NOT UnaryExp
#line 161 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = newUnaryOp(Y_NOT, yystack_[0].value.as < AST::past > ()); }
#line 1212 "./lib/parser/parser.cpp"
    break;

  case 77: // CallParams: Exp
#line 164 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 1218 "./lib/parser/parser.cpp"
    break;

  case 78: // CallParams: Exp Y_COMMA CallParams
#line 165 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = addNode(yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ());; }
#line 1224 "./lib/parser/parser.cpp"
    break;

  case 79: // MulExp: UnaryExp
#line 168 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 1230 "./lib/parser/parser.cpp"
    break;

  case 80: // MulExp: MulExp Y_MUL UnaryExp
#line 169 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = newBinaryOp(Y_MUL, yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 1236 "./lib/parser/parser.cpp"
    break;

  case 81: // MulExp: MulExp Y_DIV UnaryExp
#line 170 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = newBinaryOp(Y_DIV, yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 1242 "./lib/parser/parser.cpp"
    break;

  case 82: // MulExp: MulExp Y_MODULO UnaryExp
#line 171 "./lib/parser/parser.y"
                                        { yylhs.value.as < AST::past > () = newBinaryOp(Y_MODULO, yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 1248 "./lib/parser/parser.cpp"
    break;

  case 83: // AddExp: MulExp
#line 174 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 1254 "./lib/parser/parser.cpp"
    break;

  case 84: // AddExp: AddExp Y_ADD MulExp
#line 175 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = newBinaryOp(Y_ADD, yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 1260 "./lib/parser/parser.cpp"
    break;

  case 85: // AddExp: AddExp Y_SUB MulExp
#line 176 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = newBinaryOp(Y_SUB, yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 1266 "./lib/parser/parser.cpp"
    break;

  case 86: // RelExp: AddExp
#line 179 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 1272 "./lib/parser/parser.cpp"
    break;

  case 87: // RelExp: AddExp Y_LESS RelExp
#line 180 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = newBinaryOp(Y_LESS, yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 1278 "./lib/parser/parser.cpp"
    break;

  case 88: // RelExp: AddExp Y_GREAT RelExp
#line 181 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = newBinaryOp(Y_GREAT, yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 1284 "./lib/parser/parser.cpp"
    break;

  case 89: // RelExp: AddExp Y_LESSEQ RelExp
#line 182 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = newBinaryOp(Y_LESSEQ, yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 1290 "./lib/parser/parser.cpp"
    break;

  case 90: // RelExp: AddExp Y_GREATEQ RelExp
#line 183 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = newBinaryOp(Y_GREATEQ, yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 1296 "./lib/parser/parser.cpp"
    break;

  case 91: // EqExp: RelExp
#line 186 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 1302 "./lib/parser/parser.cpp"
    break;

  case 92: // EqExp: RelExp Y_EQ EqExp
#line 187 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = newBinaryOp(Y_EQ, yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 1308 "./lib/parser/parser.cpp"
    break;

  case 93: // EqExp: RelExp Y_NOTEQ EqExp
#line 188 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = newBinaryOp(Y_NOTEQ, yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 1314 "./lib/parser/parser.cpp"
    break;

  case 94: // LAndExp: EqExp
#line 191 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 1320 "./lib/parser/parser.cpp"
    break;

  case 95: // LAndExp: EqExp Y_AND LAndExp
#line 192 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = newBinaryOp(Y_AND, yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 1326 "./lib/parser/parser.cpp"
    break;

  case 96: // LOrExp: LAndExp
#line 195 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 1332 "./lib/parser/parser.cpp"
    break;

  case 97: // LOrExp: LAndExp Y_OR LOrExp
#line 196 "./lib/parser/parser.y"
                                { yylhs.value.as < AST::past > () = newBinaryOp(Y_OR, yystack_[2].value.as < AST::past > (), yystack_[0].value.as < AST::past > ()); }
#line 1338 "./lib/parser/parser.cpp"
    break;

  case 98: // ConstExp: AddExp
#line 199 "./lib/parser/parser.y"
                        { yylhs.value.as < AST::past > () = yystack_[0].value.as < AST::past > (); }
#line 1344 "./lib/parser/parser.cpp"
    break;

  case 99: // Type: Y_INT
#line 202 "./lib/parser/parser.y"
                { yylhs.value.as < AST::token_type > () = Y_INT; }
#line 1350 "./lib/parser/parser.cpp"
    break;

  case 100: // Type: Y_FLOAT
#line 203 "./lib/parser/parser.y"
                { yylhs.value.as < AST::token_type > () = Y_FLOAT; }
#line 1356 "./lib/parser/parser.cpp"
    break;

  case 101: // Type: Y_VOID
#line 204 "./lib/parser/parser.y"
                { yylhs.value.as < AST::token_type > () = Y_VOID; }
#line 1362 "./lib/parser/parser.cpp"
    break;


#line 1366 "./lib/parser/parser.cpp"

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









  const short parser::yypact_ninf_ = -136;

  const signed char parser::yytable_ninf_ = -1;

  const short
  parser::yypact_[] =
  {
      11,  -136,  -136,    22,  -136,    29,  -136,    11,  -136,  -136,
      11,    -6,     3,  -136,  -136,  -136,     7,   -11,    32,    31,
      83,   219,    14,   257,    30,    61,  -136,    73,   222,    85,
       3,  -136,     3,  -136,   257,   257,   257,   257,    56,  -136,
    -136,    17,  -136,  -136,  -136,  -136,  -136,    99,   106,    98,
      12,  -136,   104,   106,   114,   219,    36,   115,  -136,   192,
    -136,  -136,   222,  -136,  -136,  -136,  -136,  -136,   125,  -136,
      42,   240,   257,  -136,   257,   257,   257,   257,   257,   120,
    -136,    98,    22,   132,   139,  -136,  -136,  -136,    43,  -136,
    -136,  -136,   219,   141,  -136,   140,   144,   142,  -136,  -136,
    -136,    99,    99,   148,   149,   143,   146,   252,  -136,  -136,
    -136,  -136,   151,   156,  -136,   150,   152,    61,  -136,  -136,
     260,  -136,  -136,  -136,   222,   157,   153,  -136,   257,  -136,
     158,   257,   257,  -136,  -136,  -136,   154,  -136,  -136,  -136,
     257,   158,   163,  -136,  -136,  -136,  -136,    78,   123,   179,
     181,   180,   182,  -136,   173,  -136,  -136,   257,   257,   257,
     257,   257,   257,   257,   257,   189,   189,  -136,  -136,  -136,
    -136,  -136,  -136,  -136,  -136,  -136,   175,  -136,   189,  -136
  };

  const signed char
  parser::yydefact_[] =
  {
       0,    99,   101,     0,   100,     0,     2,     5,     7,     8,
       6,     0,     0,     1,     3,     4,    27,     0,     0,     0,
       0,     0,     0,     0,    29,     0,    23,     0,     0,     0,
       0,    10,     0,     9,     0,     0,     0,     0,     0,    69,
      70,    63,    28,    31,    68,    71,    79,    83,    62,     0,
       0,    39,     0,    98,     0,     0,    27,    25,    24,     0,
      13,    17,     0,    12,    11,    74,    75,    76,     0,    32,
       0,     0,     0,    64,     0,     0,     0,     0,     0,     0,
      37,     0,     0,    41,    15,    30,    26,    18,     0,    14,
      67,    33,     0,     0,    72,    77,     0,     0,    80,    81,
      82,    84,    85,     0,     0,     0,     0,     0,    46,    52,
      49,    54,     0,    47,    50,     0,    68,     0,    38,    40,
       0,    43,    16,    19,     0,     0,    35,    34,     0,    73,
      65,     0,     0,    58,    59,    61,     0,    45,    48,    53,
       0,    42,    21,    20,    36,    78,    66,    86,    91,    94,
      96,     0,     0,    60,     0,    44,    22,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,    51,    87,    89,
      88,    90,    93,    92,    95,    97,    56,    55,     0,    57
  };

  const short
  parser::yypgoto_[] =
  {
    -136,  -136,    70,   -66,  -136,  -136,    52,   -14,   -53,    67,
    -136,   160,   186,   -31,    87,  -136,  -136,   138,   -22,   101,
    -136,  -135,   -18,   -78,   -75,  -136,   -24,    96,    74,   -23,
     -54,   -41,    75,  -104,   210,    -1
  };

  const unsigned char
  parser::yydefgoto_[] =
  {
       0,     5,     6,     7,     8,    19,    20,    24,    60,   125,
       9,    27,    17,    42,    93,    10,    50,    51,   111,   112,
     113,   114,   115,    44,    73,    45,    46,    96,    47,    48,
     148,   149,   150,   151,    61,    11
  };

  const unsigned char
  parser::yytable_[] =
  {
      53,   116,    12,    43,    29,    53,    88,    70,   121,    89,
      65,    66,    67,   110,     1,     2,     3,     1,     2,    68,
      43,    52,    25,    26,    85,     1,     2,    80,   152,    13,
     176,   177,    16,    21,    22,   116,    53,    43,    23,    53,
      81,    18,    49,   179,    71,    82,     4,   110,    72,     4,
      98,    99,   100,    95,    97,   146,    55,     4,    28,   118,
     175,   126,    21,    23,    30,    31,   155,    23,    34,    35,
     122,   142,    91,   123,    43,    92,   124,    14,   117,    36,
      15,    52,    63,    37,    64,    38,    69,   116,   116,   136,
      77,    78,    39,    40,    41,   157,   158,   159,   160,    56,
     116,    53,    97,   168,   169,   170,   171,    58,   147,   147,
      95,    62,   117,    74,    75,    76,    32,    33,    77,    78,
     172,   173,   154,     1,     2,     3,   103,    79,   104,   105,
     106,   107,    34,    35,   147,   147,   147,   147,   147,   147,
     147,   147,    83,    36,   161,   162,    84,    37,    25,    79,
     108,   101,   102,    90,   109,     4,    39,    40,    41,     1,
       2,     3,   103,   120,   104,   105,   106,   107,    34,    35,
      23,   127,   129,   128,   130,   131,   132,   133,   140,    36,
     134,   137,   178,    37,   139,    79,    92,   143,   153,    72,
     109,     4,    39,    40,    41,   103,   124,   104,   105,   106,
     107,    34,    35,   163,    34,    35,   164,   167,   165,   156,
     166,    57,    36,   144,   138,    36,    37,    86,    79,    37,
     119,    59,    87,   109,   145,    39,    40,    41,    39,    40,
      41,    34,    35,    54,    34,    35,     0,     0,   174,     0,
       0,     0,    36,     0,     0,    36,    37,     0,    38,    37,
       0,    59,    34,    35,     0,    39,    40,    41,    39,    40,
      41,     0,     0,    36,    34,    35,     0,    37,    94,    34,
      35,     0,    34,    35,     0,    36,    39,    40,    41,    37,
      36,     0,     0,    36,    37,     0,   135,    37,    39,    40,
      41,     0,   141,    39,    40,    41,    39,    40,    41
  };

  const short
  parser::yycheck_[] =
  {
      23,    79,     3,    21,    18,    28,    59,    38,    83,    62,
      34,    35,    36,    79,     3,     4,     5,     3,     4,    37,
      38,    22,    33,    34,    55,     3,     4,    49,   132,     0,
     165,   166,    38,    26,    27,   113,    59,    55,    31,    62,
      28,    38,    28,   178,    27,    33,    35,   113,    31,    35,
      74,    75,    76,    71,    72,   130,    26,    35,    26,    81,
     164,    92,    26,    31,    33,    34,   141,    31,    12,    13,
      84,   124,    30,    30,    92,    33,    33,     7,    79,    23,
      10,    82,    30,    27,    32,    29,    30,   165,   166,   107,
      12,    13,    36,    37,    38,    17,    18,    19,    20,    38,
     178,   124,   120,   157,   158,   159,   160,    34,   131,   132,
     128,    26,   113,    14,    15,    16,    33,    34,    12,    13,
     161,   162,   140,     3,     4,     5,     6,    29,     8,     9,
      10,    11,    12,    13,   157,   158,   159,   160,   161,   162,
     163,   164,    38,    23,    21,    22,    32,    27,    33,    29,
      30,    77,    78,    28,    34,    35,    36,    37,    38,     3,
       4,     5,     6,    31,     8,     9,    10,    11,    12,    13,
      31,    30,    28,    33,    32,    27,    27,    34,    26,    23,
      34,    30,     7,    27,    34,    29,    33,    30,    34,    31,
      34,    35,    36,    37,    38,     6,    33,     8,     9,    10,
      11,    12,    13,    24,    12,    13,    25,    34,    28,   142,
      28,    25,    23,   126,   113,    23,    27,    57,    29,    27,
      82,    29,    30,    34,   128,    36,    37,    38,    36,    37,
      38,    12,    13,    23,    12,    13,    -1,    -1,   163,    -1,
      -1,    -1,    23,    -1,    -1,    23,    27,    -1,    29,    27,
      -1,    29,    12,    13,    -1,    36,    37,    38,    36,    37,
      38,    -1,    -1,    23,    12,    13,    -1,    27,    28,    12,
      13,    -1,    12,    13,    -1,    23,    36,    37,    38,    27,
      23,    -1,    -1,    23,    27,    -1,    34,    27,    36,    37,
      38,    -1,    32,    36,    37,    38,    36,    37,    38
  };

  const signed char
  parser::yystos_[] =
  {
       0,     3,     4,     5,    35,    40,    41,    42,    43,    49,
      54,    74,    74,     0,    41,    41,    38,    51,    38,    44,
      45,    26,    27,    31,    46,    33,    34,    50,    26,    46,
      33,    34,    33,    34,    12,    13,    23,    27,    29,    36,
      37,    38,    52,    61,    62,    64,    65,    67,    68,    28,
      55,    56,    74,    68,    73,    26,    38,    51,    34,    29,
      47,    73,    26,    45,    45,    65,    65,    65,    61,    30,
      52,    27,    31,    63,    14,    15,    16,    12,    13,    29,
      57,    28,    33,    38,    32,    52,    50,    30,    47,    47,
      28,    30,    33,    53,    28,    61,    66,    61,    65,    65,
      65,    67,    67,     6,     8,     9,    10,    11,    30,    34,
      42,    57,    58,    59,    60,    61,    62,    74,    57,    56,
      31,    63,    46,    30,    33,    48,    52,    30,    33,    28,
      32,    27,    27,    34,    34,    34,    61,    30,    58,    34,
      26,    32,    47,    30,    53,    66,    63,    68,    69,    70,
      71,    72,    72,    34,    61,    63,    48,    17,    18,    19,
      20,    21,    22,    24,    25,    28,    28,    34,    69,    69,
      69,    69,    70,    70,    71,    72,    60,    60,     7,    60
  };

  const signed char
  parser::yyr1_[] =
  {
       0,    39,    40,    41,    41,    41,    41,    42,    42,    43,
      43,    44,    44,    45,    45,    46,    46,    47,    47,    47,
      47,    48,    48,    49,    49,    50,    50,    51,    51,    51,
      51,    52,    52,    52,    52,    53,    53,    54,    54,    55,
      55,    56,    56,    56,    56,    57,    57,    58,    58,    59,
      59,    60,    60,    60,    60,    60,    60,    60,    60,    60,
      60,    60,    61,    62,    62,    63,    63,    64,    64,    64,
      64,    65,    65,    65,    65,    65,    65,    66,    66,    67,
      67,    67,    67,    68,    68,    68,    69,    69,    69,    69,
      69,    70,    70,    70,    71,    71,    72,    72,    73,    74,
      74,    74
  };

  const signed char
  parser::yyr2_[] =
  {
       0,     2,     1,     2,     2,     1,     1,     1,     1,     4,
       4,     3,     3,     3,     4,     3,     4,     1,     2,     3,
       4,     2,     3,     3,     4,     2,     3,     1,     3,     2,
       4,     1,     2,     3,     4,     2,     3,     5,     6,     1,
       3,     2,     4,     3,     5,     3,     2,     1,     2,     1,
       1,     4,     1,     2,     1,     5,     5,     7,     2,     2,
       3,     2,     1,     1,     2,     3,     4,     3,     1,     1,
       1,     1,     3,     4,     2,     2,     2,     1,     3,     1,
       3,     3,     3,     1,     3,     3,     1,     3,     3,     3,
       3,     1,     3,     3,     1,     3,     1,     3,     1,     1,
       1,     1
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
  "ConstDecl", "ConstDefs", "ConstDef", "ConstExps", "ConstInitVal",
  "ConstInitVals", "VarDecl", "VarDecls", "VarDef", "InitVal", "InitVals",
  "FuncDef", "FuncParams", "FuncParam", "Block", "BlockItems", "BlockItem",
  "Stmt", "Exp", "LVal", "ArraySubscripts", "PrimaryExp", "UnaryExp",
  "CallParams", "MulExp", "AddExp", "RelExp", "EqExp", "LAndExp", "LOrExp",
  "ConstExp", "Type", YY_NULLPTR
  };
#endif


#if YYDEBUG
  const unsigned char
  parser::yyrline_[] =
  {
       0,    37,    37,    40,    41,    42,    43,    46,    47,    50,
      51,    54,    55,    58,    59,    62,    63,    66,    67,    68,
      69,    72,    73,    76,    77,    80,    81,    84,    85,    86,
      87,    90,    91,    92,    93,    96,    97,   100,   101,   104,
     105,   108,   109,   110,   111,   114,   115,   118,   119,   122,
     123,   126,   127,   128,   129,   130,   131,   132,   133,   134,
     135,   136,   139,   142,   143,   146,   147,   150,   151,   152,
     153,   156,   157,   158,   159,   160,   161,   164,   165,   168,
     169,   170,   171,   174,   175,   176,   179,   180,   181,   182,
     183,   186,   187,   188,   191,   192,   195,   196,   199,   202,
     203,   204
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
#line 1818 "./lib/parser/parser.cpp"

#line 207 "./lib/parser/parser.y"


void yyerror(char *s)
{
	fprintf(stderr, "error: %s\n", s);
}
