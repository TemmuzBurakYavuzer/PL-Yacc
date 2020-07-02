# Programming Language rbt :robot:

## CSE334 Programming Languages - Lex and Yacc Project

**Group Members:** TEMMUZ BURAK YAVUZER

**Project Name** : Robotic
 
 

## Syntax


### Tokens 

* <\digit\> ::= <\digit\>| <\digit\> <\digit\>

* <\boolean\>::= 0 | <\non-zero digit\>

* <\non-zero digit\> ::= 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

* <\sign\>::= + | -

* <\bool\> ::= true | false



### Block and Commands 


* \<stat\>: \<creation stat\> **SEMICOLON** | \<if else stat> | \<while stat\> | **COMMENT**

* \<if stat\> ::= **IF**( \<expression\> ) \<stat\>

* \<if then else stat\> ::= **IF**( \<expression\> ) \<stat\> **ELSE** \<stat\>

* \<if then else stat not short\> ::= **IF**( \<expression\> ) <\stat not short if- else\> <\stat not short if\> \<stat\>

* \<while stat\> ::= **WHILE** ( \<expression\> ) \<stat\>





### Types

* \<type\> ::= \<numeric type\>  | \<function type\> |

* \<numeric type\> ::= \<integer\>




### Expressions


* \<expr\> ::= <assignment expr> | \<or expr\> | \<and expr\>

* \<assignment -expr\> ::= \<numeric type\> \<assignment -expr\> \<numeric type\>

* \<assignment opr\> ::= **EQUAL** | **BIGEQUAL** | **SMALLEQUAL** | **NOTEQUAL**

* \<assignment\> ::= <\l-hand side\> \<assignment opr\> \<assignment -expr\>

* \<assignment opr\> :: ==

* \<or expr\> ::= \<conditional or expr\> \<logical-opr\> <\conditional or expr\>

* \<and expr\> ::=  \<logical-operator\>

* \<logical -opr\> ::= **AND** | **OR**

* <\l-hand side\> ::= <\expr name\>

* \<math expr\> ::= \<numeric type\> \<math opr\> \<numeric type\>



### Operations

* \<math opr\> ::= PLUS: '+' ; MINUS: '-' ; MULT: '*' ; DIV: '/' ; AND: '&&' ; OR: '||' ; ASSIGNMENT: '==' ;


## Explanations about the language

My programming language is for mini robot game.
Basicly you can define Variables,Integers.It has conditional statements that can be used similar as If-Else statements
similar as in C programming language.It also has Loops that can be used similar as While loop in C programing Language.
It has exception handling that tells you to fix which part of your is wrong.You can basicly execute statements.
You can use mathematical expressions for your if else statements of your code or you can use it in while loop.
You can also define negative or positive integers.
	


Some of the Tokens are determined as follows:


- **INTEGER** [1-9][0-9]* You can create float,integer or string.

- **VARIABLE** [a-z] * Each variable sould have at least 1 capital and 1 small letter.

- **COMMENT** ([/*].+[*/]) Commenting is possible with using "/* */"

- **IF** IF If else statments are possible

- **ELSE** ELSE If else statments are possible

- **WHILE** WHILE Looping is possible

- **PRINT** Printing the value on the screen

- **PLUS** [+] , MINUS [-] It is using plus and minus to dertermine the location

- **MULT** '*' , **DIV** '/' using for mathematical calculations

- **AND** '&&' , **OR** '||' using for mathematical calculations and conditions

- **ASSIGNMENT** '==' for assigning variable or other expressions

- **IGNORE** [ \t\n]+ used to ignore white space




## How it run ?

- You can run your program by running the makefile and giving it to robotic as input:

- You have to install flex, make , make giule

- Takes a file with extension .rbt* 

**make robotic**

**./robotic < example.rbt**


<img src="https://i.gyazo.com/2f80903d79ced4e805002605a634c768.png" width="400">


### Input


<img src="https://i.gyazo.com/b36c34d208694c7a92e9bfc4b535f287.png" width="400">


### Output


<img src="https://i.gyazo.com/2f63a88172660aad6d3ab5254081505e.png" width="400">
