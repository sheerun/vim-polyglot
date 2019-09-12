if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'puppet') == -1

" Puppet set up for Tagbar plugin
" (https://github.com/majutsushi/tagbar).

if !exists(':Tagbar')
    finish
endif

let g:tagbar_type_puppet = {
  \ 'ctagstype': 'puppet',
  \ 'kinds': [
    \ 'c:Classes',
    \ 's:Sites',
    \ 'n:Nodes',
    \ 'v:Variables',
    \ 'i:Includes',
    \ 'd:Definitions',
    \ 'r:Resources',
    \ 'f:Defaults',
    \ 't:Types',
    \ 'u:Functions',
  \],
\}

if puppet#ctags#Type() == 'universal'
    " There no sense to split objects by colon
    let g:tagbar_type_puppet.sro = '__'
    let g:tagbar_type_puppet.kind2scope = {
      \ 'd': 'definition',
      \ 'c': 'class',
      \ 'r': 'resource',
      \ 'i': 'include',
      \ 'v': 'variable',
    \}
    let g:tagbar_type_puppet.scope2kind = {
      \ 'definition' : 'd',
      \ 'class'      : 'c',
      \ 'resource'   : 'r',
      \ 'include'    : 'i',
      \ 'variable'   : 'v',
    \}
endif

let g:tagbar_type_puppet.deffile = puppet#ctags#OptionFile()


endif
