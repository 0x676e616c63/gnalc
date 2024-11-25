parser:
	flex -o ./lib/lexer/lexer.cpp ./lib/lexer/lexer.l
	bison -o ./lib/parser/parser.cpp ./lib/parser/parser.y
	clang++ -std=c++17 -o ./build/parser ./debug/parserdbg.cpp ./lib/parser/parser.cpp ./lib/lexer/lexer.cpp -fsanitize=address

printast_regenerate:
	flex -o ./lib/lexer/lexer.cpp ./lib/lexer/lexer.l
	bison -o ./lib/parser/parser.cpp ./lib/parser/parser.y
	clang++ -std=c++17 -o ./build/printast ./debug/printast.cpp ./lib/parser/parser.cpp ./lib/lexer/lexer.cpp ./lib/parser/printer.cpp  -fsanitize=address

printast:
	clang++ -std=c++17 -o ./build/printast ./debug/printast.cpp ./lib/parser/parser.cpp ./lib/lexer/lexer.cpp ./lib/parser/printer.cpp  -fsanitize=address

clean:
	rm -rf ./build/*
