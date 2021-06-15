%{
#include<stdio.h>
#include<stdlib.h>
#include <math.h>
#define YYSTYPE int
int yylex();

FILE *yyin, *yyout;
int yyerror(const char *s) 
{
    fprintf(yyout,"%s\n", s);
}

%}

%token NEWLINE LPAREN RPAREN
%token NUM
%left BITWISEAND 
%left NOTEQUAL 
%left GREATERTHANEQUAL LESSTHANEQUAL
%left LEFTSHIFT RIGHTSHIFT 
%left PLUS MINUS
%left MUL DIV MOD
%right DOUBLESTERIK
%nonassoc INC DEC 

%%

S : P 
  | S P
  ;

P : E NEWLINE                   { fprintf(yyout,"=%d \n", $$); }     
  | E 
  ;                            

E : E BITWISEAND E              {$$ = $1 & $3 ; if($$ = 1) fprintf(yyout,"true \n"); else fprintf(yyout,"false \n");}
  | E NOTEQUAL E                {$$ = $1 != $3; if($$ = 1) fprintf(yyout,"true \n"); else fprintf(yyout,"false \n");}
  | E GREATERTHANEQUAL E        {$$ = $1 >= $3; if($$ = 1) fprintf(yyout,"true \n"); else fprintf(yyout,"false \n");}
  | E LESSTHANEQUAL E           {$$ = $1 <= $3; if($$ = 1) fprintf(yyout,"true \n"); else fprintf(yyout,"false \n");}
  | E LEFTSHIFT E               {$$ = $1 << $3;}
  | E RIGHTSHIFT E              {$$ = $1 >> $3;}  
  | E PLUS E                    {$$ = $1 + $3;}   
  | E MINUS E                   {$$ = $1 - $3;}
  | E MUL E                     {$$ = $1 * $3;}
  | E DIV E                     {if($3==0) yyerror("Div by 0 error."); else $$ = $1 / $3;}
  | E MOD E                     {if($3==0) yyerror("MOD by 0 error."); else $$ = $1 % $3;}
  | E DOUBLESTERIK E            {$$ = pow($1,$3);}
  | F                           {$$ = $1;}
;

F : LPAREN E RPAREN             {$$ = $2;}
  | MINUS F  %prec MINUS        {$$ = - $1;}
  | INC F                       {$$ = ++ $2;}
  | DEC F                       {$$ = -- $2;}
  | F INC                       {$$ = $1 ++;}
  | F DEC                       {$$ = $1 --;}
  | NUM                         {$$ = $1;}
;




%%

void main(){
    yyin = fopen("in.txt", "r");
    yyout = fopen("output.txt", "w");
    yyparse();

// uncomment and paste all in terminal
// bison -d Calculator_using_parse_tree.y
// flex Calculator_using_parse_tree.l
// gcc lex.yy.c Calculator_using_parse_tree.tab.c
// ./a.exe
}
