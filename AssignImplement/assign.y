%{
#include <cstdio>
#include <cstdlib>
#include <cctype>
#include "symbolTable.h"
#include <string>
#include <cstring>
#define strLen 50

SymbolTable table;

int yylex();
extern int yyparse();
FILE *yyin;
void yyerror(const char *s);
%}

%union {
    double num;
    char* id;
}

%type <num> expr

%token <num> NUMBER
%token <id> ID
%token ADD SUB MUL DIV
%token LPAREN RPAREN
%token ASSIGN
%token PRINT

%right ASSIGN
%left ADD SUB
%left MUL DIV
%right UMINUS
%left LPAREN RPAREN


%%

program :   program stmt
        |   stmt
        ;

stmt    :   ID ASSIGN expr ';' { table.insert(string($1), $3); }
        |   PRINT expr ';'     { cout << $2 << endl; }
        ;

expr    :   expr ADD expr           { $$ = $1 + $3; }
        |   expr SUB expr           { $$ = $1 - $3; }
        |   expr MUL expr           { $$ = $1 * $3; }
        |   expr DIV expr           { $$ = $1 / $3; }
        |   LPAREN expr RPAREN      { $$ = $2; }
        |   SUB expr %prec UMINUS   { $$ = -$2; }
        |   NUMBER                  { $$ = $1; }
        |   ID                      { 
                                        string str = $1;
                                        MAP_STR_DBL::iterator it = table.lookup(str);
                                        if (it != table.end()) {
                                            $$ = it->second;
                                        }
                                    }
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
            double num = 0;
            while (isdigit(t)) {
                num = num * 10 + t - '0';
                t = getchar();
            }
            yylval.num = num;
            ungetc(t, stdin);
            return NUMBER;
        } else if (isalpha(t) || t == '_') {
            char *idStr = (char *) malloc(strLen * sizeof(char));
            int ti = 0;
            while (isalpha(t) || t == '_' || isdigit(t)) {
                idStr[ti] = t;
                t = getchar();
                ti++;
            }
            idStr[ti] = '\0';
            string idStr_ = string(idStr);
            MAP_STR_DBL::iterator it = table.lookup(idStr_);
            if (it == table.end()) {
                table.insert(idStr_, 0);
            }
            yylval.id = idStr;
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
            case '=':
                return ASSIGN;
            case ':':
                return PRINT;
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