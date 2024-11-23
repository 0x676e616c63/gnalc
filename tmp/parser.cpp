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
#line 1 "./tmp/parser.y"

#include "ast2.hpp"
#include "parser.hpp"
extern std::shared_ptr<AST::DeclStmt> node;
using namespace AST;
extern yy::parser::symbol_type yylex ();

#line 54 "./tmp/parser.cpp"


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
#line 127 "./tmp/parser.cpp"

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

      case symbol_kind::S_Number: // Number
        value.YY_MOVE_OR_COPY< std::shared_ptr<AST::num> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstExp: // ConstExp
      case symbol_kind::S_Exp: // Exp
      case symbol_kind::S_AddExp: // AddExp
        value.YY_MOVE_OR_COPY< std::shared_ptr<AddExp> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstAS: // ConstAS
        value.YY_MOVE_OR_COPY< std::shared_ptr<ArraySubscript> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_ConstDecl: // ConstDecl
      case symbol_kind::S_VarDecl: // VarDecl
        value.YY_MOVE_OR_COPY< std::shared_ptr<DeclStmt> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVal: // InitVal
      case symbol_kind::S_InitVals: // InitVals
        value.YY_MOVE_OR_COPY< std::shared_ptr<InitVal> > (YY_MOVE (that.value));
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

      case symbol_kind::S_Number: // Number
        value.move< std::shared_ptr<AST::num> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstExp: // ConstExp
      case symbol_kind::S_Exp: // Exp
      case symbol_kind::S_AddExp: // AddExp
        value.move< std::shared_ptr<AddExp> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstAS: // ConstAS
        value.move< std::shared_ptr<ArraySubscript> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_ConstDecl: // ConstDecl
      case symbol_kind::S_VarDecl: // VarDecl
        value.move< std::shared_ptr<DeclStmt> > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVal: // InitVal
      case symbol_kind::S_InitVals: // InitVals
        value.move< std::shared_ptr<InitVal> > (YY_MOVE (that.value));
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

      case symbol_kind::S_Number: // Number
        value.copy< std::shared_ptr<AST::num> > (that.value);
        break;

      case symbol_kind::S_ConstExp: // ConstExp
      case symbol_kind::S_Exp: // Exp
      case symbol_kind::S_AddExp: // AddExp
        value.copy< std::shared_ptr<AddExp> > (that.value);
        break;

      case symbol_kind::S_ConstAS: // ConstAS
        value.copy< std::shared_ptr<ArraySubscript> > (that.value);
        break;

      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_ConstDecl: // ConstDecl
      case symbol_kind::S_VarDecl: // VarDecl
        value.copy< std::shared_ptr<DeclStmt> > (that.value);
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVal: // InitVal
      case symbol_kind::S_InitVals: // InitVals
        value.copy< std::shared_ptr<InitVal> > (that.value);
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

      case symbol_kind::S_Number: // Number
        value.move< std::shared_ptr<AST::num> > (that.value);
        break;

      case symbol_kind::S_ConstExp: // ConstExp
      case symbol_kind::S_Exp: // Exp
      case symbol_kind::S_AddExp: // AddExp
        value.move< std::shared_ptr<AddExp> > (that.value);
        break;

      case symbol_kind::S_ConstAS: // ConstAS
        value.move< std::shared_ptr<ArraySubscript> > (that.value);
        break;

      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_ConstDecl: // ConstDecl
      case symbol_kind::S_VarDecl: // VarDecl
        value.move< std::shared_ptr<DeclStmt> > (that.value);
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVal: // InitVal
      case symbol_kind::S_InitVals: // InitVals
        value.move< std::shared_ptr<InitVal> > (that.value);
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

      case symbol_kind::S_Number: // Number
        yylhs.value.emplace< std::shared_ptr<AST::num> > ();
        break;

      case symbol_kind::S_ConstExp: // ConstExp
      case symbol_kind::S_Exp: // Exp
      case symbol_kind::S_AddExp: // AddExp
        yylhs.value.emplace< std::shared_ptr<AddExp> > ();
        break;

      case symbol_kind::S_ConstAS: // ConstAS
        yylhs.value.emplace< std::shared_ptr<ArraySubscript> > ();
        break;

      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_ConstDecl: // ConstDecl
      case symbol_kind::S_VarDecl: // VarDecl
        yylhs.value.emplace< std::shared_ptr<DeclStmt> > ();
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVal: // InitVal
      case symbol_kind::S_InitVals: // InitVals
        yylhs.value.emplace< std::shared_ptr<InitVal> > ();
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
  case 2: // Decl: ConstDecl
