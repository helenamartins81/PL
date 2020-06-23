%{
	#define _GNU_SOURCE
    #include <string.h>
    #include <stdio.h>
    #include<stdlib.h>

    int yylex(void);
    int yyerror(char* s);

//asprintf calcula o tamanho da string, aloca memória e escreve lá a string

%}

%union{
    char* str;
	int value;
}

%token<str> STRING
%token<value> NUM
%token<str> NOME PESSOA MASCULINO FEMININO RELACAO
%type<str> Individuals Individual Sujeito Conceito Pessoa Sexo Predicado Objeto ListaPredicados

%left ',' ';'

//FILE* file = fopen("graph.gv","w+"); fprintf(file, "digraph familytree {\n%s\n}\n", $1);
%%


Ontologia : Individuals  										{ printf("\n%s\n", $1);}
          ;


Individuals : Individual										{asprintf(&$$, "%s", $1);}
			| Individual Individuals							{asprintf(&$$, "%s, %s", $1, $2);}
			;

Individual : ':'Sujeito ',' ':'Conceito ';' ListaPredicados '.'	{asprintf(&$$, "%s , %s, %s", $2, $5, $7);}
		   | Individual ',' Objeto ';'							{asprintf(&$$, "%s , %s", $1, $3);}
		   | Individual ';' ListaPredicados					    {asprintf(&$$, "%s , %s", $1, $3);}
		   ;

Sujeito : NOME													{asprintf(&$$, "%s", $1);}		
		;	

Conceito : Pessoa												{asprintf(&$$, "%s", $1);}
		 | Sexo													{asprintf(&$$, "%s", $1);}
		 ;


ListaPredicados : ':'Predicado ':'Objeto '.'					{asprintf(&$$, "%s , %s", $2, $4);}
				| ':'Predicado ':'Objeto ';' ListaPredicados    {asprintf(&$$, "%s , %s, %s", $2, $4, $6);}


Pessoa : ':'PESSOA												{asprintf(&$$, "%s", $2);}
	   ;			 

Sexo : ':'MASCULINO												{asprintf(&$$, "%s", $2);}			
	 | ':'FEMININO												{asprintf(&$$, "%s", $2);}			
	 ;	



Predicado : RELACAO												{asprintf(&$$, "%s", $1);}
		  ;		



Objeto : Sujeito												{asprintf(&$$, "%s", $1);}		
	   | Conceito												{asprintf(&$$, "%s", $1);}		
	   | STRING													{asprintf(&$$, "%s", $1);}		
	   | NUM													{asprintf(&$$, "%d", $1);}		
	   ;	




%%

#include "lex.yy.c"

int yyerror(char *s) {
    printf("Erro: %s \n",s );
    return 1;
}

int main(){
    yyparse();
    return 0;
}