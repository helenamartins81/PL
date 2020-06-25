#include <stdio.h>
#include "estrutura.h"


FILE* grafo;


// Inicializar 

Ontologia inicializaOntologia(){

	Ontologia ont = malloc(sizeof(struct ontologia));
	ont->individuo = NULL;
	ont->next = NULL;

	return ont;
}


Relacoes inicializaRelacao(){


	Relacoes rels = malloc(sizeof(struct relacoes));
	rels->relacao = NULL;
	rels->objeto = NULL;

	rels->next = NULL;

	return rels;
}


Individuo inicializaIndividuo() {

	Individuo ind = malloc(sizeof(struct individuo));
	ind->sujeito = NULL;
	ind->conceito = NULL;

	ind->relacoes = NULL;

	return ind;
}




Individuo inicializaIndividuo2(char* sujeito, char* conceito, int sucesso, Relacoes relacoes){
	
	Individuo ind = malloc(sizeof(struct individuo));
	ind->sujeito = strdup(sujeito);
	ind->conceito = strdup(conceito);

	ind->relacoes = relacoes;
	
}

Relacoes inicializaRelacao2(char* relacao, char* objeto, int sucesso) {

	Relacoes rel = (Relacoes)malloc(sizeof(struct relacoes));
	
    	rel->relacao = strdup(relacao);
	rel->objeto = strdup(objeto);


	rel->next = NULL;


}


Ontologia inicializaOntologia2(Individuo ind, int sucesso){

	Ontologia o = malloc(sizeof(struct ontologia));
	o->individuo = ind;
	o->next = NULL;



}

// Adicionar informações 


void adicionaIndividuoComplex(Ontologia ont, char* nome, char* conceito, Relacoes relacoes){

    Individuo ind = (Individuo) malloc(sizeof(struct individuo));
    ind->sujeito = strdup(nome);
    ind->conceito = strdup(conceito);
    ind->relacoes = relacoes;

    while(ont->next != NULL){
        ont = ont -> next;
    }
    //ont -> next = ind;
}



void adicionaRelacaoComplex(Relacoes relacoes, char* rel, char* obj){
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


void adicionaOntologia(Ontologia principal, Ontologia o) {

	if(principal == NULL) {
		principal = o;
	}

	for(;principal->next!=NULL;principal = principal->next);

	principal->next = o;
}


void adicionaRelacao(Relacoes relacoes, Relacoes relacao) {


	if (relacoes==NULL) {
		relacoes = relacao;
	}

	for(;relacoes->next!=NULL;relacoes = relacoes->next);

	relacoes->next = relacao;

}




// Imprimir cenas


void imprimirInfo(Ontologia o){
    grafo = fopen("graph.gv", "w+");
    fprintf(grafo,"digraph familytree {\n");


}

void imprimeOntologias(Ontologia o){

	while(o!=NULL){
		printf("%s\n", o->individuo->sujeito);
		o = o->next;
	}


}