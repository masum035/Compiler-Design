    //date 24 april,2021
    //Abdullah Al masum
%{
//defination
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
//variable Declaration goes here
int numLines = 1;
%}

digit			[0-9]
Number          (([0-9]+)|([0-9]*\.[0-9]+)([eE][+-]?[0-9]+)) 
Literals        (["][ a-zA-Z0-9]*["])
letter          [A-Za-z]
ID              [_a-zA-Z][_a-zA-Z0-9]*
Parenthesis     [)(]
Curly           [}{] 
Relational      (([>|<|!][=])|[>|<])
Arithmatic      [+|-|*|%|/]
Assignment      [=]
Separator       [,|:|;]
%%
    //pattern actions/Rules
"if"|"else"|"switch"|"case"|"while"|"for"|"int"|"break"|"default"|"main"|"printf" {fprintf(yyout,"<Keyword , %s > Line Number = %d\n",yytext,numLines);}   
{Parenthesis}   {fprintf(yyout,"<Parentheses , %s > Line Number = %d\n",yytext,numLines);}
{Curly}         {fprintf(yyout,"<Curly , %s > Line Number = %d\n",yytext,numLines);}
{Literals}      {fprintf(yyout,"<Literals , %s > Line Number = %d\n",yytext,numLines);}
{Separator}     {fprintf(yyout,"<Separator , %s > Line Number = %d\n",yytext,numLines);}
"&&"|"||"|"!="|"=="|"!" {fprintf(yyout,"<Logical Operator , %s > Line Number = %d\n",yytext,numLines);} 
{Assignment}    {fprintf(yyout,"<Assignment Operator , %s > Line Number = %d\n",yytext,numLines);} 
{Relational}    {fprintf(yyout,"<Relational Operator , %s > Line Number = %d\n",yytext,numLines);} 
"++" {fprintf(yyout,"<Increment Operator , %s > Line Number = %d\n",yytext,numLines);} 
"--" {fprintf(yyout,"<Decrement Operator , %s > Line Number = %d\n",yytext,numLines);} 
{Arithmatic}    {fprintf(yyout,"<Arithmetic Operator , %s > Line Number = %d\n",yytext,numLines);} 
{Number}        {fprintf(yyout,"<Number , %s > Line Number = %d\n",yytext,numLines);} 
{ID}            {fprintf(yyout,"<Identifier , %s > Line Number = %d\n",yytext,numLines);}    
[ \t] {}//ignoring whitespaces,tab
. {} //else,ignore everything
\n {numLines++;fprintf(yyout,"\n",yytext);}
%%

//User code Segment
int yywrap(){};
int main(){
    yyin=fopen("input.txt","r");
    yyout = fopen("201914044_Output.txt", "w");   
    yylex();        //This runs the Rule section  
    fprintf(yyout,"\nTotal number of lines: %d\n",numLines);
    fclose(yyin);
    fclose(yyout);
    return 0;
}
