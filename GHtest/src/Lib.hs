{-# OPTIONS_GHC -fwarn-missing-signatures #-}
module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"
