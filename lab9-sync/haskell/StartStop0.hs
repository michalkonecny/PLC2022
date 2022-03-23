{-# OPTIONS_GHC -fno-warn-missing-signatures -fno-warn-unused-do-bind #-}
module StartStop0 where

import Control.Concurrent

data State = PAUSED | RUNNING

main :: IO ()
main =
    do
    putStrLn "main starting"
    forkIO $ printNumbersFrom 0
    forkIO $ switchOnOff RUNNING
    threadDelay $ run_duration * second
    putStrLn "main finishing"
    -- the forked threads will be aborted automatically now

run_duration = 10 -- seconds
second = 1000000 -- microseconds

printNumbersFrom :: Int -> IO ()
printNumbersFrom n =
    do
    -- print current number:
    putStrLn $ show n
    -- wait for 0.2 seconds:
    threadDelay $ second `div` 5 -- integer division
    -- call itself for the next number:
    printNumbersFrom (n + 1)

switchOnOff :: State -> IO ()
switchOnOff state =
    do
    -- update state:
    putStrLn (case state of PAUSED -> "Pause!"; RUNNING -> "Resume!")
    -- wait 1 second:
    threadDelay 1000000
    -- call itselt with flipped state:
    case state of
        RUNNING -> switchOnOff PAUSED
        PAUSED -> switchOnOff RUNNING
