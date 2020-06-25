%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
//#include "y.tab.h"
//%option yylineno
//%option noyywrap
%}

%x REL


%%

^@(.|\n)+\#$	                {;}

\#.*                            {;}     

^:[A-Za-z_]+([0-9]{4})?		           printf("%s\n",yytext+1);  // {yylval.str = strdup(yytext); return NOME;}

:type                   {;}
:NamedIndividual        {;}

":Pessoa"                                   printf("%s\n",yytext+1);  // {return PESSOA;}

":Sexo :Masculino"                         printf("%s\n",yytext+1);  //{return MASCULINO;}

":Sexo :Feminino"                         printf("%s\n",yytext+1);  // {return FEMININO;} 
 
":temMae"                          {printf("%s\n",yytext+1); BEGIN REL;} //{yylval.str = strdup(yytext); return RELACAO;}
":temPai"                         {printf("%s\n",yytext+1);  BEGIN REL;} //{yylval.str = strdup(yytext); return RELACAO;}
":temFilho"                      {printf("%s\n",yytext+1); BEGIN REL;}   // {yylval.str = strdup(yytext); return RELACAO;}
":temAvô"                         {printf("%s\n",yytext+1); BEGIN REL;}  //{yylval.str = strdup(yytext); return RELACAO;}
":temAvó"                          {printf("%s\n",yytext+1); BEGIN REL;}//{yylval.str = strdup(yytext); return RELACAO;}



<REL>:[A-Za-z_]+([0-9]{4})?" "[\.;]            {printf("%s\n",yytext+1); BEGIN INITIAL;}  // {yylval.str = strdup(yytext); return NOME;}

:[A-Za-z]+                                printf("%s\n",yytext);   // {yylval.str = strdup(yytext); return STRING;}  //quando é uma string

:[0-9]+                                   printf("%s\n",yytext);   // {yylval.value = atoi(yytext); return NUM;}     //quando é um num


.|\n			{;}


%%


int yywrap(){
    return 1;
}


int main(int argc, char **argv) {

	yylex();	

	return 0;
}
