%{
	#define _GNU_SOURCE
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "estrutura.h"


	int yylex();
	int yyerror(char *s);


	GSList* individuo;
	GSList* relacoes;
	Individuo ind;
	Relacao rel;



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

Ontologia : Triplo												{asprintf(&$$, "%s", $1);}
		  | Ontologia Triplo									{asprintf(&$$, "%s, %s", $1, $2);}
		  ;

Triplo : SUJEITO '.'											{asprintf(&$$, "%s", $1); ind = newIndividuo($1, NULL); individuo = g_slist_alloc(); individuo = g_slist_append(individuo, ind);}
       | SUJEITO ',' ListaDuplos 								{relacoes = g_slist_alloc();
	   															ind = newIndividuo($1, relacoes); individuo = g_slist_append(individuo, ind); }
		;





ListaDuplos : PREDICADO Objeto ',' ListaDuplos 					{asprintf(&$$, "%s %s %s", $1, $2, $4); rel = newRelacao($1, $2); relacoes = g_slist_append(relacoes, rel);}
		    | PREDICADO Objeto ';' ListaDuplos	    			{asprintf(&$$, "%s %s %s", $1, $2, $4); rel = newRelacao($1, $2); relacoes = g_slist_append(relacoes, rel);}
		    | Objeto ';' ListaDuplos	    					{asprintf(&$$, "%s, %s", $1, $3); rel = newRelacao(NULL, $1); relacoes = g_slist_append(relacoes, rel);}
		    | PREDICADO Objeto '.'             					{asprintf(&$$, "%s %s", $1, $2); rel = newRelacao($1, $2); relacoes = g_slist_append(relacoes, rel);}
		    | Objeto '.'	    								{asprintf(&$$, "%s", $1); rel = newRelacao(NULL, $1); relacoes = g_slist_append(relacoes, rel);}
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
