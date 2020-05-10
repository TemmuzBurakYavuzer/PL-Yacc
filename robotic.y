%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <stdarg.h>
    #include "robotic.h"
    #include "y.tab.h"

    nodeType *islt(int islem, int OpsSayi, ...);nodeType *kimlik(int i);nodeType *sabit(int deger);
    void serbestNode(nodeType *point);void yyerror(char *s);
    int ifade(nodeType *point);int yylex(void);int sym[26];                    
%}

%union {int iDeger;char sIndex;nodeType *nIsaretci;};

%token <iDeger> INTEGER
%token <sIndex> VARIABLE
%token WHILE IF PRINT
%nonassoc IFX
%nonassoc ELSE

%left BIGEQUAL SMALLEQUAL EQUAL NOTEQUAL '>' '<' '+' '-' '*' '/'
%nonassoc UMINUS

%type <nIsaretci> stmt expr stmt_list

%%

program:
        function                { exit(0); }
        ;
function:
          function stmt         { ifade($2); serbestNode($2); }
        |
        ;
stmt:
          ';'                            { $$ = islt(';', 2, NULL, NULL); } | expr ';'  { $$ = $1; }
        | PRINT expr ';'                 { $$ = islt(PRINT, 1, $2); } | VARIABLE '=' expr ';'   { $$ = islt('=', 2, kimlik($1), $3); } | WHILE '(' expr ')' stmt  { $$ = islt(WHILE, 2, $3, $5); } 
        | IF '(' expr ')' stmt %prec IFX { $$ = islt(IF, 2, $3, $5); } | IF '(' expr ')' stmt ELSE stmt { $$ = islt(IF, 3, $3, $5, $7); } | '{' stmt_list '}'              { $$ = $2; }
        ;
stmt_list:
          stmt                  { $$ = $1; }| stmt_list stmt        { $$ = islt(';', 2, $1, $2); }
        ;
expr:
          INTEGER               { $$ = sabit($1); }| VARIABLE { $$ = kimlik($1); }
        | '-' expr %prec UMINUS { $$ = islt(UMINUS, 1, $2); }
        | expr '+' expr         { $$ = islt('+', 2, $1, $3); } | expr '-' expr { $$ = islt('-', 2, $1, $3); }
        | expr '*' expr         { $$ = islt('*', 2, $1, $3); } | expr '/' expr { $$ = islt('/', 2, $1, $3); }
        | expr '<' expr         { $$ = islt('<', 2, $1, $3); } | expr '>' expr { $$ = islt('>', 2, $1, $3); }
        | expr BIGEQUAL expr    { $$ = islt(BIGEQUAL, 2, $1, $3); } | expr SMALLEQUAL expr { $$ = islt(SMALLEQUAL, 2, $1, $3); }
        | expr NOTEQUAL expr    { $$ = islt(NOTEQUAL, 2, $1, $3); } | expr EQUAL expr { $$ = islt(EQUAL, 2, $1, $3); }
        | '(' expr ')'          { $$ = $2; }
        ;

%%

nodeType *sabit(int deger) {nodeType *point;
    if ((point = malloc(sizeof(nodeType))) == NULL)yyerror("out of memory");
    point->tip = tipSabit;point->sabit.deger = deger;
    return point;}

nodeType *kimlik(int i) {nodeType *point;
    if ((point = malloc(sizeof(nodeType))) == NULL) yyerror("out of memory");
    point->tip = tipKimlik;point->kimlik.i = i;
    return point;}

nodeType *islt(int islem, int OpsSayi, ...) {va_list ap;nodeType *point;int i;
    if ((point = malloc(sizeof(nodeType) + (OpsSayi-1) * sizeof(nodeType *))) == NULL) yyerror("out of memory");
    point->tip = tipIslt;point->islt.islem = islem;point->islt.OpsSayi = OpsSayi;
    va_start(ap, OpsSayi);
    for (i = 0; i < OpsSayi; i++)point->islt.islenen[i] = va_arg(ap, nodeType*);va_end(ap);return point;}

void serbestNode(nodeType *point) { int i;if (!point) return;
    if (point->tip == tipIslt) {for (i = 0; i < point->islt.OpsSayi; i++)serbestNode(point->islt.islenen[i]);}
    free (point);}

void yyerror(char *s) {fprintf(stdout, "%s\n", s);}

int main(void) {yyparse();return 0;}

int ifade(nodeType *point) {if (!point) return 0;
    switch(point->tip) {case tipSabit:return point->sabit.deger;case tipKimlik:return sym[point->kimlik.i];
    case tipIslt:
        switch(point->islt.islem) {
        case WHILE: while(ifade(point->islt.islenen[0])) ifade(point->islt.islenen[1]); return 0;

        case IF:    if (ifade(point->islt.islenen[0])) ifade(point->islt.islenen[1]);else if (point->islt.OpsSayi > 2) ifade(point->islt.islenen[2]);return 0;

        case PRINT: printf("%d\n", ifade(point->islt.islenen[0])); return 0;

        case ';':  ifade(point->islt.islenen[0]); return ifade(point->islt.islenen[1]);case '=':  return sym[point->islt.islenen[0]->kimlik.i] = ifade(point->islt.islenen[1]);

        case UMINUS:return -ifade(point->islt.islenen[0]);
        case '+':   return ifade(point->islt.islenen[0]) + ifade(point->islt.islenen[1]);case '-': return ifade(point->islt.islenen[0]) - ifade(point->islt.islenen[1]);
        case '*':   return ifade(point->islt.islenen[0]) * ifade(point->islt.islenen[1]);case '/': return ifade(point->islt.islenen[0]) / ifade(point->islt.islenen[1]);
        case '<':   return ifade(point->islt.islenen[0]) < ifade(point->islt.islenen[1]);case '>': return ifade(point->islt.islenen[0]) > ifade(point->islt.islenen[1]);

        case BIGEQUAL:  return ifade(point->islt.islenen[0]) >= ifade(point->islt.islenen[1]);case SMALLEQUAL: return ifade(point->islt.islenen[0]) <= ifade(point->islt.islenen[1]);
        case NOTEQUAL:  return ifade(point->islt.islenen[0]) != ifade(point->islt.islenen[1]);case EQUAL:   return ifade(point->islt.islenen[0]) == ifade(point->islt.islenen[1]);
        }
    }
    return 0;
}
