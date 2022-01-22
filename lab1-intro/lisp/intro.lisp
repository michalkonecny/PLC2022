;; declare, assign and use a variable:
(setf name "Alice")
  
;; function call syntax, also operators=functions:
(setf test (equal 3 (+ 1 2)))

;; "if" and comparison are also functions:
(setf name2 (if (not (equal name "")) name "no name"))

;; print returns a value in addition to printing:
(setf name3 (print "Bob"))

;; a program can be treated as data:
(setf myprogram '(print (+ 1 m))) ;; the tick is important
;; myprogram ;; returns (PRINT (+ 1 M))
;; (eval myprogram)  ;; throws error: "EVAL: variable M has no value"

(setf m 1)
;; (eval myprogram)  ;; prints 2

;; sequencing the side-effects of multiple expressions:
(setf prg1 '(progn (print "hello ") (print name)))
;; (eval prg1) ;; returns "Alice" and also prints: "hello " "Alice"
