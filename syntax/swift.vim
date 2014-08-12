" Language:    Swift<https://developer.apple.com/swift/>
" Maintainer:  toyama satoshi <toyamarinyon@gmail.com>
" URL:         http://github.com/toyamarinyon/vim-swift
" License:     GPL

" Bail if our syntax is already loaded.
if exists('b:current_syntax') && b:current_syntax == 'swift'
  finish
endif

" {{{ Whitespace and Comments
syntax region swiftComment start=#\/\*# end=#\*\/#
syntax match swiftComment /\/\/.*/
highlight default link swiftComment Comment
" }}}

" {{{ Identifiers
syntax match swiftIdentifier /[[:alpha:]_][[:alnum:]_]*/
highlight default link swiftIdentifier Identifier
" }}}

" {{{ Keywords
" Keywords used in declarations:
syntax keyword swiftDeclarationKeywords class deinit enum extension func import init let protocol static struct subscript typealias var
highlight default link swiftDeclarationKeywords Keyword
" Keywords used in statements:
syntax keyword swiftStatementKeywords break case continue default do else fallthrough if in for return switch where while
highlight default link swiftStatementKeywords Keyword
" Keywords used in expressions and types:
syntax keyword swiftExpressionTypeKeywords as dynamicType is new super self Self Type __COLUMN__ __FILE__ __FUNCTION__ __LINE__
highlight default link swiftExpressionTypeKeywords Keyword
" Keywords reserved in particular contexts:
syntax keyword swiftReserveKeywords associativity didSet get infix inout left mutating none nonmutating operator override postfix precedence prefix right set unowned unowned(safe) unowned(unsafe) weak willSet
highlight default link swiftReserveKeywords Keyword
" }}}

" {{{ Literals
" Integer literal
syntax match swiftIntegerLiteral /\<\d\+\%(_\d\+\)*\%(\.\d\+\%(_\d\+\)*\)\=\>/
syntax match swiftIntegerLiteral /\<\d\+\%(_\d\+\)*\%(\.\d\+\%(_\d\+\)*\)\=\%([eE][-+]\=\d\+\%(_\d\+\)*\)\>/
syntax match swiftIntegerLiteral /\<0x\x\+\%(_\x\+\)*\>/
syntax match swiftIntegerLiteral /\<0o\o\+\%(_\o\+\)*\>/
syntax match swiftIntegerLiteral /\<0b[01]\+\%(_[01]\+\)*\>/
highlight default link swiftIntegerLiteral Number
" String literal
syntax region swiftStringLiteral start=/"/ skip=/\\"/ end=/"/
highlight default link swiftStringLiteral String
" }}}

" {{{ Operators
syntax keyword swiftOperatorKeywords / = - + ! * % < > & \| ^ ~ .
highlight default link swiftOperatorKeywords Operator
" }}}

" {{{ Type
syntax match swiftTypeIdentifier /\<[[:alpha:]_][[:alnum:]_.]*/ contained
syntax match swiftType /: .*/ contains=swiftTypeIdentifier
highlight default link swiftType Operator
highlight default link swiftTypeIdentifier Type
" }}}

if !exists('b:current_syntax')
  let b:current_syntax = 'swift'
endif
