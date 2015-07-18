if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'haskell') == -1
  
" syntax highlighting for haskell
"
" Heavily modified version of the haskell syntax
" highlighter to support haskell.
"
" author: raichoo (raichoo@googlemail.com)

if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

if exists('g:haskell_enable_quantification') && g:haskell_enable_quantification == 1
  syn region haskellRecordBlock matchgroup=haskellDelimiter start="{" end="}"
    \ contains=
    \ haskellType,
    \ haskellSeparator,
    \ haskellParens,
    \ haskellBrackets,
    \ haskellRecordField,
    \ haskellOperators,
    \ haskellDot,
    \ haskellLineComment,
    \ haskellBlockComment,
    \ haskellPragma,
    \ haskellForall
else
  syn region haskellRecordBlock matchgroup=haskellDelimiter start="{" end="}"
    \ contains=
    \ haskellType,
    \ haskellSeparator,
    \ haskellParens,
    \ haskellBrackets,
    \ haskellRecordField,
    \ haskellOperators,
    \ haskellDot,
    \ haskellLineComment,
    \ haskellBlockComment,
    \ haskellPragma
endif
if exists('g:haskell_enable_pattern_synonyms') && g:haskell_enable_pattern_synonyms == 1
  syn region haskellImportList matchgroup=haskellDelimiter start="(" end=")"
    \ contains=
    \ haskellSeparator,
    \ haskellType,
    \ haskellLineComment,
    \ haskellBlockComment,
    \ haskellDot,
    \ haskellParens,
    \ haskellPatternKeyword
else
  syn region haskellImportList matchgroup=haskellDelimiter start="(" end=")"
    \ contains=
    \ haskellSeparator,
    \ haskellType,
    \ haskellLineComment,
    \ haskellBlockComment,
    \ haskellDot,
    \ haskellParens
end
syn match haskellRecordField "[_a-z][a-zA-Z0-9_']*\s*::" contained
  \ contains=
  \ haskellIdentifier,
  \ haskellOperators
syn match haskellTopLevelDecl
  \ "^\s*\(where\s\+\|let\s\+\|default\s\+\)\?[_a-z][a-zA-Z0-9_']*\(,\s*[_a-z][a-zA-Z0-9_']*\)*\(\s*::\|\n\s\+::\)"
  \ contains=
  \ haskellIdentifier,
  \ haskellOperators,
  \ haskellSeparator,
  \ haskellParens,
  \ haskellBrackets,
  \ haskellWhere,
  \ haskellLet,
  \ haskellDefault
syn region haskellModuleBlock matchgroup=haskellBlockKeywords start="\<module\>" end="\<where\>"
  \ contains=haskellType,haskellDot,haskellImportList
syn region haskellClassBlock
  \ matchgroup=haskellBlockKeywords
  \ start="^\<\(class\|instance\)\>"
  \ end="\<where\>\|^\<"
  \ contains=
  \ haskellType,
  \ haskellSeparator,
  \ haskellParens,
  \ haskellDot,
  \ haskellOperators,
  \ haskellLineComment,
  \ haskellBlockComment,
  \ haskellPragma
syn keyword haskellDeclKeyword newtype data type family instance where contained
syn region haskellDeclBlock keepend
  \ start="^\<\(newtype\|data\|type\)\>\s\+\(\<\(family\|instance\)\>\)\?"
  \ end="\<where\>\|=\|^\<"
  \ contains=
  \ haskellDeclKeyword,
  \ haskellType,
  \ haskellQuoted,
  \ haskellParens,
  \ haskellBrackets,
  \ haskellDot,
  \ haskellOperators,
  \ haskellLineComment,
  \ haskellBlockComment,
  \ haskellPragma
syn match haskellAssocType "\s\+\<\(data\|type\|newtype\)\>"
syn match haskellDeriving "\(deriving\s\+instance\|deriving\)"
syn keyword haskellDefault default
syn keyword haskellImportKeywords import qualified safe as hiding contained
syn keyword haskellForeignKeywords foreign export import ccall safe unsafe interruptible capi prim contained
syn region haskellForeignImport start="\<foreign\>" end="::" keepend
  \ contains=
  \ haskellString,
  \ haskellOperators,
  \ haskellForeignKeywords,
  \ haskellIdentifier
syn region haskellImport
  \ start="^import"
  \ end="^\<"
  \ contains=
  \ haskellImportKeywords,
  \ haskellImportList,
  \ haskellType,
  \ haskellLineComment,
  \ haskellBlockComment,
  \ haskellDot
syn keyword haskellStatement do case of in
syn keyword haskellWhere where
syn keyword haskellLet let
if exists('g:haskell_enable_static_pointers') && g:haskell_enable_static_pointers == 1
  syn keyword haskellStatic static
endif
syn keyword haskellConditional if then else
syn match haskellNumber "\<[0-9]\+\>\|\<0[xX][0-9a-fA-F]\+\>\|\<0[oO][0-7]\+\>\|\<0[bB][10]\+\>"
syn match haskellFloat "\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"
syn match haskellSeparator  "[,;]"
syn region haskellParens matchgroup=haskellDelimiter start="(" end=")" contains=TOP
syn region haskellBrackets matchgroup=haskellDelimiter start="\[" end="]" contains=TOP
syn region haskellBlock matchgroup=haskellDelimiter start="{" end="}" contains=TOP
syn keyword haskellInfix infix infixl infixr
syn keyword haskellBottom undefined error
syn match haskellOperators "[-!#$%&\*\+/<=>\?@\\^|~:]\+\|\<_\>"
syn match haskellQuote "\<'\+" contained
syn match haskellQuotedType "[A-Z][a-zA-Z0-9_']*\>" contained
syn region haskellQuoted start="\<'\+" end="\>"
  \ contains=
  \ haskellType,
  \ haskellQuote,
  \ haskellQuotedType,
  \ haskellSeparator,
  \ haskellParens,
  \ haskellOperators,
  \ haskellIdentifier
