module Main (main) where

import Neovim (NeovimConfig (..), defaultConfig, neovim)
import qualified NvimConfig.Plugin as Plugin

main :: IO ()
main =
  neovim
    defaultConfig
      { plugins = plugins defaultConfig ++ [Plugin.plugin]
      }
