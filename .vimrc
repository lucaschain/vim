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
"color brogrammer

"Visual Mappings
map <C-n> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>

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
