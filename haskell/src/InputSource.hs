module InputSource (inputSourceLabel) where

import Data.Char (toLower, toUpper)
import Data.List (isInfixOf)

inputSourceLabel :: String -> String
inputSourceLabel source
  | contains "russian" || contains "cyrillic" = "RU"
  | contains "abc" || contains ".us" || contains "british" = "EN"
  | otherwise = fmap toUpper . take 3 . reverse . takeWhile (/= '.') . reverse $ source
  where
    lowered = fmap toLower source
    contains needle = needle `isInfixOf` lowered
