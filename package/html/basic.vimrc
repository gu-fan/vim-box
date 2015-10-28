com! -range -nargs=0 -bar JsonTool <line1>,<line2>!python -m json.tool

com! -nargs=0 JsBeautify call JsBeautify() | setf javascript
com! -nargs=0 CssBeautify call CSSBeautify() | setf css
com! -nargs=0 HtmlBeautify call HtmlBeautify() | setf html

" PHP "{{{2
let php_sql_query = 1
let php_folding=2
let php_htmlInStrings = 1
let php_parent_error_close = 1


python import xmlrpclib, vim

function! EscapeHTML(str)
    try " Force any error to be an exception "
        let d={}
        python vim.eval("extend(d, {'xml': '"+xmlrpclib.escape(vim.eval("a:str")).replace("'", "''")+"'})")
        return d.xml
    endtry
endfunction

function! s:PasteHTML()
    return "\"=EscapeHTML(getreg(".string(v:register)."))\np"
endfunction

nnoremap <expr> ,p <SID>PasteHTML()

fun! s:debug_jasmine()
    while getcwd() != '/' 
        if isdirectory('spec')
            Dispatch jasmine
            return
        else
            cd ..
            continue
        endif
    endwhile
    echo 'no jasmine test spec'
endfun
map <localleader>db :call <SID>debug_jasmine()<CR>
