(defun get-house-category ()
    (write-string "input house category: ")
    (let*
        ((line (read-line)) ;get a line as a string
         (element (read-from-string line))) ;parse the line
        (if (house-categoryp element) ;is it a valid house type?
            element ;"then" branch; return the element!
            (progn  ;"else" branch; progn = evaluate a sequence of expressions
                (write-line "Invalid house category, please try again.")
                (get-house-category))))) ;back to the start using recursion

(defun house-categoryp (a)
    (member a '(detached semidetached terraced)))

(let ((ht (get-house-category)))
    (write-string "Your input: ")
    (write ht))
