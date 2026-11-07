module Session
  ( SessionRef (..),
    decodeSession,
  )
where

import System.FilePath (takeBaseName)

data SessionRef = SessionRef
  { sessionDirectory :: FilePath,
    sessionBranch :: Maybe String
  }
  deriving (Eq, Show)

decodeSession :: FilePath -> SessionRef
decodeSession path =
  let (encodedDirectory, branch) = splitBranch (takeBaseName path)
   in SessionRef
        { sessionDirectory = fmap decodePathCharacter encodedDirectory,
          sessionBranch = branch
        }

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
