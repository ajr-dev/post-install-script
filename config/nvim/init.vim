" The following configuration should work for both Vim and NeoVim

" Ensure vim-plug is installed and then load it
call functions#PlugLoad()
call plug#begin('~/.config/nvim/plugged')

" General {{{
set autoread            " Detect when a file is changed
set history=1000        " Change history to 1000
set secure              " Disable insecure commands in .vimrc files
set nobackup nowritebackup noswapfile " Don't make security copies of files

if (has('nvim'))
  " Show results of substition as they're happening, but don't open a split
  set inccommand=nosplit
endif

set backspace=indent,eol,start " Make backspace behave as usual
" Make backspace work in normal mode as in insert mode
nnoremap <bs> Xi

set clipboard+=unnamed,unnamedplus " Use system clipboard for y and p commands
xnoremap p pgvy

if has('mouse')
  set mouse=a
endif

" Searching
set ignorecase          " Case insensitive searching
set smartcase           " Case-sensitive if expresson contains a capital letter
set hlsearch            " Highlight search results
set incsearch           " Search as characters are introduced
set nolazyredraw        " Don't redraw while executing macros
set magic               " Set magic on, for regex

" Error bells
set noerrorbells
set visualbell
set t_vb=
set tm=500
" }}}

" Appearance {{{
set relativenumber      " Show relative line numbers for all lines
set number              " Except the current line
set whichwrap+=<,>,h,l,[,] " Change line when moving right or left
set linebreak           " Set soft wrapping
set autoindent          " Automatically set indent of new line
set smartindent         " Indent new lines based on rules
set ttyfast             " Faster redrawing
set diffopt+=vertical
set laststatus=2        " Show the satus line all the time
set so=7                " Set 7 lines to the cursors - when moving vertical
set wildmenu            " Display completion matches in a status line
set wildignorecase      " Complete filename ignoring case
set hidden              " Current buffer can be put into background
set ruler               " Show the cursor position all the time
set showcmd             " Display incomplete commands
set noshowmode          " Don't show which mode disabled for PowerLine
set wildmode=list:longest " Complete files like a shell
set scrolloff=3         " Lines of text around cursor
set shell=$SHELL
set cmdheight=1         " Command bar height
set title               " Set terminal title
set showmatch           " Show matching braces
set mat=2               " How many tenths of a second to blink
set ffs=unix,dos,mac    " Use unix as standard filetype
set encoding=utf8       " Select utf8 as standard encoding
set completeopt+=longest

" Tab control
set smarttab            " Tab and backspace keys respect 'tabstop', 'shiftwidth', and 'softtabstop'
set expandtab           " Indent with spaces instead of tabs
set shiftwidth=4        " Number of spaces to use for indent and unindent
set tabstop=4           " The visible width of tabs
set softtabstop=4       " Edit as if the tabs are 4 characters wide
set shiftround          " Round indent to a multiple of 'shiftwidth'

" Folding {{{
" Code folding settings
set foldmethod=syntax   " Fold based on indent
"set foldcolumn=2        " A column indicates open and closed folds
set foldlevelstart=99   " Don't fold by default
set foldnestmax=10      " Deepest fold is 10 levels
"set nofoldenable        " Don't fold by default
set foldlevel=1         " Where to start folding
set modeline            " Allow file specific folding configuration

" Switch between syntax and marker as foldmethod
nmap <Leader>ff :call <SID>ToggleFold()<CR>
function! s:ToggleFold()
  if &foldmethod == 'marker'
    let &l:foldmethod = 'syntax'
  else
    let &l:foldmethod = 'marker'
  endif
  echo 'foldmethod is now ' . &l:foldmethod
endfunction
" }}}

" Toggle invisible characters
set list
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪         " Show ellipsis at line break

set t_Co=256            " Explicitly tell vim that the terminal supports 256 colors

" Switch cursor to line when in insert mode, and block when not
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
\,sm:block-blinkwait175-blinkoff150-blinkon175

if &term =~ '256color'
  set t_ut=           " Disable background color erase
endif

