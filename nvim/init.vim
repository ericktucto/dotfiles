"""""""""""""""""""""""""""
"          TODO           "
"""""""""""""""""""""""""""
" ELIMINAR LOS BOTONES DE CERRAR DE LOS BUFFER DE bufferline.nvim
" ELIMINAR EL BOTON DE CERRAR DE bufferline.nvim
"""""""""""""""""""""""""""
"          KITE           "
"""""""""""""""""""""""""""
" All the languages Kite supports
let g:kite_supported_languages = ['*']
set termguicolors
lua << EOF
local colors = {
    blue = "#14747e",
    orange = "#f08e48",
    violet = "#c43060",
    yellow = "#ffcc1b",
    green = "#7fc06e",
    red = "#ff5a67",
    white = "#fafaf8",
    gray = "#a1a19a",
    fg = "#ffffff",
    bg = "#051b26"
}
local atlas_theme = {
  normal = {
    a = { fg = colors.white, bg = colors.violet },
    b = { fg = colors.white, bg = colors.bg },
    c = { fg = colors.white, bg = colors.bg },
  },

  insert = { a = { fg = colors.bg, bg = colors.yellow } },
  visual = { a = { fg = colors.bg, bg = colors.orange } },
  replace = { a = { fg = colors.white, bg = colors.blue } },

  inactive = {
    c = { fg = colors.white, bg = colors.bg },
  },
}

require('lualine').setup {
    options = {
        theme = atlas_theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "|", right = "|" }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {{'diagnostics', sources={'coc'}}},
        lualine_c = {{'filename', path = 1}, 'diff'},
        lualine_x = {},
        lualine_y = {'branch'},
        lualine_z = {{'location', padding = 1}}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    }
}
require("bufferline").setup {
  highlights = {
   -- ESTA ES LA AREA DONDE NO ESTAN LOS BUFFER
    fill = {
      guifg = '#a3a09a',
      guibg = '#051b26'
    },
    -- ESTOS SON LAS BUFFER INACTIVAS
    background = {
      guifg = '#a3a09a',
      guibg = '#051b26'
    },
    -- TODOS LOS BOTON DE CERRAR PERO DE LOS BUFFER INACTIVOS
    close_button = {
      guifg = '#a3a09a',
      guibg = '#051b26'
    },
    buffer_selected = {
        guifg = "#ffffff",
        guibg = normal_bg,
        gui = "bold,italic"
    },
    -- ES PARA EL BOTON DE CERRAR NEOVIM
    tab_close = {
        guifg = normal_fg,
        guibg = "#051b26",
    },
    separator = {
        guifg = normal_fg,
        guibg = "#051b26",
    },
    modified = {
        guifg = normal_fg,
        guibg = "#051b26",
    }
  },
  options = {
    offsets = {
      {
        filetype = "nerdtree",
        text = "PROYECTO",
        highlight = "Directory",
        text_align = "center"
      }
    },
    separator_style = "thin",
    diagnostics = "coc",
    diagnostics_update_in_insert = true,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
            local sym = e == "error"
                and " "
                or (e == "warning" and " " or "" )
                s = s .. n .. sym
        end
        return s
    end
  }
}
-- vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
vim.opt.list = true
vim.opt.listchars["extends"] = "eol:↴"

require("indent_blankline").setup {
  space_char_blankline = " ",
  char_highlight_list = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
      "IndentBlanklineIndent3",
      "IndentBlanklineIndent4",
      "IndentBlanklineIndent5",
      "IndentBlanklineIndent6",
  },
}
EOF
hi Pmenu ctermbg=10 ctermfg=15 guibg=#051b26 guifg=#ffffff
hi PmenuSel ctermbg=10 ctermfg=15 guibg=#ffffff guifg=#051b26
" AQUI LOS COLORES DEL MENU SON NEGRO EN EL BG Y BLANCO EN EL FG
"hi Pmenu ctermbg=10 ctermfg=15 guibg=#131313 guifg=#ffffff
"hi PmenuSel ctermbg=10 ctermfg=15 guibg=#ffffff guifg=#131313
hi Visual ctermbg=255 ctermfg=10 cterm=NONE guibg=#2e4a59 guifg=NONE gui=NONE
let bufferline = get(g:, 'bufferline', {})
let bufferline.icon_separator_active = '▎'

"""""""""""""""""""""""""""
" COMANDOS PERSONALIZADOS "
"""""""""""""""""""""""""""
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" FUNCION PARA ENCONTRAR UNA PALABRA EN UN ARCHIVO
function! RipgrepFzf(query, fullscreen)
  let command_fmt = "grep --exclude-dir=public --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=vendor --exclude-dir=storage -RHonia %s . || true"
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

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

"    \     'right': [['gitbranch'], ['ggstatus','filetype', 'percent', 'lineinfo'], ['kitestatus']]
"    \   'component_function': {
"    \     'kitestatus': 'kite#statusline'
"    \   },

" GIT CONFIG
let g:blamer_prefix = " \ue702 "
let g:blamer_template = "<commit-short> <committer>, <committer-time> • <summary>"
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = ''
highlight SignColumn guibg=NONE ctermbg=NONE
highlight GitGutterAdd    guibg=#009900 guifg=#ffffff gui=bold
highlight GitGutterChange guibg=#bbbb00 guifg=#ffffff gui=bold
highlight GitGutterDelete guibg=#ff2222 guifg=#ffffff gui=bold

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
set listchars=trail:·,eol:↴,nbsp:%,tab:\ \ 
set list
set eol
let mapleader="\<C-h>"

" NerdTree
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeGitStatusUseNerdFonts = 1
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

