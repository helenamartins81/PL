%{
#include <stdio.h>
#include <string.h>


int yylex();
int yyerror();	
char* yytext;
int yylineno;

%}

%union{
    char* id;
}

%token START 
%token <id>Nome Pred Conceito
%type <id>Triplo Sujeito 
%type <id>Objeto Predicado

%%

Ontologia : START ListaTriplos
          ;

ListaTriplos : ListaTriplos Triplo 			
             | Triplo                       
             ;

Triplo : Sujeito Predicado Objeto 			{printf("%s    %s   %s", $1, $2, $3);}
       | Triplo ',' Objeto ';'				{printf("%s   ,   %s   ;", $1, $3);}
       | Triplo ';' Predicado Objeto		{printf("%s   ;   %s    %s", $1, $3, $4);}
       ;

Predicado : Pred						    {$$ = $1; printf("Apanhou Predicado %s\n", $1);}
          ;

Sujeito : Nome   							{$$ = $1; printf("Apanhou Sujeito %s\n", $1);}
        ;

Objeto : Nome								{$$ = $1; printf("Apanhou Nome %s\n", $1);}
	   | Conceito							{$$ = $1; printf("Apanhou Conceito %s\n", $1);}
	   ;



%%

int yyerror()
{
  printf("Erro sintatico ou lexico na linha: %d, com o texto: %s\n", yylineno, yytext);
}

int main(int argc, char **argv) {
	
	FILE* fp;
	fp = fopen("graph.tmp", "w+");
	fprintf(fp, "digraph familytree {\n\t");
	
	yyparse();	
	
	fprintf(fp, "}\n");
	fclose(fp);
	return 0;
}