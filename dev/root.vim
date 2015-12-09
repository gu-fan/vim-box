
fu! s:getparent(item)
	let parent = substitute(a:item, '[\/][^\/]\+[\/:]\?$', '', '')
	if parent == '' || parent !~ '[\/]'
		let parent .= '/'
	en
	retu parent
endf


fun! s:set_path()

    let markers = ['.git', '.hg', '.svn', '.bzr', '_darcs', 'package.json']
    " setl path =
    let root =  s:findroot(getcwd(), markers, 0)

    setl path+=/usr/local/lib/node_modules
    if !empty(root)
        exec "setl path+=".root[1]
        exec "setl path+=".root[1].'/node_modules'
    endif
    setl includeexpr= v:fname.'/index.js'
    
endfun


fu! s:findroot(curr, mark, depth)
	let [depth, fnd] = [a:depth + 1, 0]
	if type(a:mark) == 1
		let fnd = s:glbpath(s:fnesc(a:curr, 'g', ','), a:mark, 1) != ''
	elsei type(a:mark) == 3
		for markr in a:mark
			if s:glbpath(s:fnesc(a:curr, 'g', ','), markr, 1) != ''
				let fnd = 1
				brea
			en
		endfo
	en
	if fnd
		retu [exists('markr') ? markr : a:mark, a:curr]
	elsei depth > 10
        echo '>10'
	el
		let parent = s:getparent(a:curr)
		if parent != a:curr
			retu s:findroot(parent, a:mark, depth)
		en
	en
	retu []
endf

fu! s:glbpath(...)
	retu call('ctrlp#utils#globpath', a:000)
endf

fu! s:fnesc(...)
	retu call('ctrlp#utils#fnesc', a:000)
endf


map <leader>ff :call <SID>set_path()<CR>
