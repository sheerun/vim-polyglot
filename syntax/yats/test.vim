if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/test.vim')
  finish
endif

syntax keyword typescriptTestGlobal containedin=typescriptIdentifierName describe
syntax keyword typescriptTestGlobal containedin=typescriptIdentifierName it test before
syntax keyword typescriptTestGlobal containedin=typescriptIdentifierName after beforeEach
syntax keyword typescriptTestGlobal containedin=typescriptIdentifierName afterEach
syntax keyword typescriptTestGlobal containedin=typescriptIdentifierName beforeAll
syntax keyword typescriptTestGlobal containedin=typescriptIdentifierName afterAll
syntax keyword typescriptTestGlobal containedin=typescriptIdentifierName expect assert
