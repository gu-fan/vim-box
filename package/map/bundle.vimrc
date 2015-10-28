
Plug 'Shougo/neocomplcache'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" Neocomplcache "{{{2
nno <leader>nt :NeoComplCacheToggle<CR>
nno <leader>nb :NeoComplCacheCachingBuffer<CR>
let g:acp_enableAtStartup                      = 0
let g:neocomplcache_enable_at_startup          = 1
let g:neocomplcache_enable_smart_case          = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_ignore_case         = 0
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length          = 2
let g:neocomplcache_lock_buffer_name_pattern   = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" let g:neocomplcache_disable_caching_file_path_pattern="fuf"
" let g:neocomplcache_quick_match_patterns={'default':'`'}
" let g:neocomplcache_quick_match_table = {
"             \'1' : 0, '2' : 1, '3' : 2, '4' : 3, '5' : 4, '6' : 5, '7' : 6, '8' : 7, '9' : 8, '0' : 9,
"             \}

if exists("*neocomplcache#smart_close_popup")
    ino <expr><C-h>   neocomplcache#smart_close_popup()."\<left>"
    ino <expr><C-l>   neocomplcache#smart_close_popup()."\<right>"
    ino <expr><Space> neocomplcache#smart_close_popup()."\<Space>"
    ino <expr><CR>    neocomplcache#smart_close_popup()."\<CR>"
    ino <expr><BS>    neocomplcache#smart_close_popup()."\<BS>"
    ino <expr><C-y>   neocomplcache#close_popup()
endif

"{{{ omni comp
aug neocomp_omni_compl "{{{
    au! neocomp_omni_compl
    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
aug END "}}}
" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
"}}}

" neocompl cache snippets_complete
" nmap <c-k> a<c-k><esc>
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" ino <expr>.   pumvisible() ? "." : "."
ino <expr><TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
ino <expr><s-TAB> pumvisible() ? "\<C-p>" : "\<s-TAB>"
" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: pumvisible() ? "\<C-n>" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif
let g:neosnippet#snippets_directory = "~/Dropbox/vim/my_snips/snippets_complete/"

map <leader>se :sp\|NeoSnippetEdit<cr>
map <leader>sr :sp\|NeoSnippetSource<cr>
map <leader>s_ :sp\|e ~/Dropbox/vim/my_snips/snippets_complete/_.snip <cr>

" Deprecated, not good as neosnippet
" Plug 'vim-scripts/UltiSnips'

Plug 'tomtom/tcomment_vim'
let g:tcommentMapLeaderOp1 = '<leader>c'

Plug 'tpope/vim-surround'
" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-abolish'
