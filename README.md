# FIRST - A process language. 
- Procedures belong to the operating system.
- The language goal is to translate math into the computer.
- Started June 2026, expect daily progress, maybe weekly.
- Test programs to show translation to C programs that compile and run.
- very simple subset of the ALGOL language without the complexity.
- If you overcometh look-at-fear, your human intelligence can program first programs

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
- RETURN for return a small integer result to the Operating System. See zdatest.fst.
- ? symbol for isomorphic compare.  
- Assignment of the COUNT of an assigned DENOTED to an INTEGER; See test5.fst
- OUTPUT a color, reset of color, or clear and position at top left. 
  test7.fst  has the example.
- assignment with two integers with an arithmetic work. See pi.fst.

# What Fails
- test6.fst fails to compile.
- Assignment of literal INTEGER to VARIABLE: instead of A:=0; try A := 0;
- In general, spaces are required between and betwixt the elements of the language.

# Limits
- 256 character length DENOTATIONS. This is due to an arbitrary choice.
- INTEGER is signed 128 bit values.
- RANDOM is signed 128 bit values.
- RETURN is operating system dependent.
 
# Examples
- zdatest.fst returns a random integer.
- ./first < zdatest.fst | cc -x c - -o zdatest
- Other examples are similar

# zda - A reality control, a work in progress.
- zda.fst is a first source
- The purpose is to out others that have a zero score.
- The compile procedure: ./first < zda.fst  | cc -o zda -x c -
- Run it and see it run with the top utility.


