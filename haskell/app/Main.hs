module Main (main) where

import Neovim (NeovimConfig (..), defaultConfig, neovim)
import PluginRegistry (pluginRegistry)

main :: IO ()
main =
  neovim
    defaultConfig
      { plugins = plugins defaultConfig ++ pluginRegistry
      }
