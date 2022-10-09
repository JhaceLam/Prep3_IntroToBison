%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#ifndef YYSTYPE
#define YYSTYPE char*
#endif

#define strLen 50
char idStr[strLen];
char numStr[strLen];

int yylex();
extern int yyparse();
FILE *yyin;
void yyerror(const char *s);
%}


%token NUMBER ID
%token ADD SUB MUL DIV
%token LPAREN RPAREN

%left ADD SUB
%left MUL DIV
%right UMINUS
%left LPAREN RPAREN


%%

lines   :   lines expr ';' { printf("%s\n", $2); }
        |   lines ';'
        |
        ;

expr    :   expr ADD expr           { $$ = (char*)malloc(strLen * sizeof(char));
                                    strcpy($$, $1); strcat($$, $3); strcat($$, "+ "); }
        |   expr SUB expr           { $$ = (char*)malloc(strLen * sizeof(char));
                                    strcpy($$, $1); strcat($$, $3); strcat($$, "- "); }
        |   expr MUL expr           { $$ = (char*)malloc(strLen * sizeof(char));
                                    strcpy($$, $1); strcat($$, $3); strcat($$, "* "); }
        |   expr DIV expr           { $$ = (char*)malloc(strLen * sizeof(char));
                                    strcpy($$, $1); strcat($$, $3); strcat($$, "/ "); }
        |   LPAREN expr RPAREN      { $$ = (char*)malloc(strLen * sizeof(char));
                                    strcpy($$, $2); }
        |   SUB expr %prec UMINUS   { $$ = (char*)malloc(strLen * sizeof(char));
                                    strcpy($$, "0 "); strcat($$, $2); strcat($$, "- "); }
        |   NUMBER                  { $$ = (char*)malloc(strLen * sizeof(char));
                                    strcpy($$, $1); strcat($$, " "); }
        |   ID                      { $$ = (char*)malloc(strLen * sizeof(char));
                                    strcpy($$, $1); strcat($$, " "); }
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
            int ti = 0;
            while (isdigit(t)) {
                numStr[ti] = t;
                t = getchar();
                ti++;
            }
            numStr[ti] = '\0';
            yylval = numStr;
            ungetc(t, stdin);
            return NUMBER;
        } else if (isalpha(t) || t == '_') {
            int ti = 0;
            while (isalpha(t) || t == '_' || isdigit(t)) {
                idStr[ti] = t;
                t = getchar();
                ti++;
            }
            idStr[ti] = '\0';
            yylval = idStr;
            ungetc(t, stdin);
            return ID;
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