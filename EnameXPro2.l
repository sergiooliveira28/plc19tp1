%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    
    char * cidade[50];
    char * pais[50];
    void inicializar (){
        int i=0;
        for (i=0; i<50; i++){
            cidade[i]=NULL;
            pais[i]=NULL;
        }
    }
    
    void inicializarHTML (){
        FILE *f;
        f = fopen("enamexLocais.html","w");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("<html>\n<head>\n<title>EnameXPro</title>\n</head>\n<body>\n<ul>",f);
        fclose(f);
    }
    void fecharHTML(){
        FILE *f;
        f = fopen("enamexLocais.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("</ul>\n</body>\n</html>\n",f);
        fclose(f);
    }
    void addCidade(char * n){
        int i=0;
        while (cidade[i]!=NULL && i<50) i++;
        cidade[i]=n;
    }
    void addPais(char * n){
        int i=0;
        while (pais[i]!=NULL && i<50) i++;
        pais[i]=n;
    }
    void addCidades (){
        FILE *f;
        f = fopen("enamexLocais.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("\n<h1>NOMES DE CIDADES ENCONTRADAS</h1>\n",f);
        int i=0;
        while (cidade[i]!=NULL && i<50) {
           fputs("<li>",f);
           fputs(cidade[i],f);
           fputs("</li>\n",f);
           i++;
        }
        fclose(f);
    }
    void addPaises (){
        FILE *f;
        f = fopen("enamexLocais.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("\n<h1>NOMES DE PAISES ENCONTRADOS</h1>\n",f);
        int i=0;
        while (pais[i]!=NULL && i<50) {
           fputs("<li>",f);
           fputs(pais[i],f);
           fputs("</li>\n",f);
           i++;
        }
        fclose(f);
    }

%}

CITY      [<]ENAMEX[ ]TYPE[=]["]CITY["][>]
COUNTRY   [<]ENAMEX[ ]TYPE[=]["]COUNTRY["][>]
PROC      ([a-zA-Z\-\.ãõâáóéçD\.\n][ ]?)*
%%

{CITY}{PROC}[<]           {yytext[yyleng-1]='\0'; addCidade(&yytext[20]);}
{COUNTRY}[ ]{PROC}[<]     {yytext[yyleng-1]='\0'; addPais(&yytext[23]);}
.                         ;
%%

int yywrap(void) {return 1;}

int main (int argc, char **argv){
    ++argv, --argc;
    int i=0;
    if (argc > 0)
        yyin = fopen (argv[0], "r");
    else
        yyin = stdin;

    printf("Inicio EnameX\n");
    inicializarHTML();
    inicializar();
    yylex();
    printf("A processar %s\n\n",argv[0]);
    printf("A criar HTML...\n\n");
    addCidades();
    addPaises();
    fecharHTML();
    printf("Sucesso\n");
    return 0;
}
