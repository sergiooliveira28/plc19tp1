%{

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    
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
        fputs("    ",f);
        fclose(f);
    }
     void addP (){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("<br><br>",f);
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
    
    void addh1(char * text){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("\n<h1>",f);
        fputs(text,f);
        fputs("</h1>\n",f);
        fclose(f);
    }
    void addh2(char * text){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("\n<h2>",f);
        fputs(text,f);
        fputs("</h2>\n",f);
        fclose(f);
    }
    void addh3(char * text){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("\n<h3>",f);
        fputs(text,f);
        fputs("</h3>\n",f);
        fclose(f);
    }
    void addh4(char * text){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("\n<h4>",f);
        fputs(text,f);
        fputs("</h4>\n",f);
        fclose(f);
    }
    void addh5(char * text){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("\n<h5>",f);
        fputs(text,f);
        fputs("</h5>\n",f);
        fclose(f);
    }
    void addh6(char * text){
        FILE *f;
        f = fopen("wikipage.html","a");
        if (f==NULL) exit(EXIT_FAILURE);
        fputs("\n<h6>",f);
        fputs(text,f);
        fputs("</h6>\n",f);
        fclose(f);
    }

%}

TITLE           [;][a-zA-Z0-9]+[;]
INDENT          [:]
BOLD            ['][a-zA-Z0-9]+[']
ITALIC          [/][a-zA-Z0-9]+[/]
H1              [=][ ]?[a-zA-Z0-9]+[ ]?[=]
H2              (==)[ ]?[a-zA-Z0-9]+[ ]?(==)
H3              [===][ ]?[a-zA-Z0-9]+[ ]?[===]
H4              [====][ ]?[a-zA-Z0-9]+[ ]?[====]
H5              [=====][ ]?[a-zA-Z0-9]+[ ]?[=====]
H6              [======][ ]?[a-zA-Z0-9]+[ ]?[======]
PARAGRAPH       [\-\-\-\-]
LINEBREAK       [\n\n]
BEGINULST       (\=>)
ENDULIST        (<\=)
UNORDLIST       [\*]([ ]?[a-zA-Z0-9]+[ ]?)+[\*]
%%

{TITLE}      {yytext[yyleng-1]='\0'; addTitle(&yytext[1]);}
{BOLD}       {yytext[yyleng-1]='\0'; addBold(&yytext[1]);}
{ITALIC}     {yytext[yyleng-1]='\0'; addItalic(&yytext[1]);}
{INDENT}     {addSpace();}
{PARAGRAPH}  {addP();}
{H1}         {yytext[yyleng-1]='\0'; addh1(&yytext[1]);}
{BEGINULST}  {beginulist();}
{ENDULIST}   {endulist();}
{UNORDLIST}  {yytext[yyleng-1]='\0'; addul(&yytext[1]);}
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
