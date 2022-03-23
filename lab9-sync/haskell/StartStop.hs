{-# OPTIONS_GHC -fno-warn-missing-signatures -fno-warn-unused-do-bind #-}
module StartStop where

import Control.Concurrent
import Control.Concurrent.STM

main =
    do
    putStrLn "main starting"
    stateTV <- atomically $ newTVar initState
    forkIO $ printNumbersFrom 0 stateTV
    forkIO $ switchOnOff RUNNING stateTV
    threadDelay $ run_duration * second
    putStrLn "main finishing"
    -- the forked threads will be aborted automatically now

run_duration = 10 -- seconds
second = 1000000 -- microseconds

data State = PAUSED | RUNNING

initState = RUNNING

printNumbersFrom :: Int -> TVar State -> IO ()
printNumbersFrom n stateTV =
    do
    waitTillNotPaused stateTV
    -- print current number:
    putStrLn $ show n
    -- wait for 0.2 seconds:
    threadDelay $ second `div` 5 -- integer division
    -- call itself for the next number:
    printNumbersFrom (n + 1) stateTV

waitTillNotPaused :: TVar State -> IO ()
waitTillNotPaused stateTV =
    atomically $ -- = undo and retry the following if there is a conflict:
        do
        -- read the shared state:
        state <- readTVar stateTV
        case state of
            PAUSED -> retry -- retry the critical section,
                            -- but not immediately - wait until stateTV is updated
            RUNNING -> return () -- ie, finish this critical section

switchOnOff :: State -> TVar State -> IO ()
switchOnOff state stateTV =
    do
    -- update state:
    atomically $ writeTVar stateTV state
        -- atomically = will retry assignment until no conflict
    -- wait 1 second:
    threadDelay $ 1000000
    -- call itselt with flipped state:
    case state of
        RUNNING -> switchOnOff PAUSED stateTV
        PAUSED -> switchOnOff RUNNING stateTV
