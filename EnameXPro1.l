%{
/* Código eliminado
// PROCNOME    (^([a-z]+[,.]?[ ]?|[a-z]+['-]?)+$)
// CERTEZA     [<]ENAMEX[ ]TYPE[=]["]NAME["][ ]?CERTEZA[=]["][?][?]["][>]
// {CERTEZA}[ ]?{PROCNOME2}[<]    {yytext[yyleng-1]='\0'; addNome(&yytext[34]);} 

// Não consigo fazer parse do "D. João"

PERSON      [<]ENAMEX[ ]TYPE[=]["]PERSON["][>]
NAME        [<]ENAMEX[ ]TYPE[=]["]NAME["][>]
PROCNOME    [ ]?([D\.]|[\-\.ãõâáóéç\na-zA-Z][ ]?)*[ ]?

*/

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
        f = fopen("enamexNomes.html","w");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("<html>\n<head>\n<title>EnameXPro</title>\n</head>\n<body>\n<ul>",f);
        fclose(f);
    }
    void fecharHTML(){
        FILE *f;
        f = fopen("enamexNomes.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("</ul>\n</body>\n</html>\n",f);
        fclose(f);
    }
    void addNome(char * n){
        int i=0;
        while (nome[i]!=NULL && i<50) i++;
        nome[i]=n;
    }
    void addNomes (){
        FILE *f;
        f = fopen("enamexNomes.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("\n<h1>NOMES DE PESSOAS ENCONTRADOS</h1>\n",f);
        int i=0;
        while (nome[i]!=NULL && i<50) {
           i++;
           if (nome[i]!=NULL){
              if (strcmp(nome[i-1],nome[i])!=0){
              fputs("<li>",f);
              fputs(nome[i-1],f);
              fputs("</li>\n",f);
              printf("<!> Adicionado: %s\n", nome[i-1]);
                 
              }
           }
           
        }
        fclose(f);
    }

    void ordenar (){
        int i=0,j,count=0;
        char temp [50];
        while (nome[i]!=NULL && i<50) {count++;i++;}
        for (i=0;i<count;i++){
           for (j=i;j<count;j++){
              if (strcmp(nome[i],nome[j])>0){
                  strcpy (temp,nome[i]);
                  strcpy (nome[i],nome[j]);
                  strcpy (nome[j],temp);
              }
           }
        }
        for (i=0;i<count;i++){
           for (j=i;j<count;j++){
              if (strcmp(nome[i],nome[j])==0){
                  strcpy (temp,nome[i]);
              }
           }
        }
    }

%}

PERSON      [<]ENAMEX[ ]TYPE[=]["]PERSON["][>]
NAME        [<]ENAMEX[ ]TYPE[=]["]NAME["][>]
PROCNOME    ([.]?[ ]?[\-\.ãa-zA-Z]+[.]?[ ]?)+ 
%%

{PERSON}{PROCNOME}[<]     {yytext[yyleng-1]='\0'; addNome(&yytext[22]);}
{PERSON}[ ]{PROCNOME}[<]     {yytext[yyleng-1]='\0'; addNome(&yytext[23]);}
{NAME}{PROCNOME}[<]       {yytext[yyleng-1]='\0'; addNome(&yytext[20]);}
{NAME}[ ]{PROCNOME}[<]       {yytext[yyleng-1]='\0'; addNome(&yytext[21]);}
.       ;
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
    inicializarNome();
    yylex();
    printf("A processar %s\n\n",argv[0]);
    printf("A ordenar...\n\n");
    ordenar();
    printf("A criar HTML...\n\n");
    addNomes();
    fecharHTML();
    printf("Sucesso\n");
    return 0;
}
