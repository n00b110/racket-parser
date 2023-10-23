#lang racket

(require "parser.rkt" "tokenizer.rkt")
(require brag/support)

(define (parse-file file-name)
  (define file-content (port->string (open-input-file file-name) #:close? #t))
  
  (with-handlers ([exn:fail? (lambda (exn)
                               (displayln (exn-message exn)))])
    (parse-to-datum (apply-tokenizer-maker make-tokenizer file-content))
    (display "Accept")))

(parse-file "Correct_1.txt")
