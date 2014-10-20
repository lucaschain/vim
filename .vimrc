call pathogen#infect()

set nu
set shiftwidth=2
set tabstop=2
syntax on
set expandtab
set autoindent
set smartindent
set background=dark
set omnifunc=javascriptcomplete#CompleteJS

"Visual Mappings
nmap <up> gk
nmap <down> gj
nmap <F2> :NERDTreeToggle<CR>
nnoremap <S-Tab> gT<CR>
nnoremap <Tab> gt<CR>
nmap <Esc><Esc> :q!<CR>
nmap <C-b> :w<CR>
vmap <up> gk
vmap <down>	gj


vmap < <gv
vmap > >gv

imap <up> <C-O>gk
imap <down> <C-O>gj
imap <C-b> <Esc>:w!<CR>i
inoremap <C-Space> :w!

"PHP CONFIG
autocmd BufRead,BufNewFile *.module set filetype=php
autocmd BufRead,BufNewFile *.install set filetype=php
autocmd BufRead,BufNewFile *.test set filetype=php
autocmd BufRead,BufNewFile *.inc set filetype=php
autocmd BufRead,BufNewFile *.profile set filetype=php
autocmd BufRead,BufNewFile *.view set filetype=php


au BufNewFile,BufRead *.less set filetype=less
au BufNewFile,BufRead *.ejs set filetype=html
au BufReadCmd *.epub call zip#Browse(expand("<amatch>"))

autocmd FuncUndefined * exe 'runtime autoload/' . expand('<afile>') . '.vim'
