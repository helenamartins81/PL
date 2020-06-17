%{
#include <stdio.h>
#include <string.h>
#include <ontologia.h>

int yylex();
void yyerror();	
char* yytext;
int yylineno;

%}

%union{
    string id;
    int value
}

%token <string> id
%token <value> num


%%

Ontologia : START ListaTriplos
          ;

ListaTriplos : ListaTriplos Triplo
             | Triplo
             ;

Triplo : Triplo ',' Objeto
       | Triplo ';' Predicado ',' Objeto
       | Sujeito ',' Predicado ';' Objeto '.'
       ;

Sujeito : id

Predicado :

Objeto : id
       | num
       | ...






%%