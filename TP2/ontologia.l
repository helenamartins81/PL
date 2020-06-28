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

:Pessoa                                {yylval.str = strdup(yytext+1); return CONCEITO;}

":temMae"                              {yylval.str = strdup(yytext+1); BEGIN REL; return PREDICADO; } 
":temPai"                              {yylval.str = strdup(yytext+1); BEGIN REL; return PREDICADO; } 
":temFilho"                            {yylval.str = strdup(yytext+1); BEGIN REL; return PREDICADO; } 
":temAvô"                              {yylval.str = strdup(yytext+1); BEGIN REL; return PREDICADO; } 
":temAvó"                              {yylval.str = strdup(yytext+1); BEGIN REL; return PREDICADO; } 



<REL>" ":[A-Za-z_]+([0-9]{4})?          {yylval.str = strdup(yytext+2); BEGIN INITIAL; return SUJEITO;}  

:[A-Za-z]+                             {yylval.str = strdup(yytext+2); return STRING;}   

:[0-9]+                                {yylval.value = atoi(strdup(yytext+1)); return NUM;}   


.           {;}



%%


