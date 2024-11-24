lexer:
	flex -o ./lib/lexer/lexer.c ./lib/lexer/lexer.l
	gcc ./lib/lexer/lexer.c ./debug/lexerdbg.c -o ./build/lexer

parser:
	flex -o ./lib/lexer/lexer.cpp ./lib/lexer/lexer.l
	bison -o ./lib/parser/parser.cpp ./lib/parser/parser.y
	clang++ -std=c++17 -o ./build/parser ./debug/parserdbg.cpp ./lib/parser/parser.cpp ./lib/lexer/lexer.cpp -fsanitize=address

tmptest:
	flex -o ./tmp/lexer.cpp ./tmp/lexer.l
	bison -o ./tmp/parser.cpp ./tmp/parser.y
	clang++ -std=c++17 -o ./build/tmptest ./tmp/main.cpp ./tmp/parser.cpp ./tmp/lexer.cpp ./tmp/visitor.cpp -fsanitize=address