" Plugins que solo se instalan si esto es NeoVim
if has('nvim')
call plug#begin('~/.config/nvim/plugged')
  Plug 'valloric/youcompleteme',       { 'do': './install.py --all' }
  Plug 'vim-ruby/vim-ruby',            { 'for': 'ruby' }
else
  call plug#begin('~/.vim/plugged')
endif

" Utilidades
Plug 'tpope/vim-fugitive'                               " Utilizar git sin salir de Vim
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } | Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'ryanoasis/vim-devicons'                                   " Un explorador tipo árbol Help -> :h NERD_tree
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'ctrlpvim/ctrlp.vim'     " Buscador de ficheros y mucho más Help -> :h ctrlp;  https://github.com/junegunn/fzf
Plug 'mileszs/ack.vim'                                  " Busca en los archivos usando ack. Lo mismo que la utilidad para la línea de comandos ack, pero usando :Ack
Plug 'raimondi/delimitmate'                             " Cerrar automáticamente comillas, paréntesis..
Plug 'neomake/neomake'                                " Reemplazo de neovim para syntastic
Plug 'tpope/vim-surround'                               " Cambiar fácilmente comillas, paréntesis.. Help -> :h surround
Plug 'tpope/vim-commentary'                             " Comentar cosas
Plug 'tpope/vim-unimpaired'                             " Mapeos de comandos comunes para el modo normal
Plug 'tpope/vim-endwise',            { 'for': 'ruby' }  " Añadir fin automáticamente en ruby
Plug 'tpope/vim-ragtag'                                 " Mejora vim-surround para html, xml, etc
Plug 'benmills/vimux'                                   " Integrar vim en tmux
Plug 'vim-airline/vim-airline'                          " Añadir color a la barra de estado Help -> :h airline
Plug 'vim-airline/vim-airline-themes'                   " Temas para vim-airline
Plug 'flazz/vim-colorschemes'                           " Tener disponibles todos los esquemas de colores para vim
Plug 'tpope/vim-repeat'                                 " Habilita la repetición de comandos de los plugins soportados con el comando .
Plug 'sirver/ultisnips' | Plug 'garbas/vim-snipmate'    " Completar código y escribir fragmentos predefinidos Help -> :h UltiSnips
Plug 'honza/vim-snippets'
Plug 'editorconfig/editorconfig-vim'                    " Soporte para .editorconfig
Plug 'MarcWeber/vim-addon-mw-utils'                     " Interpretar un archivo por función y cache del archivo automáticamente
Plug 'tomtom/tlib_vim'                                  " Funciones de utilidad para vim
Plug 'sotte/presenting.vim', { 'for': 'markdown' }      " Una herramienta simple para presentar diapositivas en vim basadas en archivos de texto
Plug 'ervandew/supertab'                                " Realiza todas las completaciones en el modo insertar de vim con Tab
Plug 'tpope/vim-dispatch'                               " Compilación y despachador de pruebas asíncronos
Plug 'tpope/vim-vinegar'                                " Mejora netrw
Plug 'AndrewRadev/splitjoin.vim'                        " single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
Plug 'vim-scripts/matchit.zip'                          " extended % matching
Plug 'tpope/vim-sleuth'                                 " detect indent style (tabs vs. spaces)
Plug 'sickill/vim-pasta'                                " context-aware pasting

" html / plantillas
Plug 'mattn/emmet-vim', { 'for': 'html' }               " Soporte de emmet para vim - crear fácilmente marcado con sintaxis parecida a CSS
Plug 'gregsexton/MatchTag', { 'for': 'html' }           " match tags in html, similar to paren support
Plug 'othree/html5.vim', { 'for': 'html' }              " Soporte para html5
Plug 'mustache/vim-mustache-handlebars'                 " Soporte para mustach
Plug 'digitaltoad/vim-jade', { 'for': ['jade', 'pug'] } " Soporte para jade

" JavaScript
Plug 'gavocanov/vim-js-indent', { 'for': 'javascript' } " Soporte del sangrado para JavaScript
Plug 'moll/vim-node', { 'for': 'javascript' }           " Soporte para node
Plug 'othree/yajs.vim', { 'for': 'javascript' }         " Extensión para sintaxis en JavaScript
Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' } " Sintaxis de ES6 y más allá
Plug 'mxw/vim-jsx', { 'for': ['jsx', 'javascript'] }    " Soporte para JSX

" TypeScript
Plug 'jason0x43/vim-tss', { 'for': 'typescript', 'do': 'npm install' }
Plug 'clausreinke/typescript-tools.vim', { 'for': 'typescript' } " Herramientas para typescript
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' } " Soporte para typescript

" Elm
Plug 'lambdatoast/elm.vim', { 'for': 'elm' }

" styles
Plug 'wavded/vim-stylus', { 'for': ['stylus', 'markdown'] } " Soporte de marcado
Plug 'groenewege/vim-less', { 'for': 'less' }           " Soporte para less
Plug 'ap/vim-css-color', { 'for': ['css','stylus','scss'] } " set the background of hex color values to the color
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }         " CSS3 syntax support
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }     " sass scss syntax support

" markdown
Plug 'itspriddle/vim-marked', { 'for': 'markdown', 'on': 'MarkedOpen' } " Open markdown files in Marked.app - mapped to <leader>m
Plug 'tpope/vim-markdown', { 'for': 'markdown' }        " markdown support

" language-specific plugins
Plug 'elzr/vim-json', { 'for': 'json' }                 " JSON support
Plug 'Shougo/vimproc.vim', { 'do': 'make' }             " interactive command execution in vim
Plug 'fatih/vim-go', { 'for': 'go' }                    " go support
Plug 'timcharper/textile.vim', { 'for': 'textile' }     " textile support
call plug#end()
