%{
	#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
#include "estrutura.h"
extern int yylex();
extern int yylineno;
extern char *yytext;
int yyerror();





Relacoes* relacoes;
char * conceito;
char* obj;
char* relacao;



%}
%parse-param{void* o}

%union{
    char* str;
	int value;
}


%token<str> NOME PESSOA MASCULINO FEMININO RELACAO STRING 
%token NUM
%type<value>NUM

%type<str> Individuals Individual Sujeito Conceito Pessoa Sexo Predicado Objeto ListaPredicados

%left ',' ';'

//FILE* file = fopen("graph.gv","w+"); fprintf(file, "digraph familytree {\n%s\n}\n", $1);
%%


Ontologia : Individuals  												{ printf("\n%s\n", $1);}
          ;


Individuals : Individuals Individual									{}
			| Individual												{}
			;

Individual : ':'Sujeito ',' ':'Conceito ';' ListaPredicados '.'			{printf("%s %s %s", $2, $5, $7);}
		   | Individual ',' Objeto ';'							
		   | Individual ';' ListaPredicados					    
		   ;

Sujeito : NOME   														{$$ = strdup($1); adicionaIndividuo(o,$1, conceito, relacoes);}		
		;	

Conceito : Pessoa														
		 | Sexo													
		 ;


ListaPredicados : ':'Predicado ':'Objeto '.'							{printf("%s %s", $2, $4);}			
				| ':'Predicado ':'Objeto ';' ListaPredicados    		{printf("%s %s %s", $2, $4, $6);}



Objeto : Sujeito														{obj = strdup($1);}								
	   | Conceito														{obj = strdup($1);}								
	   | STRING															{obj = strdup($1);}						
	   | NUM															{printf("%d", $1);}					
	   ;	


Pessoa : ':'PESSOA														{conceito = strdup($2); }
	   ;			 

Sexo : ':'MASCULINO														{conceito = strdup($2);}			
	 | ':'FEMININO														{conceito = strdup($2);}			
	 ;	



Predicado : RELACAO														{relacao = strdup($1); adicionaRelacao(*relacoes, relacao, obj);}
		  ;		







%%

int yyerror(){
    printf("Erro Sintático ou Léxico na linha: %d, com o texto: %s\n", yylineno, yytext);
    return 0;
}


int main(){
	Ontologia o = inicializa();
    yyparse(o);
	imprimirInfo(o);
	
    return 0;
}

