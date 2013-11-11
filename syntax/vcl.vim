" Vim syntax file
" Filename:     vcl.vim
" Language:     Varnish configuation Language, http://www.varnish-cache.org/wiki/VCL

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Code Blocks
"       sub NAME {
"       backend NAME {
"       director NAME FLAGS {
"       acl NAME {
syn region vclCodeBlock start="\s*\<sub\|backend\|director\|acl\>" end="{"he=e-1 contains=vclCodeBlockName
syn match  vclCodeBlockName "\<sub\|backend\|director\|acl\>" contained


syn match vclFunctionName "ban_url\|ban\|regsuball\|regsub\|hash_data"

syn keyword vclOperator     set call return error esi synthetic include remove unset purge
" return modes
syn keyword vclModes        deliver pipe pass hash lookup discard fetch restart hit_for_pass

" C strings
syn region vclString start=+L\="+ skip=+\\\\\|\\"+ end=+"+ contains=vclSpecial
syn match  vclSpecial display contained "\\\(x\x\+\|\o\{1,3}\|.\|$\)"
syn match  vclSpecialError   "L\='\\[^'\"?\\abfnrtv]'"
syn match  vclSpecialCharacter "L\='\\['\"?\\abfnrtv]'"
syn match  vclSpecialCharacter display "L\='\\\o\{1,3}'"
syn match  vclSpecialCharacter display "'\\x\x\{1,2}'"
syn match  vclSpecialCharacter display "L'\\x\x\+'"

syn keyword vclConditional  if else elsif elseif

" Numbers
syn match  vclNumbers  display transparent "\<\d\|\.\d" contains=vclNumber,vclNumberTime
syn match  vclNumber   display contained "\d\+"
" set obj.ttl = 0s, 0m;
syn match  vclNumberTime   display contained "\d\+[dhsmw]"
syn match  vclNumberBool   /\(true\|false\)/

" client
syn match  vclOption   /client\.ip/
" server
syn match  vclOption   /server\.\(ip\|port\|identity\)/
" req
syn match  vclOption   /req\.\(hash_always_miss\|hash\|request\|url\|proto\|backend\.healthy\|backend\|grace\|xid\|restarts\|esi_level\)/
" bereq.
syn match  vclOption   /bereq\.\(request\|url\|proto\|connect_timeout\|first_byte_timeout\|between_bytes_timeout\)/
" obj
syn match  vclOption   /obj\.\(proto\|status\|response\|cacheable\|ttl\|lastuse\|hits\|hash\|grace\|prefetch\)/
" beresp
syn match  vclOption   /beresp\.\(cacheable\|do_stream\|do_esi\|do_gzip\|do_gunzip\|hash\|hits\|lastuse\|proto\|status\|response\|ttl\|grace\|saintmode\|backend\.name\|backend\.ip\|backend\.port\|storage\)/
" resp
syn match  vclOption   /resp\.\(proto\|status\|response\)/
" common: http.HEADERNAME
syn match  vclOption   /\(req\|bereq\|resp\|beresp\|obj\)\.http\.[A-Za-z][-_A-Za-z0-9]*/

" Highlight the C block
syn include @vclC syntax/c.vim
unlet b:current_syntax

" Mark block tags itself as comment
syn region vclCBlock matchgroup=vclComment start=/C{/ end=/}C/ contains=@vclC keepend

" Synthetic
syn region vclSynthetic start=/{"/hs=s+2 end=/"}/he=e-2 contains=@vclHTML keepend

" Allow html in synthetic
syn include @vclHTML syntax/html.vim
unlet b:current_syntax

syn match  vclComment   '#.*'
syn match  vclComment   "//.*"
syn region vclComment    start="/\*"  end="\*/"

syn sync ccomment vclComment

hi link vclCodeBlock        Function
hi link vclComment          Comment
hi link vclStatement        Statement
hi link vclFunctionName     Identifier
hi link vclCodeBlockName    Statement
hi link vclSpecial          SpecialChar
hi link vclString           String
hi link vclConditional      Conditional
hi link vclSynthetic        vclString
hi link vclSpecialCharacter vclSpecialSpecial
hi link vclOperator         Operator
hi link vclModes            Operator
hi link vclOption           Identifier
hi link vclNumber           Number
hi link vclNumberTime       Number
hi link vclNumberBool       Number
