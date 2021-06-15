%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int yylex(void);
int t_count = 1;
char * str;


void yyerror(char *s)
{
	fprintf(stderr,"%s\n",s);
	return;
}

char* getTemp(int i)
{
    char *ret = (char*) malloc(15);
    sprintf(ret, "t%d", i);
	return ret;
}



%}

%union { char cvar[5]; }
%token <cvar> DOUBLE
%token <cvar> NAME
%token '\n'

%type <cvar> expr
%type <cvar> term

%right '='
%left '+' '-'
%left '*' 
%left '/'
%left '(' ')'


%%
program:
	line program			{
								
							}
	| line					{
								
							}
	;
line:
	expr 	'\n' 		    {	
								t_count =1;	
								printf("\t\n",$1);
							}
	| NAME '=' expr '\n' 	{				
								t_count-=1;
								str = getTemp(t_count);
								strcpy($3,str);
								printf("%s = %s\n",$1,$3);
								t_count=1;
								
								
							}
	;
expr:
	expr '+' expr 			{ 
								str = getTemp(t_count);
								strcpy($$,str);
								printf("%s = %s + %s\n",$$,$1,$3);
								t_count++;
								

							}
	| expr '-' expr 		{ 
	
								strcpy($$,getTemp(t_count));
								t_count++;
								printf("%s = %s - %s \n",$$,$1,$3);
								
								
							}
	
	| expr '*' expr 		{ 
								strcpy($$,getTemp(t_count));
								t_count++;
								printf("%s = %s * %s \n",$$,$1,$3);
								
								
							}
	| expr '/' expr 		{ 
								strcpy($$,getTemp(t_count));
								t_count++;
								printf("%s = %s / %s \n",$$,$1,$3);
								
								
							}
	| term 				    { 				
								strcpy($$, $1);
								
							}
	| '(' expr ')' 			{
								strcpy($$,getTemp(t_count));
								t_count++;
								printf("%s = (%s) \n",$$,$2);
								
								
							}
	;
term:
	
	NAME 					{ 
								
								strcpy($$,$1);
								
							}
	| DOUBLE 				{ 	
								strcpy($$,$1);
							}
	;
%%


int main(void)
{
	yyparse();
	return 0;
}

// Uncomment and paste all to run in terminal
// bison -d simple_print.y
// flex simple_print.l
// gcc lex.yy.c simple_print.tab.c
// ./a.exe
