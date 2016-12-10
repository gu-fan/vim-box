Debug 'cmd'

let s:cmd = {}

function! s:cmd.init() dict
    let self.name = 'test'
    return self
endfunction

Require cmd/find

" prompt
" cmd
function! s:cmd.find() dict
    echo 'find'
    " promptrepl <cword>
    return 1
endfunction
" command! Find call s:cmd.find()
" map <F3> :Find<CR>



if is#main(expand('<sfile>:p'))
    echom 'is cmd main'
    call s:cmd.init()
endif
