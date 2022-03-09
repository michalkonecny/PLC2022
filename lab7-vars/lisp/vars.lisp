(setf a 0) ; statically scoped global variable
(defvar b 0) ; dynamically scoped global variable

(defun print-ab ()
    (print a)
    (print b)) ; cannot statically determine which b will be used here

(defun test ()
    (let ((a 1) ; new variable visible only in this block
          (b 1)) ; new variable available to this thread
                 ; until this block finishes executing
                 ; (because it shadows a dynamically scoped variable)
        (print-ab)))

(test) ; prints: 0 1
(print-ab) ; prints: 0 0
