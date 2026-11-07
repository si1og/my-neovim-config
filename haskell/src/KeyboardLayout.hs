module KeyboardLayout
  ( translateKeys,
    translateLeader,
  )
where

import Data.List (stripPrefix)

translateLeader :: String -> Maybe String
translateLeader lhs = do
  suffix <- stripPrefix "<Space>" lhs `orElse` stripPrefix " " lhs
  let translated = translateKeys suffix
  if translated == suffix then Nothing else Just (' ' : translated)

translateKeys :: String -> String
translateKeys [] = []
translateKeys ('<' : rest) = case break (== '>') rest of
  (key, '>' : suffix) -> '<' : key ++ '>' : translateKeys suffix
  _ -> '<' : translateKeys rest
translateKeys (character : rest) = translateCharacter character : translateKeys rest

translateCharacter :: Char -> Char
translateCharacter character = case lookup character layout of
  Just translated -> translated
  Nothing -> character

layout :: [(Char, Char)]
layout =
  zip "qwertyuiopasdfghjklzxcvbnm" "йцукенгшщзфывапролдячсмить"
    ++ zip "QWERTYUIOPASDFGHJKLZXCVBNM" "ЙЦУКЕНГШЩЗФЫВАПРОЛДЯЧСМИТЬ"

orElse :: Maybe a -> Maybe a -> Maybe a
orElse first second = case first of
  Just value -> Just value
  Nothing -> second
