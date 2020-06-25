%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%option yylineno
%option noyywrap

%%

[ \t\r\n]   ;


[,;\.:]   return yytext[0];

^@(.|\n)+\#$	                {;}

\#.*                            {;}     

^:[A-Za-z_]+([0-9]{4})? 		{yylval.str = strdup(yytext+1); return SUJEITO; printf("Printou o nome\n");}
 
:[a-z][a-zA-Z]+\s               {yylval.str = strdup(yytext+1); return RELACAO; printf("Printou o Relacao\n");}

:[A-Za-z_]+([0-9]{4})?\s[\.;]   {yylval.str = strdup(yytext+1); return SUJEITO; printf("Printou o Nome\n");}

:[A-Za-z]+                      {yylval.str = strdup(yytext+1); return CONCEITO; printf("Printou o Conceito\n");}

[a-z:]+:[a-z]+					{yylval.str = strdup(yytext+4); return TIPOS; printf("Printou o Tipos\n");}

.			{;}


%%


