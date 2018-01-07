Debug 'file'

Plug 'scrooloose/nerdtree'
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1
let g:NERDTreeShowBookmarks = 0
let g:NERDTreeWinPos = 'right'
let NERDTreeIgnore=['\~$', '.meta$[[file]]']

Plug 'kien/ctrlp.vim'
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
map <leader>pp  :CtrlP<CR>


" Plug 'Shougo/vimfiler.vim'
" Plug 'sjbach/lusty'
" let g:LustyExplorerSuppressRubyWarning = 1
" Plug 'mbbill/VimExplorer'

