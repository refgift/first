# FIRST - A process language. Combine with pipes to create procedures.
- Started June 2026, expect daily progress, maybe weekly.
- Test programs to show translation to C programs that compile and run.
- very simple subset of the ALGOL language without complexity.

# Build
- flex -8 first.l
- cc lex.yy.c -o first -lfl
- ./first < test.fst > test.c 
- cc test.c -o test
- ./test

# Combining With Pipes
- UNIX and LINUX have the pipe operator, |, in the shell enviroment of the Terminal.
- ls -s | sort -n  for example

# Developments
- 3 datatypes: INTEGER, DENOTED, RANDOM
- YIELD operator for CPU scheduling for goto loops that are too tight.
- INPUT and OUTPUT for standard input and output for literals and variables.
- Basic math but soon isomorphic symbol  ? returns TRUE or FALSE like traditional comparisons.
 
# Examples
- zdatest.fst prints random numbers assignment from word RANDOM works but on;y that.
- ./first < zdatest.fst | cc -x c - -o zdatest
- Other examples are similar

# zda - A proof of concept
- zda.fst is the first source
- The function is to eliminate the loud zero that bugs you.
