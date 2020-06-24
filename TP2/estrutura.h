#include <stdio.h>
#include <string.h>
#include <stdlib.h>



typedef struct relacoes
{
    char* relacao;
    char* objeto;
    int sucesso;
    struct relacoes *next;
}*Relacoes;



typedef struct individuo{
    char* sujeito;
    char* conceito;
    int sucesso;
     Relacoes relacoes;
}*Individuo ;




typedef struct ontologia
{
    Individuo individuo;
    int sucesso;
    struct ontologia *next;
}*Ontologia;





Ontologia inicializa();
void adicionaIndividuo(Ontologia ont, char* nome, char* conceito, Relacoes* relacoes);
void adicionaRelacaoComplex(Relacoes relacoes, char* rel, char* obj);
void imprimirInfo(Ontologia o);


