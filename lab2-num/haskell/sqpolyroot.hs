module Main where

import Data.Ratio

main = 
    do
--     print $ solution 1 2 (-1)
    printL "tiny*tiny" (tiny*tiny)
    printL "huge*huge" (huge*huge)
    printL "huge == tiny + huge" (huge == tiny + huge)
    printL "huge * tiny * huge" (huge * tiny * huge)
    printL "huge * huge * tiny" (huge * huge * tiny)
    printL "(huge * huge) * (tiny * tiny)" ((huge * huge) * (tiny * tiny))
    printL "(huge * huge) - (huge * huge)" ((huge * huge) - (huge * huge))

    
solution a b c = 
    (- b + (sqrt $ b ** 2 - 4 * a * c))/(2 * a)
    
    
tiny = 1.0E-200 :: Double
huge = 1.0E+200 :: Double

printL label x = do putStr (label ++ ": "); print x
