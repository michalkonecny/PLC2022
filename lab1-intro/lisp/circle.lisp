;; Teach the Lisp interpreter a function:
(defun circleLines (size)
  ;; a Lisp way to loop over a list and produce a new list (aka "map" a list):
  (loop for i from 1 to size collect (circleLine size i)))
  ;; "loop" is a macro.
  ;; A macro it is first translated into a bracketed expression,
  ;; then interpreted as usual.

(defun circleLine (size i)
  (concat-strings
   (loop for jj from 1 to (* 2 size) collect (circleChar size i jj))))

;; For now, you can safely ignore the following function definition:
(defun concat-strings (list)
  (reduce (lambda (a b) (concatenate 'string a b)) list))

(defun circleChar (size i jj)
  (let
    ((j (truncate jj 2)))
    (if (shouldPaint size i j) "*" " ")))

(defun shouldPaint (size i j)
  (shouldPaintS size i j))

(defun shouldPaintS (s i j)
  (let
    ((distance (abs (- (+ (* i i) (* j j)) (* s s)))))
    (<= distance (+ 1 s))))

;; An imperative program to print a list of lines:
(defun write-lines (lines)
  (loop for line in lines do (write-line line)))

;; All the above code "teaches" the lisp interpreter new functions.
;; The following line has a direct effect:
(write-lines (circleLines 
  15))
  ;; (parse-integer (first *args*))))
