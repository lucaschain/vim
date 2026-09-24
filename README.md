vim
===

My LazyVim / Neovim config and shell configuration files.

## Neovim setup

Neovim reads this repository directly through a symlink:

```bash
mkdir -p "$HOME/.config"
# If ~/.config/nvim already exists, move it to a backup first.
ln -s "$HOME/dev/vim" "$HOME/.config/nvim"
```

Edits under `~/.config/nvim` and `~/dev/vim` now affect the same files.
No Lua copying is needed; `save-conf` and `load-conf` only copy the other
shell/tmux configuration files. Restart Neovim after changing its config.

## Requirements

- https://github.com/junegunn/fzf
- https://www.lazyvim.org/
- https://github.com/BurntSushi/ripgrep/

## Installing plugins

```
# LazyVim manages plugins automatically; use :Lazy to inspect them.
```

## .bashrc

```bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"
```
