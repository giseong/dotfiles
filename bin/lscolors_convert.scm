#!/usr/bin/env gosh

(use srfi-1)
(use srfi-13)

(define (even-odd-map f-even f-odd lis)
  (if (null? lis)
      '()
      (cons (f-odd (car lis))
            (cons (f-even (cadr lis))
                  (even-odd-map f-even f-odd (cddr lis))))))

(define (join-neighbor-pair lis)
  (if (or (null? lis)
          (null? (cdr lis)))
      lis
      (cons (string-append (car lis) ";" (cadr lis))
            (join-neighbor-pair (cddr lis)))))

;{{{funcs
(define (odd-func x)
  (cond ((char=? x #\a) "30")
        ((char=? x #\b) "31")
        ((char=? x #\c) "32")
        ((char=? x #\d) "33")
        ((char=? x #\e) "34")
        ((char=? x #\f) "35")
        ((char=? x #\g) "36")
        ((char=? x #\h) "37")

        ((char=? x #\A) "01;30")
        ((char=? x #\B) "01;31")
        ((char=? x #\C) "01;32")
        ((char=? x #\D) "01;33")
        ((char=? x #\E) "01;34")
        ((char=? x #\F) "01;35")
        ((char=? x #\G) "01;36")
        ((char=? x #\H) "01;37")
        ((char=? x #\x) "39")))

(define (even-func x)
  (cond ((char=? x #\a) "40")
        ((char=? x #\b) "41")
        ((char=? x #\c) "42")
        ((char=? x #\d) "43")
        ((char=? x #\e) "44")
        ((char=? x #\f) "45")
        ((char=? x #\g) "46")
        ((char=? x #\h) "47")

        ((char=? x #\A) "01;40")
        ((char=? x #\B) "01;41")
        ((char=? x #\C) "01;42")
        ((char=? x #\D) "01;43")
        ((char=? x #\E) "01;44")
        ((char=? x #\F) "01;45")
        ((char=? x #\G) "01;46")
        ((char=? x #\H) "01;47")
        ((char=? x #\x) "49")))
;}}}

(define (do-convert lis)
  (fold-right cons* '() '("di=" ":ln=" ":so=" ":pi=" ":ex=" ":bd=" ":cd=" ":su="
                          ":sg=" ":tw=" ":ow=")
              (join-neighbor-pair (even-odd-map even-func odd-func lis))))

(define (main args)
  (if (or (null? (cdr args))
          (not (= (string-length (cadr args)) 22)))
      (print "null or less than 22 chars.")
      (print (string-concatenate (do-convert (string->list (cadr args)))))))

