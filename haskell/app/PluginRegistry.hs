{-# LANGUAGE TemplateHaskell #-}

module PluginRegistry (pluginRegistry) where

import Data.Maybe (fromMaybe)
import FileSearch (binaryFilePatterns)
import InputSource (inputSourceLabel)
import KeyboardLayout (translateKeys, translateLeaders)
import Neovim
import Session (SessionRef (..), decodeSession)

translateLeadersRpc :: [String] -> Neovim () [String]
translateLeadersRpc = pure . translateLeaders

translateKeysRpc :: String -> Neovim () String
translateKeysRpc = pure . translateKeys

decodeSessionRpc :: String -> Neovim () [String]
decodeSessionRpc path =
  let session = decodeSession path
   in pure [sessionDirectory session, fromMaybe "" (sessionBranch session)]

inputSourceLabelRpc :: String -> Neovim () String
inputSourceLabelRpc = pure . inputSourceLabel

binaryFilePatternsRpc :: Neovim () [String]
binaryFilePatternsRpc = pure binaryFilePatterns

$(pure [])

configHelpers :: Neovim () NeovimPlugin
configHelpers =
  wrapPlugin
    Plugin
      { environment = (),
        exports =
          [ $(function "NvimConfigTranslateLeaders" 'translateLeadersRpc) Sync,
            $(function "NvimConfigTranslateKeys" 'translateKeysRpc) Sync,
            $(function "NvimConfigDecodeSession" 'decodeSessionRpc) Sync,
            $(function "NvimConfigInputSourceLabel" 'inputSourceLabelRpc) Sync,
            $(function "NvimConfigBinaryFilePatterns" 'binaryFilePatternsRpc) Sync
          ]
      }

pluginRegistry :: [Neovim () NeovimPlugin]
pluginRegistry = [configHelpers]
