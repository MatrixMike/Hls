-- Lets try something a little less ambitious, like basename.
module Main where
import System.Environment
import System.Console.Terminfo.Base
import Data.List
import System.FilePath

main :: IO ()
main = do
  term <- setupTermFromEnv
  args <- getArgs
  let options = processArgs args defaultOptions
--  runTermOutput term (termText ("Options: "++(show options)++"\n"))

  runTermOutput term (termText (showError options))
  runTermOutput term (termText (showHelp options))
  runTermOutput term (termText (showVersion options))
--  runTermOutput term (termText (showOutput options)) --if not (help or ver)?
  return ()

--showOutput :: YesOptions -> String

showError :: BasenameOptions -> String
showError opts | (null (targets opts)) = concat (intersperse "\n" errorTest)
               | otherwise = ""

showHelp :: BasenameOptions -> String
showHelp opts | (displayHelp opts) = concat (intersperse "\n" helpText)
              | otherwise = ""

showVersion :: BasenameOptions -> String
showVersion opts | (displayVersion opts) = concat (intersperse "\n" versionText)
                 | otherwise = ""

--arguments are going to have values this time... might need a better solution
processArgs :: [String] -> BasenameOptions -> BasenameOptions
processArgs [] opts = opts
processArgs (x:xs) opts = case x of
  "--help" -> processArgs xs opts{displayHelp = True}
  "--version" -> processArgs xs opts{displayVersion = True}
  _ -> processArgs xs opts{targets = x:(targets opts)}

stripQuotes :: String -> String
stripQuotes ('"':xs) = if last xs == '"' then init xs else ('"':xs)
stripQuotes xs = xs

defaultOptions :: BasenameOptions
defaultOptions = BasenameOptions [] False False "" False False

data BasenameOptions = BasenameOptions { targets :: [String]
                                       , multipleInputs :: Bool
                                       , suppressNewline :: Bool --zero
                                       , removeSuffix :: String
                                       , displayVersion :: Bool
                                       , displayHelp :: Bool } deriving (Show, Eq)


helpText :: [String]
helpText = [ "Usage: basename NAME [SUFFIX]"
           , "  or:  basename OPTION... NAME..."
           , "Print NAME with any leading directory components removed."
           , "If specified, also remove a trailing SUFFIX."
           , "Mandatory arguments to long options are mandatory for short options too."
           , "  -a, --multiple       support multiple arguments and treat each as a NAME"
           , "  -s, --suffix=SUFFIX  remove a trailing SUFFIX; implies -a"
           , "  -z, --zero           end each output line with NUL, not newline"
           , "      --help display this help and exit"
           , "      --version output version information and exit"
           , "Examples:"
           , "  basename /usr/bin/sort          -> \"sort\""
           , "  basename include/stdio.h .h     -> \"stdio\""
           , "  basename -s .h include/stdio.h  -> \"stdio\""
           , "  basename -a any/str1 any/str2   -> \"str1\" followed by \"str2\""
           , "GNU coreutils online help: <http://www.gnu.org/software/coreutils/>\n"
           ]

versionText :: [String]
versionText = [ "Hyes (Haskell implementation of GNU basename) 1.0"
              , "derrived from: basename (GNU coreutils) 8.23"
              , "Copyright (C) 2014 Free Software Foundation, Inc."
              , "License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>."
              , "This is free software: you are free to change and redistribute it."
              , "There is NO WARRANTY, to the extent permitted by law."
              , "Written by David MacKenzie."
              , "Ported by PuZZleDucK.\n"
              ]

errorTest = [ "basename: missing operand"
            , "Try `basename --help' for more information.\n"
            ]
