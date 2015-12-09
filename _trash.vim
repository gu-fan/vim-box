function! s:Ack(args) "{{{
    let g:_os  = 'mac'
    let grepprg_bak=&grepprg
    if g:_os=="ubuntu"
        set grepprg=ack-grep\ -H\ --nocolor
    else
        set grepprg=ack\ -H\ --nocolor
    endif
    silent! execute "grep! " . a:args
    let &grepprg=grepprg_bak
    botright copen
    redraw!
endfunction "}}}
command! -nargs=* -complete=file Ack call <SID>Ack(<q-args>)

" session
let g:session_autosave = 'yes'
let g:session_autosave_periodic = '30'
let g:session_default_to_last = 1

"{{{3 F5 Execute
nno <silent> <C-F5> :ccl<CR>
nor   <C-F8> :CopyFull<CR>
nor   <S-F8> :call <SID>file_man("sudo ")<CR>

map   <silent><F9>   :VimShellBufferDir -toggle <CR>
imap   <silent><F9>   <Esc>:VimShellBufferDir -toggle <CR>
nor   <F10>   :options<CR>

set sessionoptions=blank,curdir,help,tabpages,winpos,winsize,resize
" if has("unix")
"     nma <F12> :Hex! ~/.vim/sessions<CR>G$mfms
"     nma <M-F12> :Hex! ~/.vim/sessions<CR>
" else
"     nma <F12> :Hex $HOME\.vim\sessions<CR>G$mfms
"     nma <M-F12> :Hex $HOME\.vim\sessions<CR>
" endif
nma <M-F12> :call <SID>load_session(1)<CR>
nma <F12>   :OpenSession<CR>
nma <S-F12> :SaveSession<CR>

"{{{3 F8 File Manager
" let s:os = os#init()
"{{{3 F9 Termnial
" nor   <silent><F9>   :call <SID>terminal()<CR>
"}}}3
" nor   <F11>   :script<CR>
" "noremap <silent> <F11> :cal VimCommanderToggle()<CR>
"{{{3 F12 Session
" nma <F12>   :call <SID>load_session()<CR>
" nma <M-F12> :ViewSession<CR>
" nma <F12>   :call SourceSession()<CR>
" nma <S-F12> :Obses ~/.vim/sessions/default<CR>


command! Atom !Atom %


let g:unite_source_menu_menus.map = {
    \ 'description' : '            admin map                                   ⌘ [space]map',
    \}
let g:unite_source_menu_menus.map.command_candidates = [
    \['▷ F1 Help                                                       <F1> ', 'exe "normal \<F1>"'],
    \['▷ F2 Replace                                                    <F2> ', 'exe "normal \<F2>"'],
    \['▷ F3 Search                                                     <F3> ', 'exe "normal \<F3>"'],
    \['▷ F4 Tree                                                       <F4> ', 'exe "normal \<F4>"'],
    \['▷ F5 Exec                                                       <F5> ', 'exe "normal \<F5>"'],
    \['▷ F6 DEBUG                                                      <F6> ', 'exe "normal \<F6>"'],
    \['▷ F7 UNDO                                                       <F7> ', 'exe "normal \<F7>"'],
    \['▷ F8 OPEN                                                       <F8> ', 'exe "normal \<F8>"'],
    \['▷ F9 TERMINAL                                                   <F9> ', 'exe "normal \<F9>"'],
    \['▷ F10 OPTION                                                    <F10> ', 'exe "normal \<F10>"'],
    \['▷ F11 OPTION                                                    <F11> ', 'exe "normal \<F11>"'],
    \['▷ F12 OPTION                                                    <F12> ', 'exe "normal \<F12>"'],
    \]

if !exists("*s:load_session") "{{{
    fun! s:load_session(...)
        let flist = split(glob("~/.vim/sessions/*"),'\n')
        call reverse(sort(flist))
        if a:0 && a:1
            let sp = 'new'
            exec 'noa keepa '.sp.' +setl\ nobl '. "Session_Files"
            call append(0, flist)
            setl nomodifiable readonly
            map <buffer> <Enter> :exe "source " getline('.')<CR>
        else
            exe "source ".get(flist,0)
        endif
    endfun
endif "}}}
" nma <C-F12> :call SaveSession("name")<CR>
function! SaveSession(...) "{{{
    wall
    let ses_dir = expand('~/.vim/sessions')
    call s:auto_mkdir(ses_dir,1)
    let time=strftime("%y%m%d_%H%M%S")
    if exists("a:1") && a:1=="name"
        let ses =  input("Please Input your session name:")
        if  ses != ""
            let sesname = time."_".ses
        else
            echo "Invalid Input name. Stop!"
            return
        endif
    else
        let sesname = time
    endif

    try
        exe "Obses "."~/.vim/sessions/".sesname
        echom "mks success! session file : ".sesname
    catch /^vim\%((\a\+)\)\=:/
        echoe "mks failure! error: " .v:exception
    endtry
