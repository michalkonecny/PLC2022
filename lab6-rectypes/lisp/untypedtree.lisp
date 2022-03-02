(setf tree1
  '(times 2 (plus 3 0.5)))

(setf tree2
  '(tbody
    (tr (td x) (td o) (td b))
    (tr (td b) (td o) (td b))
    (tr (td o) (td x) (td b))))

(defun countnodes (tree)
  (if (and (listp tree) (> (length tree) 1)) ; is it a node with children or a leaf?
    (+ 1 (reduce '+ (mapcar 'countnodes (rest tree)))) 
        ; A node with children: Call countnodes for each child and sum the results
        ;    and add 1 to account for the current parent node.
    1   ; A leaf node: The size of this (sub)tree is 1.
        ))

(print tree1)
(print (countnodes tree1))
(print tree2)
(print (countnodes tree2))
