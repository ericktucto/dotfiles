" COC
inoremap <silent><expr> <c-space> coc#refresh()
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

" SAVE FILE
 map <silent> <Leader>h      :updat<CR>
vmap <silent> <Leader>h <C-C>:updat<CR>
imap <silent> <Leader>h <C-O>:updat<CR>
 map <silent> <Leader>H      :updat<CR>
vmap <silent> <Leader>H <C-C>:updat<CR>
imap <silent> <Leader>H <C-O>:updat<CR>

" CLOSE TAB
 map <silent> <Leader>j      :bdele<CR>
vmap <silent> <Leader>j <C-C>:bdele<CR>
imap <silent> <Leader>j <C-O>:bdele<CR>
 map          <Leader>J      :bdele!<CR>
vmap <silent> <Leader>J <C-C>:bdele!<CR>
imap <silent> <Leader>J <C-O>:bdele!<CR>

" CLOSE ALL TAB
 map <silent> <Leader>u      :%bdele<CR>
vmap <silent> <Leader>u <C-C>:%bdele<CR>
imap <silent> <Leader>u <C-O>:%bdele<CR>
 map <silent> <Leader>U      :%bdele!<CR>
vmap <silent> <Leader>U <C-C>:%bdele!<CR>
imap <silent> <Leader>U <C-O>:%bdele!<CR>

" QUIT NEOVIM
 map          <Leader>k      :quit<CR>
vmap <silent> <Leader>k <C-C>:quit<CR>
imap <silent> <Leader>k <C-O>:quit<CR>
 map          <Leader>o      :quit!<CR>
vmap <silent> <Leader>o <C-C>:quit!<CR>
imap <silent> <Leader>o <C-O>:quit!<CR>

" PHP
"nnoremap <Leader>i :PHPImportClass<cr>
