(defun myfun (n)
    (+ 1
       (* 2
          (if (> n 0)
                (factorial n)
                0))))
