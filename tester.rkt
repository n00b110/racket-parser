#lang racket

(require "parser.rkt" "tokenizer.rkt" brag/support)

(define file-content (port->string (open-input-file "Correct_1.txt") #:close? #t))
  
(apply-tokenizer-maker make-tokenizer file-content)
(parse-to-datum (apply-tokenizer-maker make-tokenizer file-content))
