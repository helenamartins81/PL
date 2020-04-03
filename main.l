%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <time.h>

	FILE * fp;
	char *user;
	char *id;
	char *data;

	char *comentario;
	char *reputacao;
	char *tempo;

	char *replies[200];
	int flags[200]={};
	int nReplies[200]={};

	int convertTimestamp(char *tmp);
	int nmrReplies(int i);
	int getReplies(int i);
	int x;

	int i =1, j=1, k=1, c=1, t=1, l=1; //DEPOIS PODE-SE APAGAR
	
	int flag = 0, n = 0, y, flag2 = 0, m;
	int nmr = 0;

%}


%x COMMENTTHREAD IDENT TIME TEXT TIMESTAMP



%%


"<html><head>"	 {BEGIN COMMENTTHREAD;}

<COMMENTTHREAD>^<ol.*list\"\>			{flag = 1; n=0; flag2=1; nmr = i; flags[nmr] = 1;} 	//flag serve para ver se está dentro das respostas flag2 serve para saber qual o comentário onde pertencem as respostas
							

<COMMENTTHREAD>\>\<li.*id\=\"[^"]*	{id = strdup(yytext+38);  printf("%d - %s\n", i, id); fprintf(fp,"%s %s %s", "{\n\"id\":", id,"\n"); i++;}

<COMMENTTHREAD>^<li.[^"]*		{BEGIN IDENT;}

<IDENT>data-comment-id\=\"[a-zA-Z0-9]+[^\"]*			{id = strdup(yytext+17);  printf("%d - %s\n", i, id); fprintf(fp,"%s %s %s", "{\n\"id\":", id,"\n");y = nmrReplies(i); i++; BEGIN COMMENTTHREAD;} 

<COMMENTTHREAD>^<a" "href=.*>[a-zA-Z0-9]+[^\<]* 	{user = strdup(yytext+108); printf("%d: %s \n",j,user); fprintf(fp,"%s %s %s", "\"user\":", user,"\n") ;j++;}

<COMMENTTHREAD>^<span.*title\=\"[A-Z]*[a-z]*\"		{reputacao = strdup(yytext+63);  printf("%d reputação: %s\n", t, reputacao); fprintf(fp,"%s %s %s", "\"reputação\":", reputacao,"\n");t++;}


<COMMENTTHREAD>^<time						{BEGIN TIME;}

<TIME>datetime\=\"[a-zA-Z0-9\.\-\:]*[^\"]*		{data = strdup(yytext+10); printf("%d data: %s\n", k, data); fprintf(fp,"%s %s %s", "\"date\":", data,"\n");BEGIN COMMENTTHREAD; k++; }

<COMMENTTHREAD>^<a.class\=.*\"\>					{BEGIN TIMESTAMP;}

<TIMESTAMP>([0-9]|\.|\:|" ")*					{tempo = strdup(yytext); printf("%d tempo: %s\n", l, tempo); x=convertTimestamp(tempo); BEGIN COMMENTTHREAD; l++;}

<COMMENTTHREAD>\<p\>\n[ ]*						{BEGIN TEXT;}

<TEXT>(\.*|\n+)*[^<]*			{comentario = strdup(yytext); printf("%d comentario: %s\n", c, comentario); 
								fprintf(fp,"%s %s %s", "\"commentText\":",comentario ,"\n"); int v = getReplies(i); 
								if(flags[n++] == 1){
										fprintf(fp,"%s %s %s", "\"hasReplies\":", "TRUE","\n");
								}else{
										fprintf(fp,"%s %s %s", "\"hasReplies\":", "FALSE","\n");}
								BEGIN COMMENTTHREAD;  c++;}

<COMMENTTHREAD>^<\/ol>			{flag = 0;}


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
	printf("timestamp: %ld\n", (long) result);
	return 0;

}

int nmrReplies(int i){  
	if(flag){
		if(flag2){
		
		nReplies[nmr] = 1;
		flag2 = 0;
		} else{
			nReplies[nmr]++;
		}
		

	}
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
