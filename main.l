%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <time.h>
	char *user;
	char *id;
	char *data;
	int flag =0; //se tem replies
	char *comentario;
	char *reputacao;
	char *tempo;
	int convertTimestamp(char *tmp);

	int i =0, j=1, k=0, c=0, t=0, l=0, x;

%}


%x COMMENTTHREAD IDENT TIME TEXT TIMESTAMP




%%


^<ol	{BEGIN COMMENTTHREAD;}

<COMMENTTHREAD>\>\<li.[^>]*		{id = strdup(yytext+38); i++;  printf("%d - %s\n", i, id);}
<COMMENTTHREAD>^<li.[^"]*		{BEGIN IDENT;}

<IDENT>data-comment-id\=\"[a-zA-Z0-9]+[^\"]*			{id = strdup(yytext+17); i++;  printf("%d - %s\n", i, id); BEGIN COMMENTTHREAD;}

<COMMENTTHREAD>^<a" "href=.*>[a-zA-Z0-9]+[^\<]* 	{user = strdup(yytext+108); printf("%d: %s \n",j,user); j++;}

<COMMENTTHREAD>^<span.*title\=\"[A-Z]*[a-z]*\"		{reputacao = strdup(yytext+63); t++; printf("%d reputação: %s\n", t, reputacao);}


<COMMENTTHREAD>^<time						{BEGIN TIME;}

<TIME>datetime\=\"[a-zA-Z0-9\.\-\:]*[^\"]*		{data = strdup(yytext+10); k++; printf("%d data: %s\n", k, data); BEGIN COMMENTTHREAD; }

<COMMENTTHREAD>^<a.class\=.*\"\>					{BEGIN TIMESTAMP;}

<TIMESTAMP>([0-9]|\.|\:|" ")*					{tempo = strdup(yytext); l++; printf("%d tempo: %s\n", l, tempo); x=convertTimestamp(tempo); BEGIN COMMENTTHREAD;}

<COMMENTTHREAD>\<p\>\n[ ]*						{BEGIN TEXT;}

<TEXT>(\.*|\n+)*[^<]*			{comentario = strdup(yytext); c++; printf("%d comentario: %s\n", c, comentario); BEGIN COMMENTTHREAD;}



<*>(.|\n)  ;



%%

int convertTimestamp(char *tmp){
	struct tm t;
	time_t result;
	int year = 0, month = 0, day = 0, hour = 0, min = 0;

	sscanf(tmp, "%2d.%2d.%4d %2d:%2d", &day, &month, &year, &hour, &min);

	t.tm_mday = day;
	t.tm_mon = month;
	t.tm_year = year - 1900;
	t.tm_hour = hour;
	t.tm_min = min;
	result = mktime(&t); 
	printf("timestamp: %ld\n", (long) result);
	return 0;

}



int yywrap(){
    return 1;
}

int main(int argc, char **argv) {
	yylex();
	return 0;
}

