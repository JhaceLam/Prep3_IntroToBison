.PHONY: test, clean, example

test: assign.y symbolTable.cpp symbolTable.h
	bison -d assign.y
	g++ -o assign assign.tab.c symbolTable.cpp
	./assign

clean:
	rm assign

example:
	cat example.txt
	./assign < example.txt