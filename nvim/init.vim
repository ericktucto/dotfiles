call plug#begin(stdpath('data') . '/plugged')
" WIDGETS
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" PENDIENTES POR INVESTIGAR
"Plug 'liuchengxu/vista.vim'
"Plug 'preservim/tagbar'

" SOPORTE A OTROS LENGUAJES
"Plug 'Yggdroot/indentLine'
call plug#end()
set termguicolors
colorscheme srcery
set background=dark

"""""""""""""""""""""""""""
" COMANDOS PERSONALIZADOS "
"""""""""""""""""""""""""""
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" FUNCION PARA ENCONTRAR UNA PALABRA EN UN ARCHIVO
function! RipgrepFzf(query, fullscreen)
  let command_fmt = "grep --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=vendor --exclude-dir=storage -RHonia %s . || true"
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let preview = stdpath('config') . '/scripts/previewer {}'
  let spec = {
  \  'options': [
  \    '--phony',
  \    '--query',
  \    a:query,
  \    '--bind',
  \    'change:reload:'.reload_command,
  \    '--layout=reverse',
  \    '--preview',
  \    preview
  \  ],
  \  'window': { 'width': 1, 'height': 1 } }
  call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
endfunction

command! -nargs=* -bang Flines call RipgrepFzf(<q-args>, <bang>0)
function Searching(view)
  if a:view == 'git'
    let config = {
    \    'options': ['--layout=reverse', '--preview', 'batcat -n --color=always {}'],
    \    'window': { 'width': 1, 'height': 1 }
    \  }
    let source = {
    \    "source": 'find . -name "*.*" -type f -not -path "./.git/*" -not -path "./vendor/*" -not -path "./node_modules/*"',
    \    "sink": "e"
    \  }
    call fzf#run(extend(config, source))
  endif
  if a:view == 'buffer'
    let config = {
    \    'options': ['--layout=reverse'],
    \    'window': { 'width': 0.5, 'height': 0.5 }
    \  }
    call fzf#vim#buffers(config)
  endif
endfunction

""""""""""""""""""
" AUTOCOMPLETADO "
""""""""""""""""""
let g:kite_completions=0
" COC
autocmd FileType scss setl iskeyword+=@-@
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php nmap <silent> gi :call IPhpInsertUse()<CR>

" COC NAVEGAR CON EL TAB
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" COC AUTOPRETTIER EN VUE
"function ExecPrettier()
"    Prettier
"   write
"endfunction
"autocmd BufWritePost *.vue call ExecPrettier()

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

let g:lightline = {
    \   'active' : {
    \     'left': [['mode', 'paste'], ['relativepath'], ['modified', 'method']],
    \     'right': [['gitbranch'], ['ggstatus','filetype', 'percent', 'lineinfo']]
    \   },
    \   'inactive': {
    \     'left': [['inactive'], ['relativepath']],
    \     'right': [['bufnum']]
    \   },
    \   'component': {
    \     'bufnum': '%n',
    \     'inactive': 'inactive'
    \   },
    \   'component_function': {
    \     'gitbranch': 'gitbranch#name',
    \     'ggstatus': 'GitStatus',
    \     'method': 'NearestMethodOrFunction'
    \   },
    \   'subseparator': {
    \     'left': '',
    \     'right': ''
    \   }
    \ }

" GITGUTTER
function! GitStatus()
  let summary = GitGutterGetHunkSummary()
  let estados = map(['+','~','-'], {k, v -> {'count': summary[k], 'display': printf("%s%d", v, summary[k])}})
  return join(map(filter(estados, {k,v -> v['count'] > 0}), {k,v -> v['display']}), ' ')
endfunction

" GIT CONFIG
let g:blamer_prefix = " \ue702 "
let g:blamer_template = "<commit-short> <committer>, <committer-time> • <summary>"

" Set variables to Python
let g:python3_host_prog='/usr/bin/python3'
autocmd BufNewFile,BufRead *xonshrc,*.xsh set filetype=python

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

" #####################
" # SUPPORT LANGUAGES #
" #####################
let g:vue_pre_processors = ['pug', 'scss']

" ###########
" # Mapping #
" ###########

source $HOME/.config/nvim/mappings.vim

