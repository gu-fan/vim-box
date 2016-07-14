Debug 'cmd'

com! Copy let @+ = expand('%:p')|echo 'PATH:'.@+
com! Trail %s#\s\+$##g

function! s:delete(name) "{{{
    let f = a:name
    if input('Delete '.f.' ?(y/N)') =~? '^y\%[es]$'
        if !delete(f)
            echom f."deleted successfully!"
        else
            echom f."delete faiure!"
        endif
    endif
endfunction "}}}
function! s:rename(name) "{{{
    let f = expand('%:p')
    exec "saveas ".a:name
    call s:delete(f)
    exec "edit ".a:name
endfunction "}}}
com! -nargs=0 Delete call <SID>delete(expand("%:p"))
com! -nargs=1 Rename call <SID>rename(<q-args>)

fun! s:glob_edit(...) "{{{
    let ext = 'php'
    let path = expand('%:p:h')
    let depth = "/**/*"
    if a:0 && a:1!=""
        let ext = a:1
        if a:0 > 1
           let path = expand(a:2)
        endif
        if a:0 > 2 && a:3 < 1
           let depth = "/*"
        endif
    endif
    let files= split(glob( path.depth.".".ext,1),"\n")
    " echom string([ext,path,depth])
    " echom string(files)
    for file in files
        exe "top sp " file
    endfor
endfun "}}}
com! -nargs=*  GlobEdit call s:glob_edit(<f-args>)


com! -nargs=? Filter let @a='' | execute 'g/<args>/y A' | new | setlocal bt=nofile | put! a

com! -nargs=* -complete=file W write! <args>
com! -nargs=* -complete=file E edit! <args>
com! -nargs=* -complete=help H help <args>


function! s:auto_mkdir(dir, force) "{{{
    if !isdirectory(a:dir) && (a:force ||
    \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction "}}}
com! -nargs=0 AutoMkdir call <SID>auto_mkdir(expand('%:p:h'),1) | w

function! s:_cdo(args, type)
    let no_confirmation_needed = matchstr(a:args,'^/c') == ""
    let command = substitute(a:args, '^/c', '', '')

    exe a:type.'rewind'
    let error_count = a:type == 'c' ? len(getqflist()) : len(getloclist(0))
    let i = 0
    while i < error_count
        let i = i + 1
        exe a:type.a:type." ".i
        let confirm_msg = "Change this line? - ".getline(".")
        if no_confirmation_needed || confirm(confirm_msg, "&yes\n&no") == 1
            exe command
        endif
    endwhile
endfunction

com! -nargs=1 -bar Cdo :call s:_cdo(<q-args>, 'c')
com! -nargs=1 -bar Ldo :call s:_cdo(<q-args>, 'l')

com! -nargs=0 Restart :call s:restart()


fun! s:restart()
    Save
    call system('gvim -c "Load"')
    quitall

endfun
