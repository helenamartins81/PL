%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%option noyywrap

%x REL OBJETO SEXO

%%

[,;.:]   return yytext[0];

^@(.|\n)+\#$	                {;}

\#.*                            {;}     

^:[A-Za-z_]+([0-9]{4})? 		            {yylval.str = strdup(yytext); return NOME;}


^[ ]+:Pessoa                                {yylval.str = strdup("Pessoa"); return PESSOA;}

^[ ]+:Sexo" ":                              {BEGIN SEXO;}

<SEXO>[A-Za-z]+                             {yylval.str = strdup(yytext);
                                            if(strcmp(yytext, "Masculino")==0) return MASCULINO;
                                            else return FEMININO;}  

^[ ]+:                                      {BEGIN REL;}

<REL>[a-zA-Z]+" "                           {yylval.str = strdup(yytext);  return RELACAO; BEGIN OBJETO;}

<OBJETO>:[A-Za-z_]+([0-9]{4})?              {yylval.str = strdup(yytext+2); return NOME;}  //quando é um sujeito

<OBJETO>[A-Za-z]+                           {yylval.str = strdup(yytext); return STRING;}  //quando é uma string

<OBJETO>[0-9]+                              {yylval.value = atoi(yytext); return NUM;}     //quando é um num



(.|\n)			{;}


%%


