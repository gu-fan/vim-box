let galaxy_path = expand("~/.vim/plugged/galaxy.vim/colors/galaxy.vim")

" Theme
let g:galaxy_enable_statusline = 0

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1

let g:airline_theme='raven'
let g:airline_powerline_fonts=1
let g:airline#extensions#hunks#non_zero_only = 1

set background=dark            " set a dark background
set t_Co=256                   " 256 colors for the terminal

if filereadable(galaxy_path)
    colorscheme galaxy
else
    colorscheme desert
endif

set nopaste
set pastetoggle=<F2>

" windows

if g:_v.is_windows
    set guifont=Droid\ Sans\ Mono\ for\ Powerline:h12
else
    set guifont=Droid\ Sans\ Mono\ for\ Powerline:h14
endif

if has('unix')
    set shell=/bin/sh
endif

scriptencoding utf-8
set encoding=utf-8              " setup the encoding to UTF-8
set ls=2                        " status line always visible
set go-=T                       " hide the toolbar
set go-=m                       " hide the menu
" The next two lines are quite tricky, but in Gvim, if you don't do this, if you
" only hide all the scrollbars, the vertical scrollbar is showed anyway
set go+=RL 
set go+=rlbh                  " show all the scrollbars
set go-=rlbh                  " hide all the scrollbars
set visualbell                  " turn on the visual bell
" set cursorline                  " highlight the line under the cursor
set fillchars+=vert:│           " better looking for windows separator
set ttyfast                     " better screen redraw
set title                       " set the terminal title to the current file
set showcmd                     " shows partial commands
set hidden                      " hide the inactive buffers
set ruler                       " sets a permanent rule
set lazyredraw                  " only redraws if it is needed
set autoread                    " update a open file edited outside of Vim
set ttimeoutlen=0               " toggle between modes almost instantly
set backspace=indent,eol,start  " defines the backspace key behavior
set virtualedit=all             " to edit where there is no actual character

" set scrolloff=7                 " buffer when scrolling
set scrolloff=1 scrolljump=1

set winheight=3
set winminheight=0

set cc=

" Wildmenu {{{

set wildmenu                        " Command line autocompletion
" set wildmode=list:longest,full      " Shows all the options
set wildmode=longest,full      " Shows all the options

set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.bak,*.?~,*.??~,*.???~,*.~      " Backup files
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.jar                            " java archives
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.stats                          " Pylint stats

" }}}

" Tabs, space and wrapping {{{

set expandtab                  " spaces instead of tabs
set tabstop=4                  " a tab = four spaces
set shiftwidth=4               " number of spaces for auto-indent
set softtabstop=4              " a soft-tab of four spaces
set autoindent                 " set on the auto-indent
set smartindent                " indent on some case


" set formatoptions=qrn1ct
set textwidth=80
set colorcolumn=81

" }}}
if has('unnamedplus')
    set clipboard=autoselectplus,html,unnamedplus,exclude:cons\|linux
else
    set clipboard=autoselect,unnamed
endif


