tnoremap <C-n> <C-\><C-n>

" COC
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" MOSTRAR AUTOCOMPLETADO
inoremap <C-space> <C-x><C-u>
inoremap <silent><expr> <c-space> coc#refresh()

" NAVEGACION
map <C-i> <C-b>
map <C-o> <C-f>

" CONTROL + P
 map <C-p>                      :call Searching('git')<CR>
imap <C-p> <Esc>                :call Searching('git')<CR>
 map <Leader>p                      :call Searching('buffer')<CR>
imap <Leader>p <Esc>                :call Searching('buffer')<CR>
 map <Leader>f                      :Flines<CR>
imap <Leader>f <Esc>                :Flines<CR>

" # Blamer
map <Leader>m :BlamerToggle<CR>
map <Leader>b :GitGutterPreviewHunk<CR>

" # NerdTree
map <C-X> :NERDTreeToggle<CR>
map <Leader>n :NERDTreeFind<CR>

" # Buffer -> Tabs
 map <C-k>       :bnext<CR>
imap <C-k> <Esc> :bnext<CR>i
 map <C-j>       :bprevious<CR>
imap <C-j> <Esc> :bprevious<CR>i
" map <C-w>       :BufferMovePrevious<CR>
"imap <C-w> <Esc> :BufferMovePrevious<CR>i
" map <C-e>       :BufferMoveNext<CR>
"imap <C-e> <Esc> :BufferMoveNext<CR>i

" SAVE FILE
 map <silent> <Leader>h      :updat<CR>
vmap <silent> <Leader>h <C-C>:updat<CR>
imap <silent> <Leader>h <C-O>:updat<CR>
 map <silent> <Leader>H      :updat!<CR>
vmap <silent> <Leader>H <C-C>:updat!<CR>
imap <silent> <Leader>H <C-O>:updat!<CR>

" CLOSE TAB
 map <silent> <Leader>j      :bd<CR>
vmap <silent> <Leader>j <C-C>:bd<CR>
imap <silent> <Leader>j <C-O>:bd<CR>
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

" SYSTEM
vmap <Leader>y  "+y

" PRETTIER
 map <Leader>r :Prettier<CR>
vmap <Leader>r :Prettier<CR>
imap <Leader>r :Prettier<CR>
