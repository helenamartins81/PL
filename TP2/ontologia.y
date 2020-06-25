%{
	#define _GNU_SOURCE
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "estrutura.h"
	int yylex();
	int yyerror(char* s);


Relacoes* relacoes;
char * conceito;
char* obj;
char* relacao;


%}

%union{
    char* str;
	int value;
}

%token START
%token<str> SUJEITO
%token<str> TIPOS
%token<str> RELACAO
%token<str> CONCEITO
%type<str> PREDICADOS OBJETO TRIPLOS ONTOLOGIA LISTADUPLOS


%%

Programa : START ONTOLOGIA											{printf("\n%s\n", $2);}
		 ;

ONTOLOGIA : TRIPLOS													{asprintf(&$$, "\n%s", $1);}
		  | ONTOLOGIA TRIPLOS										{asprintf(&$$, "\n%s\n%s", $1,$2);}
		  ;

TRIPLOS : SUJEITO LISTADUPLOS 									{asprintf(&$$, "%s %s", $1,$2);}
		;


LISTADUPLOS : PREDICADOS OBJETO ',' LISTADUPLOS 				{asprintf(&$$, "%s %s %s", $1,$2,$4);}
		    | PREDICADOS OBJETO ';' LISTADUPLOS	    	    	{asprintf(&$$, "%s %s %s", $1,$2,$4);}
		    | OBJETO ';' LISTADUPLOS	    					{asprintf(&$$, "%s %s", $1,$3);}
		    | PREDICADOS OBJETO '.'             				{asprintf(&$$, "%s %s", $1,$2);}
		    | OBJETO '.'	    								{asprintf(&$$, "%s", $1);}
		    ;


PREDICADOS : TIPOS    										{asprintf(&$$, "%s", $1);}
		   | RELACAO 										{asprintf(&$$, "%s", $1);}
		   ;


OBJETO : SUJEITO												{asprintf(&$$, "%s", $1);}
	   | CONCEITO   											{asprintf(&$$, "%s", $1);}
	   ;


%%

#include "lex.yy.c"

int yyerror(char* s){
    printf("Erro: %s \n",s);
    return 1;
}

int main(){
    yyparse();
    return 0;
}

