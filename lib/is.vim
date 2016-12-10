
let s:file = expand('<sfile>')

function! is#main(main)
    " echo expand('<sfile>')
    " echo s:file
    " echo expand('%')
    " echo a:main
    return a:main == expand('%:p')
endfunction

