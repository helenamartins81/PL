%{
	#define _GNU_SOURCE
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	


	int yylex();
	int yyerror(char *s);



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

Programa : Ontologia  									{FILE* file = fopen("grafo.dot","w+"); fprintf(file,"digraph familytree{\n\tforcelabels=true");
														fprintf(file,"\n\tnode [shape=box]\n\tgraph [rankdir=\"LR\",fontname=\"helvetica\", ranksep=1.5, nodesep=1.5, overlap=\"false\", splines=\"true\"]\n\tsize=\"71,41\";\n%s\n}\n",$1);}
		 ;

Ontologia : Triplo										{asprintf(&$$, "%s",$1);} 
		  | Ontologia Triplo							{asprintf(&$$, "%s %s",$1,$2);}
		  ;

Triplo : SUJEITO '.'									{asprintf(&$$, "	%s;",$1); }
       | SUJEITO ',' ListaDuplos						{asprintf(&$$, "	%s -> {%s};\n", $1,$3);}
		;





ListaDuplos : PREDICADO Objeto ',' ListaDuplos 			{asprintf(&$$, "%s[xlabel=\"%s\"]\n %s", $2,$1, $4);}
		    | PREDICADO Objeto ';' ListaDuplos			{asprintf(&$$, "%s[xlabel=\"%s\"]\n %s", $2,$1, $4);}
		    | Objeto ';' ListaDuplos	    			{asprintf(&$$, "%s",$3);}
		    | PREDICADO Objeto '.'             			{asprintf(&$$, "	%s[xlabel=\"%s\"]", $2,$1);}
		    | Objeto '.'	    						{}
		    ;


Objeto : SUJEITO										{asprintf(&$$, "%s",$1);}
	   | CONCEITO   									{asprintf(&$$, "%s",$1);}
	   | STRING											{asprintf(&$$, "%s",$1);}
	   | NUM											{asprintf(&$$, "%d",$1);}
	   ;


%%



int yyerror(char* s){
    printf("Erro: %s \n",s);
    return 1;
}

int main(){

    yyparse();
	//writeOntologia(o);

    return 0;
}
