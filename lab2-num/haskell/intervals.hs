module Main where

-- from package aern2-mp:
import AERN2.MP

type MI = MPBall

main = 
    do
    mapM_ usePrec [10,20..100]

usePrec prec =
    do
    putStr $ show prec
    putStr ": "
    putStr $ show resultInterval
    putStrLn ""
    where
    resultInterval = sum_fracts prec 1000

sum_fracts :: Precision -> Int -> MI
sum_fracts p n -- = 1/1 + 1/2 + ... + 1/n
    | (n == 0) = oneI
    | otherwise = (oneI/nI) + sum_fracts p (n - 1)
    where
    oneI = setPrecision p (mpBall (1::Integer))
    nI = setPrecision p (mpBall n)
    