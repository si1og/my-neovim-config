{-# LANGUAGE TemplateHaskell #-}

module NvimConfig.Plugin (plugin) where

import Data.Maybe (fromMaybe)
import Neovim
import NvimConfig.Pure

translateLeaderRpc :: String -> Neovim () String
translateLeaderRpc = pure . fromMaybe "" . translateLeader

decodeSessionRpc :: String -> Neovim () [String]
decodeSessionRpc path =
  let session = decodeSession path
   in pure [sessionDirectory session, fromMaybe "" (sessionBranch session)]

inputSourceLabelRpc :: String -> Neovim () String
inputSourceLabelRpc = pure . inputSourceLabel

$(pure [])

plugin :: Neovim () NeovimPlugin
plugin =
  wrapPlugin
    Plugin
      { environment = (),
        exports =
          [ $(function "NvimConfigTranslateLeader" 'translateLeaderRpc) Sync,
            $(function "NvimConfigDecodeSession" 'decodeSessionRpc) Sync,
            $(function "NvimConfigInputSourceLabel" 'inputSourceLabelRpc) Sync
          ]
      }
