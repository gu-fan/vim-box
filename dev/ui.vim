Debug 'sourcing ui'

" Win "{{{
" pos: below above top bot
" dir: h/v
let win= {'pos': 'bot', 'size': 5,'name': 'ui', 'dir': 'h'}
let s:uid = 1

fun! win.get(...) dict

    let name = call(self.get_name, a:000, self)

    if self.has_buf(name)
        if self.has_win(name)
            call self.switch_win(name)
        else
            call call(self.open_buf, a:000, self)
        endif
    else
        call call(self.new, a:000, self)
    endif
    
endfun

fun! win.new(...) dict
    let name = call(self.get_name, a:000, self)
    let pos  = exists("a:1.pos") ? a:1.pos : self.pos
    let size = exists("a:1.size") ? a:1.size : self.size
    let dir  = exists("a:1.dir") ? a:1.dir : self.dir
    let dir  = dir == 'h' ? '' : 'v'

    let s:uid += 1
    exec pos size  dir.'new' name.'-'.s:uid
    call self.setup()    " TODO: assign type here
endfun

fun! win.setup() dict
    " local setting
    " need cache the window or not?
    setl bufhidden=hide
    setl buftype=nofile  

    setl nobuflisted
    setl noswapfile
    setl nolist nowrap
    setl nocursorline nocursorcolumn
    setl nofoldenable nonumber nomodeline 
    setl tw=0 foldcolumn=0 sidescrolloff=0
    setl winfixwidth winfixheight noea
    if v:version >= 703
        setl cc=
    endif
endfun


fun! win.has_buf(name) dict
    return bufnr(a:name.'-'.s:uid) != -1
endfun

fun! win.get_buf(name) dict
    return bufnr(a:name.'-'.s:uid)
endfun

fun! win.open_buf(...) dict

    let name = call(self.get_name, a:000, self)
    let pos  = exists("a:1.pos") ? a:1.pos : self.pos
    let size = exists("a:1.size") ? a:1.size : self.size
    let dir  = exists("a:1.dir") ? a:1.dir : self.dir
    let dir  = dir == 'h' ? '' : 'v'

    exec pos size  dir.'split +buffer' name.'-'.s:uid

endfun

fun! win.get_name(...) dict
    return a:0 && type(a:1) == type("") ? a:1 : 
                \ exists("a:1.name") ? a:1.name : self.name
endfun

fun! win.has_win(name)
    return bufwinnr(bufnr(a:name.'-'.s:uid)) != -1
endfun

fun! win.switch_win(name)
    exe bufwinnr(bufnr(a:name.'-'.s:uid)) . "wincmd w"
endfun


"}}}


let box = {"width":15, "height":15, "x":23,"y":15 }

fun! box.create_empty_list(len)
    return map(range(a:len),'""')
endfun

fun! box.render() dict
    let lines = getline(1, '$')
    if len(lines) < self.height + self.y
        call extend(lines, self.create_empty_list(self.height + self.y -len(lines)))
    endif
    
    " assume the font's h/w is 2.1
    let fix_width =  float2nr(2.1*self.width)
    for i in range(self.height)
        " let lines[self.y + i] = printf("%". ( self.x + fix_width ). "S", 
        "                 \ repeat('#', fix_width))

        if self.y+i < 0
            continue
        endif
        let lines[self.y + i] .= repeat(' ', (self.x + fix_width - len(lines[self.y + i])))
        let lines[self.y + i] = substitute(lines[self.y + i],
                \ '\%>'.(self.x < 0 ? 0 : self.x ).'c\%<'.(self.x + fix_width).'c.','#','g')
    endfor
    let s:_ma = &ma
    let s:_lz = &lz
    setl ma lz
        call setline(1, lines)
    let &ma = s:_ma
    let &lz = s:_lz

endfun

Exports! {"win": win, "box":box}
unlet win box
