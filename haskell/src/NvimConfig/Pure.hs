module NvimConfig.Pure
  ( SessionRef (..),
    decodeSession,
    inputSourceLabel,
    translateLeader,
  )
where

import Data.Char (toLower, toUpper)
import Data.List (isInfixOf, stripPrefix)
import System.FilePath (takeBaseName)

data SessionRef = SessionRef
  { sessionDirectory :: FilePath,
    sessionBranch :: Maybe String
  }
  deriving (Eq, Show)

translateLeader :: String -> Maybe String
translateLeader lhs = do
  suffix <- stripPrefix "<Space>" lhs `orElse` stripPrefix " " lhs
  let translated = translateKeys suffix
  if translated == suffix then Nothing else Just (' ' : translated)

decodeSession :: FilePath -> SessionRef
decodeSession path =
  let (encodedDirectory, branch) = splitBranch (takeBaseName path)
   in SessionRef
        { sessionDirectory = fmap decodePathCharacter encodedDirectory,
          sessionBranch = branch
        }

inputSourceLabel :: String -> String
inputSourceLabel source
  | contains "russian" || contains "cyrillic" = "RU"
  | contains "abc" || contains ".us" || contains "british" = "EN"
  | otherwise = fmap toUpper . take 3 . reverse . takeWhile (/= '.') . reverse $ source
  where
    lowered = fmap toLower source
    contains needle = needle `isInfixOf` lowered

orElse :: Maybe a -> Maybe a -> Maybe a
orElse first second = case first of
  Just value -> Just value
  Nothing -> second

splitBranch :: String -> (String, Maybe String)
splitBranch value = case breakOnDoublePercent value of
  Just (directory, branch) -> (directory, Just branch)
  Nothing -> (value, Nothing)

breakOnDoublePercent :: String -> Maybe (String, String)
breakOnDoublePercent = go []
  where
    go _ [] = Nothing
    go _ [_] = Nothing
    go prefix ('%' : '%' : rest) = Just (reverse prefix, rest)
    go prefix (character : rest) = go (character : prefix) rest

decodePathCharacter :: Char -> Char
decodePathCharacter '%' = '/'
decodePathCharacter character = character

translateCharacter :: Char -> Char
translateCharacter character = case lookup character layout of
  Just translated -> translated
  Nothing -> character

translateKeys :: String -> String
translateKeys [] = []
translateKeys ('<' : rest) = case break (== '>') rest of
  (key, '>' : suffix) -> '<' : key ++ '>' : translateKeys suffix
  _ -> '<' : translateKeys rest
translateKeys (character : rest) = translateCharacter character : translateKeys rest

layout :: [(Char, Char)]
layout =
  zip "qwertyuiopasdfghjklzxcvbnm" "йцукенгшщзфывапролдячсмить"
    ++ zip "QWERTYUIOPASDFGHJKLZXCVBNM" "ЙЦУКЕНГШЩЗФЫВАПРОЛДЯЧСМИТЬ"
