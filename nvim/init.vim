set termguicolors
hi Pmenu ctermbg=10 ctermfg=15 guibg=#051b26 guifg=#ffffff
hi PmenuSel ctermbg=10 ctermfg=15 guibg=#ffffff guifg=#051b26
hi Visual ctermbg=255 ctermfg=10 cterm=NONE guibg=#2e4a59 guifg=NONE gui=NONE

"""""""""""""""""""""""""""
" COMANDOS PERSONALIZADOS "
"""""""""""""""""""""""""""
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" INVESTIGAR DE DONDE ES ESTA FUNCION
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
" Set variables to Python
let g:python3_host_prog='/usr/bin/python3'
set shell=/usr/local/bin/xonsh
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
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
set listchars=trail:·,eol:↴,nbsp:%,tab:\ \
set list
set eol
let mapleader="\<C-h>"
source $HOME/.config/nvim/mappings.vim

