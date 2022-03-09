module PlaylistVars where

import Text.Printf

data Product
    = Product
        {
          product_name :: String
        , product_brand :: String
        }
    deriving (Eq)

instance Show Product where 
    show (Product name brand) = 
        printf "%s by %s" name brand

data Item
    = Piece
        {
            item_name :: String,
            item_performer :: String,
            item_length_secs :: Float
        }
    | Advert
        {
            item_product :: Product,
            item_length_secs :: Float
        }
    deriving (Eq)

isAdvert (Advert _ _) = True
isAdvert _ = False

itemOK (Piece _ _ len) = 0 < len && len < 36000
itemOK (Advert _ len) = 0 < len && len < 120

instance (Show Item) where
    show (Piece name performer len) =
        printf "%s by %s (%.1fs)" name performer len
    show (Advert product len) =
        printf "Advert for %s (%.1fs)" (show product) len

playlist1 = [piece1, advert1, piece2]
    where
    piece1  = Piece "Moonlight" "C. Arrau"       (17*minutes+26*seconds)
    piece2  = Piece "Pathetique" "D. Barenboim"  (16*minutes+49*seconds)
    advert1 = Advert (Product "chocolate" "Yummm")          (15*seconds)
    minutes = 60*seconds -- TASK: identify the scope of variable "minutes"
    seconds = 1

length1 = sum [ item_length_secs item | item <- playlist1 ]
    -- OPTIONAL TASK: identify the scope of variable "item" above

main :: IO ()
main =
    do
    printf "playlist1 = %s\n" (show playlist1)
    printf "lenght1 = %s\n" (show length1)

