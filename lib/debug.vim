" let g:debug = false
function! s:debug(message, sfile, slnum) abort

    if exists('g:debug') 
        if g:debug == 1
            echom a:message
        elseif g:debug == 2
            echom a:message 'at' a:sfile a:slnum
        endif
    endif

endfunction

function! s:assert(expr, qexpr, sfile, slnum) abort

    if !a:expr
        echoe 'assert' a:qexpr 'but invalid at' a:sfile a:slnum 
    endif

endfunction

com! -nargs=1 Debug call s:debug(<args>, expand('<sfile>'), expand('<slnum>'))
com! -nargs=1 Assert call s:assert(<args>, <q-args>, expand('<sfile>'), expand('<slnum>'))

