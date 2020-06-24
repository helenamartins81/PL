#include <stdio.h>
#include "estrutura.h"


FILE* grafo;


// Inicializar 

Ontologia inicializaOntologia(){

	Ontologia ont = malloc(sizeof(struct ontologia));
	ont->individuo = NULL;
	ont->next = NULL;
	ont->sucesso = 1;

	return ont;
}


Relacoes inicializaRelacao(){


	Relacoes rels = malloc(sizeof(struct relacoes));
	rels->relacao = NULL;
	rels->objeto = NULL;
	rels->sucesso = 1;
	rels->next = NULL;

	return rels;
}


Individuo inicializaIndividuo() {

	Individuo ind = malloc(sizeof(struct individuo));
	ind->sujeito = NULL;
	ind->conceito = NULL;
	ind->sucesso = 1;
	ind->relacoes = NULL;

	return ind;
}




Individuo inicializaIndividuo2(char* sujeito, char* conceito, int sucesso, Relacoes relacoes){
	
	Individuo ind = malloc(sizeof(struct individuo));
	ind->sujeito = strdup(sujeito);
	ind->conceito = strdup(conceito);
	ind->sucesso = sucesso;
	ind->relacoes = relacoes;
	
}

Relacoes inicializaRelacao2(char* relacao, char* objeto, int sucesso) {

	Relacoes rel = (Relacoes)malloc(sizeof(struct relacoes));
	
    	rel->relacao = strdup(relacao);
	rel->objeto = strdup(objeto);


	rel->sucesso = 1;
	rel->next = NULL;


}


Ontologia inicializaOntologia2(Individuo ind, int sucesso){

	Ontologia o = malloc(sizeof(struct ontologia));
	o->individuo = ind;
	o->sucesso = sucesso;
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
    ont -> next = ind;
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
		printf("%d\n", o->sucesso);
		o = o->next;
	}


}


int main() {

	Individuo ind = inicializaIndividuo2("Carlos","dawdsa",1,NULL);
	Individuo ind2 = inicializaIndividuo2("Dsadas","dawdsa",1,NULL);
	Individuo ind3 = inicializaIndividuo2("Oka","dawdsa",1,NULL);
	Individuo ind4 = inicializaIndividuo2("WTF","dawdsa",1,NULL);
	
	Ontologia o1 = inicializaOntologia2(ind,1);
	Ontologia o2 = inicializaOntologia2(ind2,1);
	Ontologia o3 = inicializaOntologia2(ind3,1);
	Ontologia o4 = inicializaOntologia2(ind4,1);
	
	adicionaOntologia(o1,o2);
	adicionaOntologia(o1,o3);
	adicionaOntologia(o1,o4);
	
	imprimeOntologias(o1);
	
	return 1;
}
