Plug 'benmills/vimux'

nor <leader>rl :call VimuxRunCommandInDir(substitute(getline('.'),'^\s*\|\s*$','',"g"),0)<CR>

fun! s:VisualRunner()
    norm! gv"vy
    call VimuxRunCommandInDir(@v, 0)
    call VimuxSendKeys('Enter')
endfun
vnor <leader>rl :call <SID>VisualRunner()<CR>

map <Leader>rs :VimuxInterruptRunner<CR>
map <Leader>rc :VimuxCloseRunner<CR>

fun! s:PromptAndSend()
    let k = input('Prompt Vmux:')
    if !empty(k)
        call VimuxSendText(k)
        call VimuxSendKeys('Enter')
    endif
endfun

fun! s:PromptAndSendSecret()
    let k = inputsecret('Secret Vmux:')
    if !empty(k)
        call VimuxSendText(k)
        call VimuxSendKeys('Enter')
    endif
endfun

map <Leader>rk :call <SID>PromptAndSend()<CR>
map <Leader>rp :call <SID>PromptAndSendSecret()<CR>


