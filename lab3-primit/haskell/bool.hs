module Main where

main =
    do
    print (myfun 100)
    print (myfun2 100)

-- [example to illustrate if-then-else in expressions:]
myfun n = 2 * (if n > 0 then (factorial n) else 0) + 1

-- [a better way to do the above, using definition by cases with guards:]
myfun2 n 
    | n > 0 = 2 * (factorial n) + 1
    | n <= 0 = 1

factorial n 
    | n <= 1 = 1
    | n > 1 = n * (factorial (n - 1))
