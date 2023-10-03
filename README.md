vim
===

My vim config files

## Requirements

- https://github.com/junegunn/fzf
- https://lunarvim.org/
- https://github.com/BurntSushi/ripgrep/

## Installing plugins

```
# lunarvim will do that already
```

## .bashrc

```bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"
```
