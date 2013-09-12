" Vim syntax file
" Language: Haskell
" Author: Tristan Ravitch
" Maintainer: Tristan Ravitch
" Version: 0.0.1

if version < 600
  syntax clear
elseif exists('b:current_syntax')
  finish
endif

syn sync minlines=50 maxlines=200

" These basic lexical definitions are taken from the orignal haskell syntax
" description from vim 7.3.
syn match  hsSpecialChar      contained "\\\([0-9]\+\|o[0-7]\+\|x[0-9a-fA-F]\+\|[\"\\'&\\abfnrtv]\|^[A-Z^_\[\\\]]\)"
syn match  hsSpecialChar      contained "\\\(NUL\|SOH\|STX\|ETX\|EOT\|ENQ\|ACK\|BEL\|BS\|HT\|LF\|VT\|FF\|CR\|SO\|SI\|DLE\|DC1\|DC2\|DC3\|DC4\|NAK\|SYN\|ETB\|CAN\|EM\|SUB\|ESC\|FS\|GS\|RS\|US\|SP\|DEL\)"
syn match  hsSpecialCharError contained "\\&\|'''\+"
syn region hsString           start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=hsSpecialChar
syn match  hsCharacter        "[^a-zA-Z0-9_']'\([^\\]\|\\[^']\+\|\\'\)'"lc=1 contains=hsSpecialChar,hsSpecialCharError
syn match  hsCharacter        "^'\([^\\]\|\\[^']\+\|\\'\)'" contains=hsSpecialChar,hsSpecialCharError
syn match  hsNumber           "\<[0-9]\+\>\|\<0[xX][0-9a-fA-F]\+\>\|\<0[oO][0-7]\+\>"
syn match  hsFloat            "\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"

" This case matches the names of types and constructors: names beginning with
" a capital letter.  Note that this also handles the case of @M.lookup@ where
" M is a qualified import.  There is a big negative lookbehind assertion here
" so that we don't highlight import and module statements oddly. 
syn match hsTypeName "\(^import\s.*\|^module\s.*\)\@<!\([^a-zA-Z0-9]\)\@<=[A-Z][a-zA-Z0-9_]*"
" Also make unit and the empty list easy to spot - they are constructors too.
syn match hsTypeName "()"
syn match hsTypeName "\[\]"

" These are keywords that are only highlighted if they are in comments.
syn keyword hsFIXME contained FIXME TODO XXX BUG NOTE

" Comment stuff
syn region hsPragma start='{-#' end='#-}'
syn region hsBlockComment start='{-' end='-}' fold contains=hsFIXME,hsBlockComment
" FIXME: haddock block comments should be able to contain hsBlockComments, but
" it doesn't seem to work at the moment.
syn region hsHaddockComment start='{-|' end='-}' contains=hsFIXME
syn match hsLineComment "--.*$" contains=hsFIXME
" Line-based haddock comments are trickier - they continue until
" the next line that isn't part of the same block of comments.
syn region hsHaddockComment start='-- |' end='^\(\s*--\)\@!' contains=hsFIXME
syn region hsHaddockComment start='-- \$\w\+' end='^\(\s*--\)\@!' contains=hsFIXME
syn region hsHaddockComment start='-- ^' end='^\(\s*--\)\@!' contains=hsFIXME
" Haddock sections for import lists
syn match hsHaddockSection '-- \*.*$'
" Named documentation chunks (also for import lists)
syn match hsHaddockSection '-- \$.*$'


" Keywords appearing in expressions, plus a few top-level keywords
syn keyword hsKeyword do let in _ where
syn keyword hsKeyword infix infixl infixr
syn keyword hsKeyword forall foreign
syn match hsKeyword '\(^\(data\|type\)\s\+\)\@<=family\(\W\)\@='

" Vim has a special syntax category for conditionals, so here are all of the
" haskell conditionals.  These are just keywords with a slightly more flexible
" coloring.
syn keyword hsConditional case of if then else