#line 38 "./tmp/parser.y"
                    { node = yystack_[0].value.as < std::shared_ptr<DeclStmt> > (); }
#line 758 "./tmp/parser.cpp"
    break;

  case 3: // Decl: VarDecl
#line 39 "./tmp/parser.y"
                    { node = yystack_[0].value.as < std::shared_ptr<DeclStmt> > (); }
#line 764 "./tmp/parser.cpp"
    break;

  case 4: // Type: Y_INT
#line 42 "./tmp/parser.y"
                { yylhs.value.as < AST::dtype > () = dtype::INT; }
#line 770 "./tmp/parser.cpp"
    break;

  case 5: // Type: Y_FLOAT
#line 43 "./tmp/parser.y"
                { yylhs.value.as < AST::dtype > () = dtype::FLOAT; }
#line 776 "./tmp/parser.cpp"
    break;

  case 6: // Type: Y_VOID
#line 44 "./tmp/parser.y"
                { yylhs.value.as < AST::dtype > () = dtype::VOID; }
#line 782 "./tmp/parser.cpp"
    break;

  case 7: // ConstDecl: Y_CONST Type ConstDefs Y_SEMICOLON
#line 48 "./tmp/parser.y"
                                                 { yylhs.value.as < std::shared_ptr<DeclStmt> > () = std::make_shared<DeclStmt>(true, yystack_[2].value.as < AST::dtype > (), yystack_[1].value.as < std::shared_ptr<VarDef> > ()); }
#line 788 "./tmp/parser.cpp"
    break;

  case 8: // ConstDefs: ConstDef
#line 51 "./tmp/parser.y"
                                        { yylhs.value.as < std::shared_ptr<VarDef> > () = yystack_[0].value.as < std::shared_ptr<VarDef> > (); }
#line 794 "./tmp/parser.cpp"
    break;

  case 9: // ConstDefs: ConstDef Y_COMMA ConstDefs
#line 52 "./tmp/parser.y"
                                        { yystack_[2].value.as < std::shared_ptr<VarDef> > ()->next = yystack_[0].value.as < std::shared_ptr<VarDef> > (); yylhs.value.as < std::shared_ptr<VarDef> > () = yystack_[2].value.as < std::shared_ptr<VarDef> > (); }
#line 800 "./tmp/parser.cpp"
    break;

  case 10: // ConstDef: Y_ID Y_ASSIGN ConstInitVal
#line 55 "./tmp/parser.y"
                                                { yylhs.value.as < std::shared_ptr<VarDef> > () = std::make_shared<VarDef>(yystack_[2].value.as < AST::string > (), yystack_[0].value.as < std::shared_ptr<InitVal> > ()); }
#line 806 "./tmp/parser.cpp"
    break;

  case 11: // ConstDef: Y_ID ConstAS Y_ASSIGN ConstInitVal
#line 56 "./tmp/parser.y"
                                                { yylhs.value.as < std::shared_ptr<VarDef> > () = std::make_shared<VarDef>(yystack_[3].value.as < AST::string > (), yystack_[2].value.as < std::shared_ptr<ArraySubscript> > (), yystack_[0].value.as < std::shared_ptr<InitVal> > ()); }
#line 812 "./tmp/parser.cpp"
    break;

  case 12: // ConstAS: Y_LSQUARE ConstExp Y_RSQUARE
#line 59 "./tmp/parser.y"
                                                  { yylhs.value.as < std::shared_ptr<ArraySubscript> > () = std::make_shared<ArraySubscript>(yystack_[1].value.as < std::shared_ptr<AddExp> > ()); }
#line 818 "./tmp/parser.cpp"
    break;

  case 13: // ConstAS: Y_LSQUARE ConstExp Y_RSQUARE ConstAS
#line 60 "./tmp/parser.y"
                                                  { auto p = std::make_shared<ArraySubscript>(yystack_[2].value.as < std::shared_ptr<AddExp> > ()); p->next = yystack_[0].value.as < std::shared_ptr<ArraySubscript> > (); yylhs.value.as < std::shared_ptr<ArraySubscript> > () = p; }
