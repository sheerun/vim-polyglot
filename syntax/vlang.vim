if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'v') == -1

" Vim syntax file
" Language:	V
" Maintainer:	Oliver Kelton (https://github.com/ollykel)
" Last Change:	2019 Jun 13
" NOTE: largely based on go.vim, maintained by David Barnett
"       see David Barnett (https://github.com/google/vim-ft-go)
" Options:
"   There are some options for customizing the highlighting; the recommended
"   settings are the default values, but you can write:
"     let OPTION_NAME = 0
"   in your ~/.vimrc file to disable particular options. You can also write:
"     let OPTION_NAME = 1
"   to enable particular options. At present, all options default to on.
"
"   - g:v_highlight_array_whitespace_error
"     Highlights white space after "[]".
"   - g:v_highlight_chan_whitespace_error
"     Highlights white space around the communications operator that don't
"     follow the standard style.
"     Highlights commonly used library types (io.Reader, etc.).
"   - g:v_highlight_space_tab_error
"     Highlights instances of tabs following spaces.
"   - g:v_highlight_trailing_whitespace_error
"     Highlights trailing white space.

" Quit when a (custom) syntax file was already loaded
if exists('b:current_syntax')
  finish
endif

if !exists('g:v_highlight_array_whitespace_error')
  let g:v_highlight_array_whitespace_error = 1
endif
if !exists('g:v_highlight_chan_whitespace_error')
  let g:v_highlight_chan_whitespace_error = 1
endif
if !exists('g:v_highlight_space_tab_error')
  let g:v_highlight_space_tab_error = 1
endif
if !exists('g:v_highlight_trailing_whitespace_error')
  let g:v_highlight_trailing_whitespace_error = 1
endif
if !exists('g:v_highlight_function_calls')
  let g:v_highlight_function_calls = 1
endif
if !exists('g:v_highlight_fields')
  let g:v_highlight_fields = 1
endif

syn case match

syn match    	vDeclType          "\<\(struct\|interface\)\>"

syn keyword    	vDirective         module import
syn keyword    	vDeclaration       pub mut const type enum
syn region	    vIncluded	display contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match	    vIncluded	display contained "<[^>]*>"
syn match	    vFlagDefinition display contained "\s\i[^\n]*"
syn match	    vInclude	display "^\s*\zs\(%:\|#\)\s*include\>\s*["<]" contains=vIncluded
syn match	    vFlag   	display "^\s*\zs\(%:\|#\)\s*flag\>\s*[^\n]*" contains=vFlagDefinition
syn region      vShebang    display start=/^#!/ end=/$/

hi def link    	vDirective         Statement
hi def link    	vDeclaration       Keyword
hi def link    	vDeclType          Keyword
hi def link     vInclude          Include
hi def link     vFlag             Include
hi def link     vIncluded	      vString
hi def link     vFlagDefinition	  vString
hi def link     vShebang          Include

" Keywords within functions
syn keyword    	vStatement         defer go goto return break continue fallthrough
syn keyword    	vConditional       if else switch match or
syn keyword    	vLabel             case default
syn keyword    	vRepeat            for in
syn match       vCodeGen           /$if\>/
syn match       vCodeGen           /\.fields\>/
syn match       vCodeGen           /\.$\i*\>/

hi def link    	vStatement         Statement
hi def link    	vConditional       Conditional
hi def link    	vLabel             Label
hi def link    	vRepeat            Repeat
hi def link     vCodeGen           Identifier

" Predefined types
syn keyword    	vType              chan map bool string error voidptr
syn keyword    	vSignedInts        int i8 i16 i32 i64 rune intptr
syn keyword    	vUnsignedInts      byte uint u8 u16 u32 u64 byteptr
syn keyword    	vFloats            f32 f64 floatptr
syn keyword    	vComplexes         complex64 complex128

