# Neovim config

Personal Neovim configuration for macOS with an orange-and-brown theme matching
Zed and the terminal environment.

The setup includes LSP support, Telescope search, Neo-tree, Git and Diffview,
debugging, formatting, named project sessions and automatic persistence.
`Space` is used as the leader key. Leader mappings work with both English and
Russian keyboard layouts.

## Installation

Clone the repository to `~/.config/nvim`, start Neovim and let `lazy.nvim`
install the plugins.

The lualine input-source indicator uses a native macOS event watcher rather
than polling. Build it once after cloning:

```sh
sh scripts/install-input-source-watch.sh
```

The status line then displays `EN` or `RU` and updates only when macOS reports
an actual input-source change.
