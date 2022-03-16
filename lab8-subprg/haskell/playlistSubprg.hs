module PLaylistSubprg where

import Text.Printf

--------------------------------------------------
-- Record type Product
--------------------------------------------------

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

--------------------------------------------------
-- Union type Item
--------------------------------------------------

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

instance (Show Item) where
    show (Piece name performer len) =
        printf "%s by %s (%.1fs)" name performer len
    show (Advert product len) =
        printf "Advert for %s (%.1fs)" (show product) len

--------------------------------------------------
-- playlist processing
--------------------------------------------------

getPlaylistLength :: [Item] -> Float
getPlaylistLength playlist = sum (map item_length_secs playlist)

--------------------------------------------------
-- type PlaylistProgress and its methods
--------------------------------------------------

data PlaylistProgress = 
    PlaylistProgress 
    {
        playlist :: [Item],
        currentItemIndex :: Int
    }

startProgress :: [Item] -> PlaylistProgress
startProgress items = PlaylistProgress items 0

getCurrentItem :: PlaylistProgress -> Item
getCurrentItem (PlaylistProgress items index) =
    items !! index

getRemainingLength :: PlaylistProgress -> Float
getRemainingLength (PlaylistProgress items index) = 
    getPlaylistLength remainingItems
    where
    remainingItems = drop index items -- the list without the first index-many items

shiftToNextItem :: PlaylistProgress -> Maybe PlaylistProgress
shiftToNextItem (PlaylistProgress items index) = 
    if index + 1 < length items 
        then Just (PlaylistProgress items (index + 1))
        else Nothing

processPlaylist :: (PlaylistProgress -> IO ()) -> [Item] -> IO ()
processPlaylist action items =
    makeProgress (startProgress items)
    where
    makeProgress progress =
        case shiftToNextItem progress of
            Just nextProgress -> 
                do -- sequence of imperative programs
                action progress -- action for the current item
                makeProgress nextProgress -- continue recursively for the remaining items
            Nothing -> 
                action progress -- the last item

getPlaylistLengthTwoItems items =
    case shiftToNextItem progress of
        Just nextProgress -> Just $
            (item_length_secs (getCurrentItem progress)) 
            + 
            (item_length_secs (getCurrentItem nextProgress)) 
        Nothing -> Nothing
    where
    progress = startProgress items

--------------------------------------------------
-- Main
--------------------------------------------------

reportCurrentItem :: PlaylistProgress -> IO ()
reportCurrentItem playlistProgress =
    do
    printf "Next item = %s \n" (show (getCurrentItem playlistProgress))
    printf "  remaining play time = %.2f \n" (getRemainingLength playlistProgress)

main :: IO ()
main =
    do
    let piece1 = Piece "Moonlight" "C. Arrau" (17*60+26)
    let piece2 = Piece "Pathetique" "D. Barenboim" (16*60+49)
    let advert1 = Advert (Product "Bounty" "Mars") 15

    let playlist1 = [piece1, advert1, piece2]

    printf "playlist1 = %s\n" (show playlist1)
    printf "getPlaylistLength playlist1 = %.2f\n" (getPlaylistLength playlist1)

    case getPlaylistLengthTwoItems playlist1 of
        Just length2 ->
            printf "getPlaylistLengthTwoItems playlist1 = %.2f\n" length2
        Nothing ->
            pure () -- ie do nothing

    putStrLn ""

    processPlaylist reportCurrentItem playlist1
