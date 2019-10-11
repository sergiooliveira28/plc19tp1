%{

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    
    int numerlist = 1;
    
    void inicializarHTML (){
        FILE *f;
        f = fopen("wikipage.html","w");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("<html>\n<head>\n",f);
        fclose(f);
    }
    void fecharHTML(){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("\n</body>\n</html>\n",f);
        fclose(f);
    }
    void addTitle (char * text){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("\n<title>",f);
        fputs(text,f);
        fputs("</title>\n</head>\n<body>\n",f);
        fclose(f);
    }
    void addText (char * text){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs(text,f);
        fclose(f);
    }
    void addSpace (){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("&nbsp;&nbsp;&nbsp;&nbsp;",f);
        fclose(f);
    }
     void addP (){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("<br><br><br>",f);
        fclose(f);
    }
    void addBold (char * text){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("<b>",f);
        fputs(text,f);
        fputs("</b>",f);
        fclose(f);
    }
    void addItalic (char * text){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("<i>",f);
        fputs(text,f);
        fputs("</i>",f);
        fclose(f);
    }
    void addSubl (char * text){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("<u>",f);
        fputs(text,f);
        fputs("</u>",f);
        fclose(f);
    }
    void beginulist (){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("\n<ul>\n",f);
        fclose(f);
    }
    void endulist (){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("\n</ul>\n",f);
        fclose(f);
        numerlist=1;
    }
    void addul (char * text){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("<li>",f);
        fputs(text,f);
        fputs("</li>\n",f);
        fclose(f);
    }
    void addnl (char * text){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("<li>",f);
        fprintf(f,"%d",numerlist);
        fputs(". ",f);
        fputs(text,f);
        fputs("</li>\n",f);
        fclose(f);
        numerlist++;
    }
    void linebreak (){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("<br>",f);
        fclose(f);
    }

%}

TITLE           [;][a-zA-Z0-9]+[;]
INDENT          [:]
BOLD            [']([ ]?[a-zA-Z0-9]+[ ]?)+[']
ITALIC          [/]([ ]?[a-zA-Z0-9]+[ ]?)+[/]
SUBL            [_]([ ]?[a-zA-Z0-9]+[ ]?)+[_]
PARAGRAPH       [\-\+]
LINEBREAK       [\n]
BEGINULST       (\=>)
ENDULIST        (<\=)
UNORDLIST       [\*]([ ]?[a-zA-Z0-9]+[ ]?)+[\*]
NUMERLIST       [\#]([ ]?[a-zA-Z0-9]+[ ]?)+[\#]
%%

{TITLE}      {yytext[yyleng-1]='\0'; addTitle(&yytext[1]);}
{BOLD}       {yytext[yyleng-1]='\0'; addBold(&yytext[1]);}
{ITALIC}     {yytext[yyleng-1]='\0'; addItalic(&yytext[1]);}
{SUBL}       {yytext[yyleng-1]='\0'; addSubl(&yytext[1]);}
{LINEBREAK}  {linebreak();}
{INDENT}     {addSpace();}
{PARAGRAPH}  {addP();}
{BEGINULST}  {beginulist();}
{ENDULIST}   {endulist();}
{UNORDLIST}  {yytext[yyleng-1]='\0'; addul(&yytext[1]);}
{NUMERLIST}  {yytext[yyleng-1]='\0'; addnl(&yytext[1]);}
.            {addText(&yytext[0]);}
%%

int yywrap(void) {return 1;}

int main (int argc, char **argv){
    ++argv, --argc;
    int i=0;
    if (argc > 0)
        yyin = fopen (argv[0], "r");
    else
        yyin = stdin;

    printf("Wiki\n");
    inicializarHTML();
    yylex();
    printf("A processar %s\n\n",argv[0]);
    printf("A criar HTML...\n\n");
    fecharHTML();
    printf("Sucesso\n");
    return 0;
}
