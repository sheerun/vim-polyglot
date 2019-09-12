if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cryptol') == -1

" Vim syntax file
" Language:	Cryptol
" Maintainer:	Fergus Henderson
" Last Change:	Thu Feb 10 13:14:24 PST 2005
"

" Remove any old syntax stuff hanging around
if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

set expandtab
set list lcs=tab:>-,trail:.

" (Qualified) identifiers (no default highlighting)
" XXX copied from Haskell
syn match ConId "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=\<[A-Z][a-zA-Z0-9_']*\>"
syn match VarId "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=\<[a-z][a-zA-Z0-9_']*\>"

" Infix operators--most punctuation characters and any (qualified) identifier
" enclosed in `backquotes`. An operator starting with : is a constructor,
" others are variables (e.g. functions).
" XXX copied from Haskell
syn match cryVarSym "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[-!#$%&\*\+/<=>\?@\\^|~.][-!#$%&\*\+/<=>\?@\\^|~:.]*"
syn match cryConSym "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=:[-!#$%&\*\+./<=>\?@\\^|~:]*"
syn match cryVarSym "`\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[a-z][a-zA-Z0-9_']*`"
syn match cryConSym "`\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[A-Z][a-zA-Z0-9_']*`"

" Reserved symbols
syn match cryDelimiter  "(\|)\|\[|\||]\|||\|\[\|\]\|,\|;\|{\|}"

" Strings and constants
" XXX Copied from Haskell
syn match   crySpecialChar	contained "\\\([0-9]\+\|o[0-7]\+\|x[0-9a-fA-F]\+\|[\"\\'&\\abfnrtv]\|^[A-Z^_\[\\\]]\)"
syn match   crySpecialChar	contained "\\\(NUL\|SOH\|STX\|ETX\|EOT\|ENQ\|ACK\|BEL\|BS\|HT\|LF\|VT\|FF\|CR\|SO\|SI\|DLE\|DC1\|DC2\|DC3\|DC4\|NAK\|SYN\|ETB\|CAN\|EM\|SUB\|ESC\|FS\|GS\|RS\|US\|SP\|DEL\)"
syn match   crySpecialCharError	contained "\\&\|'''\+"
syn region  cryString		start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=crySpecialChar
syn region  cryString		start=+``+  skip=+\\\\\|\\"+  end=+``+  contains=hsSpecialChar
syn match   cryCharacter		"[^a-zA-Z0-9_']'\([^\\]\|\\[^']\+\|\\'\)'"lc=1 contains=crySpecialChar,crySpecialCharError
syn match   cryCharacter		"^'\([^\\]\|\\[^']\+\|\\'\)'" contains=crySpecialChar,crySpecialCharError
syn match   cryNumber		"\<[0-9]\+\>\|\<0[b][01]\+\>\|\<0[x][0-9a-fA-F]\+\>\|\<0[o][0-7]\+\>"

" Keyword definitions.

syn keyword cryInclude		include
syn keyword cryConditional	if then else
syn keyword cryWhere	        where
syn keyword cryTypeSyn	        type
syn keyword cryPragma	        pragma
syn keyword cryProp	        extern theorem proof forall codeGen Cpp Haskell SMT Isabelle axioms
syn keyword cryType	        Bit inf

" Primitives
syn keyword cryBoolean          False True
syn keyword cryPrimitive        zero undefined
syn keyword cryPrimitive        error parity lg2 pmod pdiv pmult format
syn keyword cryPrimitive        join split groupBy take drop min max negate reverse
syn keyword cryPrimitive        project tail width
syn keyword cryPrimitive        ASSERT
syn keyword cryPrimitive        module import private

" Comments
syn keyword cryTodo             contained TODO FIXME XXX
syn match   cryLineComment      "//.*" contains=cryTodo
syn region  cryBlockComment     start="/\*"  end="\*/" contains=cryBlockComment,cryTodo

if !exists("cry_minlines")
  let cry_minlines = 50
endif
exec "syn sync lines=" . cry_minlines

if version >= 508 || !exists("did_cry_syntax_inits")
  if version < 508
    let did_cry_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  hi link cryInclude			  Include
  hi link cryTypeSyn			  Keyword
  hi link cryImportMod			  cryImport
  hi link cryConditional		  Conditional
  hi link crySpecialChar		  SpecialChar
  hi link cryTypedef			  Typedef
  hi link cryPragma			  Keyword
  hi link cryVarSym			  cryOperator
  hi link cryConSym			  cryOperator
  hi link cryOperator			  Operator
  hi link cryDelimiter			  Delimiter
  hi link crySpecialCharError		  Error
  hi link cryString			  String
  hi link cryCharacter			  Character
  hi link cryNumber			  Number
  hi link cryConditional		  Conditional
  hi link cryWhere			  Keyword
  hi link cryPrimitive			  Keyword
  hi link cryBlockComment		  cryComment
  hi link cryLineComment		  cryComment
  hi link cryComment			  Comment
  hi link cryBoolean			  Boolean
  hi link cryType			  Type
  hi link cryProp			  Keyword
  hi link cryTodo			  Todo

  delcommand HiLink
endif

let b:current_syntax = "cryptol"

" Options for vi: ts=8 sw=2 sts=2 nowrap noexpandtab ft=vim

endif
