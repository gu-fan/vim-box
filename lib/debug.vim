" let g:debug = false
" TODO use redir to log to files.
function! s:debug(message, sfile, slnum) abort

    if exists('g:debug_level') 
        if g:debug_level == 1
            echom a:message
        elseif g:debug_level == 2
            echom a:message 'at' a:sfile a:slnum
        elseif g:debug_level == 3
            redir a:message 'at' a:sfile a:slnum
        endif
    endif

endfunction

function! s:assert(expr, qexpr, sfile, slnum) abort

    if !a:expr
        echoe 'assert' a:qexpr 'but invalid at' a:sfile a:slnum 
    endif

endfunction

fun! s:verbose(level)
    if a:level
        let g:debug_level = a:level
        com! -nargs=* Debug call <SID>debug(<args>, expand('<sfile>'), expand('<slnum>'))
    else
        let g:debug_level = 0
        com! -nargs=* Debug redraw
    endif
endfun

com! -nargs=* Debug call <SID>debug(<args>, expand('<sfile>'), expand('<slnum>'))
com! -nargs=* Assert call <SID>assert(<args>, <q-args>, expand('<sfile>'), expand('<slnum>'))
com! -nargs=* SetVerbose call <SID>verbose(<args>)
" com! -nargs=0 Log redir @">
