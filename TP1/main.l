%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <time.h>

	char *u = "{";
	char *p = "}";
	FILE * fp;
	char *user;
	char *id;
	char *data;

	char *comentario;
	char *reputacao;
	char *tempo;

	char *replies[200];

	int nReplies[200] = {};
	char temReplies[200][5];
	int convertTimestamp(char *tmp);

	int x;

	int i =1; 
	
	int n=0;

%}


%x COMMENTTHREAD IDENT TIME TEXT TIMESTAMP 


%%


"<html><head>"	 {BEGIN COMMENTTHREAD; }	

	

<COMMENTTHREAD>\>\<li.*id=\"[^"]*		{id = strdup(yytext+38); fprintf(fp, "%s\n\"id\": \"%s\",\n", u, id); i++;}

<COMMENTTHREAD>^<li.[^"]*				{BEGIN IDENT;}

<IDENT>data\-comment\-id\=\"[a-zA-Z0-9]+[^\"]*			{
														id = strdup(yytext+17); fprintf(fp, "%s\n\"id\": \"%s\",\n", u, id); i++; 
														 
														 BEGIN COMMENTTHREAD;} 

<COMMENTTHREAD>^<a" "href=.*>[a-zA-Z0-9]+[^\<]* 	{user = strdup(yytext+108); fprintf(fp, "\"user\": \"%s\",\n", user);}

<COMMENTTHREAD>^<span.*title\=\"[A-Z]*[a-z]*\"		{reputacao = strdup(yytext+63); fprintf(fp,"\"reputação\": %s,\n", reputacao);}


<COMMENTTHREAD>^<time						{BEGIN TIME;}

<TIME>datetime\=\"[a-zA-Z0-9\.\-\:]*[^\"]*		{data = strdup(yytext+10); fprintf(fp, "\"date\": \"%s\",\n", data);BEGIN COMMENTTHREAD; }

<COMMENTTHREAD>^<a.class\=.*\"\>					{BEGIN TIMESTAMP;}

<TIMESTAMP>([0-9]|\.|\:|" ")*					{tempo = strdup(yytext); x=convertTimestamp(tempo); BEGIN COMMENTTHREAD; }

<COMMENTTHREAD>\<p\>\n[ ]*						{BEGIN TEXT;}

<TEXT>(\.*|\n+)*[^<]*							{comentario = strdup(yytext);  
												fprintf(fp, "\"commentText\": \"%s\",\n", comentario);
												fprintf(fp,"%s", "\"likes\": 0,\n"); BEGIN COMMENTTHREAD;  }


<COMMENTTHREAD>^<\/div>\n<\/div>\n<form			{strcpy(temReplies[i-1], "FALSE"); 
												 fprintf(fp,"\"hasReplies\":\"%s\",\n", temReplies[i-1]); 
												 fprintf(fp,"\"numberOfReplies\":\"%d\"\n%s\n", 0,p);

												 }

<COMMENTTHREAD>^<\/div>\n<\/div>\n<\/li>		{strcpy(temReplies[i-1], "FALSE"); 
												 fprintf(fp,"\"hasReplies\":\"%s\",\n", temReplies[i-1]); 
												 fprintf(fp,"\"numberOfReplies\":\"%d\"\n%s\n", n++,p);
												}


<COMMENTTHREAD>^<ol.*list\"\>					{strcpy(temReplies[i-1], "TRUE"); n=0; 
												 fprintf(fp,"\"hasReplies\":\"%s\",\n", temReplies[i-1]);

												 fprintf(fp,"\"replies\" : [\n");
}
												 
<COMMENTTHREAD>^<\/ol>			{fprintf(fp,"]\n%s\n",p);} 


				 

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
	fprintf(fp, "\"timestamp\": \"%ld\",\n", result);
	
	return 0;

}






int yywrap(){
    return 1;
}

int main(int argc, char **argv) {
	
	fp = fopen("comments.json", "w+");
	fprintf(fp, "\"commentThread\": [\n");
	yylex();	
	
	fprintf(fp, "]\n");
	fclose(fp);
	return 0;
}
