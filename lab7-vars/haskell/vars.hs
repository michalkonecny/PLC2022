module Main where

main :: IO ()
main =
    do
    putStrLn $ "a = " ++ show (a :: Integer)
    putStrLn $ "i = " ++ show i
    putStrLn $ "f = " ++ show f
    putStrLn $ "b = " ++ show b
    putStrLn $ "infiniteList = " ++ (showFirst 100 infiniteList) ++ "..."
    where
    showFirst n list =
        (concat $ map (++ ",") $ map show $ take n list)

a :: (Num a) => a
a = 1

i :: Integer
i = a + 1

-- we can use a either as a Float or as an Integer
f :: Float
f = a + 1.1

b :: Integer
b =
    a + d -- not the "a" defined above; it is the other one defined below
    where
    a = c + 1
    c = 6
    d = a + c

infiniteList :: [Integer]
infiniteList = -- [1,0,1,0,1,0,1,0,....etc
    a1
    where
    a1 = 1 : a0 -- a depends on b
    a0 = 0 : a1 -- b depends on a
