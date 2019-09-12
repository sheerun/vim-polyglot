if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'latex') == -1

" adds support for cleverref package
" \Cref, \cref, \cpageref, \labelcref, \labelcpageref
syn region texRefZone		matchgroup=texStatement start="\\Cref{"				end="}\|%stopzone\>"	contains=@texRefGroup
syn region texRefZone		matchgroup=texStatement start="\\\(label\|\)c\(page\|\)ref{"	end="}\|%stopzone\>"	contains=@texRefGroup

" adds support for listings package
syn region texZone start="\\begin{lstlisting}" end="\\end{lstlisting}\|%stopzone\>"
syn match texInputFile  "\\lstinputlisting\s*\(\[.*\]\)\={.\{-}}" contains=texStatement,texInputCurlies,texInputFileOpt
syn match texZone "\\lstinline\s*\(\[.*\]\)\={.\{-}}"

endif