hi def link    	vType              Type
hi def link    	vSignedInts        Type
hi def link    	vUnsignedInts      Type
hi def link    	vFloats            Type
hi def link    	vComplexes         Type

" Treat fn specially: it's a declaration at the start of a line, but a type
" elsewhere. Order matters here.
" syn match      	vType              /\<fn\>/
syn match      	vDeclaration       /\<fn\>/
syn match      	vDeclaration       contained /\<fn\>/

" Predefined functions and values
syn keyword    	vBuiltins          assert C cap complex copy delete exit imag
syn keyword    	vBuiltins          print println eprint eprintln print_backtrace  
syn keyword    	vBuiltins          float_calloc ok memdup range_int real recover
syn keyword    	vBuiltins          malloc byte_calloc float_calloc
syn keyword    	vBuiltins          isok isnil panic on_panic
syn keyword    	vConstants         iota true false
syn match	    vBuiltins          /\<json\.\(encode\|decode\)\>/

hi def link    	vBuiltins          Keyword
hi def link    	vConstants         Keyword

" Comments; their contents
syn keyword    	vTodo              contained TODO FIXME XXX BUG
syn cluster    	vCommentGroup      contains=vTodo
syn region     	vComment           start="/\*" end="\*/" contains=@vCommentGroup,@Spell
syn region     	vComment           start="//" end="$" contains=@vCommentGroup,@Spell

hi def link    	vComment           Comment
hi def link    	vTodo              Todo

