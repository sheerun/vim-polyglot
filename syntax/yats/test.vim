let files = filter(globpath(&rtp, 'syntax/yats/test.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptTestGlobal containedin=typescriptIdentifierName describe
syntax keyword typescriptTestGlobal containedin=typescriptIdentifierName it test before
syntax keyword typescriptTestGlobal containedin=typescriptIdentifierName after beforeEach
syntax keyword typescriptTestGlobal containedin=typescriptIdentifierName afterEach
syntax keyword typescriptTestGlobal containedin=typescriptIdentifierName beforeAll
syntax keyword typescriptTestGlobal containedin=typescriptIdentifierName afterAll
syntax keyword typescriptTestGlobal containedin=typescriptIdentifierName expect assert

endif