#line 824 "./tmp/parser.cpp"
    break;

  case 14: // ConstExp: AddExp
#line 63 "./tmp/parser.y"
                        { yylhs.value.as < std::shared_ptr<AddExp> > () = yystack_[0].value.as < std::shared_ptr<AddExp> > (); }
#line 830 "./tmp/parser.cpp"
    break;

  case 15: // ConstInitVal: ConstExp
#line 66 "./tmp/parser.y"
                                                                { yylhs.value.as < std::shared_ptr<InitVal> > () = std::make_shared<InitVal>(yystack_[0].value.as < std::shared_ptr<AddExp> > ()); }
#line 836 "./tmp/parser.cpp"
    break;

  case 16: // ConstInitVal: Y_LBRACKET Y_RBRACKET
#line 67 "./tmp/parser.y"
                                                                { yylhs.value.as < std::shared_ptr<InitVal> > () = std::make_shared<InitVal>(); }
#line 842 "./tmp/parser.cpp"
    break;

  case 17: // ConstInitVal: Y_LBRACKET ConstInitVals Y_RBRACKET
#line 68 "./tmp/parser.y"
                                                                { yylhs.value.as < std::shared_ptr<InitVal> > () = std::make_shared<InitVal>(yystack_[1].value.as < std::shared_ptr<InitVal> > ()); }
#line 848 "./tmp/parser.cpp"
    break;

  case 18: // ConstInitVals: ConstInitVal
#line 71 "./tmp/parser.y"
                                                        { yylhs.value.as < std::shared_ptr<InitVal> > () = yystack_[0].value.as < std::shared_ptr<InitVal> > (); }
#line 854 "./tmp/parser.cpp"
    break;

  case 19: // ConstInitVals: ConstInitVal Y_COMMA ConstInitVals
#line 72 "./tmp/parser.y"
                                                        { yystack_[2].value.as < std::shared_ptr<InitVal> > ()->next = yystack_[0].value.as < std::shared_ptr<InitVal> > (); yylhs.value.as < std::shared_ptr<InitVal> > () = yystack_[2].value.as < std::shared_ptr<InitVal> > (); }
#line 860 "./tmp/parser.cpp"
    break;

  case 20: // VarDecl: Type VarDefs Y_SEMICOLON
#line 76 "./tmp/parser.y"
                                             { yylhs.value.as < std::shared_ptr<DeclStmt> > () = std::make_shared<DeclStmt>(false, yystack_[2].value.as < AST::dtype > (), yystack_[1].value.as < std::shared_ptr<VarDef> > ()); }
#line 866 "./tmp/parser.cpp"
    break;

  case 21: // VarDefs: VarDef
#line 79 "./tmp/parser.y"
                                        { yylhs.value.as < std::shared_ptr<VarDef> > () = yystack_[0].value.as < std::shared_ptr<VarDef> > (); }
#line 872 "./tmp/parser.cpp"
    break;

  case 22: // VarDefs: VarDef Y_COMMA VarDefs
#line 80 "./tmp/parser.y"
                                        { yystack_[2].value.as < std::shared_ptr<VarDef> > ()->next = yystack_[0].value.as < std::shared_ptr<VarDef> > (); yylhs.value.as < std::shared_ptr<VarDef> > () = yystack_[2].value.as < std::shared_ptr<VarDef> > (); }
#line 878 "./tmp/parser.cpp"
    break;

  case 23: // VarDef: Y_ID
#line 83 "./tmp/parser.y"
                                        { yylhs.value.as < std::shared_ptr<VarDef> > () = std::make_shared<VarDef>(yystack_[0].value.as < AST::string > ()); }
#line 884 "./tmp/parser.cpp"
    break;

  case 24: // VarDef: Y_ID ConstAS
#line 84 "./tmp/parser.y"
                                        { yylhs.value.as < std::shared_ptr<VarDef> > () = std::make_shared<VarDef>(yystack_[1].value.as < AST::string > (), yystack_[0].value.as < std::shared_ptr<ArraySubscript> > ()); }
#line 890 "./tmp/parser.cpp"
    break;

  case 25: // VarDef: Y_ID Y_ASSIGN InitVal
