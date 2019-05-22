vim
===

My vim config files

## Requirements
https://github.com/junegunn/fzf

## Installing plugins

```
cd ~/.vim/bundle
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/sheerun/vim-polyglot.git
git clone https://github.com/junegunn/fzf.vim
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/bronson/vim-trailing-whitespace.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/dustinfarris/vim-htmlbars-inline-syntax.git
git clone https://github.com/wellle/targets.vim
git clone https://github.com/w0rp/ale

```

## .bashrc

```bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"
```
## .tmux.conf

```
# Solve clipboard hell
set-option -g set-clipboard on

# Pretty colors
set-option -g default-terminal "screen-256color"
set-option -g terminal-overrides ",xterm-256color:Tc"

# Those are easier to type than the defaults
set-option -g prefix 'C-a'
set-option -g base-index 1

# Bigger history
set-option -g history-limit 100000

# Go to last window
bind-key C-a last-window

# Vim-like bindings
setw -g mode-keys vi
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

bind v split-window -h -c "#{pane_current_path}"
bind s split-window    -c "#{pane_current_path}"

bind c new-window      -c "#{pane_current_path}#{spotify_song}"

bind C-c choose-session
bind C-n command-prompt 'new-session -s %%'

bind-key C-k send-key C-k 
bind-key -n C-k send-prefix

bind-key = setw synchronize-panes

set -g @plugin 'pwittchen/tmux-plugin-spotify'
```
