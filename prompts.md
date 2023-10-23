# Custom Language Parsing with Racket's `brag`

This repository provides insights into using Racket's `brag` library for custom language parsing. Below is a series of questions and topics I asked ChatGPT for information and advice about. 

## Table of Contents
1. [Introduction to `racket/parser`](#introduction-to-racketparser)
2. [BNF-style Grammar for a Custom Language](#bnf-style-grammar-for-a-custom-language)
3. [Translating the BNF Grammar to `brag`](#translating-the-bnf-grammar-to-brag)
4. [Tokenization with `brag`](#tokenization-with-brag)
5. [Parsing Definition in Racket](#parsing-definition-in-racket)
6. [Code Formatting](#code-formatting)

## Introduction to `racket/parser`
- **Query:** What is `(require racket/parser)`? What library is it?
- **Summary:** The initial inquiry was about understanding the specifics and functionalities of the `racket/parser` library.

## BNF-style Grammar for a Custom Language
- **Query:** Gimme a BNF-style grammar with specific rules and symbols.
```
program -> linelist $$ 
linelist -> line linelist | epsilon 
line ->  label stmt linetail 
label -> id: | epsilon 
linetail -> stmt+ | epsilon 
stmt -> id = expr; 
	| if (boolean) stmt; 
	| while (boolean) linelist endwhile;
	| read id; 
	| write expr; 
	| goto id; 
	| gosub id; 
	| return;
	| break;
	| end; 
boolean -> true | false | expr bool-op expr 
bool-op -> < | > | >= | <= | <> | =
expr -> id etail | num etail | (expr) 
etail -> + expr | - expr | * expr | / expr | epsilon
id -> [a-zA-Z][a-zA-Z0-9]*
num -> numsign digit digit*
numsign -> + | - | epsilon 
```
- **Summary:** An overview of the desired grammar for a custom language in Backus-Naur Form (BNF) was presented.

## Translating the BNF Grammar to `brag`
- **Query:** How can the provided BNF grammar be written in `brag` form in Racket?
- **Summary:** The conversation revolved around converting the BNF grammar to be compatible with Racket's `brag` library.

## Tokenization with `brag`
- **Query:** Can the tokenizer be expanded to align with the custom grammar?
```racket
#lang br/quicklang
(require brag/support)

(define (make-tokenizer port)
  (port-count-lines! port) ; get line data
  (define (next-token)
  
    (define-lex-abbrevs
      (lower-letter (:/ "a" "z"))
      (upper-letter (:/ #\A #\Z))
      (digit (:/ "0" "9")))
      
    (define odai-lexer
      (lexer
       
       [whitespace (token 'WS lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start) #:skip? #t)]
       
       ["{" (token 'PROG-START lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["}" (token 'PROG-STOP lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["$" (token 'DOLLAR lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       
       ["read" (token 'READ lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["write" (token 'WRITE lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       [";" (token 'DELIMIT lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       
       ["if (" (token 'COND-START lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       [")" (token 'COND-STOP lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       
       ["=" (token 'ASSIGN-OP lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["+" (token 'ADD-OP lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["-" (token 'SUB-OP lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       
       [(:+ (:or lower-letter upper-letter)) (token 'ID lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       [(:+ digit) (token 'DIGIT (string->number lexeme) #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       
       [any-char (token 'MISC lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]))
    (odai-lexer port))
  next-token)

(provide make-tokenizer)
```
- **Summary:** The discussion delved into adjusting a given tokenizer to suit the custom grammar.

## Parsing Definition in Racket
- **Query:** How can the parsing definition in Racket be modified or understood better for the project?
- **Summary:** A deep dive into understanding and potentially refining a Racket-based parser definition for the custom language.

## Code Formatting
- **Query:** How can the provided Racket code be made more readable and structured?
```racket
#lang brag

program : PROG-START stmt_list PROG-STOP DOLLAR DOLLAR
stmt_list : stmt [stmt_list]*
stmt : ID ASSIGN-OP expr DELIMIT ; id = expr;
     | COND-START expr COND-STOP stmt ; if (expr) stmt
     | READ ID DELIMIT ; read id;
     | WRITE expr DELIMIT ; write expr;

expr: (ID|DIGIT|numsign DIGIT) [numsign expr]* 
numsign : ADD-OP | SUB-OP | ""
```
- **Summary:** This section focused on enhancing the clarity and presentation of the given Racket code snippet.

