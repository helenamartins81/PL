#include <stdio.h>
#include <string.h>
#include <stdlib.h>



typedef struct relacoes
{
    char* relacao;
    char* objeto;
    struct relacoes *next;
}*Relacoes;



typedef struct individuo{
    char* sujeito;
    char* conceito;
     Relacoes relacoes;
}*Individuo ;




typedef struct ontologia
{
    Individuo individuo;
    struct ontologia *next;
}*Ontologia;





Ontologia inicializa();
void adicionaIndividuo(Ontologia ont, char* nome, char* conceito, Relacoes* relacoes);
//void adicionaRelacao(Relacoes relacoes, char* rel, char* obj);
void imprimeSujeito(Ontologia o);
void imprimirInfo(Ontologia o);


