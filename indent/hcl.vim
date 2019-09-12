if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'hcl') == -1

if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

" cindent seems to work adequately with HCL's brace-y syntax
setlocal cindent

" don't de-indent comments (cindent treats them like preprocessor directives)
setlocal cinkeys-=0#

endif
