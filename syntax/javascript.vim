if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  
" Vim syntax file
" Language:     JavaScript
" Maintainer:   vim-javascript community
" URL:          https://github.com/pangloss/vim-javascript

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'javascript'
endif

if !exists('g:javascript_conceal')
  let g:javascript_conceal = 0
endif

" Dollar sign is permittd anywhere in an identifier
setlocal iskeyword+=$

syntax sync fromstart
" TODO: Figure out what type of casing I need
" syntax case ignore
syntax case match

syntax match   jsNoise           /[:,\;\.]\{1}/
syntax match   jsFuncCall         /\k\+\%(\s*(\)\@=/
syntax match   jsParensError    /\%()\|}\|\]\)/

" Program Keywords
syntax keyword jsStorageClass   const var let
syntax keyword jsOperator       delete instanceof typeof void new in of
syntax match   jsOperator       /[\!\|\&\+\-\<\>\=\%\/\*\~\^]\{1}/
syntax match   jsSpreadOperator /\.\.\./ skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsBooleanTrue    true
syntax keyword jsBooleanFalse   false

" Modules
syntax keyword jsModuleKeywords  contained import
syntax keyword jsModuleKeywords  contained export skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsModuleOperators contained from
syntax keyword jsModuleOperators contained as
syntax region  jsModuleGroup     contained matchgroup=jsBraces start=/{/ end=/}/ contains=jsModuleOperators,jsNoise
syntax match   jsModuleAsterisk  contained /*/
syntax keyword jsModuleDefault   contained default skipwhite skipempty nextgroup=@jsExpression
syntax region jsImportContainer  start=/\<import\> / end="\%(;\|$\)" contains=jsModuleKeywords,jsModuleOperators,jsComment,jsString,jsTemplateString,jsNoise,jsModuleGroup,jsModuleAsterisk
syntax match  jsExportContainer   /\<export\> / contains=jsModuleKeywords skipwhite skipempty nextgroup=jsExportBlock,jsModuleDefault
syntax region jsExportBlock      contained matchgroup=jsBraces start=/{/ end=/}/ contains=jsModuleOperators,jsNoise

" Strings, Templates, Numbers
syntax region  jsString           start=+"+  skip=+\\\("\|$\)+  end=+"\|$+  contains=jsSpecial,@Spell extend
syntax region  jsString           start=+'+  skip=+\\\('\|$\)+  end=+'\|$+  contains=jsSpecial,@Spell extend
syntax region  jsTemplateString   start=+`+  skip=+\\\(`\|$\)+  end=+`+     contains=jsTemplateVar,jsSpecial extend
syntax match   jsTaggedTemplate   /\k\+\%(`\)\@=/ nextgroup=jsTemplateString
syntax match   jsNumber           /\<-\=\d\+\(L\|[eE][+-]\=\d\+\)\=\>\|\<0[xX]\x\+\>/
syntax keyword jsNumber           Infinity
syntax match   jsFloat            /\<-\=\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%([eE][+-]\=\d\+\)\=\>/

" Regular Expressions
syntax match   jsSpecial          contained "\v\\%(0|\\x\x\{2\}\|\\u\x\{4\}\|\c[A-Z]|.)"
syntax region  jsTemplateVar      contained matchgroup=jsTemplateBraces start=+${+ end=+}+ contains=@jsExpression
syntax region  jsRegexpCharClass  contained start=+\[+ skip=+\\.+ end=+\]+
syntax match   jsRegexpBoundary   contained "\v%(\<@![\^$]|\\[bB])"
syntax match   jsRegexpBackRef    contained "\v\\[1-9][0-9]*"
syntax match   jsRegexpQuantifier contained "\v\\@<!%([?*+]|\{\d+%(,|,\d+)?})\??"
syntax match   jsRegexpOr         contained "\v\<@!\|"
syntax match   jsRegexpMod        contained "\v\(@<=\?[:=!>]"
syntax region  jsRegexpGroup      contained start="\\\@<!(" skip="\\.\|\[\(\\.\|[^]]\)*\]" end="\\\@<!)" contains=jsRegexpCharClass,@jsRegexpSpecial keepend
if v:version > 703 || v:version == 603 && has("patch1088")
  syntax region  jsRegexpString   start=+\%(\%(\%(return\|case\)\s\+\)\@50<=\|\%(\%([)\]"']\|\d\|\w\)\s*\)\@50<!\)/\(\*\|/\)\@!+ skip=+\\.\|\[\%(\\.\|[^]]\)*\]+ end=+/[gimy]\{,4}+ contains=jsRegexpCharClass,jsRegexpGroup,@jsRegexpSpecial oneline keepend extend
else
  syntax region  jsRegexpString   start=+\%(\%(\%(return\|case\)\s\+\)\@<=\|\%(\%([)\]"']\|\d\|\w\)\s*\)\@<!\)/\(\*\|/\)\@!+ skip=+\\.\|\[\%(\\.\|[^]]\)*\]+ end=+/[gimy]\{,4}+ contains=jsRegexpCharClass,jsRegexpGroup,@jsRegexpSpecial oneline keepend extend
endif
syntax cluster jsRegexpSpecial    contains=jsSpecial,jsRegexpBoundary,jsRegexpBackRef,jsRegexpQuantifier,jsRegexpOr,jsRegexpMod

syntax match   jsObjectKey         contained /\<[0-9a-zA-Z_$]*\>\(\s*:\)\@=/ contains=jsFunctionKey skipwhite skipempty nextgroup=jsObjectValue
syntax region  jsObjectKeyString   contained start=+"+  skip=+\\\("\|$\)+  end=+"\|$+  contains=jsSpecial,@Spell skipwhite skipempty nextgroup=jsObjectValue
syntax region  jsObjectKeyString   contained start=+'+  skip=+\\\('\|$\)+  end=+'\|$+  contains=jsSpecial,@Spell skipwhite skipempty nextgroup=jsObjectValue
syntax region  jsObjectKeyComputed contained matchgroup=jsBrackets start=/\[/ end=/]/ contains=@jsExpression skipwhite skipempty nextgroup=jsObjectValue,jsFuncArgs extend
syntax match   jsObjectSeparator   contained /,/
syntax region  jsObjectValue       contained start=/:/ end=/\%(,\|}\)\@=/ contains=@jsExpression extend
syntax match   jsObjectFuncName    contained /\<[a-zA-Z_$][0-9a-zA-Z_$]*\>[\r\n\t ]*(\@=/ skipwhite skipempty nextgroup=jsFuncArgs
syntax match   jsFunctionKey       contained /\<[a-zA-Z_$][0-9a-zA-Z_$]*\>\(\s*:\s*function\s*\)\@=/
syntax match   jsObjectGetSet      contained /\%(get\|set\|static\)\%( \k\+\)\@=/ skipwhite skipempty nextgroup=jsObjectFuncName
syntax region  jsObjectStringKey   contained start=+"+  skip=+\\\("\|$\)+  end=+"\|$+  contains=jsSpecial,@Spell extend skipwhite skipempty nextgroup=jsFuncArgs,jsObjectValue
syntax region  jsObjectStringKey   contained start=+'+  skip=+\\\('\|$\)+  end=+'\|$+  contains=jsSpecial,@Spell extend skipwhite skipempty nextgroup=jsFuncArgs,jsObjectValue

exe 'syntax keyword jsNull      null             '.(exists('g:javascript_conceal_null')      ? 'conceal cchar='.g:javascript_conceal_null       : '')
exe 'syntax keyword jsReturn    return contained '.(exists('g:javascript_conceal_return')    ? 'conceal cchar='.g:javascript_conceal_return     : '')
exe 'syntax keyword jsUndefined undefined        '.(exists('g:javascript_conceal_undefined') ? 'conceal cchar='.g:javascript_conceal_undefined  : '')
exe 'syntax keyword jsNan       NaN              '.(exists('g:javascript_conceal_NaN')       ? 'conceal cchar='.g:javascript_conceal_NaN        : '')
exe 'syntax keyword jsPrototype prototype        '.(exists('g:javascript_conceal_prototype') ? 'conceal cchar='.g:javascript_conceal_prototype  : '')
exe 'syntax keyword jsThis      this   contained '.(exists('g:javascript_conceal_this')      ? 'conceal cchar='.g:javascript_conceal_this       : '')
exe 'syntax keyword jsSuper     super  contained '.(exists('g:javascript_conceal_super')     ? 'conceal cchar='.g:javascript_conceal_super      : '')

" Statement Keywords
syntax keyword jsStatement    contained break continue with yield debugger
syntax keyword jsConditional            if else      skipwhite skipempty nextgroup=jsParenIfElse,jsBlock
syntax keyword jsConditional            switch       skipwhite skipempty nextgroup=jsParenSwitch
syntax keyword jsRepeat                 while for    skipwhite skipempty nextgroup=jsParenRepeat
syntax keyword jsRepeat                 do           skipwhite skipempty nextgroup=jsBlock
syntax keyword jsLabel        contained case default
syntax keyword jsTry                    try          skipwhite skipempty nextgroup=jsTryCatchBlock
syntax keyword jsFinally      contained finally      skipwhite skipempty nextgroup=jsBlock
syntax keyword jsCatch        contained catch        skipwhite skipempty nextgroup=jsParenCatch
syntax keyword jsException              throw
syntax keyword jsAsyncKeyword           async await

" Keywords
syntax keyword jsGlobalObjects  Array Boolean Date Function Iterator Number Object Symbol Map WeakMap Set RegExp String Proxy Promise Buffer ParallelArray ArrayBuffer DataView Float32Array Float64Array Int16Array Int32Array Int8Array Uint16Array Uint32Array Uint8Array Uint8ClampedArray JSON Math console document window Intl Collator DateTimeFormat NumberFormat
syntax keyword jsExceptions     Error EvalError InternalError RangeError ReferenceError StopIteration SyntaxError TypeError URIError
syntax keyword jsBuiltins       decodeURI decodeURIComponent encodeURI encodeURIComponent eval isFinite isNaN parseFloat parseInt uneval
" DISCUSS: How imporant is this, really? Perhaps it should be linked to an error because I assume the keywords are reserved?
syntax keyword jsFutureKeys     abstract enum int short boolean interface byte long char final native synchronized float package throws goto private transient implements protected volatile double public

" DISCUSS: Should we really be matching stuff like this?
" DOM2 Objects
syntax keyword jsGlobalObjects  DOMImplementation DocumentFragment Document Node NodeList NamedNodeMap CharacterData Attr Element Text Comment CDATASection DocumentType Notation Entity EntityReference ProcessingInstruction
syntax keyword jsExceptions     DOMException

" DISCUSS: Should we really be matching stuff like this?
" DOM2 CONSTANT
syntax keyword jsDomErrNo       INDEX_SIZE_ERR DOMSTRING_SIZE_ERR HIERARCHY_REQUEST_ERR WRONG_DOCUMENT_ERR INVALID_CHARACTER_ERR NO_DATA_ALLOWED_ERR NO_MODIFICATION_ALLOWED_ERR NOT_FOUND_ERR NOT_SUPPORTED_ERR INUSE_ATTRIBUTE_ERR INVALID_STATE_ERR SYNTAX_ERR INVALID_MODIFICATION_ERR NAMESPACE_ERR INVALID_ACCESS_ERR
syntax keyword jsDomNodeConsts  ELEMENT_NODE ATTRIBUTE_NODE TEXT_NODE CDATA_SECTION_NODE ENTITY_REFERENCE_NODE ENTITY_NODE PROCESSING_INSTRUCTION_NODE COMMENT_NODE DOCUMENT_NODE DOCUMENT_TYPE_NODE DOCUMENT_FRAGMENT_NODE NOTATION_NODE

" DISCUSS: Should we really be special matching on these props?
" HTML events and internal variables
syntax keyword jsHtmlEvents     onblur onclick oncontextmenu ondblclick onfocus onkeydown onkeypress onkeyup onmousedown onmousemove onmouseout onmouseover onmouseup onresize

"" Code blocks
syntax region  jsBracket                 matchgroup=jsBrackets          start="\[" end="\]" contains=@jsExpression extend fold
syntax region  jsParen                   matchgroup=jsParens            start=/(/  end=/)/  contains=@jsAll extend fold
syntax region  jsParenIfElse   contained matchgroup=jsParens            start=/(/  end=/)/  contains=@jsAll skipwhite skipempty nextgroup=jsBlock extend fold
syntax region  jsParenRepeat   contained matchgroup=jsParens            start=/(/  end=/)/  contains=@jsAll skipwhite skipempty nextgroup=jsBlock extend fold
syntax region  jsParenSwitch   contained matchgroup=jsParens            start=/(/  end=/)/  contains=@jsAll skipwhite skipempty nextgroup=jsSwitchBlock extend fold
syntax region  jsParenCatch    contained matchgroup=jsParens            start=/(/  end=/)/  skipwhite skipempty nextgroup=jsTryCatchBlock extend fold
syntax region  jsClassBlock    contained matchgroup=jsClassBraces       start=/{/  end=/}/  contains=jsClassFuncName,jsClassMethodDefinitions,jsOperator,jsArrowFunction,jsArrowFuncArgs,jsComment,jsGenerator,jsDecorator,jsClassProperty,jsClassPropertyComputed,jsClassStringKey,jsNoise extend fold
syntax region  jsFuncBlock     contained matchgroup=jsFuncBraces        start=/{/  end=/}/  contains=@jsAll extend fold
syntax region  jsBlock         contained matchgroup=jsBraces            start=/{/  end=/}/  contains=@jsAll extend fold
syntax region  jsTryCatchBlock contained matchgroup=jsBraces            start=/{/  end=/}/  contains=@jsAll skipwhite skipempty nextgroup=jsCatch,jsFinally extend fold
syntax region  jsSwitchBlock   contained matchgroup=jsBraces            start=/{/  end=/}/  contains=@jsAll,jsLabel extend fold
syntax region  jsObject                  matchgroup=jsObjectBraces      start=/{/  end=/}/  contains=jsObjectKey,jsObjectKeyString,jsObjectKeyComputed,jsObjectSeparator,jsObjectFuncName,jsObjectGetSet,jsGenerator,jsComment,jsSpreadOperator,jsObjectStringKey extend fold
syntax region  jsTernaryIf               matchgroup=jsTernaryIfOperator start=/?/  end=/\%(:\|[\}]\@=\)/  contains=@jsExpression

syntax match   jsGenerator            contained /\*/ skipwhite skipempty nextgroup=jsFuncName,jsFuncArgs
syntax match   jsFuncName             contained /\<[a-zA-Z_$][0-9a-zA-Z_$]*\>/ skipwhite skipempty nextgroup=jsFuncArgs
syntax match   jsFuncArgDestructuring contained /\({\|}\|=\|:\|\[\|\]\)/ extend
syntax region  jsFuncArgs             contained matchgroup=jsFuncParens start='(' end=')' contains=jsFuncArgCommas,jsFuncArgRest,jsComment,jsString,jsNumber,jsFuncArgDestructuring,jsArrowFunction,jsParen,jsArrowFuncArgs skipwhite skipempty nextgroup=jsFuncBlock extend
syntax match   jsFuncArgCommas        contained ','
syntax match   jsFuncArgRest          contained /\%(\.\.\.[a-zA-Z_$][0-9a-zA-Z_$]*\))/ contains=jsFuncArgRestDots
syntax match   jsFuncArgRestDots      contained /\.\.\./
syntax keyword jsArguments            contained arguments

