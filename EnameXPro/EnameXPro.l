%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
%}

PERSON      ["]PERSON["][>]
NAME        ["]NAME["][>]
CERTEZA     ["]NAME["][ ]?CERTEZA[=]["][?][?]["][>] 
PROCNOME    [\s?\w+]([\.\-ãõâáó]*\s?\w*)*
PROCNOME2   ([a-zA-Z\-\.ãõáóé\n]+[ ]?)*
%%
{PERSON}[ ]?{PROCNOME2}     printf("%s",yytext);
{NAME}[ ]?{PROCNOME2}       printf("%s",yytext);
{CERTEZA}[ ]?{PROCNOME2}       printf("%s",yytext);
.   {}
%%

int yywrap(void) {return 1;}

int main (int argc, char **argv){
    ++argv, --argc;
    if (argc > 0)
        yyin = fopen (argv[0], "r");
    else
        yyin = stdin;
    yylex();
    
}
