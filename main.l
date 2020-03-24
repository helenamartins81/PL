%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	char *user;
	char *id;
	char *data;
	int flag =0; //quando é o comentário "principal" de uma thread

	int i =0, j=0;

%}


%x COMMENTTHREAD IDENT



//user ^<a" "href=.*>[a-zA-Z0-9]+[^\<]*


%%


^<ol	{BEGIN COMMENTTHREAD;}

<COMMENTTHREAD>\>\<li.[^>]*		{id = strdup(yytext+38); i++;  printf("%d - %s\n", i, id);}
<COMMENTTHREAD>\.*\<li.[^"]*		{BEGIN IDENT;}

<IDENT>data-comment-id\=\"[a-zA-Z0-9]+[^\"]*			{id = strdup(yytext+17); i++;  printf("%d - %s\n", i, id);}





<*>(.|\n)  ;


%%

int yywrap(){
    return 1;
}

int main() {
	yylex();
	return 0;
}
