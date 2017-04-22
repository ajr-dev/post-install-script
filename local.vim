noremap <space> /
noremap <leader>h :bp<cr>
noremap <leader>l :bn<cr>
map <silent> <leader><cr> :noh<cr>
let g:airline#extensions#tabline#show_buffers = 1 " show open buffers in tabline
highlight ColorColumn ctermbg=240 guibg=#2c2d27
let &colorcolumn="81,".join(range(121,999),",")
set nowrap et
set clipboard+=unnamed,unnamedplus                       " los comandos y, p utilizan el portapapeles del sistema
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa
