" This is defining, not funcion, 
" so no need to source the whole vimrc
" so, just use '.vim'
let s:base_dir = expand('<sfile>:p:h:h')

function! s:unique_sort(list, ...)
  let dictionary = {}
  for i in a:list
    let dictionary[string(i)] = i
  endfor
  let result = []
  if ( exists( 'a:1' ) )
    let result = sort( values( dictionary ), a:1 )
  else
    let result = sort( values( dictionary ) )
  endif
  return result
endfunction

function! s:unique(list)
  let dictionary = {}
  for i in a:list
    let dictionary[string(i)] = i
  endfor
  return values( dictionary )
endfunction

function! s:require(file, dir)
    " echoe a:dir
    " echoe a:file
    " echoe s:base_dir
    let fs = split(a:file, ' ')

    let _l = []

    let _sep = g:_v.is_windows ? '\' : '/'

    for f in fs
        let _f = [a:dir ._sep. f .'.vim',
                \ a:dir ._sep. f .'.vimrc',
                \ expand('%:p:h') ._sep. f .'.vim',
                \ expand('%:p:h') ._sep. f .'.vimrc',
                \ s:base_dir ._sep. f .'.vimrc',
                \ s:base_dir ._sep. f .'.vim',
                \ ]
        let _f = s:unique(_f)
        call filter(_f, 'filereadable(v:val)')
        call extend(_l, _f)
    endfor
    " echom string(_l)

    for f in _l
        if filereadable(f)
            exec 'so ' f
            " echo 'so ' f
            " echom 'required' f
        endif
    endfor

endfun

com! -nargs=* Require call s:require(<q-args>, expand('<sfile>:p:h'))