" Matches a single keyword argument with no parens
syntax match   jsArrowFuncArgs  /\k\+\s*\%(=>\)\@=/ skipwhite contains=jsFuncArgs skipwhite skipempty nextgroup=jsArrowFunction extend
" Matches a series of arguments surrounded in parens
syntax match   jsArrowFuncArgs  /([^()]*)\s*\(=>\)\@=/ contains=jsFuncArgs skipempty skipwhite nextgroup=jsArrowFunction extend

exe 'syntax match jsFunction /\<function\>/ skipwhite skipempty nextgroup=jsGenerator,jsFuncName,jsFuncArgs skipwhite '.(exists('g:javascript_conceal_function')       ? 'conceal cchar='.g:javascript_conceal_function : '')
exe 'syntax match jsArrowFunction /=>/      skipwhite skipempty nextgroup=jsFuncBlock contains=jsFuncBraces           '.(exists('g:javascript_conceal_arrow_function') ? 'conceal cchar='.g:javascript_conceal_arrow_function : '')

syntax keyword jsClassKeywords          contained extends class
syntax match   jsClassNoise             contained /\./
syntax match   jsClassMethodDefinitions contained /\%(get\|set\|static\)\%( \k\+\)\@=/ skipwhite skipempty nextgroup=jsFuncName,jsClassProperty
syntax match   jsClassDefinition        /\<class\>\%( [a-zA-Z_$][0-9a-zA-Z_$ \n.]*\)*/ contains=jsClassKeywords,jsClassNoise skipwhite skipempty nextgroup=jsClassBlock
syntax match   jsDecorator              contained "@" nextgroup=jsDecoratorFunction
syntax match   jsDecoratorFunction      contained "[a-zA-Z_][a-zA-Z0-9_.]*"
syntax match   jsClassProperty          contained /\<[0-9a-zA-Z_$]*\>\(\s*=\)\@=/ skipwhite skipempty nextgroup=jsClassValue
syntax region  jsClassValue             contained start=/=/ end=/\%(;\|}\|\n\)\@=/ contains=@jsExpression
syntax region  jsClassPropertyComputed  contained matchgroup=jsBrackets start=/\[/ end=/]/ contains=@jsExpression skipwhite skipempty nextgroup=jsFuncArgs,jsClassValue extend
syntax match   jsClassFuncName          contained /\<[a-zA-Z_$][0-9a-zA-Z_$]*\>\%(\s*(\)\@=/ skipwhite skipempty nextgroup=jsFuncArgs
syntax region  jsClassStringKey         contained start=+"+  skip=+\\\("\|$\)+  end=+"\|$+  contains=jsSpecial,@Spell extend skipwhite skipempty nextgroup=jsFuncArgs
syntax region  jsClassStringKey         contained start=+'+  skip=+\\\('\|$\)+  end=+'\|$+  contains=jsSpecial,@Spell extend skipwhite skipempty nextgroup=jsFuncArgs

