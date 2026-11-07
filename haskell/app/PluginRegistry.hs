{-# LANGUAGE TemplateHaskell #-}

module PluginRegistry (pluginRegistry) where

import Data.Maybe (fromMaybe)
import InputSource (inputSourceLabel)
import KeyboardLayout (translateKeys, translateLeader)
import Neovim
import Session (SessionRef (..), decodeSession)

translateLeaderRpc :: String -> Neovim () String
translateLeaderRpc = pure . fromMaybe "" . translateLeader

translateKeysRpc :: String -> Neovim () String
translateKeysRpc = pure . translateKeys

decodeSessionRpc :: String -> Neovim () [String]
decodeSessionRpc path =
  let session = decodeSession path
   in pure [sessionDirectory session, fromMaybe "" (sessionBranch session)]

inputSourceLabelRpc :: String -> Neovim () String
inputSourceLabelRpc = pure . inputSourceLabel

$(pure [])

configHelpers :: Neovim () NeovimPlugin
configHelpers =
  wrapPlugin
    Plugin
      { environment = (),
        exports =
          [ $(function "NvimConfigTranslateLeader" 'translateLeaderRpc) Sync,
            $(function "NvimConfigTranslateKeys" 'translateKeysRpc) Sync,
            $(function "NvimConfigDecodeSession" 'decodeSessionRpc) Sync,
            $(function "NvimConfigInputSourceLabel" 'inputSourceLabelRpc) Sync
          ]
      }

pluginRegistry :: [Neovim () NeovimPlugin]
pluginRegistry = [configHelpers]
