if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jasmine') == -1

" Syntax highlighting for jasmine specs (used by http://github.com/thomd/vim-jasmine).

" if b:current_syntax is defined, some other syntax files, earlier in 'runtimepath' was already loaded
if exists("b:current_syntax")
  finish
endif

" match the case of syntax elements
syntax case match

" keywords
syntax keyword jasmineSuite describe it beforeEach afterEach beforeAll afterAll
syntax keyword jasmine jasmine

" special
syntax match jasmineSpecial /\.Ajax/
syntax match jasmineSpecial /\.addMatcher/
syntax match jasmineSpecial /\.getEnv/
syntax match jasmineSpecial /\.loadConfigFile/
syntax match jasmineSpecial /\.onComplete/
syntax match jasmineSpecial /\.QueryString/
syntax match jasmineSpecial /\.HtmlSpecFilter/
syntax match jasmineSpecial /\.addCustomEqualityTester/
syntax match jasmineSpecial /\.configureDefaultReporter/
syntax match jasmineSpecial /\.execute/

" clock
syntax match jasmineClock /\.Timer/
syntax match jasmineClock /\.clock/
syntax match jasmineClock /\.tick/
syntax match jasmineClock /\.mockDate/

" disabled
syntax keyword jasmineDisabled xdescribe xit

" focused 
syntax keyword jasmineFocused fdescribe fit

" expectation
syntax keyword jasmineExpectation expect

" not
syntax region jasmineNot start=/not/ end=/\.to/me=s-1

" matchers
syntax match jasmineMatcher /\.to\h\+/
syntax match jasmineMatcher /\.objectContaining/
syntax match jasmineMatcher /\.arrayContaining/
syntax match jasmineMatcher /\.anything/
syntax match jasmineMatcher /\.any/
syntax keyword jasmineSpy spyOn
syntax match jasmineSpy /\.createSpy/
syntax match jasmineSpyMatcher /and\h\+/

" jasmine is a subset of the javascript language, thus we need to activate
" javascript syntax highlighting and add new jasmin group names to the
" JavaScriptAll cluster which is defined there
runtime! syntax/javascript.vim
syntax cluster JavaScriptAll add=
  \ jasmine,
  \ jasmineClock,
  \ jasmineDisabled,
  \ jasmineFocused,
  \ jasmineExpectation,
  \ jasmineMatcher,
  \ jasmineNot,
  \ jasmineSpecial,
  \ jasmineSpy,
  \ jasmineSpyMatcher,
  \ jasmineSuite

let b:current_syntax = "jasmine"

hi def link jasmine Special
hi def link jasmineClock Special
hi def link jasmineDisabled Error
hi def link jasmineFocused Special
hi def link jasmineExpectation Statement
hi def link jasmineMatcher Statement
hi def link jasmineNot Special
hi def link jasmineSpecial Special
hi def link jasmineSpy Special
hi def link jasmineSpyMatcher Statement
hi def link jasmineSuite Statement

endif
