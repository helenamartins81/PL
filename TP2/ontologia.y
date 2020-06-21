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
}

%token START
%token<str> nome pessoa masculino feminino rel string num 
%type<str> Individuals Individual Sujeito Conceito Pessoa Sexo Predicado Relacao Objeto

%left ',' ';'


%%


Ontologia : START Individuals  			{FILE* file = fopen("graph.tmp","w+"); fprintf(file, "digraph familytree {\n\t");}
          ;


Individuals : Individual
			| Individuals Individual
			;

Individual : Sujeito ',' Conceito ';' Predicado ';' Objeto '.'
		   | Individual ',' Objeto ';'
		   | Individual ';' Predicado ';' Objeto
		   ;

Sujeito : nome							
		;	

Conceito : Pessoa
		 | Sexo
		 ;


Pessoa : pessoa			{$$ = $1;}
	   ;			 

Sexo : masculino		{$$ = $1;}				
	 | feminino			{$$ = $1;}			
	 ;	



Predicado : Relacao
		  ;


Relacao : rel				{$$ = $1;}		
		;

Objeto : Sujeito						
	   | Conceito						
	   | string							
	   | num							
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