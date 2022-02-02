(setf a 1)
(setf b 2)
(setf c 1)

(write
(/
    (+
        (- b)
        (sqrt
            (-
                (expt b 2)
                (* 4 a c))))
    (* 2 a))
)
