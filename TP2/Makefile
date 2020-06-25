

ontologia: y.tab.o lex.yy.o estrutura.o
	gcc -o  ontologia  y.tab.o lex.yy.o estrutura.o

y.tab.o: y.tab.c
	gcc -c y.tab.c

lex.yy.o: lex.yy.c 
	gcc -c lex.yy.c

y.tab.c y.tab.h: ontologia.y estrutura.h
	yacc -d -v ontologia.y

lex.yy.c: ontologia.l y.tab.h
	flex -d ontologia.l


clean:
	rm -f ontologia lex.yy.c lex.yy.o y.tab.h y.tab.o y.tab.c


