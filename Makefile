lexer:
	flex -o ./lib/lexer/lexer.c ./lib/lexer/lexer.l
	gcc ./lib/lexer/lexer.c ./debug/lexerdbg.c -o ./build/lexer

parser:
	bison -o ./lib/parser/parser.cpp ./lib/parser/parser.y

tmptest:
	flex -o ./tmp/lexer.cpp ./tmp/lexer.l
	bison -o ./tmp/parser.cpp ./tmp/parser.y
	clang++ -std=c++20 -o ./build/tmptest ./tmp/main.cpp ./tmp/parser.cpp ./tmp/lexer.cpp ./tmp/visitor.cpp -fsanitize=address