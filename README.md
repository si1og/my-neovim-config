# Neovim config

Personal Neovim configuration for macOS with an orange-and-brown theme matching
Zed and the terminal environment.

The setup includes LSP support, Telescope search, Neo-tree, Git and Diffview,
debugging, formatting, named project sessions and automatic persistence.
`Space` is used as the leader key. Leader mappings work with both English and
Russian keyboard layouts.

## Architecture

The configuration uses Lua for Neovim integration and a small
[`nvim-hs`](https://github.com/neovimhaskell/nvim-hs) provider for pure config
logic. The Haskell code is split into three independent modules:

- `KeyboardLayout` translates leader mappings for the Russian layout.
- `Session` decodes persistence session paths and branches.
- `InputSource` converts macOS input-source identifiers into status-line labels.

Lua starts the provider through
[`nvim-hs.vim`](https://github.com/neovimhaskell/nvim-hs.vim), handles editor
events and calls the exported Haskell functions over Neovim RPC. The algorithms
themselves do not perform I/O or access editor state.

## Installation

The required tools are Neovim, Git and
[`stack`](https://docs.haskellstack.org/en/stable/). Clone the repository and
start Neovim:

```sh
git clone https://github.com/si1og/neovim-config.git ~/.config/nvim
nvim
```

On the first launch, `lazy.nvim` installs the plugins and `nvim-hs.vim` builds
the local Haskell provider. The first Haskell build can take a while; subsequent
starts use the cached executable.

To build and test the provider manually:

```sh
cd ~/.config/nvim/haskell
stack test
stack build nvim-config-hs:exe:nvim-config-hs
```

## Input-source indicator

The lualine input-source indicator uses a native macOS event watcher rather
than polling. Build it once after cloning:

```sh
sh scripts/install-input-source-watch.sh
```

The status line then displays `EN` or `RU` and updates only when macOS reports
an actual input-source change.
