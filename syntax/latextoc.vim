if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'latex') == -1

syntax match helpText /^.*: .*/
syntax match secNum /^\S\+\(\.\S\+\)\?\s*/ contained conceal
syntax match secLine /^\S\+\t.\+/ contains=secNum
syntax match mainSecLine /^[^\.]\+\t.*/ contains=secNum
syntax match ssubSecLine /^[^\.]\+\.[^\.]\+\.[^\.]\+\t.*/ contains=secNum
highlight link helpText		PreProc
highlight link secNum		Number
highlight link mainSecLine	Title
highlight link ssubSecLine	Comment

endif
