.PHONY: test, clean, example

test: infixToPostfix.y
	bison -d infixToPostfix.y
	gcc -o infixToPostfix infixToPostfix.tab.c
	./infixToPostfix

clean:
	rm infixToPostfix

example:
	cat example.txt
	./infixToPostfix < example.txt