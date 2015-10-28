" Basci Settings Without any Bundle
so <sfile>:p:h/lib/os.vim
so <sfile>:p:h/lib/main.vim

Require lib/debug
Require lib/is
Require dev/init

" let g:debug = 1

" for easy 'gf'
set sua=.vim,.js
" set path=.,,~/.vim/plugged/

let g:mapleader=' '
let g:maplocalleader=' '
let g:unite_source_menu_menus = {}
let g:vim_box_packages = ['basic', 'html', 'git', 'history', 'map', 'file']

nnoremap [menu] <Nop>
map <LocalLeader> [menu]
" nnoremap <silent>[menu]me :Unite -silent -winheight=20 menu<CR>

" mac
let g:fzf_launcher = "start_iterm %s"

call plug#begin('~/.vim/plugged')

Plug '~/Dropbox/vim-box/dev/require.vim'
Plug '~/Dropbox/vim-box/dev/ui.vim'

" Admin Git

" Show git repository changes in the current file
" Plug 'airblade/vim-gitgutter'
" Git viewer
" Browse GitHub events in Vim
" Plug 'joedicastro/vim-github-dashboard'
" Plug 'junegunn/vim-easy-align'

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
" Plug 'junegunn/fzf.vim'

" Unmanaged plugin (manually installed and updated)

" Add plugins to &runtimepath
" Plug 'tomasr/molokai'

" Plug 'sjl/gundo.vim'

" Plug 'scrooloose/syntastic'

for package in g:vim_box_packages
    let package_path = $VIM_BOX. "/package/" . package . "/bundle.vimrc"
    if filereadable(package_path)
        exec ':so ' package_path
    endif
endfor

" >> map/bundle.vimrc

Plug 'Shougo/vimproc.vim'
" Plug 'Shougo/vimshell.vim'


" Plug 'vim-scripts/sudo.vim'

" Plug 'tpope/vim-dispatch'

" Docuemnt under macos
" Plug 'rizzatti/dash.vim'

" Plug 'mattn/calendar-vim'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
" Plug 'vim-scripts/fcitx.vim'

" tabbar
" Plug 'dbext.vim'

" Plug 'matchit.zip'
" Plug 'godlygeek/tabular'
" Plug 'jmcantrell/vim-virtualenv'

" Plug 'vimwiki'
" Plug 'xolox/vim-misc'
" Plug 'xolox/vim-session'
" Plug "tpope/vim-obsession"

" deploy
" Plug 'Puppet-Syntax-Highlighting'

" trans

"
Plug 'rking/ag.vim'
Plug 'vim-jp/vital.vim'

" oh-my
Plug 'rykka/colorv.vim'
Plug 'rykka/galaxy.vim'
" Plug 'rykka/easydigraph.vim'
Plug 'rykka/lastbuf.vim'
" Plug 'rykka/jass.vim'
" Plug 'rykka/mathematic.vim'
" Plug 'rykka/zendjango.vim'
Plug 'rykka/trans.vim'
Plug 'rykka/riv.vim'
Plug 'rykka/miv.vim'
" Plug 'rykka/os.vim'
" Plug 'rykka/clickable.vim'
" Plug 'rykka/clickable-things'
" Plug 'rykka/autotype.vim'
Plug 'rykka/InstantRst'

" Plug 'Lokaltog/vim-easymotion'

Plug 'bling/vim-airline'

" Plug 'sjl/gundo.vim'

 " Plug 'rykka/instant-uml.vim'
call plug#end()

" TODO
" we should make this a require too.
for package in g:vim_box_packages
    let package_path = $VIM_BOX. "/package/" . package . "/basic.vimrc"
    if filereadable(package_path)
        exec ':so ' package_path
    endif
endfor

filetype plugin indent on      " Indent and plugins by filetype
syntax enable                  " enable the syntax highlight
