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
- 2 datatypes: INTEGER, DENOTED
- YIELD operator for CPU scheduling for goto loops that are too tight.
- RANDOM operator for clean random from the CPU
- INPUT and OUTPUT for standard input and output for literals and variables.
- ? returns TRUE or FALSE like traditional comparisons, but isometric.
- IN and OUT for CPU I/O is next feature
- An error in ? compares, spaces make a difference, and " paper " compare to "title" fails.
 
# Examples
- zdatest.fst prints random numbers assignment from word RANDOM works but on;y that.
- ./first < zdatest.fst | cc -x c - -o zdatest
- Other examples are similar

# zda - A code complete proof of concept
- zda.fst is the first source
- The function is to eliminate the loud zero that bugs you.
- ./first < zda.fst  | cc -o zda -x c -