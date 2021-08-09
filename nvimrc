let g:debug = 0

set ff=unix
set ffs=unix,dos
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,cp936
scriptencoding utf-8
language messages zh_CN.utf-8



" Basci Settings Without any Bundle
exe 'so <sfile>:p:h/' . 'lib/debug.vim'
exe 'so <sfile>:p:h/' . 'lib/require.vim'

Require lib/os
Require lib/is

Require mswin
behave xterm        " fix mouse selection issue

if _v.is_windows
    set ffs=dos
endif


" DEV WORK
Require dev/miv

let g:require_file_index = 1

"Require dev/init
"let path = expand('<sfile>:p')
"let k = Require('dev/mods', path)
"let m = Require('dev/test', path)

" Require dev/test/ui

" for easier 'gf'
set sua=.vim,.vimrc
" set path=.,,~/.vim/plugged/
"
let g:mapleader=' '
let g:maplocalleader=' '
let $VIM_BOX=expand("~/vim-box")
if has('nvim')
    let $VIM_BOXRC= $VIM_BOX . '/nvimrc'
    nmap <leader>vv :e $VIM_BOX/nvimrc<CR>
else
    let $VIM_BOXRC= $VIM_BOX . '/vimrc'
    nmap <leader>vv :e $VIM_BOX/vimrc<CR>
endif

aug au_Vimrc "{{{
    au!
    if has('nvim')
        autocmd! BufWritePost vimrc source %
    else
        autocmd! BufWritePost nvimrc source %
    endif

    autocmd! BufWritePost *.vimrc source $VIM_BOXRC
    " au SourcePre ~/Dropbox/dotfiles/.vimrc redraw | echohl WarningMsg
    "             \|echom "Reloading .vimrc"|echohl Normal
    " au BufWritePre,FileWritePre ~/Dropbox/dotfiles/.vimrc  LastUpdate
    " au BufWritePost,FileWritePost ~/Dropbox/dotfiles/.vimrc redraw
    "             \|echohl WarningMsg
    "             \|echom "Writing .vimrc"|echohl Normal
    "             \|so $MYVIMRC|normal '.zv
    " load vimrc after load any session.
    " au SessionLoadPost * so ~/.vimrc
    " avoid using function while redefine it.
    " au BufRead */.vimrc map <buffer> <F5> :silent so %<CR>
    

aug END "}}}

let g:vim_box_packages = [
            \'basic',
            \'map',
            \]

nnoremap [menu] <Nop>
map <LocalLeader> [menu]

call plug#begin('~/.nvim/plugged')
Plug 'crusoexia/vim-monokai'


" FILE MANAGER "{{{
Plug 'preservim/nerdtree' "{{{
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1
let g:NERDTreeShowBookmarks = 0
let g:NERDTreeWinPos = 'right'
let NERDTreeIgnore=['\~$', '.meta$[[file]]'] "}}}
Plug 'kien/ctrlp.vim' "{{{
nmap <C-J>  :CtrlPLine<CR>
let g:ctrlp_custom_ignore =  {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules)$'
    \ }

fun! V(...)
    CtrlPMRU
    if a:0 
        call feedkeys(a:1)
    endif
endfun
com! -nargs=* V call V(<q-args>)
map <leader>pv  :CtrlPMRU<CR>
map <leader>pl  :CtrlPLine<CR>
map <leader>pp  :CtrlP<CR> "}}}
"}}}

" NAVIGATION {{{
Plug 'Lokaltog/vim-easymotion' "{{{
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader> <Plug>(easymotion-prefix)

nmap f <Plug>(easymotion-s)
nmap t <Plug>(easymotion-t)

" Bidirectional & within line 't' motion
omap t <Plug>(easymotion-bd-tl)
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
 " type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1 "}}}
"}}}

" CODING
Plug 'tomtom/tcomment_vim'
let g:tcomment_opleader1= '<leader>c'
nnoremap <c-/> :TComment<cr>
let g:tcomment#filetpye#guess = 0
let g:tcomment#filetype#guess_vue = 'html'
Plug 'tpope/vim-surround'

" COMPLETE "{{{
" Plug 'neovim/nvim-lspconfig'
" Plug 'glepnir/lspsaga.nvim'
" nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
Plug 'neoclide/coc.nvim', {'branch': 'release'}
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"}}}
" HTML
Plug 'mattn/emmet-vim'

let g:user_emmet_settings       = { 
    \ 'indentation' : '    ',
    \ 'vue': {
    \ 'extends' : 'html'
    \}}
let g:user_emmet_leader_key     = '<c-f>'
let g:user_emmet_expandabbr_key = '<c-f>f'    "e
let g:user_emmet_expandword_key = '<c-f>F'    "e
let g:user_emmet_next_key       = '<c-f>j'    "n
let g:user_emmet_prev_key       = '<c-f>k'    "p
let g:user_emmet_removetag_key  = '<c-f>d'    "k

Plug 'maksimr/vim-jsbeautify'


" UTILS "{{{
Plug 'sjl/gundo.vim'
Plug 'rykka/lastbuf.vim'
"}}}
" GIT "{{{
Plug 'tpope/vim-fugitive'
nnoremap <Leader>gp :Git! push<CR>
nnoremap <Leader>gP :Git! pull<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gb :Gblame<CR>
Plug 'airblade/vim-gitgutter'
"}}}
"
" WIKI{{{
Plug 'rykka/riv.vim'

let proj2 = {'path': '~/Dropbox/riv/'}
let proj3 = {'path': '~/Dropbox/wiki/'}
let proj1 = {'path': '~/Dropbox/wiki_new/'}
let proj4 = {'path': '~/test/sphinx/'}

let g:riv_todo_datestamp = 0

let g:riv_projects = [proj1, proj2, proj3, proj4]
" XXX: This should be set as a project option.
let g:riv_file_link_style = 2
"}}}
call plug#end()

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

color monokai

behave xterm        " fix mouse selection issue
set noimd           " I want to use IME
