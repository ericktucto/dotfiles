set encoding=utf-8
hi Pmenu ctermbg=10 ctermfg=15 guibg=#051b26 guifg=#ffffff
hi PmenuSel ctermbg=10 ctermfg=15 guibg=#ffffff guifg=#051b26
hi Visual ctermbg=255 ctermfg=10 cterm=NONE guibg=#2e4a59 guifg=NONE gui=NONE
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" INVESTIGAR DE DONDE ES ESTA FUNCION
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
let g:python3_host_prog='/usr/bin/python3'
syntax enable
set colorcolumn=80
set backspace=indent,eol,start
set hidden
set nobackup
set noswapfile
set noshowmode " IMPIDE VER EL MODO POR DEFAULT NEOVIM (INSERT,VISUAL,NORMAL).
set showmatch
set listchars=trail:·,eol:↴,nbsp:%,tab:\ \
set list
set eol
let mapleader="\<C-h>"
