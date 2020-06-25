let g:ale_completion_enabled = 1
let g:ale_kotlin_languageserver_executable = '/home/lucas.chain/dev/KotlinLanguageServer/server/build/install/server/bin/server'
let g:ale_linters = {'go': ['golangserver', 'staticcheck', 'gobuild']}
let g:ale_fixers = {'go': ['gofmt'], 'terraform': ['terraform']}
let g:ale_go_langserver_executable = '/home/lucas.chain/go/bin/go-langserver'
let g:ale_fix_on_save = 1


call pathogen#infect()

set backupdir=/home/lucas.chain/vimtmp
set directory=/home/lucas.chain/vimtmp

set nu
set shiftwidth=2
set tabstop=2
syntax on
set expandtab
set autoindent
set smartindent
set incsearch
set background=dark
"color brogrammer

"Visual Mappings
map <C-n> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>
noremap gd :ALEGoToDefinition<CR>
noremap gD :ALEGoToDefinition<CR>
noremap F :ALESymbolSearch<space>
noremap K :ALEHover<CR>

nmap <Esc><Esc> :q!<CR>
nmap <C-b> :w<CR>
vmap < <gv
vmap > >gv

imap <up> <C-O>gk
imap <down> <C-O>gj
imap <C-b> <Esc>:w!<CR>i
inoremap <C-Space> :w!

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

noremap <C-t> :Find<CR>

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

autocmd BufRead,BufNewFile *.js HighlightInlineHbs

" Clipboard (yank/paste from/to clipboard, if available)
if has("clipboard")
  set clipboard=unnamed
  if has("unnamedplus")
    set clipboard+=unnamedplus
  endif
endif

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

let g:terraform_fmt_on_save=1
