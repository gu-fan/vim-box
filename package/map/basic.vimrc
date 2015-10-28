Require pairs
Require fn

Require fold
Require search


" input
se noimd
se ims=1
se ve=block

cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

nor <Leader>li :setl list! list?<CR>

set nonu nornu
nor <leader>nn :setl <c-r>=&rnu?'nornu':&nu?'nonu':'rnu'<CR><CR>

" Clear screen
nno   <silent>   <c-l>   :let @/=''\|redraw!<CR>

" Moving
nno   H   h
nno   L   l
nno   J   j
nno   K   k
nno   j   gj
nno   k   gk

vno   j  gj
vno   k  gk

nno   <leader>   <Nop>
vno   <leader>   <Nop>
nno   s          <Nop>
nno   S          <Nop>
nno   Q          <Nop>
" similar with D
" nno   yy         "*yy
nno   Y          "*y$
" nno   p          "*p
nno   cc        <nop>
" nno   dd         "*dd
" nno   D          "*D
" vno   y          "*y
" vno   d          "*d
" vno   x          "*x

nno   >          >>
nno   <          <<
vno   >          >gv
vno   <          <gv

" repeat on every line
vno   .          :normal .<CR>
nor <rightmouse><leftmouse> <c-o>
nor <rightmouse><rightmouse> <c-o>
nor <rightrelease><leftrelease> <c-o>
ino <rightrelease><leftrelease> <c-o><c-o>

" Undo/Redo
nor <C-Z>       uzv
ino <C-Z>       <C-O>u<C-O>zv
vno <C-Z>       <Nop>

nor <C-Y>       <C-R>zv
ino <C-Y>       <C-O><C-R><C-O>zv
vno <C-Y>       <Nop>

" Window
nno <silent><C-W>1 :resize<cr>
nno <silent><C-W>2 :vert resize<cr>
nno <silent><C-W>3 <C-W>=
nno <silent><C-W>o <C-W><c-o>

nno <C-W>n <C-W>w
nno <C-W>N <C-W>n

fun! s:edit_file(ask)
    let file = expand('<cfile>')
    let ptn ='\v(%(file|https=|ftp|gopher)://|%(mailto|news):)([0-9a-zA-Z#&?._-~/]*)'
    let links = matchlist(file,ptn)
    if !empty(links) 
        if links[1] =~ 'file'
            let file = links[2]
        else
            sil! exe "!firefox ". links[2]
        endif
        return
    endif
    let file = expand(file)
    if filereadable(file) || isdirectory(file)
        exe "edit ".file
        return
    elseif a:ask==1 && input("file: ".file." not exists, continue?(Y/n)") =~?"y"
        exe "edit ".file
        return
    endif

    " find the file match with <cfile>.ext 
    if file !~ '^\s*$'
        let files = split(glob(expand('%:p:h')."/".file.".*"),'\n')
        if !empty(files)
            exe "edit ".files[0]
            for f in files[1:]
                exe "split ".f
            endfor
            return
        endif
    endif
endfun 
nno <silent><C-W>v :vsp\|call <SID>edit_file(0)<CR>
nno <silent><C-W>s :sp\|call <SID>edit_file(0)<CR>
nno <silent><C-W><C-V> :vsp\|call <SID>edit_file(0)<CR>
nno <silent><C-W><C-S> :sp\|call <SID>edit_file(0)<CR>
nno <silent><C-W><C-T> :tab sp\|call <SID>edit_file(0)<CR>
nno <silent><C-W><C-F> :sp\|call <SID>edit_file(1)<CR>
" Save
nnoremap <c-s> :w<CR>
