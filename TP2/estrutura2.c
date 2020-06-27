#include "estrutura.h"






Individuo newIndividuo (char* nome, GSList* relacoes){
  Individuo n = malloc(sizeof(struct individuo));
  n -> sujeito = strdup(nome);
  n -> relacao = relacoes;
  return n;
}



Relacao newRelacao (char* rel, char* obj){
  Relacao r = malloc(sizeof(struct relacao));
  r->objeto = strdup(obj);
  r->relacao = strdup(rel);
  return r;
}
