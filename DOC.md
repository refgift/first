# Programming with First

## Introduction

First is a minimalist, assembly-like language designed for learning low-level programming concepts. It aims to provide a simple syntax for manipulating data, controlling program flow, and interacting with hardware.  First emphasizes clarity and directness, making it a good starting point for those interested in systems programming or embedded development.  This document serves as a basic tutorial to get you started.

## Core Concepts

*   **Labels:**  Labels are used for branching and function calls. They are defined using the format `LABELNAME:`.  Example: `LOOP:`.
*   **Variables:**  First supports two types of variables:
    *   **INTEGER:**  Long integer variables. Declared using `INTEGER variable_name`. Example: `INTEGER counter`.
    *   **DENOTED:** Character string variables. Declared using `DENOTED variable_name`.  Example: `DENOTED message`.
*   **Assignment:** The assignment operator is `:=`. Example: `counter := 10`.
*   **Input/Output:**
    *   `IN digit , label`:  Reads a byte from the specified I/O port (digit) and stores it in the variable `label`. Linux only; the program calls `iopl(3)` and must run as root or with `CAP_SYS_RAWIO`.
    *   `OUT digit , label`:  Writes the value of the variable `label` to the specified I/O port (digit). Same privilege as `IN`.
    *   `OUTPUT "string"`: Outputs a string literal to the console.
    *   `OUTPUT variable`:  Outputs the value of a variable to the console.
    *   `OUTPUT SPACE`, `OUTPUT TAB`, `OUTPUT NEWLINE`, `OUTPUT CR`:  Outputs whitespace characters.
    *   `OUTPUT RED`, `OUTPUT BLUE`, `OUTPUT GREEN`, etc.:  Sets the console text color. `OUTPUT CLEAR` resets to default.

*   **Control Flow:**
    *   `IF condition THEN`:  Conditional execution. The `condition` could be an equality check, or an isomorphism check.
    *   `GOTO label`:  Unconditional jump to a label.
    *   `JUMP label`: Same as goto.
    *   `RETURN label`: Exits the program with the specified label as the return value.
*   **Special Functions:**
    *   `RANDOM`:  Generates a random number. The value is stored into the label variable.

## Syntax and Keywords

| Keyword/Symbol | Description                                   |
|----------------|-----------------------------------------------|
| `INTEGER`      | Declares a long integer variable.             |
| `DENOTED`      | Declares a character string variable.         |
| `LABEL:`       | Defines a label.                             |
| `:=`           | Assignment operator.                          |
| `OUT`          | Output a byte to an I/O port.                 |
| `IN`           | Input a byte from an I/O port.                |
| `OUTPUT`       | Output to the console.                       |
| `IF`           | Conditional statement.                        |
| `THEN`         | Marks the end of the `IF` condition.          |
| `GOTO`         | Unconditional jump.                           |
| `JUMP`         | Unconditional jump.                           |
| `RETURN`       | Exits the program.                           |
| `BEGIN`        | Marks the start of a code block.              |
| `END`          | Marks the end of a code block.                |
| `SPACE`        | Outputs a space.                              |
| `TAB`          | Outputs a tab.                               |
| `NEWLINE`      | Outputs a newline.                           |
| `CR`           | Outputs a carriage return.                    |
| `RED`, `BLUE`, `GREEN`, `WHITE`, `BLACK`, `CLEAR`, `YELLOW`, `MAGENTA`, `CYAN` | Console text color keywords |
| `TRUE`| Boolean True |
| `FALSE`| Boolean False |

## Examples

### Simple Counter

```first
INTEGER counter

counter := 0
LOOP:
  counter := counter + 1
  OUTPUT "Counter: "
  OUTPUT counter
  OUTPUT NEWLINE
  GOTO LOOP
```

### Reading and Displaying Input

```first
DENOTED input_string

INPUT input_string
OUTPUT "You entered: "
OUTPUT input_string
OUTPUT NEWLINE
```

### Conditional Output

```first
INTEGER x

x := 5

IF x > 0 THEN
  OUTPUT "x is positive\n"
END
```

### Color Example
```first
OUTPUT RED
OUTPUT "This text is red!\n"
OUTPUT CLEAR
```

## Advanced Features

*   **Isomorphic Comparison:** The `IF` statement supports an isomorphism check (`?`). This allows you to compare strings for structural equivalence, not just equality.

```first
DENOTED string1
DENOTED string2

string1 := "abc"
string2 := "xyz"

IF string1 ? string2 THEN
  OUTPUT "Strings are isomorphic\n"
END
```

## Limitations

*   Error handling is minimal.
*   No math functions beyond `RANDOM` are currently supported.


## Future Development

*   Expanded arithmetic functions like sine and cosine .
*   Improved error reporting.
*   Boolean data type and operators.

```

**CRITICAL NOTES and Customization Steps:**

1.  **Accuracy:**  *Thoroughly* test every example in your language against its generated C code.  The generated C code is the source of truth.  Adjust the documentation to *exactly* match the behavior of your language.
2.  **`isofunct` Integration:** The Markdown includes the `isofunct` constant. This is *crucial* because it contains the C code for your isomorphism check.  Make sure this code is correct and efficient. If you change the isomorphism logic, *update this constant*.
3.  **Color Codes:** The color codes (RED, BLUE, etc.) depend on the terminal and library you're using to display output.  The `\033[...]m` sequences are ANSI escape codes.  Test these on your target platform. If they don't work, you'll need to find alternative color mechanisms.
4.  **Input Handling:**  The `INPUT` statement's behavior is critical.  The current example uses `scanf` to read a line of input.  This might have limitations (e.g., buffer size).  Document these limitations clearly. The `getchar()` is crucial to prevent the next prompt from consuming the newline character.
5.  **Variable Types:**  Emphasize the difference between `INTEGER` and `DENOTED` variables.  The generated C code uses `long` for integers and `char[]` for strings, so this distinction is important for understanding the generated code.
6.  **Error Handling:** Your language currently doesn't have robust error handling.  This is a significant limitation.  Document this explicitly.
7.  **Future Development:**  The "Future Development" section is a good place to outline your roadmap for the language.
8.  **Target Audience:**  Consider who you're writing this documentation for. If it's for absolute beginners, you might need to explain more basic programming concepts.
9.  **Assembly-Like Nature:** Highlight the assembly-like characteristics of First. This will help users understand its low-level focus.
10. **Generated C code:** The generated c code can be inspected to understand the underlying implementation.
11. **Boolean values:** Boolean datatype is not yet supported.

**Document

1.  Copy the Markdown text into a file named `programming_with_first.md`.
2.  Open the file in a Markdown editor or viewer (e.g., VS Code, GitHub).
3.  Carefully review and customize the content, paying particular attention to the critical notes above.
4.  Render the Markdown to HTML or PDF for distribution.

