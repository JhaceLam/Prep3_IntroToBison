.PHONY: test, clean, example

test: exprCalc.y
	bison -d exprCalc.y
	gcc -o exprCalc exprCalc.tab.c
	./exprCalc

clean:
	rm exprCalc

example:
	cat example.txt
	./exprCalc < example.txt