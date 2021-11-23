autocmd FileType javascript let b:coc_suggest_disable = 1
autocmd FileType python let b:coc_suggest_disable = 1
autocmd FileType scss setl iskeyword+=@-@

" COC NAVEGAR CON EL TAB
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" MOSTRAR AUTOCOMPLETADO
inoremap <C-space> <C-x><C-u>
inoremap <silent><expr> <c-space> coc#refresh()
