%{
#include <stdlib.h>
#include "robotic.h"
#include "y.tab.h"
void yyerror(char *);
%}

%%
[a-z]         {yylval.sIndex = *yytext - 'a'; return VARIABLE; }
0             {yylval.iDeger = atoi(yytext);return INTEGER;}
[1-9][0-9]*   {yylval.iDeger = atoi(yytext);return INTEGER;}
[-()<>=+*/;{}.] {return *yytext;}
">="            return BIGEQUAL;
"<="            return SMALLEQUAL;
"=="            return EQUAL;
"!="            return NOTEQUAL;
"while"         return WHILE;
"if"            return IF;
"else"          return ELSE;
"print"         return PRINT;
[ \t\n]+        ;       
.               yyerror("Unknown character");
%%
int yywrap(void) {return 1;}
