" folding for varnish vcl, completely based on markdown folding:
" original version from Steve Losh's gist: https://gist.github.com/1038710
"
" Javi Polo <javipolo@drslump.org>
" You can place this file in ~/.vim/after/ftplugin/vcl.vim

func! Foldexpr_vcl(lnum)
    if (a:lnum == 1)
        let l0 = ''
    else
        let l0 = getline(a:lnum-1)
    endif

    let l1 = getline(a:lnum)

    if l1 =~ '\v^\s*#*\s*(director|acl|sub)'
" current line is blank (level 1 end)
        return '>1'
    else
" keep previous foldlevel
        return '='
    endif
endfunc

setlocal foldexpr=Foldexpr_vcl(v:lnum)
setlocal foldmethod=expr

function! Foldtext_vcl()
      let foldsize = (v:foldend-v:foldstart)
        return getline(v:foldstart).' ('.foldsize.' lines)'
    endfunction
    setlocal foldtext=Foldtext_vcl()

"---------- everything after this is optional -----------------------
" change the following fold options to your liking
" see ':help fold-options' for more
"setlocal foldenable
"setlocal foldlevel=0
"setlocal foldcolumn=0
set foldmethod=expr
set foldopen-=search
