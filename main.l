%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <time.h>

	char *u = "{";
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
	int nmrReplies();
	int getReplies(int i);
	int x;

	int i =1; 
	
	int flag = 0, n = 0, flag2 = 0, nmr=0;

%}


%x COMMENTTHREAD IDENT TIME TEXT TIMESTAMP 


%%


"<html><head>"	 {BEGIN COMMENTTHREAD; }	

	

<COMMENTTHREAD>\>\<li.*id=\"[^"]*		{id = strdup(yytext+38); fprintf(fp, "%s\n\"id\":%s\n", u, id); i++;}

<COMMENTTHREAD>^<li.[^"]*				{BEGIN IDENT;}

<IDENT>data\-comment\-id\=\"[a-zA-Z0-9]+[^\"]*			{if(flag) n++;
														id = strdup(yytext+17); fprintf(fp, "%s\n\"id\":%s\n", u, id); i++; 
														 
														 BEGIN COMMENTTHREAD;} 

<COMMENTTHREAD>^<a" "href=.*>[a-zA-Z0-9]+[^\<]* 	{user = strdup(yytext+108); fprintf(fp,"%s %s %s", "\"user\":", user,"\n") ;}

<COMMENTTHREAD>^<span.*title\=\"[A-Z]*[a-z]*\"		{reputacao = strdup(yytext+63); fprintf(fp,"%s %s %s", "\"reputação\":", reputacao,"\n");}


<COMMENTTHREAD>^<time						{BEGIN TIME;}

<TIME>datetime\=\"[a-zA-Z0-9\.\-\:]*[^\"]*		{data = strdup(yytext+10); fprintf(fp,"%s %s %s", "\"date\":", data,"\n");BEGIN COMMENTTHREAD; }

<COMMENTTHREAD>^<a.class\=.*\"\>					{BEGIN TIMESTAMP;}

<TIMESTAMP>([0-9]|\.|\:|" ")*					{tempo = strdup(yytext); x=convertTimestamp(tempo); BEGIN COMMENTTHREAD; }

<COMMENTTHREAD>\<p\>\n[ ]*						{BEGIN TEXT;}

<TEXT>(\.*|\n+)*[^<]*							{comentario = strdup(yytext); int v = getReplies(i); 
												fprintf(fp,"%s %s %s", "\"commentText\":", comentario,"\n");
												fprintf(fp,"%s", "\"likes\": 0\n"); BEGIN COMMENTTHREAD;  }


<COMMENTTHREAD>^<\/div>\n<\/div>\n<form			{strcpy(temReplies[i-1], "FALSE"); 
												 fprintf(fp,"\"hasReplies\":%s\n", temReplies[i-1]); 
												 fprintf(fp,"\"numberOfReplies\":%d\n", 0);

												 }

<COMMENTTHREAD>^<\/div>\n<\/div>\n<\/li>		{strcpy(temReplies[i-1], "FALSE"); 
												 fprintf(fp,"\"hasReplies\":%s\n", temReplies[i-1]); 
												 fprintf(fp,"\"numberOfReplies\":%d\n", 0);
												}

<COMMENTTHREAD>^<\/ol>			{flag = 0; nReplies[nmr]=n;  n=0; fprintf(fp,"\"numberOfReplies\":%d\n", nReplies[nmr]);} 


<COMMENTTHREAD>^<ol.*list\"\>					{strcpy(temReplies[i-1], "TRUE"); flag = 1; flag2 = 1; nmr=i;
												 fprintf(fp,"\"hasReplies\":%s\n", temReplies[i-1]);
}
												 


				 

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
	fprintf(fp,"%s %ld %s", "\"timestamp\":", result,"\n");
	
	return 0;

}



int getReplies(int i){
	int m = i-2;
	if(flag){
		replies[m] =comentario;
	}
	return 0;
}




int yywrap(){
    return 1;
}

int main(int argc, char **argv) {
	
	fp = fopen("comments.json", "w+");
	fprintf(fp, "\"commentThread\": [\n");
	yylex();	
	
	fprintf(fp, "]");
	fclose(fp);
	return 0;
}
