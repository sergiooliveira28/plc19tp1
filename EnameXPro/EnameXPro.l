%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    
    char * nome[50];

    void inicializarNome (){
        int i=0;
        for (i=0; i<50; i++){
            nome[i]=NULL;
        }
    }
    
    void inicializarHTML (){
        FILE *f;
        f = fopen("enamex.html","w");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("<html>\n<head>\n<title>EnameXPro</title>\n</head>\n<body>\n<ul>",f);
        fclose(f);
    }
    void fecharHTML(){
        FILE *f;
        f = fopen("enamex.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("</ul>\n</body>\n</html>\n",f);
        fclose(f);
    }
    void addNome(char * n){
        FILE *f;
        f = fopen("enamex.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        int i=0;
        while (nome[i]!=NULL && i<50) i++;
        nome[i]=n;
        fputs("<li>",f);
        fputs(nome[i],f);
        fputs("</li>\n",f);
        fclose(f);
    }

%}

PERSON      ["]PERSON["][>]
NAME        ["]NAME["][>]
CERTEZA     ["]NAME["][ ]?CERTEZA[=]["][?][?]["][>] 
PROCNOME    [\s?\w+]([\.\-ãõâáó]*\s?\w*)*
PROCNOME2   ([a-zA-Z\-\.ãõáóé\n]+[ ]?)*
%%
{PERSON}[ ]?{PROCNOME2}[<]     {yytext[yyleng-1]='\0'; addNome(&yytext[9]);}
{NAME}[ ]?{PROCNOME2}[<]       {yytext[yyleng-1]='\0'; addNome(&yytext[8]);}
{CERTEZA}[ ]?{PROCNOME2}[<]    {yytext[yyleng-1]='\0'; addNome(&yytext[20]);} 
.   {printf(yytext);};
%%

int yywrap(void) {return 1;}

int main (int argc, char **argv){
    ++argv, --argc;
    int i=0;
    if (argc > 0)
        yyin = fopen (argv[0], "r");
    else
        yyin = stdin;

    printf("Inicio EnameX\n\n");
    inicializarHTML();
    inicializarNome();

    yylex();
    fecharHTML();
    printf("Nomes registados:\n");
    for (i=0;i<50;i++){
        printf("%d| %s\n",i,nome[i]);
    }
    
}
