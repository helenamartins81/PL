
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
	
	printf("%s \n", rel->relacao);

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

void adicionaRelacaoAIndividuo(Individuo ind, Relacoes relacao) {

	if (ind->relacoes==NULL) {
		printf("OLA");
		ind->relacoes = relacao;
	}

	for(;ind->relacoes->next!=NULL;ind->relacoes = ind->relacoes->next);

	ind->relacoes->next = relacao;



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

void writeOntologia(Ontologia o) {
	FILE *fp = fopen("sample.dot","w"); 
	fprintf(fp,"digraph familytree {\n");
	while(o!=NULL){
		
		while(o->individuo->relacoes!=NULL) {
			//printf("Dsoajdosa\n");
			fprintf(fp,"	%s -> %s [label = %s] \n", o->individuo->sujeito,o->individuo->relacoes->objeto,o->individuo->relacoes->relacao);
			o->individuo->relacoes = o->individuo->relacoes->next;
		}	
			
		o = o->next; 
	}
	fprintf(fp,"}\n");


	fclose(fp);
}

