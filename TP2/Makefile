
CFLAGS=-g -Wall -Wextra -std=gnu99 -pedantic -pedantic-errors -Wshadow -Wno-unused-parameter
INCLUDE  = `pkg-config --cflags --libs glib-2.0`
ontologia: y.tab.o lex.yy.o estrutura.o
	gcc -o  ontologia  y.tab.o lex.yy.o estrutura.o -lglib-2.0 $(CFLAGS) $(INCLUDE)

y.tab.o: y.tab.c
	gcc -c $(CFLAGS) $(INCLUDE) $< -o $@

lex.yy.o: lex.yy.c y.tab.h
	gcc -c lex.yy.c

y.tab.c y.tab.h: ontologia.y estrutura.h
	yacc -d -v ontologia.y

lex.yy.c: ontologia.l
	flex -8 ontologia.l

estrutura.o : estrutura.c estrutura.h
		gcc $(CFLAGS) $(INCLUDE) -c  $< -o $@

clean:
	rm -f ontologia lex.yy.c lex.yy.o y.tab.h y.tab.o y.tab.c
