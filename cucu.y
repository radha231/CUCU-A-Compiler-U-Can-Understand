%{
#include <stdio.h>
#include<stdbool.h>
#include <string.h>
#include<stdint.h>
int yylex();
void yyerror(char const *);
extern FILE *yyin,*yyout;
extern FILE *TP_GENERATOR;
%}
%token INT CHAR ASSIGNMENT PLUS MINUS DIV MULTIPLY 
%token BRACE_LEFT_CURLY BRACE_RIGHT_CURLY LEFT_BRACKET RIGHT_BRACKET LEFT_SQUARE_BRACKET RIGHT_SQUARE_BRACKET GREATER_THAN LESS_THAN EQUAL LESS_THAN_EQUAL_OP GREATER_THAN_EQUAL_OP COMPARE_NOT_EQUAL_OP
%union{
    char *str;
    int num;
}
%token WHILE IF ELSE RETURN COMMA SEMICOLON
%token <str> STRING
%token <num> NUM
%token <str> ID
%left MULTIPLY DIV
%left PLUS MINUS
%left LEFT_BRACKET RIGHT_BRACKET
%%
Start : Variable_declarations              {fprintf(yyout,"\n");}
      | FUNC_PROTOTYPE             {fprintf(yyout,"\n");}
      | Start FUNC_PROTOTYPE       {fprintf(yyout,"\n");}
      | Start Func_heading        {fprintf(yyout,"\n");}
      | Start Variable_declarations        {fprintf(yyout,"\n");}
      | Func_heading              {fprintf(yyout,"\n");}
;

Func_heading : int identifier LEFT_BRACKET Func_args RIGHT_BRACKET Function_Body       {fprintf(yyout,"Function has been declared above\n\n");}
             | char identifier LEFT_BRACKET RIGHT_BRACKET Function_Body                {fprintf(yyout,"Function has been declared above\n\n");}
             | char identifier LEFT_BRACKET Func_args RIGHT_BRACKET Function_Body      {fprintf(yyout,"Function has been declared above\n\n");}
             | int identifier LEFT_BRACKET RIGHT_BRACKET Function_Body                 {fprintf(yyout,"Function has been declared above\n\n");}
;
Variable_declarations : int identifier SEMICOLON  
         | char identifier SEMICOLON               
         | char identifier ASSIGNMENT string SEMICOLON     {fprintf(yyout,"Assignment : =\n");}
         | int identifier LEFT_SQUARE_BRACKET expr_list RIGHT_SQUARE_BRACKET NEW_PROG SEMICOLON
         | int identifier ASSIGNMENT expr_list SEMICOLON        {fprintf(yyout,"Assignment : =\n");}  
;
FUNC_PROTOTYPE : int identifier LEFT_BRACKET RIGHT_BRACKET SEMICOLON                           {fprintf(yyout,"Function has been declared above\n\n");}
          |  int identifier LEFT_BRACKET Func_args RIGHT_BRACKET SEMICOLON           {fprintf(yyout,"Function has been declared above\n\n");}
          | char identifier LEFT_BRACKET Func_args RIGHT_BRACKET SEMICOLON                {fprintf(yyout,"Function has been declared above\n\n");}
          | char identifier LEFT_BRACKET RIGHT_BRACKET SEMICOLON                          {fprintf(yyout,"Function has been declared above\n\n");}
;
NEW_PROG: ASSIGNMENT expr_list 
|
;

Func_args : int identifier                         {fprintf(yyout,"Argument of the functions\n\n");}
          | char identifier                        {fprintf(yyout,"Argument of the functions\n\n");}
          | int identifier COMMA Func_args
          | char identifier COMMA Func_args
;
int : INT       {fprintf(yyout,"Datatype : int\n");}
;
char : CHAR     {fprintf(yyout,"Datatype : char *\n");}
;
Function_Body : BRACE_LEFT_CURLY stmts_list BRACE_RIGHT_CURLY
          | stmt_new
;
stmt_new : assignment_stmt
     | Function_calling SEMICOLON            {fprintf(yyout,"Func_heading has been ended \n\n");}
     | Conditional_stmt             {fprintf(yyout,"If Condition Ends \n\n");}
     | return_stmt           {fprintf(yyout,"Return stmts_list \n\n");}
     | while_stmt                  {fprintf(yyout,"While Loop Ends \n\n");}
     | Variable_declarations
;
stmts_list : stmts_list stmt_new
          | stmt_new
;
return_stmt : RETURN SEMICOLON
            | RETURN expr_list SEMICOLON
;
assignment_stmt : expr_list ASSIGNMENT expr_list SEMICOLON
;
boolean_exp : boolean_exp LESS_THAN boolean_exp              {fprintf(yyout,"Operator : < \n");}
     | boolean_exp LEFT_SQUARE_BRACKET Identity RIGHT_SQUARE_BRACKET NEW_PROG
     | boolean_exp LESS_THAN_EQUAL_OP boolean_exp         {fprintf(yyout,"Operator : <= \n");}
     | boolean_exp GREATER_THAN_EQUAL_OP boolean_exp      {fprintf(yyout,"Operator : >= \n");}
     | boolean_exp COMPARE_NOT_EQUAL_OP boolean_exp       {fprintf(yyout,"Operator : != \n");}
     | boolean_exp GREATER_THAN boolean_exp            {fprintf(yyout,"Operator : > \n");}
     | boolean_exp EQUAL boolean_exp           {fprintf(yyout,"Operator : == \n");}
     | expr_list
;
Conditional_stmt : IF LEFT_BRACKET boolean_exp RIGHT_BRACKET Function_Body
          | IF LEFT_BRACKET boolean_exp RIGHT_BRACKET Function_Body ELSE Function_Body
;
while_stmt : WHILE LEFT_BRACKET boolean_exp RIGHT_BRACKET Function_Body
;
Function_calling : identifier expr_list            
;
Identity: identifier
|int
;
expr_list : LEFT_BRACKET expr_list RIGHT_BRACKET  {fprintf(yyout,"hi : + \n");}
     | expr_list PLUS expr_list           {fprintf(yyout,"Operator : + \n");}
     | expr_list MINUS expr_list        {fprintf(yyout,"Operator : - \n");}
     | expr2
     | expr_list COMMA expr_list
     | expr_list ASSIGNMENT expr_list
     | expr_list EQUAL expr_list
     | Identity LEFT_SQUARE_BRACKET Identity2 RIGHT_SQUARE_BRACKET
     | number              
     | identifier
     | string 
     |
;
Identity2: NUM
| identifier
;
expr2:expr2 MULTIPLY expr3            {fprintf(yyout,"Operator : * \n");}
     | expr2 DIV expr3         {fprintf(yyout,"Operator : / \n");}
     |expr3
;
expr3: number              
     | identifier 
     | string 
identifier : ID      {fprintf(yyout,"Varibale : %s \n", $1);}
;
number : NUM    {fprintf(yyout,"Value : %d \n", $1);}
;
string : STRING {fprintf(yyout,"Value : %s \n", $1);}
;
%%

int main()
{
    //For running Sample2.cu change Sample1.cu to Sample2.cu
    TP_GENERATOR=fopen("Lexer.txt","w");
    yyin=fopen("Sample2.cu","r");
    yyout=fopen("Parser.txt","w");
    yyparse();
    return 0;
}

void yyerror(char const *s){
    printf("Syntax Error Is there\n");
}