%{
#include <stdio.h>
#include "y.tab.h"
%}

%option noyywrap



%%

^@(.|\n)+\#$	                {;}

\#.*                            {;}

^:[A-Za-z_]+([0-9]{4})? 		{yylval.id = strdup(yytext); return Sujeito;}

[,;.]							{return yytext[0];}

rdf:[a-z]+						{yylval.id = strdup(yytext); return Propriedade;}

:tem[A-Za-z]+					{yylval.id = strdup(yytext); return Relacao;}

:[a-zA-Z]+\s[,;.] 				{yylval.id = strndup(yytext, yyleng-2); return Conceito;}

:[A-Za-z]+_{1,}\w*\s[;.]		{yylval.id = strndup(yytext, yyleng-2); return Progenitor;}


[.*|\n]         {;}
				
(.|\n)			{;}

%%


