source ~/.config/nvim/plugins.vim

" => Atajos de teclado {{{
let mapleader = ","
let g:mapleader = ","

" Intercambiar 0 y ^
noremap 0 ^
noremap ^ 0

" No hacer nada al presionar Q
:map Q <Nop>
" Escape
inoremap jk <esc>
" Atajos para usar git desde vim
noremap <leader>gs :Gstatus<cr>
noremap <leader>gc :Gcommit<cr>
noremap <leader>ga :Gwrite<cr>
noremap <leader>gl :Glog<cr>
noremap <leader>gd :Gdiff<cr>
noremap <leader>gb :Gblame<cr>
" Alternar NERDTree
nmap <silent> <leader>k :NERDTreeToggle<cr>
" Expandir a la ruta del archivo en el bufer actual
nmap <silent> <leader>y :NERDTreeFind<cr>
" Ver los mapeos para NERDTree
nmap <silent> <leader>nem :h NERDTreeMappings<cr>

" => Copiar y pegar {{{
set clipboard+=unnamed,unnamedplus                       " los comandos y, p utilizan el portapapeles del sistema
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa
" }}}

" Asignar la barra espaciadora <Space> a / (buscar) y Ctrl-<Space>
" a ? (búsqueda invertida)
map <space> /
map <c-space> ?

" Desactivar el resaltado de las búsquedas
map <silent> <leader><cr> :noh<cr>
"noremap <space> :set hlsearch! hlsearch?<cr>

"Activar las alternativas de corrección ortográfica
nmap ;s :set invspell spelllang=en<cr>

" Markdown para html
nmap <leader>md :%!markdown --html4tags <cr>

" Cambiar tabuladores por espacios
nmap <leader>r :set et \| retab<cr>
" Remover espacios en blanco sobrantes
 nmap <leader><space> :%s/\s\+$<cr>
" nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>
" Borrar los espacios en blanco de final de línea al guardar.
" http://vim.wikia.com/wiki/Remove_unwanted_spaces
" autocmd BufWritePre * :%s/\s\+$//e

" Filetype specific spaces not working properly sometimes
nmap <leader>ss :set sw=2 \| set ts=2 \| set sts=2

nmap <leader>l :set list!<cr>

" Textmate style indentation
"Indentación de estilo Textmate
vmap <leader>[ <gv
vmap <leader>] >gv
nmap <leader>[ <<
nmap <leader>] >>

" => Guardar {{{
" Edición y carga rápida de configuraciones vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
map <leader>eg :e! ~/.gitconfig<cr>
nnoremap <leader>s :source $MYVIMRC<cr>
" Guardar sesión {{{
" Guardar unas cuantas ventanas para que se abran igual la próxima vez que
" abras Vim. Después de guardar una sesión de Vim, la puedes volver a abrir
" escribiendo vim -S.
" }}}
nnoremap <leader>ms :mksession<cr>

" Ctrl-S para guardar fichero
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
" Atajo para guardar
nmap <leader>, :w<cr>
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
"command W w !sudo tee % > /dev/null
" nmap <leader>, :w !sudo tee % > /dev/null<cr>
" }}}
" => Pestañas, ventanas y búfers {{{
" Moverse rápidamente entre búfers
map <leader>h :bp<cr>
map <leader>l :bn<cr>
map <leader>d :bd<cr>

" Liquidar bufer
nmap <silent> <leader>b :bw<cr>

"Conmuta entre el búfer actual y el último
nmap <leader>. <c-^>

" Al abandonar un búber este se vuelve oculto. De esta forma
" no hay que guardar los búfers cuando se cambia de uno a otro.
set hidden
" }}}

" Habilitar comando . en modo visual
vnoremap . :normal .<cr>

map <silent> <C-h> :call functions#WinMove('h')<cr>
map <silent> <C-j> :call functions#WinMove('j')<cr>
map <silent> <C-k> :call functions#WinMove('k')<cr>
map <silent> <C-l> :call functions#WinMove('l')<cr>

map <leader>wc :wincmd q<cr>

"Alternar la línea del cursor
nnoremap <leader>i :set cursorline!<cr>

"Desplaza el visor más rápido
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Tratar las líneas largas como si estuvieran partidas (es útil para moverse por ellas fácilmente)
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" Busca la palabra bajo el cursor
nnoremap <leader>/ "fyiw :/<c-r>f<cr>

" Toggle NERDTree
nmap <silent> <leader>k :NERDTreeToggle<cr>
" expand to the path of the file in the current buffer
nmap <silent> <leader>y :NERDTreeFind<cr>

if isdirectory(".git")
    " if in a git project, use :GFiles
    nmap <silent> <leader>t :GFiles<cr>
else
    " otherwise, use :FZF
    nmap <silent> <leader>t :FZF<cr>
endif

"nmap <silent> <leader>r :Buffers<cr>
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


