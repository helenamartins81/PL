#include <stdio.h>
#include "estrutura.h"


FILE* grafo;


Ontologia inicializa(){
	Ontologia ont = malloc(sizeof(struct ontologia));
    ont -> individuo = NULL;
    ont -> next = NULL;
	return ont;
}



void adicionaIndividuo(Ontologia ont, char* nome, char* conceito, Relacoes* relacoes){
    Individuo ind = (Individuo) malloc(sizeof(struct individuo));
	ind->sujeito = strdup(nome);
    ind->conceito = strdup(conceito);
    ind->relacoes = relacoes;

    while(ont->next != NULL){
        ont = ont -> next;
    }
    ont -> next = ind;
}



void adicionaRelacao(Relacoes relacoes, char* rel, char* obj){
    Relacoes nova = malloc(sizeof(struct relacoes));
    nova->relacao = strdup(rel);
    nova->objeto = strdup(obj);
    nova -> next = NULL;

    if(relacoes == NULL){
        relacoes = nova;
    }

    while(relacoes->next != NULL){
        relacoes = relacoes -> next;
    }
    relacoes -> next = nova;

}



void imprimirInfo(Ontologia o){
    grafo = fopen("graph.gv", "w+");
    fprintf(grafo,"digraph familytree {\n");


}

