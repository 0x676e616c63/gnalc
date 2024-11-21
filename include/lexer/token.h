/**
 * @brief token, yylval等的定义，由于bison也会生成token enum，故该文件可能被弃用
 * @attention 依赖关系：lexer.c->token.h->datatype.h
 * @attention yylex的返回值为int。
 * @todo yylval的位置
 * @todo yyerror的位置
 */

#pragma once
#ifndef PRASER_TOKEN_H
#define PRASER_TOKEN_H

#include "datatype.h"

// #ifdef __cplusplus
// namespace AST {
// #endif

enum yytokentype {
	num_INT = 258,
	num_FLOAT = 259,

	Y_ID = 260,

	Y_INT = 261,
	Y_VOID = 262,
	Y_CONST = 263,
	Y_IF = 264,
	Y_ELSE = 265,
	Y_WHILE = 266,
	Y_BREAK = 267,
	Y_CONTINUE = 268,
	Y_RETURN = 269,

	Y_ADD = 270,
	Y_SUB = 271,
	Y_MUL = 272,
	Y_DIV = 273,
	Y_MODULO = 274,
	Y_LESS = 275,
	Y_LESSEQ = 276,
	Y_GREAT = 277,
	Y_GREATEQ = 278,
	Y_NOTEQ = 279,
	Y_EQ = 280,
	Y_NOT = 281,
	Y_AND = 282,
	Y_OR = 283,
	Y_ASSIGN = 284,

	Y_LPAR = 285,
	Y_RPAR = 286,
	Y_LBRACKET = 287,
	Y_RBRACKET = 288,
	Y_LSQUARE = 289,
	Y_RSQUARE = 290,
	Y_COMMA = 291,
	Y_SEMICOLON = 292,

	Y_FLOAT = 293
};

typedef union _YYLVAL{
	int		token;
	int32		int_value;
	float32   float_value;
	char*	id_name;
}_YYLVAL;

extern _YYLVAL yylval;

void yyerror(char* s);

// #ifdef __cplusplus
// }
// #endif

#endif //COMPILER_LAB_TOKEN_H