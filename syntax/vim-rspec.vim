syntax match rspecHeader /^*.*/
syntax match rspecTitle /^\[.\+/
syntax match rspecOk /^+.\+/
syntax match rspecOk /PASS.\+/
syntax match rspecError /^-.\+/
syntax match rspecError /FAIL.\+/
syntax match rspecError /^|.\+/
syntax match rspecErrorDetail /^  \w.\+/
syntax match rspecErrorURL /^  \/.\+/
syntax match rspecNotImplemented /^#.\+/
syntax match rspecCode /^  \d\+:/
syntax match rspecNotImplemented /Example disabled.*/

highlight link rspecHeader Identifier
highlight link rspecTitle Identifier
highlight link rspecOk    Statement
highlight link rspecError Error
highlight link rspecErrorDetail Constant
highlight link rspecErrorURL PreProc
highlight link rspecNotImplemented Todo
highlight link rspecCode Type
