module PlaylistTree where

import Text.Printf

-- A playlist is a synonym for a list of items

type Playlist = [Item]

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
    | Sublist
        {
            item_sublist :: [Item]
        }
    deriving (Eq)

instance (Show Item) where
    show (Piece name performer len) =
        printf "%s by %s (%.1fs)" name performer len
    show (Advert product len) =
        printf "Advert for %s (%.1fs)" (show product) len
    show (Sublist items) = 
        show items

countItemsInItem (Sublist items) = countItemsInList items
countItemsInItem _ = 1 :: Int

countItemsInList items = sum (map countItemsInItem items)

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


piece1 = Piece "Moonlight" "C. Arrau" (17*60+26)
piece2 = Piece "Pathetique" "D. Barenboim" (16*60+49)
advert1 = Advert (Product "chocolate" "Yumm") 15
advert2 = Advert (Product "crisps" "Yumm") 15

playlist1 = [piece1, piece2]
playlist2 = [Sublist playlist1, advert1, Sublist playlist1]

addItemAtStartDeep ad (Sublist sublist_items : remaining_items) = 
    (Sublist (addItemAtStartDeep ad sublist_items)) : remaining_items
addItemAtStartDeep ad items = 
    ad : items

main :: IO ()
main =
    do
    printf "playlist1 = %s\n" (show playlist1)
    printf "\n"
    printf "countItemsInList playlist1 = %s\n" (show (countItemsInList playlist1))
    printf "\n"
    printf "playlist2 = %s\n" (show playlist2)
    printf "\n"
    printf "countItemsInList playlist2 = %s\n" (show (countItemsInList playlist2))
    printf "\n"
    printf "addAdvertAtStart advert2 playlist1 = %s\n" (show (addItemAtStartDeep advert2 playlist1))
    printf "\n"
    printf "addAdvertAtStart advert2 playlist2 = %s\n" (show (addItemAtStartDeep advert2 playlist2))
    printf "\n"
    printf "countItemsInList (addAdvertAtStart advert1 playlist2) = %s\n" (show (countItemsInList (addItemAtStartDeep advert2 playlist2)))
    