" Go escapes
syn match      	vEscapeOctal       display contained "\\[0-7]\{3}"
syn match       vEscapeVar         display contained "\$[0-9A-Za-z\.]*"
syn match       vEscapeVar         display contained "\${[^}]*}"
syn match      	vEscapeC           display contained +\\[abfnrtv\\'"]+
syn match      	vEscapeX           display contained "\\x\x\{2}"
syn match      	vEscapeU           display contained "\\u\x\{4}"
syn match      	vEscapeBigU        display contained "\\U\x\{8}"
syn match      	vEscapeError       display contained +\\[^0-7xuUabfnrtv\\'"]+

hi def link    	vEscapeOctal      	vSpecialString
hi def link     vEscapeVar          vSpecialString
hi def link    	vEscapeC          	vSpecialString
hi def link    	vEscapeX          	vSpecialString
hi def link    	vEscapeU          	vSpecialString
hi def link    	vEscapeBigU       	vSpecialString
hi def link    	vSpecialString     Special
hi def link    	vEscapeError       Error

" Strings and their contents
syn cluster    	vStringGroup       contains=vEscapeOctal,vEscapeVar,vEscapeC,vEscapeX,vEscapeU,vEscapeBigU,vEscapeError
syn region     	vString            start=+"+ skip=+\\\\\|\\'+ end=+"+ contains=@vStringGroup
syn region     	vRawString         start=+`+ end=+`+

hi def link    	vString            String
hi def link    	vRawString         String

" Characters; their contents
syn cluster    	vCharacterGroup    contains=vEscapeOctal,vEscapeC,vEscapeVar,vEscapeX,vEscapeU,vEscapeBigU
syn region     	vCharacter         start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=@vCharacterGroup

hi def link    	vCharacter         Character

" Regions
syn region     	vBlock             start="{" end="}" transparent fold
syn region     	vParen             start='(' end=')' transparent

" Integers
syn match      	vDecimalInt        "\<\d\+\([Ee]\d\+\)\?\>"
syn match      	vHexadecimalInt    "\<0x\x\+\>"
syn match      	vOctalInt          "\<0\o\+\>"
syn match      	vOctalError        "\<0\o*[89]\d*\>"

hi def link    	vDecimalInt        Integer
hi def link    	vHexadecimalInt    Integer
hi def link    	vOctalInt          Integer
hi def link     Integer             Number

" Floating point
syn match      	vFloat             "\<\d\+\.\d*\([Ee][-+]\d\+\)\?\>"
syn match      	vFloat             "\<\.\d\+\([Ee][-+]\d\+\)\?\>"
syn match      	vFloat             "\<\d\+[Ee][-+]\d\+\>"

hi def link    	vFloat             Float

" Imaginary literals
syn match      	vImaginary         "\<\d\+i\>"
syn match      	vImaginary         "\<\d\+\.\d*\([Ee][-+]\d\+\)\?i\>"
syn match      	vImaginary         "\<\.\d\+\([Ee][-+]\d\+\)\?i\>"
syn match      	vImaginary         "\<\d\+[Ee][-+]\d\+i\>"

hi def link    	vImaginary         Number

" Generics
syn match     vGenericBrackets     display contained "[<>]"
syn match     vInterfaceDeclaration  display "\s*\zsinterface\s*\i*\s*<[^>]*>" contains=vDeclType,vGenericBrackets
syn match     vStructDeclaration  display "\s*\zsstruct\s*\i*\s*<[^>]*>" contains=vDeclType,vGenericBrackets
" vFunctionName only appears when v_highlight_function_calls set
syn match     vFuncDeclaration  display "\s*\zsfn\s*\i*\s*<[^>]*>" contains=vFunctionName,vDeclaration,vGenericBrackets

hi def link     vGenericBrackets  Identifier

" Spaces after "[]"
if	v_highlight_array_whitespace_error != 0
  syn match	vSpaceError display "\(\[\]\)\@<=\s\+"
endif

" Spacing errors around the 'chan' keyword
if	v_highlight_chan_whitespace_error != 0
  " receive-only annotation on chan type
  syn match	vSpaceError display "\(<-\)\@<=\s\+\(chan\>\)\@="
  " send-only annotation on chan type
  syn match	vSpaceError display "\(\<chan\)\@<=\s\+\(<-\)\@="
  " value-ignoring receives in a few contexts
  syn match	vSpaceError display "\(\(^\|[={(,;]\)\s*<-\)\@<=\s\+"
endif

" Space-tab error
if	v_highlight_space_tab_error != 0
  syn match	vSpaceError display " \+\t"me=e-1
endif

" Trailing white space error
if	v_highlight_trailing_whitespace_error != 0
  syn match	vSpaceError display excludenl "\s\+$"
endif

hi def link    	vSpaceError        Error

" Function calls and Fields are from: https://github.com/fatih/vim-go/blob/master/syntax/go.vim
" Function calls;
if v_highlight_function_calls
  syn match vFunctionCall      /\w\+\ze\s*(/ contains=vBuiltins,vDeclaration
  syn match vFunctionName     display contained /\s\w\+/
  hi def link   vFunctionName      Special
endif

hi def link     vFunctionCall      Special

" Fields;
if v_highlight_fields
  " 1. Match a sequence of word characters coming after a '.'
  " 2. Require the following but dont match it: ( \@= see :h E59)
  "    - The symbols: / - + * %   OR
  "    - The symbols: [] {} <> )  OR
  "    - The symbols: \n \r space OR
  "    - The symbols: , : .
  " 3. Have the start of highlight (hs) be the start of matched
  "    pattern (s) offsetted one to the right (+1) (see :h E401)
  syn match       vField   /\.\w\+\
        \%(\%([\/\-\+*%]\)\|\
        \%([\[\]{}<\>\)]\)\|\
        \%([\!=\^|&]\)\|\
        \%([\n\r\ ]\)\|\
        \%([,\:.]\)\)\@=/hs=s+1
endif
hi def link    vField              Identifier

" Search backwards for a global declaration to start processing the syntax.
"syn sync match	vSync grouphere NONE /^\(const\|var\|type\|func\)\>/

" There's a bug in the implementation of grouphere. For now, use the
" following as a more expensive/less precise workaround.
syn sync minlines=500

let b:current_syntax = 'vlang'

" vim: sw=2 sts=2 et

endif
