all: EnameXPro1 EnameXPro2 Wiki

EnameXPro1: EnameXPro1.l
	flex -o EnameXPro1.c EnameXPro1.l
	gcc -o EnameXPro1 EnameXPro1.c

EnameXPro2: EnameXPro2.l
	flex -o EnameXPro2.c EnameXPro2.l
	gcc -o EnameXPro2 EnameXPro2.c

Wiki: Wiki.l
	flex -o Wiki.c Wiki.l
	gcc -o Wiki Wiki.c

clean:
	rm EnameXPro1 EnameXPro2 Wiki *.c