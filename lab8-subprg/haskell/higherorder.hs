module HigherOrder where

import Data.List

main =
    do
    printWithLabel "all" strings
    printWithLabel "filter long" (filter isLong strings)
    printWithLabel "filter hi" (filter startsWithHi strings)
    printWithLabel "filter hi+long (1)" (filter (\ s -> isLong s && startsWithHi s) strings)
    printWithLabel "filter hi+long (2)" (filterTwo isLong startsWithHi strings)
    printWithLabel "ok fns"
        (length $
            findOKfns fnAcceptsHilarious
                [isLong, -- not ok, hilarious is not long enough
                 startsWithHi, -- ok
                 const True, -- ok, accepts anything
                 const False, -- not ok, rejects everything
                 (== "hilarious") -- ok, just about
                ]
        )
    printWithLabel "ok fn indices"
        (
            findOKfnIndices fnAcceptsHilarious
                [isLong, -- not ok, hilarious is not long enough
                 startsWithHi, -- ok
                 const True, -- ok, accepts anything
                 const False, -- not ok, rejects everything
                 (== "hilarious") -- ok, just about
                ]
        )
    where
    printWithLabel label val = putStrLn $ label ++ ": " ++ (show val)

strings :: [String]
strings = 
    ["hi dear", "referential", "hippie", "hilariousness"]

fns :: [(String -> Bool)]
fns = [isLong, startsWithHi, isLong]

isLong :: String -> Bool
isLong s = 
    (length s) > 10

startsWithHi :: String -> Bool
startsWithHi s =
    isPrefixOf "hi" s

filterTwo ::
    (a -> Bool) -> -- first condition
    (a -> Bool) -> -- second condition
    [a] -> -- list to be filtered
    [a] -- result list
filterTwo cond1 cond2 list =
    filter cond1ANDcond2 list
    where
    cond1ANDcond2 s = cond1 s && cond2 s

fnAcceptsHilarious ::
    (String -> Bool) -> -- a string tester function
    Bool -- result of calling the above function with parameter "hilarious"
fnAcceptsHilarious fn =
    fn "hilarious" == True

findOKfns ::
    ((String -> Bool) -> Bool) -> -- a testing "super" function
    [(String -> Bool)] -> -- list of functions
    [(String -> Bool)] -- those that satisfy the testing fn
findOKfns fnOK fnList =
    filter fnOK fnList

findOKfnIndices ::
    ((String -> Bool) -> Bool) -> -- a testing "super" function
    [(String -> Bool)] -> -- list of functions
    [Int] -- indices of those that satisfy the testing fn
findOKfnIndices fnOK fnList =
    [] -- TODO: optional TASK 8.4.(b) and Q6

