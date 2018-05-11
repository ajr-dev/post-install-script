" .vimrc / init.vim
" The following configuration works for both Vim and NeoVim

" ensure vim-plug is installed and then load it
call functions#PlugLoad()
call plug#begin('~/.config/nvim/plugged')

" General {{{
    " Abbreviations
    abbr funciton function
    abbr teh the
    abbr tempalte template
    abbr fitler filter
    abbr cosnt const
    abbr attribtue attribute
    abbr attribuet attribute

    set autoread " detect when a file is changed
    set history=1000 " change history to 1000
    set secure " disable insecure commands in .vimrc files
    set nobackup nowritebackup noswapfile " don't make security copies of files

    if (has('nvim'))
        " show results of substition as they're happening
        " but don't open a split
        set inccommand=nosplit
    endif

    set backspace=indent,eol,start " make backspace behave as usual
    " make backspace work in normal mode as in insert mode
    nnoremap <bs> Xi

    set clipboard+=unnamed,unnamedplus " use system clipboard for y and p commands

    if has('mouse')
        set mouse=a
    endif

    " Searching
    set ignorecase " case insensitive searching
    set smartcase " case-sensitive if expresson contains a capital letter
    set hlsearch " highlight search results
    set incsearch " search as characters are introduced
    set nolazyredraw " don't redraw while executing macros
    set magic " set magic on, for regex

    " error bells
    set noerrorbells
    set visualbell
    set t_vb=
    set tm=500
" }}}

" Appearance {{{
    set relativenumber " show relative line number of the current line
    set wrap " turn on line wrapping
    set whichwrap+=<,>,h,l,[,] " change line when moving right or left
    "set wrapmargin=8 " wrap lines when coming within n characters from side
    set linebreak " set soft wrapping
    set autoindent " automatically set indent of new line
    set ttyfast " faster redrawing
    set diffopt+=vertical
    set laststatus=2 " show the satus line all the time
    set so=7 " set 7 lines to the cursors - when moving vertical
    set wildmenu " enhanced command line completion
    set wildignorecase " complete filename ignoring case
    set hidden " current buffer can be put into background
    set showcmd " show incomplete commands
    set noshowmode " don't show which mode disabled for PowerLine
    set wildmode=list:longest " complete files like a shell
    set scrolloff=3 " lines of text around cursor
    set shell=$SHELL
    set cmdheight=1 " command bar height
    set title " set terminal title
    set showmatch " show matching braces
    set mat=2 " how many tenths of a second to blink
    set ffs=unix,dos,mac " use unix as standard filetype
    set encoding=utf8 " select utf8 as standard encoding
    set completeopt+=longest

    " Tab control
    set expandtab " insert spaces rather than tabs
    set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
    set tabstop=4 " the visible width of tabs
    set softtabstop=4 " edit as if the tabs are 4 characters wide
    set shiftwidth=4 " number of spaces to use for indent and unindent
    set shiftround " round indent to a multiple of 'shiftwidth'

    " Code folding settings
    set foldmethod=syntax " fold based on indent
    set foldlevelstart=99
    set foldnestmax=10 " deepest fold is 10 levels
    set nofoldenable " don't fold by default
    set foldlevel=1
    set modeline " allow file specific folding configuration

    " Toggle invisible characters
    set list
    set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
    set showbreak=↪ " show ellipsis at line break

    set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
    " switch cursor to line when in insert mode, and block when not
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175

    if &term =~ '256color'
        " disable background color erase
        set t_ut=
    endif

    if has("termguicolors")
        set termguicolors
    endif

    " highlight conflicts
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

    Plug 'joshdick/onedark.vim' " load colorschemes

    " Airline {{{
        Plug 'vim-airline/vim-airline' " fancy statusline
        Plug 'vim-airline/vim-airline-themes' " themes for vim-airline
        let g:airline_powerline_fonts=1
        let g:airline_theme='onedark'
        let g:airline#extensions#tabline#enabled = 1              " Habilitar la pestaña de Airline
        let g:airline#extensions#tabline#tab_min_count = 2        " Mostrar las pestañas
        let g:airline#extensions#tabline#show_buffers = 1         " Mostrar los bufers abiertos
        let g:airline#extensions#tabline#show_splits = 0
    " }}}
" }}}

