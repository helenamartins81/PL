%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "y.tab.h"

%}

%option yylineno
%option noyywrap

%x REL


%%

[\n \t]*                              {;}

[\.,;]                                 {return yytext[0];}

^@(.|\n)+\#$	                       {;}

\#.*                                   {;}     

^:[A-Za-z_]+([0-9]{4})?		           {yylval.str = strdup(yytext+1); return SUJEITO;}

:type                                  {;}
:NamedIndividual                       {;}

:Pessoa                                {printf("\nAQUI!\n");yylval.str = strdup(yytext+1); return CONCEITO;}

":temMae"                              {yylval.str = strdup(yytext+1); return PREDICADO;} 
":temPai"                              {yylval.str = strdup(yytext+1); return PREDICADO;} 
":temFilho"                            {yylval.str = strdup(yytext+1); return PREDICADO;} 
":temAvô"                              {yylval.str = strdup(yytext+1); return PREDICADO;} 
":temAvó"                              {yylval.str = strdup(yytext+1); return PREDICADO;} 



<REL>" ":[A-Za-z_]+([0-9]{4})?" "[\.;]    {yylval.str = strdup(yytext+1); return SUJEITO;}  // {yylval.str = strdup(yytext); return NOME;}

:[A-Za-z]+                                {yylval.str = strdup(yytext+1); return STRING;}   // {yylval.str = strdup(yytext); return STRING;}  //quando é uma string

:[0-9]+                                   {yylval.value = atoi(strdup(yytext+1)); return NUM;}   // {yylval.value = atoi(yytext); return NUM;}     //quando é um num

.           {;}


%%


