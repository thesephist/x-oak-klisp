" place this in the init path (.vimrc)
" au BufNewFile,BufRead *.klisp set filetype=klisp

if exists("b:current_syntax")
    finish
endif

" auto-format on write
" au BufWritePre *.klisp normal gg=G''

" klisp syntax definition for vi/vim
syntax sync fromstart

" lisp-style indentation
set lisp

" booleans
syntax keyword klispBoolean true false
highlight link klispBoolean Boolean

" numbers should be consumed first by identifiers, so comes before
syntax match klispNumber "\v[-+]?\d+[.\d+]?"
highlight link klispNumber Number

" special forms
syntax keyword klispKeyword quote contained
syntax keyword klispKeyword do contained
syntax keyword klispKeyword def contained
syntax keyword klispKeyword if contained
syntax keyword klispKeyword fn contained
syntax keyword klispKeyword macro contained
" language builtin forms
syntax match klispKeywordCadrContainer "\vc[ad]r!?\W" contains=klispKeywordCadr
syntax match klispKeywordCadr "\vc[ad]r!?" contained
syntax keyword klispKeyword cons contained
" core library and control flow forms
syntax keyword klispKeyword let contained
syntax keyword klispKeyword when contained
syntax keyword klispKeyword when-let contained
syntax keyword klispKeyword unless contained
syntax keyword klispKeyword defn contained
syntax keyword klispKeyword defmacro contained
syntax keyword klispKeyword cond contained
syntax keyword klispKeyword match contained
syntax keyword klispKeyword quasiquote contained
syntax keyword klispKeyword unquote contained
" type assertions
syntax match klispKeywordTyContainer "\v\-\>(nil|int|float|number|bool|string|symbol|function|list)\??\W" contains=klispKeywordTy
syntax match klispKeywordTy "\vnil\?" contained
syntax match klispKeywordTy "\vint\??" contained
syntax match klispKeywordTy "\vfloat\??" contained
syntax match klispKeywordTy "\vnumber\?" contained
syntax match klispKeywordTy "\vbool\??" contained
syntax match klispKeywordTy "\v\-\>string\??" contained
syntax match klispKeywordTy "\vsymbol\?" contained
syntax match klispKeywordTy "\vfunction\?" contained
syntax match klispKeywordTy "\vlist\??" contained
highlight link klispKeyword Keyword
highlight link klispKeywordCadr Keyword
highlight link klispKeywordTy Keyword

" functions
syntax match klispFunctionForm "\v\(\s*[A-Za-z0-9\-?!+*/:><=%&|]+" contains=klispFunctionName,klispKeyword,klispKeywordCadr,klispKeywordTy
syntax match klispFunctionForm "\v\(\s*defn\s+[A-Za-z0-9\-?!+*/:><=%&|]+" contains=klispFunctionName,klispKeyword,klispKeywordCadr,klispKeywordTy
syntax match klispFunctionName "\v[A-Za-z0-9\-?!+*/:><=%&|]+" contained contains=klispKeyword,klispKeywordCadr,klispKeywordTy
highlight link klispFunctionName Function

" strings
syntax region klispString start=/\v'/ skip=/\v(\\.|\r|\n)/ end=/\v'/
highlight link klispString String

" comment
" -- block
" -- line-ending comment
syntax match klispComment "\v;.*" contains=klispTodo
highlight link klispComment Comment
" -- shebang, highlighted as comment
syntax match klispShebangComment "\v^#!.*"
highlight link klispShebangComment Comment
" -- TODO in comments
syntax match klispTodo "\v(TODO\(.*\)|TODO)" contained
syntax keyword klispTodo XXX contained
highlight link klispTodo Todo

syntax region klispForm start="(" end=")" transparent fold
set foldmethod=syntax
set foldlevel=20

let b:current_syntax = "klisp"
