module Main where

import System.IO (hSetBuffering, stdout, BufferMode(..))
    -- We need these functions to set the console buffering mode.

import Data.Char (toUpper)

main :: IO ()
main =
    do
    hc <- getElement
    putStrLn ("You entered: " ++ show hc)

data HouseCategory = DETACHED | SEMIDETACHED | TERRACED
    deriving (Show, Read)

type ElementType = HouseCategory
elementTypeName :: String
elementTypeName = "house category"
-- type ElementType = Integer
-- elementTypeName = "integer"

{-
  `getElement'
  queries the user for one element until the user types something
  that can be interpreted as the correct type of element (eg integer)
-}
getElement :: IO ElementType
getElement =
    do
    hSetBuffering stdout NoBuffering -- print to console in real time, not in batches
    putStr ("Input one " ++ elementTypeName ++ ": ") -- print the prompt
    line <- getLine -- get whatever user types as a string
    case parseElement (map toUpper line) of
         Just element ->
            do
            return element
         Nothing ->
            do
            putStrLn ("Invalid " ++ elementTypeName ++ ", try again")
            getElement -- try again - using recursion

parseElement :: String -> Maybe ElementType
parseElement line =
    case reads line of
    -- [Attempts to parse the string in `line' as ElementType.
    -- The result is a list containing all possible interpretations
    -- of the string in `line' as an element of ElementType.
    -- The list will be matched against the following patterns:]
        -- [pattern 1:]
        [(n,"")] -> -- found one interpretation, call it "n"
                -- [The second component is the remainder of the string
                -- after parsing.]
            Just n
            -- [pattern 2:]
        _ -> -- no valid interpretation of the line as an element
        -- [Underscore _ here means "anything - its value does not matter". ]
            Nothing


-- getHouseCategoryCode hc =
-- --     | hc == DETACHED = "det"
--     case hc of
--         DETACHED -> "det"
--         SEMIDETACHED -> "sem"
--         TERRACED -> "ter"
--         _ -> ""

-- getHouseCategoryCode DETACHED = "det"
-- getHouseCategoryCode SEMIDETACHED = "sem"
-- getHouseCategoryCode TERRACED = "ter"
