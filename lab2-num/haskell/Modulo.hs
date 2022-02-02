module Modulo where

newtype Mod10 = Mod10 Int deriving (Eq, Ord)

instance Num Mod10 where
  fromInteger n = Mod10 (fromInteger (n `mod` 10))
  signum (Mod10 n) = Mod10 ((signum n) `mod` 10)
  abs (Mod10 n) = Mod10 n
  negate (Mod10 n) = Mod10 ((negate n) `mod` 10)
  (Mod10 n1) + (Mod10 n2) = Mod10 ((n1 + n2) `mod` 10)
  (Mod10 n1) * (Mod10 n2) = Mod10 ((n1 * n2) `mod` 10)
  
instance Show Mod10 where
  show (Mod10 n) = "[" ++ show n ++ "]"

instance Read Mod10 where
  readsPrec prec s =
    case (readsPrec prec s) of -- parse as Int
       [] -> []
       ((n,remainder):_) -> 
           [(Mod10 (n `mod` 10), remainder)]

-- to test the parsing, run "ghci Modulo.hs" and then type: readsPrec 1  "-1a" :: [(Mod10, String)]

-- inferred type: expr :: (Num t) => t -> t -> t 
expr a b = a * a + b

a = expr 10 10 :: Int
b = expr 10 10 :: Double
c = expr 10 10 :: Mod10


-- inferred type: expr2 :: Int -> Int -> Int
-- (when b is of type Int also a is of type Int)
expr2 a b = a * a + (b :: Int)

