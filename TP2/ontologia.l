%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%option noyywrap

%x REL OBJETO SEXO

%%

[,;.]   return yytext[0];

^@(.|\n)+\#$	                {return START;}

\#.*                            {;}     

^:[A-Za-z_]+([0-9]{4})? 		            {yylval.str = strdup(yytext+1); return nome;}



^[ ]+:Pessoa                                {yylval.str = strdup(yytext+1);  return pessoa;}

^[ ]+:Sexo" ":                              {BEGIN SEXO;}

<SEXO>[A-Za-z]+                             {yylval.str = strdup(yytext);
                                            if(strcmp(yytext, "Masculino")==0) return masculino;
                                            else return feminino;}  

^[ ]*:                                      {BEGIN REL;}

<REL>[a-zA-Z]+" "                           {yylval.str = strdup(yytext);  return rel; BEGIN OBJETO;}

<OBJETO>[A-Za-z]+                           {yylval.str = strdup(yytext); return string; BEGIN INITIAL;}  

<OBJETO>[0-9]+                              {yylval.str = strdup(yytext); return num; BEGIN INITIAL;} 

<OBJETO>" ":[A-Za-z_]+([0-9]{4})?           {yylval.str = strdup(yytext+1); return nome; BEGIN INITIAL;}


(.|\n)			{;}


%%