" Comments
syntax keyword jsCommentTodo    contained TODO FIXME XXX TBD
syntax region  jsComment        start=+\/\/+ end=+$+ contains=jsCommentTodo,@Spell extend keepend
syntax region  jsComment        start=+^\s*\/\/+ skip=+\n\s*\/\/+ end=+$+ contains=jsCommentTodo,@Spell fold extend keepend
syntax region  jsComment        start="/\*"  end="\*/" contains=jsCommentTodo,jsCvsTag,@Spell fold extend keepend
syntax region  jsEnvComment     start="\%^#!" end="$" display
syntax region  jsCvsTag         contained start="\$\cid:" end="\$" oneline

"" JSDoc / JSDoc Toolkit
if !exists("javascript_ignore_javaScriptdoc")
  "" syntax coloring for javadoc comments (HTML)
  syntax region jsComment    matchgroup=jsComment start="/\*\s*"  end="\*/" contains=jsDocTags,jsCommentTodo,jsCvsTag,@jsHtml,@Spell fold

  " tags containing a param
  syntax match  jsDocTags         contained "@\(alias\|api\|augments\|borrows\|class\|constructs\|default\|defaultvalue\|emits\|exception\|exports\|extends\|fires\|kind\|link\|listens\|member\|member[oO]f\|mixes\|module\|name\|namespace\|requires\|template\|throws\|var\|variation\|version\)\>" skipwhite nextgroup=jsDocParam
  " tags containing type and param
  syntax match  jsDocTags         contained "@\(arg\|argument\|cfg\|param\|property\|prop\)\>" skipwhite nextgroup=jsDocType
  " tags containing type but no param
  syntax match  jsDocTags         contained "@\(callback\|define\|enum\|external\|implements\|this\|type\|typedef\|return\|returns\)\>" skipwhite nextgroup=jsDocTypeNoParam
  " tags containing references
  syntax match  jsDocTags         contained "@\(lends\|see\|tutorial\)\>" skipwhite nextgroup=jsDocSeeTag
  " other tags (no extra syntax)
  syntax match  jsDocTags         contained "@\(abstract\|access\|accessor\|author\|classdesc\|constant\|const\|constructor\|copyright\|deprecated\|desc\|description\|dict\|event\|example\|file\|file[oO]verview\|final\|function\|global\|ignore\|inheritDoc\|inner\|instance\|interface\|license\|localdoc\|method\|mixin\|nosideeffects\|override\|overview\|preserve\|private\|protected\|public\|readonly\|since\|static\|struct\|todo\|summary\|undocumented\|virtual\)\>"

  syntax region jsDocType         contained matchgroup=jsDocTypeBrackets start="{" end="}" contains=jsDocTypeRecord oneline skipwhite nextgroup=jsDocParam
  syntax match  jsDocType         contained "\%(#\|\"\|\w\|\.\|:\|\/\)\+" skipwhite nextgroup=jsDocParam
  syntax region jsDocTypeRecord   contained start=/{/ end=/}/ contains=jsDocTypeRecord extend
  syntax region jsDocTypeRecord   contained start=/\[/ end=/\]/ contains=jsDocTypeRecord extend
  syntax region jsDocTypeNoParam  contained start="{" end="}" oneline
  syntax match  jsDocTypeNoParam  contained "\%(#\|\"\|\w\|\.\|:\|\/\)\+"
  syntax match  jsDocParam        contained "\%(#\|\$\|-\|'\|\"\|{.\{-}}\|\w\|\.\|:\|\/\|\[.{-}]\|=\)\+"
  syntax region jsDocSeeTag       contained matchgroup=jsDocSeeTag start="{" end="}" contains=jsDocTags
