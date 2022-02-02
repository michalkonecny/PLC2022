; define function exp1
; in Java it would be: static float exp1(float a, float b){ return ...; }
(defun exp1 (a b)
    (+ 
     1 (*
        (+
            a
            b)
        (-
            a
            (/
                1
                b)))
    )
)

; define function get-number
; in Java it would be: static float getNumber(String varName){ ...; return ...; }
(defun get-number (varName)
    (write-string (format nil "Input a number: ~a = " varName))
    (let*
        ((line (read-line)) ;get a line as a string
         (element (read-from-string line))) ;parse the line
        (if (numberp element) ;is get a valid floating point?
            element ;yes, return it
            (progn 
                (write-line "Invalid number, please try again.")  ;no, try again
                (get-element))))) ;using recursion


; evaluate an expression and display its result:
; (asking the user for 2 numbers in the process)
(format t "result = ~d" (exp1 (get-number "a") (get-number "b")))