endfunction "}}}

" if !exists("*s:exe")
" endif
fun! s:rst() "{{{
    let bang="!"
    if has("unix")
        let browser = "firefox "
        let runner="xdg-open "
        let err_log=" 2>&1 | tee /tmp/.vim_exe.tmp"
        let term = "gnome-terminal "
    elseif g:_v.is_mac
        let browser ="firefox "
        let runner="open "
        let err_log=" "
        let term = "iTerm "
    else
        let browser ="firefox.lnk "
        let runner="start "
        let err_log=" "
        let term = "cmd "
    endif
    " NOTE:
    " we should generate the css of external code by
    " pygmentize -f html -S colorful -a .syntax



    " and use it by
    " rst2html.py --stylesheet=html4css1.css,transition-stars.css

    " sil !rst2html.py % > /tmp/_rst.html
    " !rst2html.py
    " \ --stylesheet=/home/meoki/.vim/scripts/pygments-default.css % > /tmp/_rst.html
    " !python2 ~/.vim/scripts/pygments_code_block_directive.py
    "    \ --stylesheet=/home/meoki/.vim/scripts/pygments-default.css % > /tmp/_rst.html

    " !python2 ~/.vim/scripts/rst2html-pygments 
    "    \ --stylesheet=/home/meoki/.vim/scripts/pygments-default.css % > /tmp/_rst.html
    " !rst2html.py
    "     \ --stylesheet=/home/meoki/.vim/scripts/pygments-default.css % > /tmp/_rst.html

    " !python2 ~/.vim/scripts/rst-directive.py
    "    \ --stylesheet=/home/meoki/.vim/scripts/pygments-default.css % > /tmp/_rst.html
    let style = expand('~/.vim/scripts/css/trac.css')
    let style .= ",".expand('~/.vim/scripts/css/html4css1.css')
    " exec "!rst2html.py   --stylesheet=". style . " % > /tmp/_rst.html"
    exec "!rst2html2.py  % > /tmp/_rst.html"
    exec bang.browser."/tmp/_rst.html &"

    " for file in split(glob("~/.vim/scripts/css/*"))
    "     exec "!rst2html.py   --stylesheet=". file . " --title=".file." % > /tmp/_rst.html"
    "     exec bang.browser."/tmp/_rst.html"
    " endfor
endfun "}}}
"}}}3
" nor   <F6>   :TagbarToggle<CR>
nor <F6> :call <SID>debug_jasmine()<CR>


" " Enable file operation commands.  " Edit file by tabedit.
" call vimfiler#custom#profile('default', 'context', {
            \ 'safe' : 0,
            \ })
"
" " Like Textmate icons.
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
"
let g:vimfiler_execute_file_list = {'_' : 'open'}
"
autocmd FileType vimfiler nmap <nowait><buffer> <Space> <Plug>(vimfiler_toggle_mark_current_line)
" autocmd FileType vimfiler nmap <buffer> <2-LeftMouse> <Plug>(vimfiler_edit_file)
autocmd FileType vimfiler nmap <nowait><buffer> <CR> :call <SID>vimfiler_on_double_click()<CR>
autocmd FileType vimfiler nmap <buffer><silent> <2-LeftMouse> :call <SID>vimfiler_on_double_click()<CR>
function! s:vimfiler_on_double_click() "{{{
    let context = vimfiler#get_context()

    if context.explorer
        let mapping = vimfiler#mappings#smart_cursor_map(
                    \ "\<Plug>(vimfiler_expand_tree)",
                    \ "\<Plug>(vimfiler_edit_file)"
                    \ )
    else
        let mapping = vimfiler#mappings#smart_cursor_map(
                    \ "\<Plug>(vimfiler_cd_file)",
                    \ "\<Plug>(vimfiler_edit_file)"
                    \ )
    endif

    execute "normal " . mapping
endfunction "}}}
" let g:loaded_netrwPlugin = 1
" " nmap <localleader>bn <ESC>:NERDTreeFromBookmark<SPACE>
function! s:toggle_vimfiler() "{{{
    if exists("t:_vmfilerwin") && t:_vmfilerwin==1
        norm q
        let t:_vmfilerwin=0
    else
        VimFilerCurrentDir -parent -double
        let t:_vmfilerwin=1
    endif
endfunction "}}}



" Wrapping

function! ToggleWrap()
    let s:nowrap_cc_bg = [22, '#005f00']
    redir => s:curr_cc_hi
    silent hi ColorColumn
    redir END
    let s:curr_cc_ctermbg = matchstr(s:curr_cc_hi, 'ctermbg=\zs.\{-}\s\ze\1')
    let s:curr_cc_guibg = matchstr(s:curr_cc_hi, 'guibg=\zs.\{-}\_$\ze\1')
    if s:curr_cc_ctermbg != s:nowrap_cc_bg[0]
        let g:curr_cc_ctermbg = s:curr_cc_ctermbg
    endif
    if s:curr_cc_guibg != s:nowrap_cc_bg[1]
        let g:curr_cc_guibg = s:curr_cc_guibg
    endif
    if &textwidth == 80
        set textwidth=0
        exec 'hi ColorColumn ctermbg='.s:nowrap_cc_bg[0].
                    \' guibg='.s:nowrap_cc_bg[1]
    elseif &textwidth == 0
        set textwidth=80
        exec 'hi ColorColumn ctermbg='.g:curr_cc_ctermbg.
                    \' guibg='.g:curr_cc_guibg
    endif
endfunction

nmap <silent><Leader>ew :call ToggleWrap()<CR>

nor [menu]cc :TComment<cr>

nno <silent> n :call <SID>wrapscan_warn('f')<CR>
nno <silent> N :call <SID>wrapscan_warn('b')<CR>
function! s:wrapscan_warn(d) "{{{
    " show an warning message when hit end of file.
    try
        if (a:d=='f' && v:searchforward == 1)
                    \ || (a:d=='b' && v:searchforward == 0)
            //
        else
            ??
        endif
    catch /^Vim\%((\a\+)\)\=:E38[45]/
        echohl Comment
        echon ' Searching of '
        echohl Warningmsg
        if v:searchforward ==1
            echon @/[:15]
            echohl Comment
            echon ' hit END-Of-File.'
        else
            echon @/[:15]
            echohl Comment
            echon ' hit TOP-Of-File.'
        endif
        let c = nr2char(getchar(1))
        if  v:searchforward == 0
            call search(@/,'wb')
            echon ' Wrapscan to END'
        elseif v:searchforward == 1
            call search(@/,'w')
            echon ' Wrap to TOP'
        endif
        echohl Normal
    endtry
endfunction "}}}

nno <localleader>lf :LustyFilesystemExplorer<CR>
nno <localleader>lr :LustyFilesystemExplorerFromHere<CR>
nno <localleader>lb :LustyBufferExplorer<CR>
nno <localleader>lg :LustyBufferGrep<CR>
nno <localleader>lj :LustyJuggler<CR>

set virtualedit=block
nor <Leader>ve :setl ve=<c-r>= &ve=='' ? 'block' : &ve=='block' ? 'all' : ''  <CR><CR>

command! -nargs=0 FesDoc Start! sh ~/momo/doc/bridge_doc/deploy
command! -nargs=0 FesDeploy Start! sh ~/Dropbox/Riv/Script/fes_deploy
command! -nargs=0 Server Start server

" git
let g:gist_use_password_in_gitconfig = 1

nmap <localleader>vf :e ~/.config/fish/config.fish<CR>
nmap <localleader>ff :Unite -start-insert -auto-preview -auto-highlight line<CR>
nmap <silent><Leader>gg :Unite -silent -auto-preview -winheight=40 -no-quit grep<CR><CR><CR>

let g:session_autoload = 'no'

let g:riv_web_browser = 'Firefox'

command! -nargs=0 -bar LastUpdate call LastUpdate()
function! LastUpdate() "{{{
    let rx_str_upd='\%(Change\|Update\|Updated\|Modified\|Revision\)'
    for i in range(1,40)
        let line = getline(i)
        if line =~# rx_str_upd
            let nline = substitute(line, '\(^.*'.rx_str_upd.':\s*\).\{-}\([''"]\|$\)',
                        \ '\1'.strftime("%Y-%m-%d_%H:%M:%S").'\2', '')
            if line != nline
                keepmarks keepjumps call setline(i, nline)
            endif
            return

        endif
    endfor
endfunction "}}}

" ?? 
nnoremap <silent> <C-F3> :redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR>

nnoremap gE :e <cfile><CR>
nnoremap ,gk :Start! git add . && git commit -m '-' && git pull && git push<CR>


let g:jsx_indent_required = 0

" remove pre/suf whitespace ?
vmap <silent> ;h :s?^\(\s*\) + '\([^']\+\)',*\s*$?\1\2?g<CR>
vmap <silent> ;q :s?^\(\s*\)\(.*\)]s*$?\1+'\2'?<CR>

command! -nargs=0 New RivScratchCreate
command! -nargs=0 View RivScratchView
