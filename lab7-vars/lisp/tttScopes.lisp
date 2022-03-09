; function that adds together all numbers in a list
(defun sum-list (list)
    (if list ; ie, if list NOT is empty
          (+ (first list) (sum-list (rest list))) ; proceed by recursion
        0 ; if list is empty, return 0
    )
)

; function that returns a boolean: is "a" equal to "X"?
(defun isX (a) (eql a 'X))

; function that sums X's in the board held in the *current-board* variable
(defun count-x-in-curr-board ()
    ; first learn how to sum X's in a given row
    (defun sumRow (row)
        (count-if 'isX row)
    )
    ; now sum all rows and then sum the results:
    (sum-list (mapcar 'sumRow current-board))
)

(defun test ()
    (let
        (
            ; declare and assign variable:
            (current-board '((X X O) (O X X) (O O X)))
        )
        (print current-board)
        (print (count-x-in-curr-board))
    )
)

(defvar current-board '((B B B) (B X B) (B B B)))
(test)
(print current-board)
(print (count-x-in-curr-board))

