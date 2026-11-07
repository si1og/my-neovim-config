module FileSearch (binaryFilePatterns) where

import Data.Char (isAlpha, toLower, toUpper)

binaryFilePatterns :: [String]
binaryFilePatterns = fmap toPattern binaryExtensions
  where
    toPattern extension = "%." ++ concatMap caseInsensitive extension ++ "$"
    caseInsensitive character
      | isAlpha character = ['[', toLower character, toUpper character, ']']
      | otherwise = [character]

binaryExtensions :: [String]
binaryExtensions =
  [ "7z",
    "a",
    "apng",
    "avi",
    "avif",
    "bin",
    "bmp",
    "bz2",
    "class",
    "db",
    "dll",
    "doc",
    "docx",
    "dylib",
    "eot",
    "exe",
    "flac",
    "gif",
    "gz",
    "heic",
    "ico",
    "iso",
    "jar",
    "jpeg",
    "jpg",
    "mkv",
    "mov",
    "mp3",
    "mp4",
    "o",
    "ogg",
    "otf",
    "pdf",
    "png",
    "ppt",
    "pptx",
    "pyc",
    "rar",
    "so",
    "sqlite",
    "svg",
    "tar",
    "tiff",
    "ttf",
    "wav",
    "wasm",
    "webm",
    "webp",
    "woff",
    "woff2",
    "xls",
    "xlsx",
    "xz",
    "zip"
  ]
