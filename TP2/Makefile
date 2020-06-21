 
make:
	flex ontologia.l
	yacc -d -v ontologia.y
	gcc -o ontologia y.tab.c
clean:
	rm -f ontologia lex.yy.c lex.yy.o y.tab.h y.tab.o y.tab.c