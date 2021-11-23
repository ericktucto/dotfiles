" MODOS PARA LA BUSQUEDA DE ARCHIVOS EN UN PROYECTO
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

" CONTROL + P
 map <C-p>                      :call Searching('git')<CR>
imap <C-p> <Esc>                :call Searching('git')<CR>
 map <Leader>p                      :call Searching('buffer')<CR>
imap <Leader>p <Esc>                :call Searching('buffer')<CR>
 map <Leader>f                      :Flines<CR>
imap <Leader>f <Esc>                :Flines<CR>
