{-# OPTIONS_GHC -fwarn-missing-signatures #-}

-- need to add functions that are to be available from repl between () here
module Lib
    ( someFunc, anotherFunc
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

anotherFunc :: IO ()
anotherFunc = putStrLn "should be visible from repl"