" Airline {{{
Plug 'vim-airline/vim-airline' " Fancy statusline
Plug 'vim-airline/vim-airline-themes' " Themes for vim-airline
let g:airline_powerline_fonts=1
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1              " Habilitar la pestaña de Airline
let g:airline#extensions#tabline#tab_min_count = 2        " Mostrar las pestañas
let g:airline#extensions#tabline#show_buffers = 1         " Mostrar los bufers abiertos
let g:airline#extensions#tabline#show_splits = 0
" }}}
" }}}

" General Mappings {{{
" Set a map leader for more key combos
let mapleader = ","

" Remap esc
inoremap jk <esc>

" Disable ex mode
:map Q <Nop>

" Assign search to <Space> and backward search to Ctrl-<Space>
map <space> /
map <c-space> ?

" Clear highlighted search
noremap <leader>, :set hlsearch! hlsearch?<cr>

" Search the word under the cursor
nnoremap <leader><space> "fyiw :/<c-r>f<cr>

" Shortcut to save
nmap <leader>w :w<cr>

" Automatically save after editing
" inoremap <Esc> <Esc>:w<CR>

" Allow saving files that need sudo privileges
nmap <leader>W :w !sudo tee % > /dev/null<cr>
cmap w! w !sudo tee % > /dev/null<cr>

" Ctrl-S for saving file
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Make Ctrl x, Ctrl c and  Ctrl v cut, copy and paste
vmap <C-x> "+c
vmap <C-c> "+y
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" Toggle between indenting pasted text or not
set pastetoggle=<leader>v

" Fast edit of config files
map <leader>ev :e! $MYVIMRC<cr>
map <leader>eg :e! ~/.gitconfig<cr>

" Activate spell-checking alternatives
nmap ;s :set invspell spelllang=en<cr>

" Markdown to html
nmap <leader>md :%!markdown --html4tags <cr>

" Remove extra whitespace
nmap <leader>tr :%s/\s\+$<cr>
nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

" Helpers for dealing with other people's code
nmap <leader>ss :set ts=4 sts=4 sw=4 et \| retab<cr>
nmap <leader>st :set ts=4 sts=4 sw=4 noet \| retab<cr>

" Textmate style indentation
vmap <leader>[ <gv
vmap <leader>] >gv
nmap <leader>[ <<
nmap <leader>] >>

" Enable . command in visual mode
vnoremap . :normal .<cr>

" Move quickly between buffers
map <leader>h :bp<cr>
map <leader>l :bn<cr>
map <leader>d :bd<cr>

" Switch between current and last buffer
nmap <leader>. <c-^>

" Delete buffer
nmap <silent> <leader>b :bw<cr>

" Move around windows with Ctrl + {h, j, k, l}
map <silent> <C-h> :call functions#WinMove('h')<cr>
map <silent> <C-j> :call functions#WinMove('j')<cr>
map <silent> <C-k> :call functions#WinMove('k')<cr>
map <silent> <C-l> :call functions#WinMove('l')<cr>

" Move line or block of lines with Alt-j, Alt-k in any mode
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=g

" Toggle cursor line
nnoremap <leader>i :set cursorline!<cr>

" Scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Exchange 0 and ^
noremap 0 ^
noremap ^ 0

" Treat long lines as if they were split. It's useful to move around easily
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g0
nnoremap <silent> $ g$
" }}}

" File type specific settings {{{
" augroup ensures the autocmd's are only applied once
if has("autocmd")
  aug configgroup
    au!

    " Resize splits when the window is resized
    autocmd VimResized * exe "normal! \<c-w>="

    autocmd Filetype vim,lua,nginx,xhtml,php,html,javascript,ruby,
      \.vimrc,.vimrc.local,init.vim setlocal ts=2 sts=2 sw=2
    autocmd FileType make setlocal noexpandtab ts=8 sts=8 sw=8

    " Folding: Filetype Settings
    autocmd BufRead,BufEnter *.css,*.scss,.vimrc,.vimrc.local,init.vim setlocal foldmethod=marker

    " Automatically reload configuration
    autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %

    " Save all files on focus lost, ignoring warnings about untitled buffers
    autocmd FocusLost * silent! wa
  aug END

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  aug vimStartup
  au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
  aug END
endif
" }}}

