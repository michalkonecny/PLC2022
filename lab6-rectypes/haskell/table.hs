module Table where

-- define type of HTML trees:
data HTMLFragment
    = HTMLFrElem -- tree node variant one
      { 
        htf_elem :: HTMLElement, 
        htf_children :: [HTMLFragment] -- recursion
      }
    | HTMLFrText -- tree node variant two
      {
        htf_text :: String
      }
    deriving (Show, Eq)

data HTMLElement
    = TABLE | TBODY | TR | TD -- and many others
    deriving (Show, Eq)

countNodes :: HTMLFragment -> Integer
countNodes (HTMLFrText _) = 1
countNodes (HTMLFrElem _ children) =
    1 + sum (map countNodes children)

-- it's a bit tedious to define a table literally:
htmlBoard1 =
    HTMLFrElem TABLE
        -- one child:
        [HTMLFrElem TBODY
            -- three children:
            [HTMLFrElem TR
                -- three children:
                [HTMLFrElem TD [HTMLFrText "X"],
                 HTMLFrElem TD [HTMLFrText "X"],
                 HTMLFrElem TD [HTMLFrText "O"]
                ]
            ,HTMLFrElem TR
                -- three children:
                [HTMLFrElem TD [HTMLFrText "O"],
                 HTMLFrElem TD [HTMLFrText "B"],
                 HTMLFrElem TD [HTMLFrText "X"]
                ]
            ,HTMLFrElem TR
                -- three children:
                [HTMLFrElem TD [HTMLFrText "O"],
                 HTMLFrElem TD [HTMLFrText "B"],
                 HTMLFrElem TD [HTMLFrText "B"]
                ]
            ]
        ]

-- a much more convenient way to define the same table:
htmlBoard2 =
    makeTable [["X","X","O"],["O","B","X"],["O","B","B"]]

makeTable rows =
    HTMLFrElem TABLE
        [HTMLFrElem TBODY
            [HTMLFrElem TR
                [HTMLFrElem TD [HTMLFrText cellValue]
                | -- list comprehension: mapping
                    cellValue <- row
                ]
            | -- list comprehension: mapping
                row <- rows
            ]
        ]

aliasingTree =
    HTMLFrElem TR [td,td,td]
        where
        td = HTMLFrElem TD [HTMLFrText "B"]

-- the following defines a table that has an identical
-- table in its cell...ever seen two facing parallel mirrors?
infiniteTree =
    HTMLFrElem TABLE 
        [HTMLFrElem TBODY
            [HTMLFrElem TR
                [HTMLFrElem TD 
                    [HTMLFrText "B",
                     infiniteTree]]]] -- recursion!

main =
    do
    putStrLn $ show (htmlBoard1 == htmlBoard2)
    putStrLn $ "countNodes htmlBoard1 = " ++ 
                (show $ countNodes htmlBoard1)
    putStrLn $ "countNodes aliasingTree = " ++ 
                (show $ countNodes aliasingTree)
    