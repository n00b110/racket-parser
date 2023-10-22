#lang racket

(require brag/support)

(define (make-tokenizer port)
  (port-count-lines! port) ; get line data
  
  (define (next-token)
    (define-lex-abbrevs
      (lower-letter (:/ "a" "z"))
      (upper-letter (:/ #\A #\Z))
      (digit (:/ "0" "9")))
    
    (define immanuel-lexer
      (lexer
       
       [whitespace (token 'WS lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start) #:skip? #t)]
       
       ["{" (token 'PROG-START lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["}" (token 'PROG-STOP lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["$" (token 'DOLLAR lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       
       ["read" (token 'READ lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["write" (token 'WRITE lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["goto" (token 'GOTO lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["gosub" (token 'GOSUB lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["return" (token 'RETURN lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["break" (token 'BREAK lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["end" (token 'END lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       
       ["if (" (token 'COND-START lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["while (" (token 'LOOP-START lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["endwhile" (token 'LOOP-END lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       [")" (token 'COND-STOP lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       
       ["=" (token 'ASSIGN-OP lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["+" (token 'ADD-OP lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["-" (token 'SUB-OP lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["*" (token 'MULT-OP lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["/" (token 'DIV-OP lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       
       ["<" (token 'LESS lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       [">" (token 'GREATER lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       [">=" (token 'GREATER-EQUAL lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["<=" (token 'LESS-EQUAL lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["<>" (token 'NOT-EQUAL lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       
       [";" (token 'DELIMIT lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       
       [(:+ (:or lower-letter upper-letter) (:* (:or lower-letter upper-letter digit))) 
        (token 'ID lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       
       [(:+ digit) 
        (token 'DIGIT (string->number lexeme) #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       
       [any-char 
        (token 'MISC lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]))
    
    (immanuel-lexer port))
  
  next-token)

(provide make-tokenizer)
