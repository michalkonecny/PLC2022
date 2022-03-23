{-# OPTIONS_GHC -fno-warn-missing-signatures -fno-warn-unused-do-bind #-}
module PlaylistMixer where

import Control.Concurrent
import Control.Concurrent.STM

import Text.Printf
import System.IO (hSetBuffering, stdout, BufferMode(..))

main :: IO ()
main =
  do
  initialiseIO
  putStrLn "main starting"
  playlistTV <- atomically (newTVar (Playlist [] 0))
  forkIO (keepAdding playlistTV)
  forkIO (keepMixing playlistTV)
  forkIO (keepReportingLengthChanges playlistTV)
  threadDelay (4*second)
  putStrLn "main finishing"

second = 1000000 -- microseconds

initialiseIO = hSetBuffering stdout LineBuffering 
    -- ensure any console output is shown line by line, 
    -- not mixing characters output by multiple threads in a single line

data Item = Item {
    item_id :: Int
  , item_length :: Float
  }

instance Show Item where
  show (Item id len) = printf "Item %d (%.2f)" id len

data Playlist = Playlist {
    playlist_items :: [Item]
  , playlist_length :: Float
  }

instance Show Playlist where
  show (Playlist items len) = printf "%s (%.2f)" (show items) len


printPlaylist sourceName playlistTV =
  do
  playlist <- atomically (readTVar playlistTV)
  printf "%s: playlist = %s\n" sourceName (show playlist)

keepAdding :: TVar Playlist -> IO ()
keepAdding playlistTV = 
  addingFrom 1
  where
  addingFrom i =
    do
    addWithI i
    printPlaylist "adder" playlistTV
    threadDelay second
    addingFrom (i + 1)

  addWithI i =
    atomically $  
      do
      playlist <- readTVar playlistTV
      writeTVar playlistTV (addNewItem playlist)
    where
    addNewItem playlist = 
      playlist { 
        playlist_items = newItem : playlist_items playlist
      , playlist_length = playlist_length playlist + item_length newItem
      }
    newItem = 
      Item { 
        item_id = i, 
        item_length = fromIntegral (13 + 7*(i `mod` 4)) 
      }


keepMixing :: TVar Playlist -> IO ()
keepMixing playlistTV =
  mixFrom 1
  where
  mixFrom i =
    do
    mixWithI i playlistTV
    printPlaylist "mixer" playlistTV
    threadDelay (second `div` 3)
    mixFrom (i + 1)

mixWithI :: Int -> TVar Playlist -> IO ()
mixWithI i playlistTV =
  atomically $
    do
    playlist <- readTVar playlistTV
    let newPlaylist = playlist { playlist_items = shuffle (playlist_items playlist) }
    writeTVar playlistTV newPlaylist
  where
  shuffle [] = [] -- if empty list, do nothing
  shuffle [item] = [item] -- if one-element list, do nothing
  shuffle list = 
    drop j list ++ take j list -- shuffle once
    where
    j = 1 + (i `mod` (length list - 1)) -- 0 < j < length list
    
keepReportingLengthChanges playlistTV =
  do
  playlist <- atomically (readTVar playlistTV)
  loop (playlist_length playlist)
  where
  loop oldLength =
    do
    newLength <- waitUntilNewLength oldLength
    putStrLn "length updated"
    loop newLength

  waitUntilNewLength oldLength =
    atomically $
      do
      (Playlist items len) <- readTVar playlistTV
      return len
