if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'graphql') == -1

" Vim plugin
" Language: GraphQL
" Maintainer: Jon Parise <jon@indelible.org>

if exists('g:autoloaded_graphql')
  finish
endif
let g:autoloaded_graphql = 1

function! graphql#javascript_tags() abort
  return get(g:, 'graphql_javascript_tags', ['gql', 'graphql', 'Relay.QL'])
endfunction

endif
