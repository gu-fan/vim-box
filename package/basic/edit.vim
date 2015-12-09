Debug 'edit'

scriptencoding utf-8
set encoding=utf-8              " setup the encoding to UTF-8
    
set nopaste
set pastetoggle=<F2>
set autoread                    " update a open file edited outside of Vim
set ttimeoutlen=0               " toggle between modes almost instantly

set backspace=indent,eol,start  " defines the backspace key behavior
" set virtualedit=all             " to edit where there is no actual character
set virtualedit=block             " to edit where there is no actual character


" Tabs, space and wrapping {{{
set expandtab                  " spaces instead of tabs
set tabstop=4                  " a tab = four spaces
set shiftwidth=4               " number of spaces for auto-indent
set softtabstop=4              " a soft-tab of four spaces
set autoindent                 " set on the auto-indent
set smartindent                " indent on some case
" }}}
"
if has('unnamedplus')
    set clipboard=autoselectplus,html,unnamedplus,exclude:cons\|linux
else
    set clipboard=autoselect,unnamed
endif
