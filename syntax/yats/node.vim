let files = filter(globpath(&rtp, 'syntax/yats/node.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
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
