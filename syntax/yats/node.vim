if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/node.vim')
  finish
endif

syntax keyword typescriptNodeGlobal containedin=typescriptIdentifierName global process
syntax keyword typescriptNodeGlobal containedin=typescriptIdentifierName console Buffer
syntax keyword typescriptNodeGlobal containedin=typescriptIdentifierName module exports
syntax keyword typescriptNodeGlobal containedin=typescriptIdentifierName setTimeout
syntax keyword typescriptNodeGlobal containedin=typescriptIdentifierName clearTimeout
syntax keyword typescriptNodeGlobal containedin=typescriptIdentifierName setInterval
syntax keyword typescriptNodeGlobal containedin=typescriptIdentifierName clearInterval
if exists("did_typescript_hilink") | HiLink typescriptNodeGlobal Structure
endif
