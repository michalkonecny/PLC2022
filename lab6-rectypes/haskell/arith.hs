module Arith where

-- define a type of arithmetic expression trees:
data ArithExp -- type name ArithExp defined
    = ArithExpBinary -- constructor for a tree node, variant one
      {
        ae_Op :: BinaryOp, -- component name :: component type
        ae_Left :: ArithExp,
        ae_Right :: ArithExp
      }
    | ArithExpInt -- constructor for a tree node, variant two
      {
        ae_Int :: Integer
      }
    | ArithExpDouble -- constructor for a tree node, variant two
      {
        ae_Double :: Double
      }
    deriving (Eq)

data BinaryOp = BinaryTimes | BinaryPlus | BinaryPower
    deriving (Eq)
    
-- how to print these expressions:
instance (Show ArithExp) where
    show (ArithExpBinary op left right) =
        "(" ++ show left ++ " " ++ show op ++ " " ++ show right ++ ")"
    show (ArithExpInt n) = show n
    show (ArithExpDouble d) = show d

instance (Show BinaryOp) where
    show BinaryTimes = "*"
    show BinaryPlus = "+"
    show BinaryPower = "^"

countNodes :: ArithExp -> Int
    -- the above declares the type of the function
    -- (parameter of type ArithExp, result of type Int)
countNodes (ArithExpInt _) = 1
countNodes (ArithExpDouble _) = 1
countNodes (ArithExpBinary _ subExpLeft subExpRight) =
    1 + (countNodes subExpLeft) + (countNodes subExpRight)

-- function to increment all numbers in an expression by 1:
incrAllNumbers :: ArithExp -> ArithExp
incrAllNumbers (ArithExpInt n) = 
    ArithExpInt (n + 1)
incrAllNumbers (ArithExpDouble d) = 
    ArithExpDouble (d + 1)
incrAllNumbers (ArithExpBinary op l r) = 
    ArithExpBinary op (incrAllNumbers l) (incrAllNumbers r)

-- exp1 = 2 * (3 + 0.5):
exp1 =
    ArithExpBinary BinaryTimes
        (ArithExpInt 2)
        (ArithExpBinary BinaryPlus
            (ArithExpInt 3)
            (ArithExpDouble 0.5))

-- exp2 = exp1 ^ exp1
exp2 =
    ArithExpBinary BinaryPower exp1 exp1

main =
    do
    printExpInfo "exp1" exp1
    printExpInfo "exp1 all numbers incremented" (incrAllNumbers exp1)
    printExpInfo "exp2" exp2
    printExpInfo "exp2 all numbers incremented" (incrAllNumbers exp2)
    where
    printExpInfo exprName expr =
        do
        putStrLn "--------"
        putStrLn $ exprName ++ " = "
                    ++ (show $ expr)
        putStrLn $ "countNodes (" ++ exprName ++ ") = "
                    ++ (show $ countNodes expr)
--         putStrLn $ "checkArithExp (" ++ exprName ++ ") = "
--                     ++ (show $ checkArithExp expr)
        putStrLn "--------"
    
-- OPTIONAL PART:
    
-- auxiliary enumerated type:
data ArithExpNumberType = ENT_INT | ENT_DOUBLE

-- function to check whether all exponents are integers:
checkArithExp :: ArithExp -> Bool
checkArithExp expression =
    -- return the first component, discard the other:
    fst (checkArithExpGiveType expression)
    where
    -- auxiliary function that checks expression and at the same
    -- time works out whether its value is an integer or a float
    checkArithExpGiveType :: ArithExp -> (Bool, ArithExpNumberType)
    checkArithExpGiveType (ArithExpInt _) = (True, ENT_INT)
    checkArithExpGiveType (ArithExpDouble _) = (True, ENT_DOUBLE)
    checkArithExpGiveType (ArithExpBinary BinaryPower base exponent) =
        (baseOK && expOK && isInt expType, baseType)
        where
        (baseOK, baseType) = checkArithExpGiveType base
        (expOK, expType) = checkArithExpGiveType exponent
        isInt ENT_INT = True
        isInt _ = False
    checkArithExpGiveType (ArithExpBinary _ l r) =
        undefined -- OPTIONAL TASK: COMPLETE THIS LINE
        where
        (lOK, lType) = checkArithExpGiveType l
        (rOK, rType) = checkArithExpGiveType r
        combineTypes ENT_INT ENT_INT = ENT_INT
        combineTypes _ _ = ENT_DOUBLE
        -- only if both are integers, the result is an integer