" General Functionality {{{
Plug 'jiangmiao/auto-pairs' " insert or delete brackets, parens, quotes in pair
Plug 'tpope/vim-ragtag' " endings for html, xml, etc. - ehances surround
Plug 'tpope/vim-surround' " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.

" Add end, endif, etc. automatically
Plug 'tpope/vim-endwise', { 'for': [ 'ruby', 'bash', 'zsh', 'sh', 'vim' ]}

" NERDTree {{{
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'ryanoasis/vim-devicons' " this add weird character to status line

" Toggle NERDTree
function! ToggleNerdTree()
  if @% != "" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
    :NERDTreeFind
  else
    :NERDTreeToggle
  endif
endfunction
" Toggle nerd tree
nmap <silent> <leader>k :call ToggleNerdTree()<cr>
" Find the current file in nerdtree without needing to reload the drawer
nmap <silent> <leader>y :NERDTreeFind<cr>

let NERDTreeShowHidden=1
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
" }}}

" FZF {{{
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'down': '~25%' }

if isdirectory(".git")
  " if in a git project, use :GFiles
  nmap <silent> <leader>t :GFiles --cached --others --exclude-standard<cr>
else
  " otherwise, use :FZF
  nmap <silent> <leader>t :FZF<cr>
endif

nmap <silent> <leader>r :Buffers<cr>
nmap <silent> <leader>e :FZF<cr>
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nnoremap <silent> <Leader>C :call fzf#run({
\   'source':
\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
\   'sink':    'colo',
\   'options': '+m',
\   'left':    30
\ })<CR>

command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})

command! -bang -nargs=* Find call fzf#vim#grep(
    \ 'rg --column --line-number --no-heading --follow --color=always '.<q-args>, 1,
    \ <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
" }}}

" signify {{{
Plug 'mhinz/vim-signify' " show differences in a version controlled file
let g:signify_vcs_list = [ 'git' ]
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change = '!'
" }}}

" vim-fugitive {{{
Plug 'tpope/vim-fugitive' " amazing git wrapper for vim

" Shortcuts for using git within vim
nmap <silent> <leader>gs :Gstatus<cr>
nmap <leader>ge :Gedit<cr>
nmap <silent><leader>gr :Gread<cr>
nmap <silent><leader>gb :Gblame<cr>

noremap <leader>gc :Gcommit<cr>
noremap <leader>ga :Gwrite<cr>
noremap <leader>gl :Glog<cr>
noremap <leader>gd :Gdiff<cr>
" }}}

" ALE {{{
Plug 'w0rp/ale' " Asynchonous linting engine
let g:ale_lint_delay = 1000
let g:ale_change_sign_column_color = 0
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
" }}}

" YouCompleteMe {{{
"let g:ycm_server_python_interpreter = '/usr/bin/python'
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" make YCM compatible with UltiSnips (using supertab)
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:SuperTabDefaultCompletionType = '<C-n>'
" }}}

" UltiSnips {{{
Plug 'sirver/ultisnips' " snippet manager
Plug 'honza/vim-snippets'
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" }}}
" }}}

" Colorscheme and final setup {{{
" Enable true color in tmux 2.6 or higher
if has("termguicolors")
  set termguicolors
endif

Plug 'joshdick/onedark.vim' " Load colorscheme
call plug#end()

" This call must happen after the plug#end() call to ensure
" that the colorschemes have been loaded
let g:onedark_termcolors=16
let g:onedark_terminal_italics=1
syntax on
colorscheme onedark
filetype plugin indent on
" Make the highlighting of tabs and other non-text less annoying
highlight SpecialKey ctermfg=236
highlight NonText ctermfg=236

" Make comments and HTML attributes italic
highlight Comment cterm=italic
highlight htmlArg cterm=italic
highlight xmlAttrib cterm=italic
highlight Type cterm=italic
highlight Normal ctermbg=none

" Show a different background color as 'warning' and 'danger' markers
if v:version > 703
  highlight ColorColumn ctermbg=240 guibg=#2c2d27
  let &colorcolumn="81,".join(range(121,999),",")
endif
" }}}

" Use local configuration file if available
if !empty(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
