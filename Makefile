lexer:
	flex -o ./lib/parser/lexer.c ./lib/parser/lexer.l
	gcc ./lib/parser/lexer.c ./debug/lexmain.c -o ./build/lexer