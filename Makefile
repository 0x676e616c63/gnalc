lexer:
	flex -o ./lib/lexer/lexer.c ./lib/lexer/lexer.l
	gcc ./lib/lexer/lexer.c ./debug/lexerdbg.c -o ./build/lexer

parser:
	bison -d -o ./lib/parser.cpp ./lib/parser/parser.y