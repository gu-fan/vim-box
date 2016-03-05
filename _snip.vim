" UNIQ
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
