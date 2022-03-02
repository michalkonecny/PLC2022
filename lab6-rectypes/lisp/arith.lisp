(setf exp1 '(plus 1 (times 2 3)))

(setf nonexp1 '(a (1 "a")))

(defun arithp (a)
  (or
    (integerp a) ; a leaf node
    (and ; a plus or times node
      (listp a)
      (equal (length a) 3)
      (member (nth 0 a) '(plus times))
      (arithp (nth 1 a)) ; recursion
      (arithp (nth 2 a))))) ; recursion

(defun countnodes (a)
  (if
    (integerp a)
    1
    (+
      1 ; counting this node
      (countnodes (nth 1 a)) ; recursion for left child
      (countnodes (nth 2 a))))) ; recursion for right child

(setf mylist1 '(1 2 3))
(print mylist1) ; will print (1 2 3)
(setf (nth 1 mylist1) 5) ; update a list element
(print mylist1) ; will print (1 5 3)

(defun test ()
  (setf a '(1 2 3))
  (setf (nth 1 a) (+ 1 (nth 1 a))) ; increment second element
    ; It modifies the definition of function test
    ;   since the value of a is embedded in the definition!!!
  a)

(print (test)) ; will print (1 3 3)
(print (test)) ; will print (1 4 3)
(print (test)) ; will print (1 5 3)