syn match haskellDot "\."
syn match haskellLineComment "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$"
  \ contains=
  \ haskellTodo,
  \ @Spell
syn match haskellBacktick "`[A-Za-z_][A-Za-z0-9_\.']*`"
syn region haskellString start=+"+ skip=+\\\\\|\\"+ end=+"+
  \ contains=@Spell
syn match haskellIdentifier "[_a-z][a-zA-z0-9_']*" contained
syn match haskellChar "\<'[^'\\]'\|'\\.'\|'\\u[0-9a-fA-F]\{4}'\>"
syn match haskellType "\<[A-Z][a-zA-Z0-9_']*\>\n\?\s*"
  \ nextgroup=haskellBlockComment,haskellRecordBlock
syn region haskellBlockComment start="{-" end="-}"
  \ contains=
  \ haskellBlockComment,
  \ haskellTodo,
  \ @Spell
syn region haskellPragma start="{-#" end="#-}"
syn region haskellQuasiQuote matchgroup=haskellTH start="\[[_a-z][a-zA-z0-9_']*|" end="|\]"
syn region haskellTHBlock matchgroup=haskellTH start="\[\(d\|t\|p\)\?|" end="|]" contains=TOP
syn region haskellTHDoubleBlock matchgroup=haskellTH start="\[||" end="||]" contains=TOP
syn match haskellPreProc "^#.*$"
syn keyword haskellTodo TODO FIXME contained
if exists('g:haskell_enable_typeroles') && g:haskell_enable_typeroles == 1
  syn keyword haskellTypeRoles phantom representational nominal contained
  syn region haskellTypeRoleBlock matchgroup=haskellTypeRoles start="type\s\+role" end="^\<" keepend
    \ contains=
    \ haskellType,
    \ haskellTypeRoles
endif
if exists('g:haskell_enable_quantification') && g:haskell_enable_quantification == 1
  syn keyword haskellForall forall
endif
if exists('g:haskell_enable_recursivedo') && g:haskell_enable_recursivedo == 1
  syn keyword haskellRecursiveDo mdo rec
endif
if exists('g:haskell_enable_arrowsyntax') && g:haskell_enable_arrowsyntax == 1
  syn keyword haskellArrowSyntax proc
endif
if exists('g:haskell_enable_pattern_synonyms') && g:haskell_enable_pattern_synonyms == 1
  syn region haskellPatternSynonym start="^\<pattern\>" end="=\|<-" keepend
    \ contains=
    \ haskellPatternKeyword,
    \ haskellType,
    \ haskellOperators
  syn keyword haskellPatternKeyword pattern contained
endif

highlight def link haskellBottom Macro
highlight def link haskellTH Boolean
highlight def link haskellBlockKeywords Structure
highlight def link haskellIdentifier Identifier
highlight def link haskellForeignKeywords Structure
highlight def link haskellDeriving Structure
highlight def link haskellStatement Statement
highlight def link haskellWhere Statement
highlight def link haskellLet Statement
highlight def link haskellDefault Statement
highlight def link haskellConditional Conditional
highlight def link haskellNumber Number
highlight def link haskellFloat Float
highlight def link haskellSeparator Delimiter
highlight def link haskellDelimiter Delimiter
highlight def link haskellInfix PreProc
highlight def link haskellOperators Operator
highlight def link haskellQuote Operator
highlight def link haskellQuotedType Include
highlight def link haskellDot Operator
highlight def link haskellType Include
highlight def link haskellLineComment Comment
highlight def link haskellBlockComment Comment
highlight def link haskellPragma SpecialComment
highlight def link haskellString String
highlight def link haskellChar String
highlight def link haskellBacktick Operator
highlight def link haskellPreProc Macro
highlight def link haskellTodo Todo
highlight def link haskellAssocType Structure
highlight def link haskellImportBlock Delimiter
highlight def link haskellImportKeywords Structure
highlight def link haskellDeclKeyword Structure

if exists('g:haskell_enable_quantification') && g:haskell_enable_quantification == 1
  highlight def link haskellForall Operator
endif
if exists('g:haskell_enable_recursivedo') && g:haskell_enable_recursivedo == 1
  highlight def link haskellRecursiveDo Operator
endif
if exists('g:haskell_enable_arrowsyntax') && g:haskell_enable_arrowsyntax == 1
  highlight def link haskellArrowSyntax Operator
endif
if exists('g:haskell_enable_pattern_synonyms') && g:haskell_enable_pattern_synonyms == 1
  highlight def link haskellPatternKeyword Structure
endif
if exists('g:haskell_enable_typeroles') && g:haskell_enable_typeroles == 1
  highlight def link haskellTypeRoles Structure
endif
if exists('g:haskell_enable_static_pointers') && g:haskell_enable_static_pointers == 1
  highlight def link haskellStatic Statement
endif

let b:current_syntax = "haskell"

endif