endif   "" JSDoc end

syntax cluster jsExpression  contains=jsBracket,jsParen,jsObject,jsBlock,jsTernaryIf,jsTaggedTemplate,jsTemplateString,jsString,jsRegexpString,jsNumber,jsFloat,jsOperator,jsBooleanTrue,jsBooleanFalse,jsNull,jsFunction,jsArrowFunction,jsGlobalObjects,jsExceptions,jsFutureKeys,jsDomErrNo,jsDomNodeConsts,jsHtmlEvents,jsFuncCall,jsUndefined,jsNan,jsPrototype,jsBuiltins,jsNoise,jsClassDefinition,jsArrowFunction,jsArrowFuncArgs,jsParensError,jsComment,jsArguments,jsThis,jsSuper,jsSpreadOperator
syntax cluster jsAll         contains=@jsExpression,jsExportContainer,jsImportContainer,jsStorageClass,jsConditional,jsRepeat,jsReturn,jsStatement,jsException,jsTry,jsAsyncKeyword

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_javascript_syn_inits")
  if version < 508
    let did_javascript_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink jsFuncArgRest          Special
  HiLink jsComment              Comment
  HiLink jsEnvComment           PreProc
  HiLink jsCommentTodo          Todo
  HiLink jsCvsTag               Function
  HiLink jsDocTags              Special
  HiLink jsDocSeeTag            Function
  HiLink jsDocType              Type
  HiLink jsDocTypeBrackets      jsDocType
  HiLink jsDocTypeRecord        jsDocType
  HiLink jsDocTypeNoParam       Type
  HiLink jsDocParam             Label
  HiLink jsString               String
  HiLink jsObjectKeyString      String
  HiLink jsTemplateString       String
  HiLink jsObjectStringKey      String
  HiLink jsClassStringKey       String
  HiLink jsTaggedTemplate       StorageClass
  HiLink jsTernaryIfOperator    Operator
  HiLink jsRegexpString         String
  HiLink jsRegexpBoundary       SpecialChar
  HiLink jsRegexpQuantifier     SpecialChar
  HiLink jsRegexpOr             Conditional
  HiLink jsRegexpMod            SpecialChar
  HiLink jsRegexpBackRef        SpecialChar
  HiLink jsRegexpGroup          jsRegexpString
  HiLink jsRegexpCharClass      Character
  HiLink jsCharacter            Character
  HiLink jsPrototype            Special
  HiLink jsConditional          Conditional
  HiLink jsBranch               Conditional
  HiLink jsLabel                Label
  HiLink jsReturn               Statement
  HiLink jsRepeat               Repeat
  HiLink jsStatement            Statement
  HiLink jsException            Exception
  HiLink jsTry                  Exception
  HiLink jsFinally              Exception
  HiLink jsCatch                Exception
  HiLink jsAsyncKeyword         Keyword
  HiLink jsArrowFunction        Type
  HiLink jsFunction             Type
  HiLink jsGenerator            jsFunction
  HiLink jsArrowFuncArgs        jsFuncArgs
  HiLink jsFuncName             Function
  HiLink jsClassFuncName        jsFuncName
  HiLink jsObjectFuncName       Function
  HiLink jsArguments            Special
  HiLink jsError                Error
  HiLink jsParensError          Error
  HiLink jsOperator             Operator
  HiLink jsOf                   Operator
  HiLink jsStorageClass         StorageClass
  HiLink jsClassKeywords        Structure
  HiLink jsThis                 Special
  HiLink jsSuper                Special
  HiLink jsNan                  Number
  HiLink jsNull                 Type
  HiLink jsUndefined            Type
  HiLink jsNumber               Number
  HiLink jsFloat                Float
  HiLink jsBooleanTrue          Boolean
  HiLink jsBooleanFalse         Boolean
  HiLink jsNoise                Noise
  HiLink jsBrackets             Noise
  HiLink jsParens               Noise
  HiLink jsBraces               Noise
  HiLink jsFuncBraces           Noise
  HiLink jsFuncParens           Noise
  HiLink jsClassBraces          Noise
  HiLink jsClassNoise           Noise
  HiLink jsObjectBraces         Noise
  HiLink jsObjectSeparator      Noise
  HiLink jsSpecial              Special
  HiLink jsTemplateVar          Special
  HiLink jsTemplateBraces       jsBraces
  HiLink jsGlobalObjects        Special
  HiLink jsExceptions           Special
  HiLink jsBuiltins             Special
  HiLink jsModuleKeywords       Include
  HiLink jsModuleOperators      Include
  HiLink jsModuleDefault        Include
  HiLink jsDecorator            Special
  HiLink jsDecoratorFunction    Special
  HiLink jsFuncArgRestDots      Noise
  HiLink jsFuncArgDestructuring Noise
  HiLink jsModuleAsterisk       Noise
  HiLink jsClassProperty        jsObjectKey
  HiLink jsSpreadOperator       Operator

  HiLink jsDomErrNo             Constant
  HiLink jsDomNodeConsts        Constant
  HiLink jsDomElemAttrs         Label
  HiLink jsDomElemFuncs         PreProc

  HiLink jsHtmlEvents           Special
  HiLink jsHtmlElemAttrs        Label
  HiLink jsHtmlElemFuncs        PreProc

  HiLink jsCssStyles            Label

  HiLink jsClassMethodDefinitions Type
  HiLink jsObjectGetSet           Type

  delcommand HiLink
endif

" Define the htmlJavaScript for HTML syntax html.vim
syntax cluster  htmlJavaScript       contains=@jsAll
syntax cluster  javaScriptExpression contains=@jsAll

" Vim's default html.vim highlights all javascript as 'Special'
hi! def link javaScript              NONE

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
  unlet main_syntax
endif

endif
