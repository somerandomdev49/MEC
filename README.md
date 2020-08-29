# MEC

- [MEC](#mec)
  - [VM](#vm)
  - [Instructions](#instructions)
  - [Binary file format](#binary-file-format)
      - [Values](#values)
      - [Instructions](#instructions-1)
  - [Compiler](#compiler)
      - [Syntax](#syntax)
      - [Usage](#usage)

## VM
MEC Virtual Machine simply executes instructions. It has storage for Values (constant strings). And (for now) it has no RAM, only 16 registers.

## Instructions

| Name|                      Description                      |
| --- | :---------------------------------------------------: |
| IMM |           set register 0 to IMMediate value           |
| MVR |        MV value from one Register to another.         |
| MOV |        MOVe from register to value in memory.         |
| STR |           SeT Register to value in memory.            |
| SPX |                     Switch PiXel.                     |
| DRW |                  DRaW scrren buffer.                  |
| CLS |                     CLear Screen.                     |
| GET |                     GET a number.                     |
| CLL |                   CaLL a function.                    |
| PAU |                         PAUse                         | 
| PUT |             PUT a string to the console.              |
| JMP |       JuMP to immediate instruction (PC = N).         |
| CJP | Conditional JumP (if register 0 is truthy then jump). |
| ADD<br/>SUB<br/>MUL<br/>DIV<br/>AND<br/>COR<br/>NOT<br/>CLT<br/>CGT<br/>CLE<br/>CGE<br/> | Math |

## Binary file format
Extension: `.mecc`
All of the numbers are Big Endian `[0x00, 0x01] -> 1, not 255`

    <16-bit value-count> <values>
    <16-bit instruction-count> <instructions>

#### Values
Zero-terminated strings. Maximum length of 65536.
#### Instructions
Depending on the instruction, `first` and `second` might be interpreted as one 16-bit number, or they might be ignored.

    <8-bit type> <8-bit first> <8-bit second>


## Compiler
> :warning: You must have python 3 installed.

A simple MEC code compiler.

#### Syntax
Extension: `.mec`
Syntax is very simple:

    VAL <string>
    <command>
    <command> <16-bit number>
    <command> <8-bit number> <8-bit number>
    ; comment

The file is split into lines, each line is split using `shlex` and decoded with `unicode-escape` (so `"quoted strings are allowed\n\talso with escapes!"`)
The `VAL` is for adding values.

#### Usage
    usage: mecc [-h] [-o [OUTPUT]] [-v] input

    positional arguments:
    input          input filename

    optional arguments:
    -h, --help     show this help message and exit
    -o [OUTPUT]    output filename
    -v, --verbose  show additional things

