" Ensure vim-plug is installed and then load it
call functions#PlugLoad()
call plug#begin('~/.config/nvim/plugged')

" General {{{
  set autoread            " reload file if it changes
  set history=1000        " change history to 1000
  "set secure              " disable insecure commands in .vimrc files
  set nobackup nowritebackup noswapfile  " don't make security copies of files

  if (has('nvim'))
    " Show results of substition as they're happening, but don't open a split
    set inccommand=nosplit
  endif

  set backspace=indent,eol,start " make backspace behave as usual
  " Make backspace work in normal mode as in insert mode
  nnoremap <bs> Xi

  set clipboard+=unnamed,unnamedplus " use system clipboard for y and p commands
  " Paste text without overriding the default register
  xnoremap p pgvy

  if has('mouse')
    set mouse=a
  endif

  " Searching
  set ignorecase          " case insensitive searching
  set smartcase           " case-sensitive if expression contains a capital letter
  set hlsearch            " highlight search results
  set incsearch           " search as characters are introduced
  set nolazyredraw        " don't redraw while executing macros
  set magic               " set magic on, for regex

  " Error bells
  set noerrorbells
  set visualbell
  set t_vb=
  set tm=500
" }}}

" Appearance {{{
  set relativenumber      " show relative line numbers for all lines
  set number              " except the current line
  set whichwrap+=<,>,h,l,[,] " change line when moving right or left
  set linebreak           " set soft wrapping
  set showbreak=↪         " show ellipsis at line break
  set autoindent          " automatically set indent of new line
  set smartindent         " indent new lines based on rules
  set ttyfast             " faster redrawing
  " If using vimdiff
  if &diff
    set diffopt-=internal
    set diffopt+=vertical,iwhite,internal,algorithm:patience,hiddenoff
  endif
  set laststatus=2        " show the satus line all the time
  set so=7                " set 7 lines to the cursors - when moving vertically
  set wildmenu            " display completion matches in a status line
  set wildignorecase      " complete filename ignoring case
  set wildmode=list:longest " complete files like a shell
  set shell=$SHELL
  set hidden              " current buffer can be put into background
  set ruler               " show the cursor position all the time
  set showcmd             " display incomplete commands
  set noshowmode          " don't show which mode. Disabled for PowerLine
  set scrolloff=3         " lines of text around cursor
  set shell=$SHELL
  set cmdheight=1         " command bar height
  set title               " set terminal title
  set showmatch           " show matching braces
  set mat=2               " how many tenths of a second to blink
  set ffs=unix,dos,mac    " use unix as standard filetype
  set encoding=utf8       " Select utf8 as standard encoding
  set completeopt+=longest
  set updatetime=750      " write swap file to disc in nothing happens in this miliseconds
  set signcolumn=yes      " always show signcolumns
  set shortmess+=c        " don't give |ins-completion-menu| messages.

  " Tab control
  set smarttab            " tab and backspace keys respect 'tabstop', 'shiftwidth', and 'softtabstop'
  set expandtab           " indent with spaces instead of tabs
  set tabstop=2           " the visible width of tabs
  set softtabstop=2       " edit as if the tabs are 4 characters wide
  set shiftwidth=2        " number of spaces to use for indent and unindent
  set shiftround          " round indent to a multiple of 'shiftwidth'

  " Code folding settings
  set foldmethod=syntax   " fold based on indent
  "set foldcolumn=2        " a column indicates open and closed folds
  set foldlevelstart=99   " don't fold by default
  set foldnestmax=10      " deepest fold is 10 levels
  "set nofoldenable        " don't fold by default
  set foldlevel=1         " where to start folding
  set modeline            " allow file specific folding configuration

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

  " Toggle invisible characters
  set list
  set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮

  set t_Co=256            " explicitly tell vim that the terminal supports 256 colors

  " Switch cursor to line when in insert mode, and block when not
  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

  if &term =~ '256color'
  set t_ut=           " disable background color erase
  endif

  " Use 24-bit (true-color) mode in Vim/Neovim
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799
  if (has("termguicolors"))
    if (!(has("nvim")))
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    set termguicolors
  elseif (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif

  match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'  " highlight conflicts

  Plug 'joshdick/onedark.vim' " load colorscheme
  Plug 'vim-airline/vim-airline' " Fancy statusline
  Plug 'vim-airline/vim-airline-themes' " Themes for vim-airline
  let g:airline_powerline_fonts=1
  let g:airline_theme='onedark'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#tab_min_count = 2
  let g:airline#extensions#tabline#show_buffers = 1
  let g:airline#extensions#tabline#show_splits = 0
" }}}

" General Mappings {{{
  " Set a map leader for more key combos
  let mapleader = ","

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
  " FZF {{{
    Plug '/usr/local/opt/fzf'
    Plug 'junegunn/fzf.vim'
    "let g:fzf_layout = { 'down': '~25%' }

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

  " Fast edit of config files
  map <leader>ev :e! $MYVIMRC<cr>
  map <leader>eg :e! ~/.gitconfig<cr>

  " Activate spell-checking alternatives
  nmap <leader>sc :set invspell spelllang=en<cr>
  nmap ;s :set invspell spelllang=en<cr>

  " Markdown to html
  nmap <leader>md :%!markdown --html4tags <cr>

  " Remove extra whitespace
  nmap <leader>tr :%s/\s\+$<cr>
  nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

  inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
  inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

  " toggle invisible characters. List Chars mnemonic
  nmap <leader>lc :set list!<cr>

  " keep visual selection when indenting/outdenting
  vmap < <gv
  vmap > >gv

  " Move quickly between buffers
  map <leader>h :bp<cr>
  map <leader>l :bn<cr>
  map <leader>d :bd<cr>

  " Switch between current and last buffer
  nmap <leader>. <c-^>

  " Enable . command in visual mode
  vnoremap . :normal .<cr>

  " Delete buffer
  nmap <silent> <leader>b :bw<cr>

  " Move around windows with Ctrl + {h, j, k, l}
  "map <silent> <C-h> :call functions#WinMove('h')<cr>
  "map <silent> <C-j> :call functions#WinMove('j')<cr>
  "map <silent> <C-k> :call functions#WinMove('k')<cr>
  "map <silent> <C-l> :call functions#WinMove('l')<cr>

  "nmap <leader>z <Plug>Zoom

  "map <leader>wc :wincmd q<cr>

  " Move line or block of lines with Alt-j, Alt-k in any mode
  nnoremap <A-j> :m .+1<cr>==
  nnoremap <A-k> :m .-2<cr>==
  inoremap <A-j> <Esc>:m .+1<cr>==gi
  inoremap <A-k> <Esc>:m .-2<cr>==gi
  vnoremap <A-j> :m '>+1<cr>gv=gv
  vnoremap <A-k> :m '<-2<cr>gv=gv

  vnoremap $( <esc>`>a)<esc>`<i(<esc>
  vnoremap $[ <esc>`>a]<esc>`<i[<esc>
  vnoremap ${ <esc>`>a}<esc>`<i{<esc>
  vnoremap $" <esc>`>a"<esc>`<i"<esc>
  vnoremap $' <esc>`>a'<esc>`<i'<esc>
  vnoremap $\ <esc>`>o*/<esc>`<O/*<esc>
  vnoremap $< <esc>`>a><esc>`<i<<esc>

  " Toggle cursor line
  nnoremap <leader>cl :set cursorline!<cr>

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

  " Helpers for dealing with other people's code
  nmap <leader>s2 :set ts=2 sts=2 sw=2 et \| retab<cr>
  nmap <leader>s4 :set ts=4 sts=4 sw=4 et \| retab<cr>
  nmap <leader>st :set ts=4 sts=4 sw=4 noet \| retab<cr>

  " Custom text objects

  " inner-line
  xnoremap <silent> il :<c-u>normal! g_v^<cr>
  onoremap <silent> il :<c-u>normal! g_v^<cr>

  " around line
  vnoremap <silent> al :<c-u>normal! $v0<cr>
  onoremap <silent> al :<c-u>normal! $v0<cr>

  " Interesting word mappings
  nmap <leader>0 <Plug>ClearInterestingWord
  nmap <leader>1 <Plug>HiInterestingWord1
  nmap <leader>2 <Plug>HiInterestingWord2
  nmap <leader>3 <Plug>HiInterestingWord3
  nmap <leader>4 <Plug>HiInterestingWord4
  nmap <leader>5 <Plug>HiInterestingWord5
  nmap <leader>6 <Plug>HiInterestingWord6
" }}}

" AutoGroups {{{
  " File type specific settings
  " augroup ensures the autocmd's are only applied once
  if has("autocmd")
  augroup configgroup
    autocmd!

    " Resize splits when the window is resized
    autocmd VimResized * exe "normal! \<c-w>="

    autocmd Filetype vim,lua,nginx,xhtml,php,c,cpp,java setlocal ts=2 sts=2 sw=2
    autocmd Filetype .vimrc,.vimrc.local,init.vim setlocal ts=2 sts=2 sw=2
    autocmd FileType make setlocal noexpandtab ts=8 sts=8 sw=8

    " Folding: Filetype Settings
    autocmd BufRead,BufEnter *.css,*.scss,.vimrc,.vimrc.local,init.vim setlocal foldmethod=marker

    " Automatically reload configuration
    autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
    autocmd BufWritePost .vimrc.local source %

    " Save all files on focus lost, ignoring warnings about untitled buffers
    autocmd FocusLost * silent! wa

    " make quickfix windows take all the lower section of the screen
    " when there are multiple windows open
    autocmd FileType qf wincmd J
    autocmd FileType qf nmap <buffer> q :q<cr>
  augroup END

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
  " better terminal integration
  " substitute, search, and abbreviate multiple variants of a word
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary' " easy commenting motions
  Plug 'tpope/vim-unimpaired' " mappings which are simply short normal mode aliases for commonly used ex commands
  Plug 'tpope/vim-ragtag'     " endings for html, xml, etc. - ehances surround
  Plug 'tpope/vim-surround'   " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
  Plug 'tpope/vim-sleuth'     " detect indent style (tabs vs. spaces)
  Plug 'sickill/vim-pasta'    " context-aware pasting

  " NERDTree {{{
    Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ryanoasis/vim-devicons'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    augroup nerdtree
      autocmd!
      autocmd FileType nerdtree setlocal nolist " turn off whitespace characters
      autocmd FileType nerdtree setlocal nocursorline " turn off line highlighting for performance
    augroup END

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
    " let NERDTreeDirArrowExpandable = '▷'
    " let NERDTreeDirArrowCollapsible = '▼'
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

    nmap <silent> <leader>s :GFiles?<cr>

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

  " vim-fugitive {{{
    Plug 'tpope/vim-fugitive' " amazing git wrapper for vim

    " Shortcuts for using git within vim
    nmap <silent> <leader>gs :Gstatus<cr>
    nmap <leader>ge :Gedit<cr>
    nmap <silent><leader>gr :Gread<cr>
    nmap <silent><leader>gb :Gblame<cr>

    noremap <leader>gc :Gcommit<cr>
    noremap <leader>gw :Gwrite<cr>
    noremap <leader>gl :Glog<cr>
    noremap <leader>gd :Gdiff<cr>

    Plug 'tpope/vim-rhubarb' " hub extension for fugitive
    Plug 'sodapopcan/vim-twiggy'
    Plug 'rbong/vim-flog'
  " }}}

  " ALE {{{
    "Plug 'w0rp/ale' " Asynchonous linting engine
    "let g:ale_lint_delay = 1000
    "let g:ale_change_sign_column_color = 0
    "let g:ale_sign_column_always = 1
    "let g:ale_sign_error = '✖'
    "let g:ale_sign_warning = '⚠'
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
    let g:UltiSnipsExpandTrigger = "<C-l>"
    let g:UltiSnipsJumpForwardTrigger = "<C-j>"
    let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
  " }}}

  " coc {{{
    " Code completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-json',
    \ 'coc-tsserver',
    \ 'coc-git',
    \ 'coc-eslint',
    \ 'coc-tslint-plugin',
    \ 'coc-pairs',
    \ 'coc-sh',
    \ 'coc-vimlsp',
    \ 'coc-emmet',
    \ 'coc-prettier',
    \ 'coc-ultisnips',
    \ 'coc-explorer',
    \ 'coc-diagnostic'
    \ ]

    autocmd CursorHold * silent call CocActionAsync('highlight')

    " coc-prettier
    command! -nargs=0 Prettier :CocCommand prettier.formatFile
    nmap <leader>f :CocCommand prettier.formatFile<cr>

    " coc-git
    nmap [g <Plug>(coc-git-prevchunk)
    nmap ]g <Plug>(coc-git-nextchunk)
    nmap gs <Plug>(coc-git-chunkinfo)
    nmap gu :CocCommand git.chunkUndo<cr>

    nmap <silent> <leader>k :CocCommand explorer<cr>

    "remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nmap <silent> gh <Plug>(coc-doHover)

    " diagnostics navigation
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " rename
    nmap <silent> <leader>rn <Plug>(coc-rename)

    " Remap for format selected region
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    " organize imports
    command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    "tab completion
    inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    if exists('*complete_info')
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " For enhanced <CR> experience with coc-pairs checkout :h coc#on_enter()
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
          \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  " }}}
" }}}

" Language-Specific Configuration {{{
  " html / templates {{{
    Plug 'mattn/emmet-vim'  " emmet support for vim - easily create markdup wth CSS-like syntax
    Plug 'gregsexton/MatchTag', { 'for': 'html' }   " match tags in html, similar to paren support
    Plug 'othree/html5.vim', { 'for': 'html' }      " html5 support
    Plug 'mustache/vim-mustache-handlebars'         " mustache support
    Plug 'digitaltoad/vim-pug', { 'for': ['jade', 'pug'] }  " pug / jade support
    Plug 'Glench/Vim-Jinja2-Syntax', { 'for': 'njk' }  " nunjucks support
    Plug 'tpope/vim-liquid'                         " liquid support
  " }}}

  " JavaScript {{{
    Plug 'othree/yajs.vim', { 'for': [ 'javascript', 'javascript.jsx', 'html' ] }
    " Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx', 'html'] }
    Plug 'moll/vim-node', { 'for': 'javascript' }
    Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
    Plug 'MaxMEllon/vim-jsx-pretty'
    let g:vim_jsx_pretty_highlight_close_tag = 1
  " }}}

  " TypeScript {{{
    Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'typescript.tsx'] }
  " }}}

  " Styles {{{
    Plug 'wavded/vim-stylus', { 'for': ['stylus', 'markdown'] }
    Plug 'groenewege/vim-less', { 'for': 'less' }
    Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
    Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
    Plug 'stephenway/postcss.vim', { 'for': 'css' }
  " }}}

  " markdown {{{
    Plug 'tpope/vim-markdown', { 'for': 'markdown' }
    let g:markdown_fenced_languages = [ 'tsx=typescript.tsx' ]

    " Open markdown files in Marked.app - mapped to <leader>m
    Plug 'itspriddle/vim-marked', { 'for': 'markdown', 'on': 'MarkedOpen' }
    nmap <leader>m :MarkedOpen!<cr>
    nmap <leader>mq :MarkedQuit<cr>
    nmap <leader>* *<c-o>:%s///gn<cr>
  " }}}

  " JSON {{{
    Plug 'elzr/vim-json', { 'for': 'json' }
    let g:vim_json_syntax_conceal = 0
  " }}}

  Plug 'ekalinin/Dockerfile.vim'
" }}}

call plug#end()

" Colorscheme and final setup {{{
  " This call must happen after the plug#end() call to ensure
  " that the colorschemes have been loaded
  let g:onedark_termcolors=16
  let g:onedark_terminal_italics=1
  syntax on
  colorscheme onedark
  filetype plugin indent on

  " Make the highlighting of tabs and other non-text less annoying
  highlight SpecialKey ctermfg=19 guifg=#333333
  highlight NonText ctermfg=19 guifg=#333333

  " Make comments and HTML attributes italic
  highlight Comment cterm=italic term=italic gui=italic
  highlight htmlArg cterm=italic term=italic gui=italic
  highlight xmlAttrib cterm=italic term=italic gui=italic
  highlight Normal ctermbg=none

  " Show a different background color as 'warning' and 'danger' markers
  if v:version > 703
    highlight ColorColumn ctermbg=240 guibg=#1f2126
    let &colorcolumn="81,".join(range(121,999),",")
  endif
" Colorscheme and final setup {{{
Plug 'joshdick/onedark.vim' " load colorscheme
Plug 'sheerun/vim-polyglot' " improved syntax highlighting for various languages
call plug#end()

" This call must happen after the plug#end() call to ensure
" that the colorschemes have been loaded
let g:onedark_termcolors=16
let g:onedark_terminal_italics=1
syntax on
colorscheme onedark " all options for the colorscheme should be set before this line
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
" vim:set foldmethod=marker foldlevel=0
