robotic: lex.yy.c y.tab.c
	gcc -g lex.yy.c y.tab.c -o robotic

lex.yy.c: y.tab.c robotic.l
	lex robotic.l

y.tab.c: robotic.y
	yacc -d robotic.y

clean:
	rm -rf lex.yy.c y.tab.c y.tab.h robotic robotic.dSYM
