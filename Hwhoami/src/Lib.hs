module Lib
    ( someFunc
      {-versionText-}
      {-stripQuotes-}
      {-getUsername  -}
    ) where


someFunc :: IO ()
someFunc = do
    putStrLn    "someFunc 4"
    putStrLn    "more text"

stripQuotes :: String -> String
stripQuotes ('"':xs) =
  if last xs == '"'
    then init xs
    else '"' : xs
stripQuotes xs = xs

{-getUsername :: IO String
getUsername = do
  e <- getEnvironment
  return (((snd . head) (filter (\x -> (fst x) == "USER") e)) ++ "\n")
-}
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
