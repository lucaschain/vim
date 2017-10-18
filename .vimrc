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
set background=dark

"Visual Mappings
nmap <F2> :NERDTreeToggle<CR>
nmap <Esc><Esc> :q!<CR>
nmap <C-b> :w<CR>
vmap < <gv 
vmap > >gv

imap <up> <C-O>gk
imap <down> <C-O>gj
imap <C-b> <Esc>:w!<CR>i
inoremap <C-Space> :w!
