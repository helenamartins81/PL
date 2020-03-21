%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	char *user;
	void error();
	int i =0;

%}

%option noyywrap yylineno


%x COMENTARIO

user ^<a" "href=.*>(.*)<\/a> 
comentario <ol.*>

%%
{user}	{
	user = strdup(yytext+108);
	//printf("User: %s\n",user);
}

"<p>"\n*\s*(.*)\s*\n*(.*)\s*\n*(.*)	{
	i++;
	printf("%d - User %s -  %s\n",i,user,yytext);
}

.|\n	{}


%%

int main() {
	yylex();
	return 0;
}
