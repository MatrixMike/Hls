module Lib
    ( someFunc
      {-versionText-}
      {-stripQuotes-}
      {-getUsername  -}
    ) where
import System.Environment
{-import System.Console.Terminfo.Base -}
import Data.List

someFunc :: IO ()
someFunc = do
--    term <- setupTermFromEnv
    args <- getArgs
--    let options = processArgs args defaultWhoami
    putStrLn    "someFunc 4"
    putStrLn    "more text"
    processArgs args defaultWhoami
    {-getUsername-}

stripQuotes :: String -> String
stripQuotes ('"':xs) =
  if last xs == '"'
    then init xs
    else '"' : xs
stripQuotes xs = xs

showVersion :: WhoamiOptions -> String
showVersion opts
  | (displayVersion opts) = concat (intersperse "\n" versionText)
  | otherwise = ""
  
processArgs :: [String] -> WhoamiOptions -> WhoamiOptions
processArgs [] opts = opts
processArgs (x:xs) opts =
  case x of
    "--help" -> processArgs xs opts {displayHelp = True}
    "--version" -> processArgs xs opts {displayVersion = True}
    _ -> processArgs xs opts
 
defaultWhoami :: WhoamiOptions
defaultWhoami = WhoamiOptions False False

data WhoamiOptions = WhoamiOptions
  { displayHelp :: Bool
  , displayVersion :: Bool
  } deriving (Show, Eq)
  
getUsername :: IO String
getUsername = do
  e <- getEnvironment
  return (((snd . head) (filter (\x -> (fst x) == "USER") e)) ++ "\n")

versionText :: [String]
versionText =
  [ "Hwhoami (Haskell implementation of GNU whoami) 1.0"
  , "derrived from: whoami (GNU coreutils) 8.23"
  , "Copyright (C) 2014 Free Software Foundation, Inc."
  , "License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>."
  , "This is free software: you are free to change and redistribute it."
  , "There is NO WARRANTY, to the extent permitted by law."
  , "Written by Richard Mlynarik."
  , "Ported by PuZZleDucK.\n"
  ]


