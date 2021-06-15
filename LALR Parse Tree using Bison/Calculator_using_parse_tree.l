%option noyywrap
%{ 
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include "Calculator_using_parse_tree.tab.h"
%}

WS [ \t]+
DIGITS [0-9]+
NUMBER {DIGITS}(\.{DIGITS})?

%%
{WS}            { ; }
[\n]            {return NEWLINE;}
"**"            {return DOUBLESTERIK;} 
"<="            {return LESSTHANEQUAL;}   
">="            {return GREATERTHANEQUAL;}
"!="            {return NOTEQUAL;}
"&"             {return BITWISEAND;}
"++"            {return INC;}
"--"            {return DEC;}
"+"             {return PLUS;}
\-              {return MINUS;}
"*"             {return MUL;}
"/"             {return DIV;}
"%"             {return MOD;}   
"("             {return LPAREN;}
")"             {return RPAREN;}
"exit"          {exit(0);}
{NUMBER}        {sscanf(yytext, "%d", &yylval); return NUM;}
.               {fprintf(yyout,"unrecognized character.",yytext);}

%%
//User code Segment
