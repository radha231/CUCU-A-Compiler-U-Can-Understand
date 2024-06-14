# CUCU-A-Compiler-U-Can-Understand
CUCU is a simple, educational compiler for a toy language that closely resembles the C programming language. This project is designed to help students and enthusiasts understand the fundamental concepts of compiler construction. The compiler is implemented using Lex and Yacc, which are tools commonly used for lexical analysis and parsing.

In this directory, there are 7 crucial files: cucu.l, cucu.y, Sample1.cu, and Sample2.cu.,Lexer.txt,Parser.txt Here's how to navigate and utilize them effectively:

For Running the Program, execute the following commands sequentially:
1. flex cucu.l
2. bison -d cucu.y
3. g++ cucu.tab.c lex.yy.c -o cucu
4. ./cucu


cucu.l:
1. This file meticulously tokenizes variable names, keywords, special characters, and numbers.
2. All tokens are logged into lexer.txt, with each token name printed for clarity.


cucu.y:
1. Holds the BNF grammar rules necessary for the compiler's operation.
2. Parsing details are recorded in parser.txt, including various steps and statement types encountered.
3. If a syntax error arises during parsing, a clear "Syntax Error" message is displayed in the terminal.


Sample1.cu:
1. Contains code snippets with flawless syntax, ready for parsing and analysis.


Sample2.cu:
1. Offers code segments intentionally crafted with incorrect syntax, serving as valuable test cases.


Lexer.txt and Parser.txt:
1.Contains output
