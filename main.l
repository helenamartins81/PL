%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	char *user;
	char *id;
	char *data;
	int flag =0; //quando é o comentário "principal" de uma thread
	char *comentario;
	char *titulo;


	int i =0, j=1, k=0, c=0, t=0;

%}


%x COMMENTTHREAD IDENT TIME TEXT TITLE





%%


^<ol	{BEGIN COMMENTTHREAD;}

<COMMENTTHREAD>\>\<li.[^>]*		{id = strdup(yytext+38); i++;  printf("%d - %s\n", i, id);}
<COMMENTTHREAD>\.*\<li.[^"]*		{BEGIN IDENT;}

<IDENT>data-comment-id\=\"[a-zA-Z0-9]+[^\"]*			{id = strdup(yytext+17); i++;  printf("%d - %s\n", i, id); BEGIN COMMENTTHREAD;}

<COMMENTTHREAD>^<a" "href=.*>[a-zA-Z0-9]+[^\<]* 	{user = strdup(yytext+108); printf("%d: %s \n",j,user); j++;}

<COMMENTTHREAD>^<time						{BEGIN TIME;}


<COMMENTTHREAD>^<span\sclass="comment.*"><i			{BEGIN TITLE;}


<TIME>datetime\=\"[a-zA-Z0-9\.\-\:]*[^\"]*		{data = strdup(yytext+10); k++; printf("%d ----- %s\n", k, data); BEGIN COMMENTTHREAD;}

<COMMENTTHREAD>\<p\>\n[ ]*						{BEGIN TEXT;}

<TEXT>.*|\n*			{comentario = strdup(yytext); c++; printf("%d comentario: %s\n", c, comentario); BEGIN COMMENTTHREAD;}

<TITLE>""|"[A-Z][a-z]*"		{titulo = strdup(yytext); t++; printf("%d ---- titulo: %s", t, titulo); BEGIN COMMENTTHREAD;}




<*>(.|\n)  ;


%%

int yywrap(){
    return 1;
}

int main() {
	yylex();
	return 0;
}