#line 85 "./tmp/parser.y"
                                        { yylhs.value.as < std::shared_ptr<VarDef> > () = std::make_shared<VarDef>(yystack_[2].value.as < AST::string > (), yystack_[0].value.as < std::shared_ptr<InitVal> > ()); }
#line 896 "./tmp/parser.cpp"
    break;

  case 26: // VarDef: Y_ID ConstAS Y_ASSIGN InitVal
#line 86 "./tmp/parser.y"
                                        { yylhs.value.as < std::shared_ptr<VarDef> > () = std::make_shared<VarDef>(yystack_[3].value.as < AST::string > (), yystack_[2].value.as < std::shared_ptr<ArraySubscript> > (), yystack_[0].value.as < std::shared_ptr<InitVal> > ()); }
#line 902 "./tmp/parser.cpp"
    break;

  case 27: // InitVal: Exp
#line 89 "./tmp/parser.y"
                                                { yylhs.value.as < std::shared_ptr<InitVal> > () = std::make_shared<InitVal>(yystack_[0].value.as < std::shared_ptr<AddExp> > ()); }
#line 908 "./tmp/parser.cpp"
    break;

  case 28: // InitVal: Y_LBRACKET Y_RBRACKET
#line 90 "./tmp/parser.y"
                                                { yylhs.value.as < std::shared_ptr<InitVal> > () = std::make_shared<InitVal>(); }
#line 914 "./tmp/parser.cpp"
    break;

  case 29: // InitVal: Y_LBRACKET InitVals Y_RBRACKET
#line 91 "./tmp/parser.y"
                                                { yylhs.value.as < std::shared_ptr<InitVal> > () = std::make_shared<InitVal>(yystack_[1].value.as < std::shared_ptr<InitVal> > ()); }
#line 920 "./tmp/parser.cpp"
    break;

  case 30: // InitVals: InitVal
#line 94 "./tmp/parser.y"
                                        { yylhs.value.as < std::shared_ptr<InitVal> > () = yystack_[0].value.as < std::shared_ptr<InitVal> > (); }
#line 926 "./tmp/parser.cpp"
    break;

  case 31: // InitVals: InitVal Y_COMMA InitVals
#line 95 "./tmp/parser.y"
                                        { yystack_[2].value.as < std::shared_ptr<InitVal> > ()->next = yystack_[0].value.as < std::shared_ptr<InitVal> > (); yylhs.value.as < std::shared_ptr<InitVal> > () = yystack_[2].value.as < std::shared_ptr<InitVal> > (); }
#line 932 "./tmp/parser.cpp"
    break;

  case 32: // Number: num_INT
#line 98 "./tmp/parser.y"
                            { yylhs.value.as < std::shared_ptr<AST::num> > () = std::make_shared<num>(yystack_[0].value.as < AST::int32 > ()); }
#line 938 "./tmp/parser.cpp"
    break;

  case 33: // Number: num_FLOAT
#line 99 "./tmp/parser.y"
                            { yylhs.value.as < std::shared_ptr<AST::num> > () = std::make_shared<num>(yystack_[0].value.as < AST::float32 > ()); }
#line 944 "./tmp/parser.cpp"
    break;

  case 34: // Exp: AddExp
#line 102 "./tmp/parser.y"
                  { yylhs.value.as < std::shared_ptr<AddExp> > () = yystack_[0].value.as < std::shared_ptr<AddExp> > (); }
#line 950 "./tmp/parser.cpp"
    break;

  case 35: // AddExp: Number
#line 105 "./tmp/parser.y"
                            { yylhs.value.as < std::shared_ptr<AddExp> > () = std::make_shared<AddExp>(yystack_[0].value.as < std::shared_ptr<AST::num> > ()); }
#line 956 "./tmp/parser.cpp"
    break;


