# FIRST - A process language. 
- Procedures belong to the operating system.
- The language goal is to translate math into the computer.
- Started June 2026, expect daily progress, maybe weekly.
- Test programs to show translation to C programs that compile and run.
- very simple subset of the ALGOL language without the complexity.

# Build
- flex -8 first.l
- cc lex.yy.c -o first -lfl
- ./first < test.fst > test.c 
- cc test.c -o test
- ./test

# Combining with pipes to make a procedure
- UNIX and LINUX have the pipe operator, |, in the shell enviroment of the Terminal.
- ls -s | sort -n for example combines 2 processes ls and sort to 
  create a procedure of listing files sorted from smallest to largest

# What Works
- 2 datatypes: INTEGER, DENOTED
- YIELD operator for CPU scheduling for goto loops that are too tight.
- RANDOM operator for clean random from the CPU
- INPUT and OUTPUT for standard input and output for literals and variables.
- ? symbol for isomorphic compare.
- IN for port access, has to be optimized cc with -O and run with sudo or su.
- OUT is like IN above. 

# What Fails
- test6.fst is how to reboot the system but fails on Linux for some reason.
- Assignment of literal INTEGER to VARIABLE: instead of A:=0; try A := 0;
- In general, spaces are required between and betwixt the elements of the language.
 
# Examples
- zdatest.fst prints random numbers assignment from word RANDOM works but on;y that.
- ./first < zdatest.fst | cc -x c - -o zdatest
- Other examples are similar

# zda - A process proof of concept
- zda.fst is the first source
- The purpose is to out others that have a zero score.
- The compile procedure: ./first < zda.fst  | cc -o zda -x c -



