let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/yats/node.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptNodeGlobal containedin=typescriptIdentifierName global process
syntax keyword typescriptNodeGlobal containedin=typescriptIdentifierName console Buffer
syntax keyword typescriptNodeGlobal containedin=typescriptIdentifierName module exports
syntax keyword typescriptNodeGlobal containedin=typescriptIdentifierName setTimeout
syntax keyword typescriptNodeGlobal containedin=typescriptIdentifierName clearTimeout
syntax keyword typescriptNodeGlobal containedin=typescriptIdentifierName setInterval
syntax keyword typescriptNodeGlobal containedin=typescriptIdentifierName clearInterval
if exists("did_typescript_hilink") | HiLink typescriptNodeGlobal Structure
endif

endif
