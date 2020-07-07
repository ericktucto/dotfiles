call plug#begin(stdpath('data') . '/plugged')
source $HOME/.config/nvim/plugins.vim
call plug#end()

" TEMA
colo seoul256
set background=dark

" GIT CONFIG
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
"let g:blamer_enabled = 1
"let g:blamer_prefix = " \ue702 "
"let g:blamer_template = "<commit-short> <committer>, <committer-time> • <summary>"
"let g:indentLine_bgcolor_gui = '#FF00FF'

" USAR TAB PARA NAVEGAR EN EL AUTOCOMPLETADO
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" COC PRETTIER
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" COC VETUR
let g:LanguageClient_serverCommands = {
  \ 'vue': ['vls']
  \ }

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Set variables to Python
let g:python3_host_prog='/usr/bin/python3'
autocmd BufNewFile,BufRead *xonshrc,*.xsh set filetype=pytho

set shell=/usr/local/bin/xonsh
let g:ctrlp_map = '<c-p>'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

set t_Co=256

" Identado
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" AJUSTES PARA ARCHIVOS ESPECIFICOS
autocmd FileType gitcommit set cc=72

" AJUSTES GENERALES
set encoding=utf-8
syntax enable
set colorcolumn=80
set backspace=indent,eol,start
set hidden
set number
set relativenumber
set nowrap
set nobackup
set noswapfile
set noshowmode " IMPIDE VER EL MODO POR DEFAULT NEOVIM (INSERT,VISUAL,NORMAL).
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

" ###########
" # Mapping #
" ###########

source $HOME/.config/nvim/mappings.vim

hi Normal guibg=NONE ctermbg=NONE