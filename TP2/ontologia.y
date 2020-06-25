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

%token<str> SUJEITO
%token<str> CONCEITO
%token<str> STRING
%token<str> PREDICADO
%token<value> NUM
%type<str> Triplo ListaDuplos Objeto Ontologia


%%

Programa : Ontologia											{printf("\n%s\n", $1);}
		 ;

Ontologia : Triplo													{asprintf(&$$, "\n%s", $1);}
		  | Ontologia Triplo										{asprintf(&$$, "\n%s\n%s", $1,$2);}
		  ;

Triplo : SUJEITO '.'												{asprintf(&$$, "%s", $1);}
       | SUJEITO ',' ListaDuplos 									{asprintf(&$$, "%s %s", $1,$3);}
		;


ListaDuplos : PREDICADO Objeto ',' ListaDuplos 					{asprintf(&$$, "%s %s %s", $1,$2,$4);}
		    | PREDICADO Objeto ';' ListaDuplos	    	    	{asprintf(&$$, "%s %s %s", $1,$2,$4);}
		    | Objeto ';' ListaDuplos	    					{asprintf(&$$, "%s %s", $1,$3);}
		    | PREDICADO Objeto '.'             					{asprintf(&$$, "%s %s", $1,$2);}
		    | Objeto '.'	    								{asprintf(&$$, "%s", $1);}
		    ;


Objeto : SUJEITO												{asprintf(&$$, "%s", $1);}
	   | CONCEITO   											{asprintf(&$$, "%s", $1);}
	   | STRING													{asprintf(&$$, "%s", $1);}
	   | NUM													{asprintf(&$$, "%d", $1);}
	   ;


%%


int yyerror(char* s){
    printf("Erro: %s \n",s);
    return 1;
}

int main(){
    yyparse();
    return 0;
}