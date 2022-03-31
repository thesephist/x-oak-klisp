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
set lispwords+=quote,def,do,if,fn,macro
set lispwords+=def,defn,defmacro,defmut,deftest,when,unless,let,when-let,if-let,quasiquote,loop,while,match,partial

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
syntax match klispKeywordCadrContainer "\v(car|cdr|first|rest)!?[ ()$]" contains=klispKeywordCadr
syntax match klispKeywordCadr "\v(car|cdr|first|rest)!?" contained
syntax keyword klispKeyword cons contained
syntax keyword klispKeyword conj contained
" core library and control flow forms
syntax keyword klispKeyword defn contained
syntax keyword klispKeyword defmacro contained
syntax keyword klispKeyword defmut contained
syntax keyword klispKeyword deftest contained
syntax keyword klispKeyword when contained
syntax keyword klispKeyword unless contained
syntax keyword klispKeyword let contained
syntax keyword klispKeyword if-let contained
syntax keyword klispKeyword when-let contained
syntax keyword klispKeyword unless contained
syntax keyword klispKeyword quasiquote contained
syntax keyword klispKeyword unquote contained
syntax keyword klispKeyword default contained
syntax keyword klispKeyword loop contained
syntax keyword klispKeyword break contained
syntax keyword klispKeyword while contained
syntax keyword klispKeyword cond contained
syntax keyword klispKeyword match contained
syntax keyword klispKeyword partial contained
" type assertions
syntax match klispKeywordTyContainer "\v\(\s*(nil|int|float|number|bool|\-\>string|symbol|function|list)\??[ ()$]" contains=klispKeywordTy
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
syntax match klispFunctionForm "\v\(\s*[A-Za-z0-9\-?!+*/#:><=%&|]+" contains=klispFunctionName,klispKeywordTyContainer
syntax match klispFunctionForm "\v\(\s*defn\s+[A-Za-z0-9\-?!+*/#:><=%&|]+" contains=klispFunctionName
syntax match klispFunctionName "\v[A-Za-z0-9\-?!+*/#:><=%&|]+" contained contains=klispKeyword,klispKeywordCadrContainer
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
