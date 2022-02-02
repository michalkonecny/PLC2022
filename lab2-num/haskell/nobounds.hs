module Main where

import Data.Ratio

main = 
   do
   print $ factorial 10000
--      print $ sum_fracts 1000

factorial n = product [1..n]
-- factorial n -- = n! = n * (n-1) * ... * 3 * 2 * 1
--     | (n == 0) = 1
--     | otherwise = n * factorial (n - 1)

sum_fracts n -- = 1/1 + 1/1 + 1/2 + ... + 1/n
    | (n == 0) = 1
    | otherwise = (1%n) + sum_fracts (n - 1)
    
    