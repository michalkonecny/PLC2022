;; code for Task 1.2(a):
(print (1 + 2 - 3))
;; the above expression throws an error

;; code for Task 1.2(b)
(defvar x 55)
(cond 
  ((< x 10) (format t "number below 10"))
  ((< x 50) (format t "number below 50"))
  (t (format t "number greater or equal 50"))
)
; TODO: convert the cond macro in a nested if-then-else

;; code for Task 1.2(c):
(setf prg '(+ 1 n)) ; define a very simple program
(print prg) ; print the program
; TODO: execute the program with n = 1 and print its result
