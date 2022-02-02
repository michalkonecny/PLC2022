module Main where

-- from package hmpfr:
import qualified Data.Number.MPFR as M 
import Data.Number.MPFR.Instances.Near ()

main = 
    do
    mapM_ usePrec [10,20..100]

usePrec p =
    do
    putStr $ show p
    putStr ": "
    print $ sum_fracts p 1000

sum_fracts :: M.Precision -> Int -> M.MPFR
sum_fracts p n -- = 1/1 + 1/2 + ... + 1/n
    | (n == 0) = oneM
    | otherwise = (oneM/nM) + sum_fracts p (n - 1)
    where
    oneM = fromInt p 1
    nM = fromInt p n
    
fromInt :: M.Precision -> Int -> M.MPFR
fromInt p n =
    M.set M.Near p (fromIntegral n)

sum_fractsDbl :: Int -> Double
sum_fractsDbl n -- = 1/1 + 1/2 + ... + 1/n
    | (n == 0) = 1 :: Double
    | otherwise = (1/nD) + sum_fractsDbl (n - 1)
    where
    nD = fromIntegral n
    