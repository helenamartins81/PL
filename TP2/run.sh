#!/bin/sh

flex ontologia.l
yacc -d ontologia.y
gcc -o ontologia lex.yy.c y.tab.c

./ontologia < copia.ttl

#awk '!a[$0]++' graph.tmp > graph.dot

#neato -Tsvg graph.dot -o graph.svg

#google-chrome graph.svg
