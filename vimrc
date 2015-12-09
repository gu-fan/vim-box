let g:debug = 0

" Basci Settings Without any Bundle
exe 'so <sfile>:p:h/' . 'lib/debug.vim'
exe 'so <sfile>:p:h/' . 'lib/require.vim'

" exe 'so <sfile>:p:h\' . 'lib\os.vim'
Require lib/os
Require lib/is
Require mswin

Require dev/miv

"Require dev/init
"let path = expand('<sfile>:p')
"let k = Require('dev/mods', path)
"let m = Require('dev/test', path)

" Require dev/test/ui

" for easier 'gf'
set sua=.vim,.vimrc
" set path=.,,~/.vim/plugged/

let g:mapleader=' '
let g:maplocalleader=' '
let g:unite_source_menu_menus = {}
let g:vim_box_packages = [
            \'basic',
            \'html',
            \'git',
            \'history',
            \'map',
            \'file']

nnoremap [menu] <Nop>
map <LocalLeader> [menu]
" nnoremap <silent>[menu]me :Unite -silent -winheight=20 menu<CR>

" mac
let g:fzf_launcher = "start_iterm %s"

" if !exists('s:plugged')
let s:plugged = 1
call plug#begin('~/.vim/plugged')

" Admin Git

" Show git repository changes in the current file
" Plug 'airblade/vim-gitgutter'
" Git viewer
" Browse github events in vim
" Plug 'joedicastro/vim-github-dashboard'
" Plug 'junegunn/vim-easy-align'

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
" Plug 'junegunn/fzf.vim'

" Unmanaged plugin (manually installed and updated)

" Add plugins to &runtimepath
Plug 'tomasr/molokai'

" Plug 'sjl/gundo.vim'

Plug 'fatih/vim-go'

for package in g:vim_box_packages
    let package_path = $VIM_BOX. "/package/" . package . "/bundle.vimrc"
    " if filereadable(package_path)
        sil! exec ':so ' package_path
    " endif
endfor

" >> map/bundle.vimrc

Plug 'Shougo/vimproc.vim'
" Plug 'Shougo/vimshell.vim'
" let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
" if has('win32') || has('win64')
"     " Display user name on Windows.
"     let g:vimshell_prompt = $USERNAME."% "
" else
"     " Display user name on Linux.
"     let g:vimshell_prompt = $USER."% "
" endif
" map <leader>rc :call <SID>cd_cur_dir()<CR>
" map <leader>rr :call <SID>exec_cur_line()<CR>
"
" fun! s:cd_cur_dir()
"     let dir = expand('%:p:h')
"     exe 'VimShellSendString cd '.dir
" endfun
" fun! s:exec_cur_line()
"     let line = substitute(getline('.'), '^\s*\|\s*$','','g')
"     exe 'VimShellSendString '.line
" endfun
"
" com! -nargs=* VS VimShellSendString <args>
" com! -nargs=* VV VimShellSendString <args>


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
Plug 'tpope/vim-obsession'

let _p = expand('~/.vim/session')
if !isdirectory(_p)
    call mkdir(_p, 'p')
endif

set ssop=blank,curdir,help,options,resize,tabpages,winpos,winsize

command! -nargs=? Save call s:save_session(<q-args>)
command! -nargs=? Load call s:load_session(<q-args>)

fun! s:save_session(ses)
    if a:ses
        exe 'Obsession ~/.vim/session/' . a:ses
    else
        Obsession ~/.vim/session/default.vim
    endif
endfun
fun! s:load_session(ses)
    if a:ses
        exe 'so ~/.vim/session/' . a:ses
    else
        so ~/.vim/session/default.vim
    endif
endfun

" deploy
" Plug 'Puppet-Syntax-Highlighting'

" trans

"
Plug 'rking/ag.vim'
Plug 'vim-jp/vital.vim'
Plug 'groenewege/vim-less'

" oh-my
Plug 'rykka/colorv.vim'
Plug 'rykka/galaxy.vim'
" Plug 'rykka/easydigraph.vim'
Plug 'rykka/lastbuf.vim'
" Plug 'rykka/jass.vim'
" Plug 'rykka/mathematic.vim'
" Plug 'rykka/zendjango.vim'
Plug 'rykka/trans.vim'
" This api is much faster.
let g:trans_default_api = 'youdao'
let g:trans_map_trans = '<localleader>tt'

Plug 'rykka/riv.vim'

let proj1 = {'path': '~/Dropbox/Riv/'}
let proj2 = {'path': '~/Dropbox/wiki/'}
let proj3 = {'path': '~/test/sphinx/'}

let g:riv_projects = [proj1, proj2, proj3]
" XXX: This should be set as a project option.
let g:riv_file_link_style = 2

Plug 'rykka/miv.vim'
" Plug 'rykka/os.vim'
" Plug 'rykka/clickable.vim'
" let g:clickable_browser = 'google chrome'
" Plug 'rykka/clickable-things'
" Plug 'rykka/autotype.vim'
Plug 'rykka/InstantRst'

Plug 'Lokaltog/vim-easymotion'
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader> <Plug>(easymotion-prefix)
" Gif config
"
nmap f <Plug>(easymotion-s)
nmap t <Plug>(easymotion-t)
" " Gif config
" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)

" " These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" " Without these mappings, `n` & `N` works fine. (These mappings just provide
" " different highlight method and have some other features )
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)

" nmap s <Plug>(easymotion-s)
" Bidirectional & within line 't' motion
omap t <Plug>(easymotion-bd-tl)
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
 " type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1

Plug 'bling/vim-airline'

Plug 'vim-scripts/if_v8'

" Plug 'sjl/gundo.vim'
" Plug 'rykka/instant-uml.vim'
call plug#end()

" endif

" TODO
" we should make this a require too.
for package in g:vim_box_packages
    let package_path = $VIM_BOX. "/package/" . package . "/basic.vimrc"
    " if filereadable(package_path)

        sil! exec ':so ' package_path
    " endif
endfor

if !exists('s:loaded')
    let s:loaded = 1
    filetype plugin indent on      " Indent and plugins by filetype
    syntax enable                  " enable the syntax highlight
endif
