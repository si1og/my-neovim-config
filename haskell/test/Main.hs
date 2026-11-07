module Main (main) where

import Control.Monad (unless)
import NvimConfig.Pure
import System.Exit (exitFailure)

main :: IO ()
main = do
  let checks =
        [ (translateLeader "<Space>ee" == Just " уу", "lowercase leader translation"),
          (translateLeader " qQ" == Just " йЙ", "uppercase leader translation"),
          (translateLeader "<Space>e<CR>" == Just " у<CR>", "special key is preserved"),
          (translateLeader "gd" == Nothing, "non-leader mapping is ignored"),
          (decodeSession "%Users%ilyasemenov%project.vim" == SessionRef "/Users/ilyasemenov/project" Nothing, "session directory"),
          (decodeSession "%Users%ilyasemenov%project%%feature.vim" == SessionRef "/Users/ilyasemenov/project" (Just "feature"), "session branch"),
          (inputSourceLabel "com.apple.keylayout.RussianWin" == "RU", "Russian input source"),
          (inputSourceLabel "com.apple.keylayout.US" == "EN", "English input source")
        ]
  mapM_ report checks
  unless (all fst checks) exitFailure
  where
    report (passed, name) = putStrLn $ (if passed then "PASS " else "FAIL ") ++ name