" Fugitive Shortcuts
"""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>gs :Gstatus<cr>
nmap <leader>ge :Gedit<cr>
nmap <silent><leader>gr :Gread<cr>
nmap <silent><leader>gb :Gblame<cr>

nmap <leader>m :MarkedOpen!<cr>
nmap <leader>mq :MarkedQuit<cr>
nmap <leader>* *<c-o>:%s///gn<cr>
"}}}
" => General {{{
set autoread                                              " recargar ficheros cuando cambian
set history=1000                                          " cambiar historial a 1000
set secure                                                " desactivar comandos inseguros en los archivos .vimrc
"set nobackup nowritebackup noswapfile                     " no realizar copias de seguridad
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backspace=indent,eol,start                            " backspace normal
set relativenumber                                        " show relative line number of the current line
set scrolloff=3                                           " mostrar contexto por encima/debajo del cursor
set noerrorbells
set visualbell
set t_vb=
set tm=500
" => Límite del texto {{{
"set textwidth=120                                        " cortar las líneas a los 120 caracteres

" Resaltar una línea completa
"highlight ColorColumn ctermbg=magenta
"set colorcolumn=81
highlight ColorColumn ctermbg=240 guibg=#2c2d27
"let &colorcolumn=join(range(81,999),",")
let &colorcolumn="81,".join(range(121,999),",")

" Resalta el texto que se pasa del límite
"highlight OverLength ctermbg=darkred guibg=#592929 "letras blancas ctermfg=white
"match OverLength /\%81v.\|\%>121v.\+/
"highlight ColorColumn ctermbg=darkred
"call matchadd ('ColorColumn', '\%81v', 100)
" }}}
"let g:python_host_prog = '/usr/local/bin/python'
"let g:python3_host_prog = '/usr/local/bin/python3'
" }}}
" => Colores y Fuentes {{{
"Cambiar cursor de línea cuando está en modo de inserción, y bloquear cuando no
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

"set background=dark
if &term =~ '256color'
    " desabilitar el color de fondo
    set t_ut=
endif

" Habilitar soporte para colores de 24 bit si está disponible
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
end
if ( has("termguicolors"))
    set termguicolors
endif

let g:onedark_termcolors=16
let g:onedark_terminal_italics=1

syntax on
colorscheme onedark

"Hacer el resaltado de las pestañas menos molesto
highlight SpecialKey ctermbg=none ctermfg=8
highlight NonText ctermbg=none ctermfg=8

" Poner comentarios y etiquetas html en cursiva
highlight Comment cterm=italic
highlight htmlArg cterm=italic
"if $TERM =~ "xterm-256color-italic" || $TERM =~ "tmux-256color-italic"
"    highlight Comment cterm=italic
"    highlight htmlArg cterm=italic
"endif

" Seleccionar utf8 como la codificación estándar
set encoding=utf8

" Usar Unix como el tipo de fichero estándar
set ttyfast                                               " Redibujado más rápido
set ffs=unix,dos,mac
set diffopt+=vertical
set laststatus=2                                          " Mostrar la barra de estado todo el tiempo
set so=7                                                  " Mostrar líneas alrededor del cursor
set wildmenu                                              " autocompletado de comandos
set showcmd                                               " mostrar comandos incompletos
set noshowmode                                            " No mostrar el modo desactivado para PowerLine
set wildmode=list:longest                                 " Completar ficheros como el terminal
set scrolloff=3                                           " Líneas alrededor del cursor
set shell=$SHELL
set cmdheight=1                                           " Altura de la barra de comandos
set title                                                 " Cambiar nombre del terminal

" Establecer fuente en función del sistema {{{
" Abrir enlace con gx, guardar archivo en fichero.sh y ejecutar 'bash fichero.sh'
" http://mxlian.github.io/install-hack-typeface-on-ubuntudebian.html
" }}}
" }}}
" => Tabulador y sangrado {{{
set smarttab      " sta                                   " Utilizar tabuladores de forma inteligente
set expandtab     " et                                    " Usar espacios en lugar de tabuladores
set tabstop=4     " ts                                    " Número de espacios por tabulador
set softtabstop=4 " sts                                   " Número de espacios por tabulador al editar
set shiftwidth=4  " sw                                    " Número de espacios sangrado automático
set shiftround                                            " Redondear indentado a un múltiplo de 'shiftwidth'
set completeopt+=longest
set wrap                                                " Envolver líneas
"set wrapmargin=8                                         " Envolver líneas cuando están a n caracteres del lado
set linebreak                                             " Envoltura suave
set showbreak=↪                                           " Mostrar elipsis al romper
set autoindent    " ai                                    " Mantener sangrado en el cambio de línea

" Mostrar tabuladores y espacios no deseados
set list
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" Resaltar conflictos
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
" }}}
" => Plegado {{{
" Cuando es distinto de cero, se muestra una columna con el ancho especificado
" al lado de la ventana que indica los pliegues abiertos y cerrados
" También sirve para dar algo de margen al texto
"set foldcolumn=2
set foldmethod=syntax                                     " Plegado basado en sangrado
set foldnestmax=10                                        " El plegado más profundo es 10 niveles
set nofoldenable                                            " No plegar por defecto
set foldlevel=1
set modeline                                              " permitir configuración de cada fichero con modeline
" }}}
" => Búsqueda {{{
set ignorecase                                               " No distingue entre mayúsculas y minúsculas al buscar
set smartcase                                                " Reconoce mayúsculas si se especifican
set hlsearch                                                 " Resaltar los resultados de las búsquedas
set incsearch                                                " Buscar conforme se introducen caracteres.
set nolazyredraw                                             " No redibujar cuando se ejecutan macros
set magic                                                    " Activar magia para regex
set showmatch                                                " Mostrar parejas de llaves
set mat=2                                                    " Por cuantas decimas de segundo parpadear

if (has('nvim'))
    " mostrar los resultados de las sustituciones mientras ocurren
    set inccommand=nosplit
endif
" }}}
" => Movimiento {{{
if has('mouse')
    set mouse=a
    " set ttymouse=xterm2
endif

" => {{{Por defecto, al pulsar las teclas izquierda/derecha, Vim no se moverá a la
"línea anterior/siguiente al alcanzar el primer/último carácter en la línea.
"Este comportamiento se puede cambiar fácilmente poniendo:
" }}}
set whichwrap+=<,>,h,l,[,]

"noremap <Up> :echo "Ni lo intentes"<cr>
"inoremap <Up> <Esc>:echo "Ni lo intentes"<cr>
"noremap <Right> :echo "Ni lo intentes"<cr>
"inoremap <Right> <Esc>:echo "Ni lo intentes"<cr>
"noremap <Down> :echo "Ni lo intentes"<cr>
"inoremap <Down> <Esc>:echo "Ni lo intentes"<cr>
"noremap <Left> :echo "Ni lo intentes"<cr>
"inoremap <Left> <Esc>:echo "Ni lo intentes"<cr>
" }}}
" => AutoGroups {{{
" Configuración específica por tipo de archivo
augroup configgroup
    autocmd!

    "autocmd filetype c,asm,python setlocal shiftwidth=4 tabstop=4 softtabstop=4
    autocmd Filetype xhtml,php,html,javascript setlocal autoindent smartindent expandtab shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType make setlocal noexpandtab

    "Redimensionar automáticamente los paneles al cambiar el tamaño
    autocmd VimResized * exe 'normal! \<c-w>='
    " Recargar configuración automáticamente
    autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
    autocmd BufWritePost .vimrc.local .local.vim source %
    " Guardar todos los archivos cuando se pierde el foco, ignorando las advertencias sobre bufers sin utilizar
    autocmd FocusLost * silent! wa
    " Hacer que las ventanas quickfix tomen toda la parte inferior de la pantalla
    " cuando hay varias ventanas abiertas
    autocmd FileType qf wincmd J

    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    let g:markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'json=javascript', 'stylus', 'html']

    autocmd BufNewFile,BufRead,BufWrite *.md syntax match Comment /\%^---\_.\{-}---$/

    " Análisis sintáctico al guardar el archivo
    autocmd! BufWritePost * Neomake
augroup END
" }}}
" Section Plugins {{{

" FZF
"""""""""""""""""""""""""""""""""""""

let NERDTreeShowHidden=1
let NERDTreeDirArrowExpandable = '▷'
let NERDTreeDirArrowCollapsible = '▼'

let g:fzf_layout = { 'down': '~25%' }

let g:neomake_javascript_jshint_maker = {
    \ 'args': ['--verbose'],
    \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
\ }

let g:neomake_typescript_tsc_maker = {
    \ 'args': ['-m', 'commonjs', '--noEmit' ],
    \ 'append_file': 0,
    \ 'errorformat':
        \ '%E%f %#(%l\,%c): error %m,' .
        \ '%E%f %#(%l\,%c): %m,' .
        \ '%Eerror %m,' .
        \ '%C%\s%\+%m'
\ }

" Airline options
let g:airline_powerline_fonts=1
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1              " Habilitar la pestaña de Airline
let g:airline#extensions#tabline#tab_min_count = 2        " Mostrar las pestañas
let g:airline#extensions#tabline#show_buffers = 1         " Mostrar los bufers abiertos
let g:airline#extensions#tabline#show_splits = 0

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Airline Symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Don't hide quotes in json files
let g:vim_json_syntax_conceal = 0

let g:SuperTabCrMapping = 0

" DelimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" Hacer que YCM sea compatible con UltiSnips (usando supertab)
"Plugin 'ervandew/supertab'
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" Mejores mapeos de teclas para UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" }}}

" use local configuration file
if !empty(glob("~/.local.vim"))
    source ~/.local.vim
endif

" vim:foldmethod=marker:foldlevel=0
