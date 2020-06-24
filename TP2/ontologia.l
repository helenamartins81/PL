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

^:[A-Za-z_]+([0-9]{4})? 		            {yylval.str = strdup(yytext); return NOME;}

:Pessoa                                     {return PESSOA;}

:Sexo" ":Masculino                          {return MASCULINO;}

:Sexo" ":Feminino                           {return FEMININO;} 
 
:[a-z][a-zA-Z]+" "                          {yylval.str = strdup(yytext); return RELACAO;}

:[A-Za-z_]+([0-9]{4})?" "[\.;]                {yylval.str = strdup(yytext); return NOME;}

[A-Za-z]+                                   {yylval.str = strdup(yytext); return STRING;}  //quando é uma string

[0-9]+                                      {yylval.value = atoi(yytext); return NUM;}     //quando é um num


.			{;}


%%


