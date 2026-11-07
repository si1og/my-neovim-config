#!/bin/sh
set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
install_dir=${HOME}/.local/bin

mkdir -p "$install_dir"
swiftc -O -framework Carbon \
  "$script_dir/input-source-watch.swift" \
  -o "$install_dir/nvim-input-source-watch"

printf 'Installed %s\n' "$install_dir/nvim-input-source-watch"
