#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <glib.h>


typedef struct relacao
{
    char *relacao;
    char *objeto;
} * Relacao;

typedef struct individuo
{
    char *sujeito;
    GSList *relacao;
} * Individuo;


/*
typedef struct ontologia
{
    GSList *individuo;
} * Ontologia;
*/



/*
Ontologia inicializa();
void adicionaIndividuo(Ontologia ont, Individuo ind);
void adicionaRelacoes(Relacoes relacao, Individuo ind);
void adicionaRelacao(char* rel, char*obj, GSList* relacoes);
Relacoes* criaRelacao(char* rel, char* objeto);
void imprimeSujeito(Ontologia o);
void imprimirInfo(Ontologia o);
*/



Individuo newIndividuo (char* nome, GSList* relacoes);
Relacao newRelacao (char* relacao, char* obj);
