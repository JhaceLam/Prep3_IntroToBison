%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#ifndef YYSTYPE
#define YYSTYPE double
#endif

int yylex();
extern int yyparse();
FILE *yyin;
void yyerror(const char *s);
%}


%token NUMBER
%token ADD SUB MUL DIV
%token LPAREN RPAREN

%left ADD SUB
%left MUL DIV
%right UMINUS
%left LPAREN RPAREN


%%

lines   :   lines expr ';' { printf("%f\n", $2); }
        |   lines ';'
        |
        ;

expr    :   expr ADD expr   { $$ = $1 + $3; }
        |   expr SUB expr   { $$ = $1 - $3; }
        |   expr MUL expr   { $$ = $1 * $3; }
        |   expr DIV expr   { $$ = $1 / $3; }
        |   LPAREN expr RPAREN    { $$ = $2; }
        |   SUB expr %prec UMINUS   { $$ = -$2; }
        |   NUMBER { $$ = $1; }
        ;

%%

int yylex()
{
    int t;
    while (1) {
        t = getchar();
        if (t == ' ' || t == '\t' || t == '\n') {
            continue;
        } else if (isdigit(t)) {
            yylval = 0;
            while (isdigit(t)) {
                yylval = yylval * 10 + t - '0';
                t = getchar();
            }
            ungetc(t, stdin);
            return NUMBER;
        }

        switch(t) {
            case '+':
                return ADD;
            case '-':
                return SUB;
            case '*':
                return MUL;
            case '/':
                return DIV;
            case '(':
                return LPAREN;
            case ')':
                return RPAREN;
            default:
                return t;
        }
    }
}

int main()
{
    yyin = stdin;
    do {
        yyparse();
    } while(!feof(yyin));

    return 0;
}

void yyerror(const char *s)
{
    fprintf(stderr, "Parse error: %s\n", s);
    exit(1);
}