#line 960 "./tmp/parser.cpp"

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









  const signed char parser::yypact_ninf_ = -27;

  const signed char parser::yytable_ninf_ = -1;

  const signed char
  parser::yypact_[] =
  {
      -2,   -27,   -27,     1,   -27,    12,   -21,   -27,   -27,   -19,
     -27,    13,    -7,    -4,    14,    -6,    -3,    -5,   -26,    15,
     -27,   -21,     6,    20,   -27,   -19,   -16,   -27,   -27,   -27,
     -27,   -27,   -27,    16,   -27,    -5,   -27,   -14,   -27,   -27,
       6,   -27,   -27,     5,    17,    18,   -27,   -27,    19,    21,
     -27,    -5,   -27,   -27,     6,   -27,   -27,   -27
  };

  const signed char
  parser::yydefact_[] =
  {
       0,     4,     6,     0,     5,     0,     0,     2,     3,     0,
       1,    23,     0,    21,     0,     0,     8,     0,     0,    24,
      20,     0,     0,     0,     7,     0,     0,    32,    33,    25,
      35,    27,    34,     0,    14,     0,    22,     0,    15,    10,
       0,     9,    28,    30,     0,    12,    26,    16,    18,     0,
      11,     0,    29,    13,     0,    17,    31,    19
  };

  const signed char
  parser::yypgoto_[] =
  {
     -27,   -27,    47,   -27,    28,   -27,    -8,    36,   -15,     2,
     -27,    34,   -27,    -9,     7,   -27,   -27,   -17
  };

  const signed char
  parser::yydefgoto_[] =
  {
       0,     5,     6,     7,    15,    16,    19,    38,    48,    49,
       8,    12,    13,    43,    44,    30,    31,    34
  };

  const signed char
  parser::yytable_[] =
  {
      32,     1,     2,     3,     1,     2,    23,    39,    29,    32,
      27,    28,    10,    26,    42,    37,    47,    11,    32,    14,
      27,    28,    27,    28,    26,    50,    46,    20,    24,    21,
      25,    27,    28,     4,    32,    37,     4,    53,    51,    17,
      22,    35,    27,    28,    18,    18,    40,    52,    45,    18,
       9,    55,    54,    41,    33,    36,    57,     0,    56
  };

  const signed char
  parser::yycheck_[] =
  {
      17,     3,     4,     5,     3,     4,    14,    22,    17,    26,
      36,    37,     0,    29,    30,    29,    30,    38,    35,    38,
      36,    37,    36,    37,    29,    40,    35,    34,    34,    33,
      33,    36,    37,    35,    51,    29,    35,    45,    33,    26,
      26,    26,    36,    37,    31,    31,    26,    30,    32,    31,
       3,    30,    33,    25,    18,    21,    54,    -1,    51
  };

  const signed char
  parser::yystos_[] =
  {
       0,     3,     4,     5,    35,    40,    41,    42,    49,    41,
       0,    38,    50,    51,    38,    43,    44,    26,    31,    45,
      34,    33,    26,    45,    34,    33,    29,    36,    37,    52,
      54,    55,    56,    46,    56,    26,    50,    29,    46,    47,
      26,    43,    30,    52,    53,    32,    52,    30,    47,    48,
      47,    33,    30,    45,    33,    30,    53,    48
  };

  const signed char
  parser::yyr1_[] =
  {
       0,    39,    40,    40,    41,    41,    41,    42,    43,    43,
      44,    44,    45,    45,    46,    47,    47,    47,    48,    48,
      49,    50,    50,    51,    51,    51,    51,    52,    52,    52,
      53,    53,    54,    54,    55,    56
  };

  const signed char
  parser::yyr2_[] =
  {
       0,     2,     1,     1,     1,     1,     1,     4,     1,     3,
       3,     4,     3,     4,     1,     1,     2,     3,     1,     3,
       3,     1,     3,     1,     2,     3,     4,     1,     2,     3,
       1,     3,     1,     1,     1,     1
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
  "num_FLOAT", "Y_ID", "$accept", "Decl", "Type", "ConstDecl", "ConstDefs",
  "ConstDef", "ConstAS", "ConstExp", "ConstInitVal", "ConstInitVals",
  "VarDecl", "VarDefs", "VarDef", "InitVal", "InitVals", "Number", "Exp",
  "AddExp", YY_NULLPTR
  };
#endif


#if YYDEBUG
  const signed char
  parser::yyrline_[] =
  {
       0,    38,    38,    39,    42,    43,    44,    48,    51,    52,
      55,    56,    59,    60,    63,    66,    67,    68,    71,    72,
      76,    79,    80,    83,    84,    85,    86,    89,    90,    91,
      94,    95,    98,    99,   102,   105
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
#line 1300 "./tmp/parser.cpp"

#line 108 "./tmp/parser.y"


void
yy::parser::error (const std::string& msg) { 
      std::cerr << "Error: " << msg << std::endl; 
}
