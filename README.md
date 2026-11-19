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
Restart Neovim after changing its config.

## Bash and tmux setup

On a new machine, compare and back up existing files first. With the
destinations clear, link the tracked files directly:

```bash
mkdir -p "$HOME/.local/bin"
for file in .bash_aliases .bash_aliases_custom .tmux.conf; do
  ln -s "$HOME/dev/vim/$file" "$HOME/$file"
done
ln -s "$HOME/dev/vim/bin/faws-work-browser" "$HOME/.local/bin/faws-work-browser"
```

The machine-local `~/.bashrc` sources `~/.bash_aliases`, which sources
`~/.bash_aliases_custom`. `aconf` opens both alias files (`:next` switches
to the second), checks their syntax, and reloads them. `rconf` edits and
checks `~/.bashrc`; open a new shell to apply startup changes without
rerunning PATH setup or tmux startup in the current shell. For an existing
tmux server, apply edits with `tmux source-file ~/.tmux.conf`.

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
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
```
