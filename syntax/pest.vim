if polyglot#init#is_disabled(expand('<sfile>:p'), 'pest', 'syntax/pest.vim')
  finish
endif

" Comments
syntax keyword pestTodo contained TODO FIXME XXX NOTE
syntax match pestComment "\/\/.*$" contains=celTodo

" Rule names
syntax match pestName "^[a-z_][a-z0-9_]*"

" String types
syntax region pestString start=/"/ skip=/\\\\\|\\"/ end=/"/ oneline contained
syntax region pestStringIcase start=/\^"/ skip=/\\\\\|\\"/ end=/"/ oneline contained
syntax region pestChar start=/'/ end=/'/ oneline contained

" Operators, modifiers, keywords
syntax match pestModifier "\v[_@$!]"
syntax match pestOperator "\v[~|*+?&!]" contained
syntax keyword pestKeyword PUSH POP POP_ALL PEEK PEEK_ALL DROP contained
syntax keyword pestSpecial WHITESPACE COMMENT ANY SOI EOI ASCII_DIGIT ASCII_NONZERO_DIGIT ASCII_BIN_DIGIT ASCII_OCT_DIGIT ASCII_HEX_DIGIT
      \ ASCII_ALPHA_LOWER ASCII_ALPHA_UPPER ASCII_ALPHA ASCII_ALPHANUMERIC ASCII NEWLINE
syntax keyword pestGeneral contained
    \ LETTER
    \     CASED_LETTER
    \         UPPERCASE_LETTER
    \         LOWERCASE_LETTER
    \     TITLECASE_LETTER
    \     MODIFIER_LETTER
    \     OTHER_LETTER
    \ MARK
    \     NONSPACING_MARK
    \     SPACING_MARK
    \     ENCLOSING_MARK
    \ NUMBER
    \     DECIMAL_NUMBER
    \     LETTER_NUMBER
    \     OTHER_NUMBER
    \ PUNCTUATION
    \     CONNECTOR_PUNCTUATION
    \     DASH_PUNCTUATION
    \     OPEN_PUNCTUATION
    \     CLOSE_PUNCTUATION
    \     INITIAL_PUNCTUATION
    \     FINAL_PUNCTUATION
    \     OTHER_PUNCTUATION
    \ SYMBOL
    \     MATH_SYMBOL
    \     CURRENCY_SYMBOL
    \     MODIFIER_SYMBOL
    \     OTHER_SYMBOL
    \ SEPARATOR
    \     SPACE_SEPARATOR
    \     LINE_SEPARATOR
    \     PARAGRAPH_SEPARATOR
    \ OTHER
    \     CONTROL
    \     FORMAT
    \     SURROGATE
    \     PRIVATE_USE
    \     UNASSIGNED
syntax keyword pestBinary contained
    \ ALPHABETIC
    \ BIDI_CONTROL
    \ CASE_IGNORABLE
    \ CASED
    \ CHANGES_WHEN_CASEFOLDED
    \ CHANGES_WHEN_CASEMAPPED
    \ CHANGES_WHEN_LOWERCASED
    \ CHANGES_WHEN_TITLECASED
    \ CHANGES_WHEN_UPPERCASED
    \ DASH
    \ DEFAULT_IGNORABLE_CODE_POINT
    \ DEPRECATED
    \ DIACRITIC
    \ EXTENDER
    \ GRAPHEME_BASE
    \ GRAPHEME_EXTEND
    \ GRAPHEME_LINK
    \ HEX_DIGIT
    \ HYPHEN
    \ IDS_BINARY_OPERATOR
    \ IDS_TRINARY_OPERATOR
    \ ID_CONTINUE
    \ ID_START
    \ IDEOGRAPHIC
    \ JOIN_CONTROL
    \ LOGICAL_ORDER_EXCEPTION
    \ LOWERCASE
    \ MATH
    \ NONCHARACTER_CODE_POINT
    \ OTHER_ALPHABETIC
    \ OTHER_DEFAULT_IGNORABLE_CODE_POINT
    \ OTHER_GRAPHEME_EXTEND
    \ OTHER_ID_CONTINUE
    \ OTHER_ID_START
    \ OTHER_LOWERCASE
    \ OTHER_MATH
    \ OTHER_UPPERCASE
    \ PATTERN_SYNTAX
    \ PATTERN_WHITE_SPACE
    \ PREPENDED_CONCATENATION_MARK
    \ QUOTATION_MARK
    \ RADICAL
    \ REGIONAL_INDICATOR
    \ SENTENCE_TERMINAL
    \ SOFT_DOTTED
    \ TERMINAL_PUNCTUATION
    \ UNIFIED_IDEOGRAPH
    \ UPPERCASE
    \ VARIATION_SELECTOR
    \ WHITE_SPACE
    \ XID_CONTINUE
    \ XID_START
syntax keyword pestForbidden abstract alignof as become box break const continue crate do else enum extern false
      \ final fn for if impl in let loop macro match mod move mut offsetof override priv proc pure pub ref return
      \ Self self sizeof static struct super trait true type typeof unsafe unsized use virtual where while yield 

" Rule blocks
syntax region pestBlock start=/{/ end=/}/ fold transparent contains=pestString,pestStringIcase,pestChar,pestOperator,pestKeyword,pestSpecial,pestGeneral,pestBinary,pestForbidden,pestComment,pestBlock
syntax region pestRule start=/^/ end=/ / fold transparent contains=pestName,pestForbidden,pestComment

highlight default link pestTodo Todo
highlight default link pestComment Comment
highlight default link pestString String
highlight default link pestStringIcase String
highlight default link pestChar Character
highlight default link pestName Identifier
highlight default link pestModifier Operator
highlight default link pestOperator Operator
highlight default link pestKeyword Keyword
highlight default link pestSpecial Type
highlight default link pestGeneral Type
highlight default link pestBinary Type
highlight default link pestForbidden Error
