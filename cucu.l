%{
#include <stdio.h>
#include<stdbool.h>
#include <string.h>
#include<stdint.h>
#include "cucu.tab.h"
FILE *TP_GENERATOR;
%}
%%
"int"                   {fprintf (TP_GENERATOR,"Type : int\n"); return INT;}
"char *"                {fprintf (TP_GENERATOR,"Type : char*\n"); return CHAR;}
"if"                    {fprintf (TP_GENERATOR,"IF : if\n"); return IF;}
"else"                  {fprintf (TP_GENERATOR,"ELSE : else\n"); return ELSE;}
"while"                 {fprintf (TP_GENERATOR,"WHILE : while\n"); return WHILE;}
"return"                {fprintf (TP_GENERATOR, "RETURN : return\n"); return RETURN;}
[0-9]+                  {fprintf (TP_GENERATOR,"NUM : %d\n", yylval.num=atoi(yytext)); return NUM;}
(\"[a-zA-Z0-9]*\")      {fprintf (TP_GENERATOR, "Type : string"); yylval.str=strdup(yytext); return STRING;}
[a-zA-Z_][a-zA-Z0-9_]*  {fprintf (TP_GENERATOR,"ID : %s\n", yytext); yylval.str=strdup(yytext); return ID;}
"="                     {fprintf (TP_GENERATOR,"ASSIGN : =\n"); return ASSIGNMENT;}
";"                     {fprintf (TP_GENERATOR,"SEMI : ;\n"); return SEMICOLON;}
","                     {fprintf (TP_GENERATOR,"COMMA : ,\n"); return COMMA;}
">"                     {fprintf (TP_GENERATOR,"GREATER_THAN : >\n"); return GREATER_THAN;}
"<"                     {fprintf (TP_GENERATOR,"LESS_THAN : <\n"); return LESS_THAN;}
"=="                    {fprintf (TP_GENERATOR,"COMPARE_EQUAL : ==\n"); return EQUAL;}
"<="                    {fprintf (TP_GENERATOR,"LESS_THAN_EQUAL : <=\n"); return LESS_THAN_EQUAL_OP;}
">="                    {fprintf (TP_GENERATOR,"GREATER_THAN_EQUAL : >=\n"); return GREATER_THAN_EQUAL_OP;}
[\{]                    {fprintf (TP_GENERATOR,"LEFT_CURLY_BRACE : {\n"); return BRACE_LEFT_CURLY;}
[\}]                    {fprintf (TP_GENERATOR,"RIGHT_CURLY_BRACE : }\n"); return BRACE_RIGHT_CURLY;}
[\(]                    {fprintf (TP_GENERATOR,"LEFT_BRACKET : (\n"); return LEFT_BRACKET;}
[\)]                    {fprintf (TP_GENERATOR,"RIGHT_BRACKET : )\n"); return RIGHT_BRACKET;}
[\[]                    {fprintf (TP_GENERATOR,"LEFT_SQUARE_BRACKET : [\n"); return LEFT_SQUARE_BRACKET;}
[\]]                    {fprintf (TP_GENERATOR,"RIGHT_SQUARE_BRACKET : ]\n"); return RIGHT_SQUARE_BRACKET;}
"+"                     {fprintf (TP_GENERATOR,"PLUS : +\n"); return PLUS;}
"-"                     {fprintf (TP_GENERATOR,"MINUS : +\n"); return MINUS;}
"*"                     {fprintf (TP_GENERATOR,"MULTIPLICATION : *\n"); return MULTIPLY;}
"/"                     {fprintf (TP_GENERATOR,"DIVISION : /\n"); return DIV;}
"!="                    {fprintf (TP_GENERATOR,"COMPARE_NOT_EQUAL : !=\n"); return COMPARE_NOT_EQUAL_OP;}
\/\*(.|\n)*\*\/         ; //IGNORING ANYTHING ELSE
[ \t\n]+                ; // IGNORING SPACES, TABS, NEW LINE
%%
int yywrap(){
    return 1;
}