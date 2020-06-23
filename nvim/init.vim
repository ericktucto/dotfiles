call plug#begin(stdpath('data') . '/plugged')
source $HOME/.config/nvim/plugins.vim
call plug#end()

" Set variables to Python
let g:python3_host_prog='/usr/bin/python3'

colorscheme base16-pico
let base16colorspace=256

set shell=/usr/local/bin/xonsh
let g:ctrlp_map = '<c-p>'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

set t_Co=256
set background=dark

" Identado
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Otras modificaciones para archivos
set encoding=utf-8
set backspace=indent,eol,start
set hidden

syntax enable
set colorcolumn=80

" Ajustes en archivos
autocmd BufNewFile,BufRead *xonshrc,*.xsh set filetype=python
autocmd FileType gitcommit set cc=72
autocmd FileType php,js,vue,html,py,json BracelessEnable +highlight

" Seteo General
set number
set mouse=a
set relativenumber
set nowrap
set showmatch
set listchars=trail:·,eol:<,nbsp:%,tab:\ \ 
set list
set eol
let mapleader="\<C-h>"

" NerdTree
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
let NERDTreeShowLineNumber=1
autocmd FileType nerdtree setlocal relativenumber

" CtrlP
let g:ctrlp_map = '<Leader>,'

" ###########
" # Mapping #
" ###########

" # Control + P
 map <C-p>         :CtrlP<CR>
imap <C-p> <Esc>   :CtrlP<CR>

" # NerdTree
map <C-X> :NERDTreeToggle<CR>

" # Buffer -> Tabs
 map <C-k>       :bnext<CR>
imap <C-k> <Esc> :bnext<CR>i
 map <C-j>       :bprev<CR>
imap <C-j> <Esc> :bprev<CR>i

" # Update
 map <silent> <Leader>h      :updat<CR>
vmap <silent> <Leader>h <C-C>:updat<CR>
imap <silent> <Leader>h <C-O>:updat<CR>
 map <silent> <Leader>H      :updat<CR>
vmap <silent> <Leader>H <C-C>:updat<CR>
imap <silent> <Leader>H <C-O>:updat<CR>
 map <silent> <Leader>j      :bdele<CR>
imap <silent> <Leader>j <C-O>:bdele<CR>
 map          <Leader>J      :bdele!<CR>
imap <silent> <Leader>J <C-O>:bdele!<CR>
 map          <Leader>k      :quit<CR>
vmap <silent> <Leader>k <C-C>:quit<CR>
imap <silent> <Leader>k <C-O>:quit<CR>
" map          <Leader>K      :quit!<CR>
"imap <silent> <Leader>K <C-O>:quit!<CR>

" PHP
nnoremap <Leader>i :PHPImportClass<cr>