" We define a region for module NNNN (...) where so that haddock section
" headers (-- *) can be highlighted specially only within this context.
syn region hsModuleHeader start="^module\s" end="where" contains=hsHaddockSection keepend fold transparent
" Treat Module imports as the #include category; it maps reasonably well
syn keyword hsImport import qualified as hiding module

syn keyword hsTypeDecls class instance data newtype type deriving default
" FIXME: Maybe we can do something fancy for data/type families?  'family' is
" only a keyword if it follows data/type...

" This is uglier than I'd like.  We want to let '-' participate in operators,
" but we can't let it match '--' because that interferes with comments.  Hacks
" for now - just include some common operators with '-'.
syn match hsOperator "<-\|->\|-->\|-\(-\)\@!\|[%\~\&\*/\$\^|@:+<!>=#!\?]\+"
" A bare . is an operator (but not surrounded by alnum chars)
syn match hsOperator "\s\@<=\.\s\@="
" . is also an operator if adjacent to some other operator char
syn match hsOperator "[%\~\&\*\$\^|@:+<!>=#!\?]\+\.[%\~\&\*\$\^|@:+<\.!>=#!\?]*"
syn match hsOperator "[%\~\&\*\$\^|@:+<!>=#!\?]*\.[%\~\&\*\$\^|@:+\.<!>=#!\?]\+"
" Include support for infix functions as operators
syn match hsOperator "`[a-zA-Z0-9\.]\+`"

" Highlight function/value names in type signatures.  Looks ahead to find a ::
" after a name.  This allows whitespace before the name so that it can match
" in a 'where,' but it won't match local type annotations on random little
" things.
syn match hsFunctionList "^\s*\([a-z][a-zA-Z0-9']*[[:space:]\n,]\+\)*[a-z][a-zA-Z0-9']*[[:space:]\n]*::" contains=hsFunction
syn match hsFunction "\s*[a-z][a-zA-Z0-9']*[[:space:]\n]*\(::\|,\)\@=" contained
" Also support the style where the first where binding is on the same line as
" the where keyword.
syn match hsFunction "\(^\s\+where\s\+\)\@<=[a-z][a-zA-Z0-9']*\(\s*::\)\@="

" FIXME Ignoring proc for now, also mdo and rec

" Give undefined a bit of special treatment
syn keyword hsScary undefined

" C Preprocessor stuff
syn match hsCPP '\(^\s*\)\@<=#\(warning\|pragma\|error\)\W\@='
syn match hsCPPCond '\(^\s*\)\@<=#\(if\|ifdef\|elif\)\W\@='
syn match hsCPPCond '\(^\s*\)\@<=#\(endif\|else\)\(\s*$\|\W\)\@='
syn match hsCPPInclude '\(^\s*\)\@<=#include\W\@='
syn match hsCPPDefine '\(^\s*\)\@<=#define\W\@='
syn match hsCPPDefined '\(^\s*.*\W\)\@<=defined(\w\+)'

if version >= 508 || !exists('did_hs_syntax_inits')
  if version < 508
    let did_hs_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " CPP
  HiLink hsCPP PreProc
  HiLink hsCPPCond PreCondit
  HiLink hsCPPInclude Include
  HiLink hsCPPDefine Define
  HiLink hsCPPDefined PreProc

  " Comments
  HiLink hsLineComment Comment
  HiLink hsBlockComment Comment
  HiLink hsPragma Comment
  HiLink hsHaddockComment SpecialComment
  HiLink hsHaddockSection SpecialComment

  HiLink hsKeyword Keyword
  HiLink hsConditional Conditional
  HiLink hsImport Include
  HiLink hsTypeDecls Keyword

  HiLink hsFIXME Todo

  HiLink hsOperator Operator

  HiLink hsModuleQualifier StorageClass

  HiLink hsFunction Function
  HiLink hsTypeName Type

  " Literals
  HiLink hsSpecialChar SpecialChar
  HiLink hsFloat Float
  HiLink hsNumber Number
  HiLink hsCharacter Character
  HiLink hsString String

  HiLink hsScary Todo

  delcommand HiLink
endif

let b:current_syntax = "haskell"
