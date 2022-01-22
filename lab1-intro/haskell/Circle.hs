{-# OPTIONS_GHC -fno-warn-type-defaults  -fno-warn-missing-signatures #-}
module Main where

-- import System.Environment (getArgs)

main =
  do
  -- [sizeS] <- getArgs
  let sizeS = "15"
  sequence_ (map putStrLn (circleLines (read sizeS)))

circleLines :: Integer -> [String]
circleLines size =
  map (circleLine size) [1..size]

circleLine :: Integer -> Integer -> String
circleLine size i =
  map (circleChar size i) [1..(size*2)]

circleChar :: Integer -> Integer -> Integer -> Char
circleChar size i jj =
  if shouldPaint then '*' else ' '
  where
  shouldPaint =
    shouldPaintS size
  shouldPaintS s =
    abs (i^2 + j^2 - s^2) <= s+1
    where
    j = jj `div` 2
