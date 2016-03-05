Plug 'mattn/emmet-vim'

let g:user_emmet_settings       = { 'indentation' : '    '}
let g:user_emmet_leader_key     = '<c-f>'
let g:user_emmet_expandabbr_key = '<c-f>f'    "e
let g:user_emmet_expandword_key = '<c-f>F'    "e
let g:user_emmet_next_key       = '<c-f>j'    "n
let g:user_emmet_prev_key       = '<c-f>k'    "p
let g:user_emmet_removetag_key  = '<c-f>d'    "k

Plug 'maksimr/vim-jsbeautify'

Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0
Plug 'pangloss/vim-javascript'


" Plug 'scrooloose/syntastic'
" let g:syntastic_javascript_checkers = ['jsxhint']
" let g:jsx_ext_required = 0
"
" let g:syntastic_css_checkers = ['csslint']
" " ignore the compressed file.
" let g:syntastic_ignore_files = ['\.min\.js\|\.min\.css']
