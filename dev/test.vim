echo 'test'

let p = expand('<sfile>:p')
call Require('test2', p)
call Require('test2', p)

Require mods
Require m\m1

let s = {'a':1,'b':2}
function! s.plus() dict
    echo self.a + self.b
endfunction

Exports s
