
autocmd BufEnter * silent! lcd %:p:h

aug au_GuiEnter "{{{
    au!
    au GuiEnter * set t_vb=
    " awesome don't need this
    " exe "au GuiEnter * winpos ".s:win_pos." 0"
    " exe "au GuiEnter * set columns=".s:win_col." lines=".s:win_row
aug END "}}}
aug au_VimEnter " {{{
    au!
    " if !has("gui_running")
    "     au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
    "     au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
    "     au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
    " endif
aug END
"}}}
aug au_Vimrc "{{{
    au!
    au SourcePre ~/Dropbox/dotfiles/.vimrc redraw | echohl WarningMsg
                \|echom "Reloading .vimrc"|echohl Normal
    au BufWritePre,FileWritePre ~/Dropbox/dotfiles/.vimrc  LastUpdate
    au BufWritePost,FileWritePost ~/Dropbox/dotfiles/.vimrc redraw
                \|echohl WarningMsg
                \|echom "Writing .vimrc"|echohl Normal
                \|so $MYVIMRC|normal '.zv
    " load vimrc after load any session.
    au SessionLoadPost * so ~/.vimrc
    " avoid using function while redefine it.
    au BufRead */.vimrc map <buffer> <F5> :silent so %<CR>
aug END "}}}
aug au_Buffer "{{{
    au! 
    au BufEnter,BufNew,BufReadPost * silent! lcd %:p:h:gs/ /\\ /
    " to the line when file last opened
    au BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe  "normal! g`\"" | endif
aug END "}}} 

aug au_Filetypes "{{{
    au!
    au BufRead,BufNewFile *.j,*.wct setf jass
    au BufRead,BufNewFile *.mako    setf mako
    au BufRead,BufNewFile *.conf    setf conf
    au BufRead,BufNewFile tmux.conf setf tmux
    au FileType c,cpp    setl fdm=syntax
    au FileType jass     setl wrap fdm=syntax
    au FileType jass     nor <buffer> gD :call <SID>jass_goDef()<CR>
    au FileType javascript call <SID>js_fold()
    au FileType python map <buffer> <F1> :Pydoc <C-R><C-W><CR>
    au FileType python map <buffer> K k
    au FileType python setl wrap foldtext=MyFoldText()
    " au FileType python  call <SID>py_aug()
    au FileType python  setl fdm=indent
    " au FileType javascript setl fdm=syntax
    au Filetype php,html,xhtml,xml setl shiftwidth=4 softtabstop=4
    au Filetype php,html,xhtml,xml setl foldmethod=indent
    au Filetype php setl smartindent
    au Filetype php cal <SID>check_html()
    au BufRead,BufNewFile *template*.php    setf conf
    au FileType help setl isk+=-,:
    au FileType help call <SID>hlp_fold()
    au FileType vim setl isk+=:
    au FileType html cal <SID>check_ft()
    " au FileType rst syn spell toplevel
aug END "}}}

aug au_Dev "{{{
    au!
    " au BufWritePre,FileWritePre momo_bridge{_dev,}\.*\.js  LastUpdate
aug END "}}}

fun! s:check_html() "{{{
    " The html template file place
    if expand('<afile>:p') =~ '\v[/\\]%(template|views)[/\\]'
        set ft=html
    endif
endfun "}}}
fun! s:check_ft() "{{{
    " The django file place
    if expand('<afile>:p') =~ '\v[/\\]%(templates|views)[/\\]'
        set ft=htmldjango
    endif
endfun "}}}

function! s:hlp_fold() "{{{
    setl foldmethod=syntax
    setl foldtext=MyHlpFoldText()
    syn region foldBraces start=/[-=]\{50,}/
                \ end=#\ze[-=]\{50,}# transparent fold keepend
endfunction "}}}
function! MyHlpFoldText() "{{{
    let dash = getline(v:foldstart)[0]
    let line = getline(v:foldstart+1)
    let num  = printf("%4s",(v:foldend-v:foldstart))
    let line = substitute(line, '\%>44c\%<53c', '['.dash.num.']', '')
    return line
endfunction "}}}

" JavaScript {{{2
function! s:js_fold() "{{{
    setl foldmethod=syntax
    syn region foldBraces start=/{/ skip=#/\%([^/]\|\/\)*/\|'[^']*'\|"[^"]*"#
                \ end=/}/ transparent fold keepend extend 
endfunction "}}}
" }}}

" Resize the divisions if the Vim window size changes {{{

au VimResized * exe "normal! \<c-w>="


autocmd! BufWritePost vimrc source %
autocmd! BufWritePost *.vimrc source ~/.vimrc

" Execution permissions by default to shebang (#!) files {{{

augroup shebang_chmod
  autocmd!
  autocmd BufNewFile  * let b:brand_new_file = 1
  autocmd BufWritePost * unlet! b:brand_new_file
  autocmd BufWritePre *
        \ if exists('b:brand_new_file') |
        \   if getline(1) =~ '^#!' |
        \     let b:chmod_post = '+x' |
        \   endif |
        \ endif
  autocmd BufWritePost,FileWritePost *
        \ if exists('b:chmod_post') && executable('chmod') |
        \   silent! execute '!chmod '.b:chmod_post.' "<afile>"' |
        \   unlet b:chmod_post |
        \ endif
augroup END

" }}}
