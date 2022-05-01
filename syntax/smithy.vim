if polyglot#init#is_disabled(expand('<sfile>:p'), 'smithy', 'syntax/smithy.vim')
  finish
endif

syn case match

syn keyword   smithyNamespace     namespace
syn keyword   smithyMetadata      metadata suppresssions
syn keyword   smithyKeywords      use apply
syn keyword   smithyMember        member
syn region    smithyTrait         start="@" end="\w*"

hi def link   smithyNamespace     Statement
hi def link   smithyMetadata      Statement 
hi def link   smithyKeywords      Keyword 
hi def link   smithyMember        Label 
hi def link   smithyTrait         Identifier


" Predefined types
syn keyword   smithyContainer   list set map union document structure service operation
syn keyword   smithySimpleType  boolean blob string byte short integer long float double timestamp

hi def link   smithyContainer   Type
hi def link   smithySimpleType  Type

" Comments
syn region    smithyCommentBlock  start="///" end="$" contains=@Spell
syn region    smithyComment       start="//" end="$" contains=@Spell

hi def link   smithyCommentBlock  Comment
hi def link   smithyComment       Comment

" Literal strings
syn region    smithyString            start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@Spell
syn region    smithyMultiLineString   start=+"""+ end=+"""+ contains=@Spell

hi def link   smithyString            String
hi def link   smithyMultiLineString   String

" Regions
syn region    smithyParen             start='('  end=')' transparent
syn region    smithyBlock             start="{"  end="}" transparent
syn region    smithyList              start="\[" end="\]" transparent


" vim: sw=2 ts=2 et
