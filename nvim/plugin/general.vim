set encoding=utf-8
hi Pmenu ctermbg=10 ctermfg=15 guibg=#051b26 guifg=#ffffff
hi PmenuSel ctermbg=10 ctermfg=15 guibg=#ffffff guifg=#051b26
hi Visual ctermbg=255 ctermfg=10 cterm=NONE guibg=#2e4a59 guifg=NONE gui=NONE
hi NonText guifg=#ffff60

" INVESTIGAR DE DONDE ES ESTA FUNCION
function! NearestMethodOrFunction() abort
  let result = get(b:, 'vista_nearest_method_or_function', '')
  return len(result) == 0 ? result : "\uf794 " . result
endfunction
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
syntax enable
set backspace=indent,eol,start
set hidden
set nobackup
set noswapfile
set noshowmode " IMPIDE VER EL MODO POR DEFAULT NEOVIM (INSERT,VISUAL,NORMAL).
set showmatch
set list
set eol
" let mapleader="\<C-h>"
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "m": "",
\   "method": "",
\   "variable": "$",
\   "variables": "$",
\  }

autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2