" General Mappings {{{
    " set a map leader for more key combos
    let mapleader = ","

    " remap esc
    inoremap jk <esc>

    " exchange 0 y ^
    noremap 0 ^
    noremap ^ 0

    " don't do anything when pressing Q
    :map Q <Nop>

    " assign search to <Space> and backward search to Ctrl-<Space>
    map <space> /
    map <c-space> ?

    " clear highlighted search
    noremap <leader><cr> :set hlsearch! hlsearch?<cr>

    " Search the word under the cursor
    nnoremap <leader><space> "fyiw :/<c-r>f<cr>

    " Shortcut to save
    nmap <leader>, :w<cr>

    " Automatically save after editing
    inoremap <Esc> <Esc>:w<CR>

    " Allow saving of files as sudo when I forgot to start vim using sudo.
    command! W w !sudo tee % > /dev/null<cr>
    cmap w!! w !sudo tee > /dev/null %
    "nmap <leader>, :w !sudo tee % > /dev/null<cr>

    " Ctrl-S for saving file
    noremap <silent> <C-S>          :update<CR>
    vnoremap <silent> <C-S>         <C-C>:update<CR>
    inoremap <silent> <C-S>         <C-O>:update<CR>

    " Make Ctrl x, Ctrl c and  Ctrl v cut, copy and paste
    vmap <C-c> "+y
    vmap <C-x> "+c
    vmap <C-v> c<ESC>"+p
    imap <C-v> <ESC>"+pa

    " toggle between indenting pasted text or not
    set pastetoggle=<leader>v

    " fast edit of config files
    map <leader>ev :e! $MYVIMRC<cr>
    map <leader>eg :e! ~/.gitconfig<cr>

    " activate spell-checking alternatives
    nmap ;s :set invspell spelllang=en<cr>

    " markdown to html
    nmap <leader>md :%!markdown --html4tags <cr>

    " remove extra whitespace
    nmap <leader>tr :%s/\s\+$<cr>
    nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

    " helpers for dealing with other people's code
    nmap \t :set ts=4 sts=4 sw=4 noet \| retab<cr>
    nmap \s :set ts=4 sts=4 sw=4 et \| retab<cr>

    " Filetype specific spaces not working properly sometimes
    nmap <leader>ss :set sw=2 \| set ts=2 \| set sts=2

    " Textmate style indentation
    vmap <leader>[ <gv
    vmap <leader>] >gv
    nmap <leader>[ <<
    nmap <leader>] >>

    " switch between current and last buffer
    nmap <leader>. <c-^>

    " enable . command in visual mode
    vnoremap . :normal .<cr>

    " Move quickly between buffers
    map <leader>h :bp<cr>
    map <leader>l :bn<cr>
    map <leader>d :bd<cr>

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

    " toggle cursor line
    nnoremap <leader>i :set cursorline!<cr>

    " scroll the viewport faster
    nnoremap <C-e> 3<C-e>
    nnoremap <C-y> 3<C-y>

    " Treat long lines as if they were split. It's useful to move around easily
    nnoremap <silent> j gj
    nnoremap <silent> k gk
    nnoremap <silent> ^ g^
    nnoremap <silent> $ g$
" }}}

" AutoGroups {{{
    " file type specific settings
    augroup configgroup
        autocmd!

        autocmd Filetype xhtml,php,html,javascript setlocal autoindent smartindent expandtab shiftwidth=2 tabstop=2 softtabstop=2
        autocmd FileType make setlocal noexpandtab

        " automatically resize panes on resize
        autocmd VimResized * exe 'normal! \<c-w>='
        " Automatically reload configuration
        autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
        autocmd BufWritePost .vimrc.local .local.vim source %

        " save all files on focus lost, ignoring warnings about untitled buffers
        autocmd FocusLost * silent! wa
    augroup END
" }}}

" General Functionality {{{
    Plug 'jiangmiao/auto-pairs' " insert or delete brackets, parens, quotes in pair
    Plug 'tpope/vim-ragtag' " endings for html, xml, etc. - ehances surround
    Plug 'tpope/vim-surround' " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.

    " add end, endif, etc. automatically
    Plug 'tpope/vim-endwise', { 'for': [ 'ruby', 'bash', 'zsh', 'sh', 'vim' ]}

    " NERDTree {{{
        Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
        Plug 'Xuyuanp/nerdtree-git-plugin'
        "Plug 'ryanoasis/vim-devicons'

        " Toggle NERDTree
        function! ToggleNerdTree()
            if @% != "" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
                :NERDTreeFind
            else
                :NERDTreeToggle
            endif
        endfunction
        " toggle nerd tree
        nmap <silent> <leader>k :call ToggleNerdTree()<cr>
        " find the current file in nerdtree without needing to reload the drawer
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

        " shortcuts for using git within vim
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
        let g:ycm_server_python_interpreter = '/usr/bin/python'
        let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

        " make YCM compatible with UltiSnips (using supertab)
        let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
        let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
        let g:SuperTabDefaultCompletionType = '<C-n>'
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

call plug#end()

" Colorscheme and final setup {{{
    " This call must happen after the plug#end() call to ensure
    " that the colorschemes have been loaded
    let g:onedark_termcolors=16
    let g:onedark_terminal_italics=1
    colorscheme onedark
    syntax on
    filetype plugin indent on
    " make the highlighting of tabs and other non-text less annoying
    highlight SpecialKey ctermfg=236
    highlight NonText ctermfg=236

    " make comments and HTML attributes italic
    highlight Comment cterm=italic
    highlight htmlArg cterm=italic
    highlight xmlAttrib cterm=italic
    highlight Type cterm=italic
    highlight Normal ctermbg=none

    highlight ColorColumn ctermbg=240 guibg=#2c2d27
    let &colorcolumn="81,".join(range(121,999),",")
" }}}

" use local configuration file if available
if !empty(glob("~/.vim.local"))
    source ~/.vim.local
endif

" vim:set foldmethod=marker foldlevel=0
