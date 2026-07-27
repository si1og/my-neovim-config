# Nvim config

Personal Neovim configuration.

Originally based on [topoff0/nvim](https://github.com/topoff0/nvim) by
[@topoff0](https://github.com/topoff0).

`<leader>` is `Space`. Unless stated otherwise, mappings work in Normal mode.

## Key mappings

### General

| Mapping | Mode | Action |
| --- | --- | --- |
| `jj` | Insert | Return to Normal mode |
| `<Space>cd` | Normal | Open the built-in file explorer |
| `<Space>ee` | Normal | Toggle Neo-tree |
| `<Space>rr` | Normal | Reveal the current file in Neo-tree |
| `<Space>cb` | Normal | Close the current buffer |
| `<Esc>` | Normal | Clear search highlighting |
| `+` / `-` | Normal | Increment / decrement the number under the cursor |
| `J` / `K` | Visual | Move the selected lines down / up |
| `n` / `N` | Normal | Next / previous search result, keeping it centered |
| `*` / `#` | Normal | Search for the word under the cursor forward / backward |

### Files and search

| Mapping | Action |
| --- | --- |
| `<Space>ff` | Find files with Telescope |
| `<Space>fg` | Search text in the project |
| `<Space>fb` | Select an open buffer |
| `<Space>fh` | Search Neovim help |
| `<Space>td` | Search TODO comments |
| `]t` / `[t` | Next / previous TODO comment |

### LSP and formatting

Some LSP mappings are available only in buffers to which an LSP server is attached.

| Mapping | Mode | Action |
| --- | --- | --- |
| `K` | Normal | Show hover documentation |
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gi` | Normal | Go to implementation |
| `gr` | Normal | Find references with Telescope |
| `gs` | Normal | Show signature help |
| `gl` | Normal | Show diagnostics |
| `<Space>ca` / `<Space>la` | Normal/Visual / Normal | Code action |
| `<Space>lr` | Normal | Rename symbol |
| `<Space>gf` / `<Space>lf` | Normal | Format using LSP |
| `<Space>mp` | Normal/Visual | Format the file or selected range with Conform |
| `<Space>v` | Normal | Open the definition in a vertical split |

### Git

| Mapping | Action |
| --- | --- |
| `<Space>gs` | Open Fugitive Git status |
| `<Space>gw` | Stage the current file |
| `<Space>gc` | Create a commit |
| `<Space>gpl` | Pull changes |
| `<Space>gpu` | Push changes in a terminal split |
| `<Space>gh` | Preview the hunk |
| `<Space>gH` | Preview the hunk inline |
| `<Space>ga` | Stage the hunk |
| `<Space>gu` | Undo staging of the hunk |
| `<Space>gr` | Reset the hunk |
| `<Space>gR` | Reset all changes in the current buffer |
| `<Space>gx` | Show blame for the current line |
| `<Space>gD` | Diff the current file against `HEAD` |
| `]h` / `[h` | Next / previous Git hunk |

### Harpoon

| Mapping | Action |
| --- | --- |
| `<Space>a` | Add the current file to the Harpoon list |
| `<C-e>` | Open the Harpoon quick menu |
| `<Space>fl` | Open the Harpoon list with Telescope |
| `<C-p>` / `<C-n>` | Previous / next Harpoon file |

### Debugging

| Mapping | Action |
| --- | --- |
| `<Space>dc` | Start or continue debugging |
| `<Space>ss` | Stop debugging |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<Space>b` | Toggle breakpoint |
| `<Space>dcb` | Clear all breakpoints |
| `<Space>dC` | Run to cursor |
| `<Space>dr` | Toggle the DAP REPL |
| `<Space>dj` / `<Space>dk` | Move down / up the stack |

### Undo history

| Mapping | Action |
| --- | --- |
| `<Space>uU` | Toggle Undotree |

### Sessions

Sessions are saved automatically on exit and kept separately for each working
directory and Git branch.

| Mapping | Action |
| --- | --- |
| `<Space>qs` | Restore the session for the current directory and Git branch |
| `<Space>qS` | Select a saved session |
| `<Space>ql` | Restore the last session |
| `<Space>qd` | Stop persistence and do not save the current session |

### LaTeX

These mappings are provided by VimTeX. Its local leader is `\`.

| Mapping | Action |
| --- | --- |
| `\ll` | Start or stop continuous compilation |
| `\lk` | Stop compilation |
| `\lv` | Open the generated PDF in Skim |
| `\le` | Show VimTeX errors |
| `\lt` | Open the table of contents |
| `\li` | Show project information |

### Standard Neovim windows and tabs

These are built-in Neovim mappings rather than custom mappings.

| Mapping | Action |
| --- | --- |
| `<C-w>s` / `<C-w>v` | Create a horizontal / vertical split |
| `<C-w>h/j/k/l` | Move between split windows |
| `<C-w>w` | Move to the next window |
| `<C-w>q` | Close the current window |
| `<C-w>=` | Make split windows equal in size |
| `<C-w>+/-` | Increase / decrease window height |
| `<C-w>>/<` | Increase / decrease window width |
| `gt` / `gT` | Next / previous tab |
