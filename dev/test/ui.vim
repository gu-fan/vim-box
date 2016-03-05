let s:p = expand('<sfile>:p')
let ui#b = Require('../ui', s:p)

map (<Plug>ui.win.new) :call ui#b.win.new('mean')<CR> 
map (<Plug>ui.win.get) :call ui#b.win.get('mean')<CR> 
map (<Plug>ui.box.render) :call ui#b.box.render()<CR> 
map <leader>ne  (<Plug>ui.win.new)
map <leader>ge  (<Plug>ui.win.get)
map <leader>bo  (<Plug>ui.box.render)
