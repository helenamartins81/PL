%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <time.h>
	char *user;
	char *id;
	char *data;
	int flag =0; //quando é o comentário "principal" de uma thread
	char *comentario;
	char *reputacao;
	char *tempo;


	int i =0, j=1, k=0, c=0, t=0, l=0;

%}


%x COMMENTTHREAD IDENT TIME TEXT 









%%


^<ol	{BEGIN COMMENTTHREAD;}

<COMMENTTHREAD>\>\<li.[^>]*		{id = strdup(yytext+38); i++;  printf("%d - %s\n", i, id);}
<COMMENTTHREAD>^<li.[^"]*		{BEGIN IDENT;}

<IDENT>data-comment-id\=\"[a-zA-Z0-9]+[^\"]*			{id = strdup(yytext+17); i++;  printf("%d - %s\n", i, id); BEGIN COMMENTTHREAD;}

<COMMENTTHREAD>^<a" "href=.*>[a-zA-Z0-9]+[^\<]* 	{user = strdup(yytext+108); printf("%d: %s \n",j,user); j++;}

<COMMENTTHREAD>^<span.*title\=\"[A-Z]*[a-z]*\"		{reputacao = strdup(yytext+63); t++; printf("%d reputação: %s\n", t, reputacao);}


<COMMENTTHREAD>^<time						{BEGIN TIME;}

<TIME>datetime\=\"[a-zA-Z0-9\.\-\:]*[^\"]*		{data = strdup(yytext+10); k++; printf("%d data: %s\n", k, data); BEGIN COMMENTTHREAD;}

<TIME>^\<a\sclass\=.*[0-9]						{}

<COMMENTTHREAD>\<p\>\n[ ]*						{BEGIN TEXT;}

<TEXT>.*|\n*			{comentario = strdup(yytext); c++; printf("%d comentario: %s\n", c, comentario); BEGIN COMMENTTHREAD;}



<*>(.|\n)  ;


%%

int yywrap(){
    return 1;
}

int main() {
	yylex();
	return 0;
}
