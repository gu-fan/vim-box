Require ui cmd au

" session
let g:session_autosave = 'yes'
let g:session_autosave_periodic = '30'
let g:session_default_to_last = 1

" git
let g:gist_use_password_in_gitconfig = 1

" Help "{{{2
let g:clickable_browser = 'google chrome'

nma <silent><leader>1s :call <SID>synstack()<CR>
function! s:synstack() "{{{
    if exists("*synstack")
        for id in synstack(line("."), col("."))
            echon " ".synIDattr(id, "name")
            exe "echoh ".synIDattr(id, "name")
            echon "[".synIDattr(synIDtrans(id), "name")."]"
            echoh None
        endfor
    endif
endfunc "}}}

let proj1 = {'path': '~/Dropbox/Riv/'}
let proj2 = {'path': '~/Dropbox/wiki/'}
let proj3 = {'path': '~/test/sphinx/'}

let g:riv_projects = [proj1, proj2, proj3]
" XXX: This should be set as a project option.
let g:riv_file_link_style = 2

" let g:clickable_maps =''

let g:LustyExplorerSuppressRubyWarning = 1

let g:syntastic_javascript_checkers = ['jsxhint']
let g:jsx_ext_required = 0

let g:syntastic_css_checkers = ['csslint']
" ignore the compressed file.
let g:syntastic_ignore_files = ['\.min\.js\|\.min\.css']

nmap <localleader>vv :e ~/.after.vimrc<CR>
nmap <localleader>vf :e ~/.config/fish/config.fish<CR>
nmap <localleader>bm <ESC>:Unite -start-insert bookmark <CR>
nmap <localleader>ee <F4>
nmap <localleader>ff :Unite -start-insert -auto-preview -auto-highlight line<CR>
" nmap <localleader>gg :Unite -start-insert -auto-preview -auto-highlight grep<CR>

nmap <silent><Leader>gg :Unite -silent -auto-preview -winheight=40 -no-quit grep<CR><CR><CR>


let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'

if has('win32') || has('win64')
    " Display user name on Windows.
    let g:vimshell_prompt = $USERNAME."% "
else
    " Display user name on Linux.
    let g:vimshell_prompt = $USER."% "
endif



nmap ： :

" map gf :e %:p:h/<cfile><CR>

if has('nvim')
	runtime! plugin/python_setup.vim
endif

map <leader>rc :call <SID>cd_cur_dir()<CR>
map <leader>rr :call <SID>exec_cur_line()<CR>
fun! s:cd_cur_dir()
    let dir = expand('%:p:h')
    exe 'VimShellSendString cd '.dir
endfun
fun! s:exec_cur_line()
    let line = substitute(getline('.'), '^\s*\|\s*$','','g')
    exe 'VimShellSendString '.line
endfun

com! -nargs=* VS VimShellSendString <args>
com! -nargs=* VV VimShellSendString <args>


" This api is much faster.
let g:trans_default_api = 'youdao'
let g:trans_map_trans = '<localleader>tt'

let g:session_autoload = 'no'

" set noimdisable
" aug insert_method
" autocmd! InsertLeave * set imdisable 
" autocmd! InsertEnter * set noimdisable
" aug END


    

nmap <C-J>  :CtrlPLine<CR>


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
" Gif config
nmap f <Plug>(easymotion-s)
nmap t <Plug>(easymotion-t)
" " Gif config
" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)

" " These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" " Without these mappings, `n` & `N` works fine. (These mappings just provide
" " different highlight method and have some other features )
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)

" Gif config
map <localLeader>l <Plug>(easymotion-lineforward)
map <localLeader>j <Plug>(easymotion-j)
map <localLeader>k <Plug>(easymotion-k)
map <localLeader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

" nmap s <Plug>(easymotion-s)
" Bidirectional & within line 't' motion
omap t <Plug>(easymotion-bd-tl)
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
 " type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1


nnoremap <silent> <C-F3> :redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR>


nnoremap gE :e <cfile><CR>
nnoremap ,gk :Start! git add . && git commit -m '-' && git pull && git push<CR>

let g:jsx_indent_required = 0

vmap <silent> ;h :s?^\(\s*\) + '\([^']\+\)',*\s*$?\1\2?g<CR>
vmap <silent> ;q :s?^\(\s*\)\(.*\)]s*$?\1+'\2'?<CR>

noremap <C-CR> jJ

command! -nargs=0 New RivScratchCreate
command! -nargs=0 View RivScratchView

nno <silent><localleader>dd :call <SID>toggle_diff()<CR>

function! s:toggle_diff()
    if &diff
        diffoff
    else
        diffthis
    endif
endfunction
