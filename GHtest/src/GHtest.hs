{-# OPTIONS_GHC -fwarn-missing-signatures #-}

{- 23.07.2017 11:52:53
   11.08.2017 00:01:59
use 
this program chosen to convert to 'stack build'
as
1) it compiles under geany 1.30.1
2) uses some imports 
3) does something when executed - though 
4) Lint has some interesting suggestions
-}
module Main where

import System.Environment
import System.IO
import System.Process
import Test.QuickCheck
import Test.QuickCheck.Monadic
import Lib

main = do
  putStrLn ":: Test Gnu <=> Haskell implementations ::"
  (arg:_) <- getArgs
  putStrLn $ "Testing: " ++ show arg
  putStrLn $ "Gnu cmd: " ++ arg ++ "  Haskell cmd: H" ++ arg ++ ".hs"
  outGnu <- runGnuCmd arg "y"
  putStrLn $ "5 Gnu:\n" ++ unlines (take 5 outGnu)
  outHas <- runHasCmd arg "y"
  putStrLn $ "5 Has:\n" ++ unlines (take 5 outHas)
  quickCheck (ioPropOne arg)
  return ()

--ioPropOne :: String -> ioProperty
ioPropOne cmd args =
  monadicIO $ do
    g <- run (runGnuCmd cmd ("--\"" ++ args ++ "\""))
    h <- run (runHasCmd cmd ("--\"" ++ args ++ "\""))
    assert (take 100 g == take 100 h)

runGnuCmd :: String -> String -> IO [String]
runGnuCmd cmd args = do
  (_i, o, _e, _hand) <-
    runInteractiveCommand ("/usr/bin/" ++ cmd ++ " " ++ args)
  hSetBinaryMode o True
  output <- hGetContents o
  return (lines output)

runHasCmd :: String -> String -> IO [String]
runHasCmd cmd args = do
  (_i, o, _e, _hand) <-
    runInteractiveCommand
      ("/home/puzzleduck/Dropbox/x/haskell/files/hls/H" ++ cmd ++ " " ++ args)
  hSetBinaryMode o True
  output <- hGetContents o
  return (lines output)
