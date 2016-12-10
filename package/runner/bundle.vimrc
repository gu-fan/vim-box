Plug 'benmills/vimux'


fun! s:VisualRunner()
    norm! gv"vy
    call VimuxRunCommandInDir(@v, 0)
    call VimuxSendKeys('Enter')
endfun


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


com! -nargs=0 RunLine call VimuxRunCommandInDir(substitute(getline('.'),'^\s*\|\s*$','',"g"),0)
com! -nargs=0 RunStop VimuxInterruptRunner
com! -nargs=0 RunClose VimuxCloseRunner
com! -nargs=0 RunSend call <SID>PromptAndSend()
com! -nargs=0 RunSecrect call <SID>PromptAndSendSecret()
com! -nargs=0 RunDir call VimuxRunCommand('cd '.expand('%:p:h'),1)

" run
nor <leader>rl :RunLine<CR>
vnor <leader>rl :call <SID>VisualRunner()<CR>

" stop
map <Leader>ri :VimuxInterruptRunner<CR>
map <Leader>rc :VimuxCloseRunner<CR>

" open
map <Leader>rd :RunDir<CR>

" prompt words
map <Leader>rp :RunSend<CR>
map <Leader>rs :RunSecrect<CR>

