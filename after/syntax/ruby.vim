if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'yard') == -1

" Ruby syntax extensions for highlighting YARD documentation.
"
" Author: Joel Holdbrooks <https://github.com/noprompt>
" URI: https://github.com/noprompt/vim-yardoc
" Version: 0.0.1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syn match yardGenericTag "@\h\+" contained
syn match yardAbstract "@abstract" contained
syn match yardApi "@api" contained
syn match yardAttr "@attr" contained
syn match yardAttrReader "@attr_reader" contained
syn match yardAttrWriter "@attr_writer" contained
syn match yardAuthor "@author" contained
syn match yardDeprecated "@deprecated" contained
syn match yardExample "@example" contained
syn match yardNote "@note" contained
syn match yardOption "@option" contained
syn match yardOverload "@overload" contained
syn match yardParam "@param" contained
syn match yardPrivate "@private" contained
syn match yardRaise "@raise" contained
syn match yardReturn "@return" contained
syn match yardSee "@see" contained
syn match yardSince "@since" contained
syn match yardTodo "@todo" contained
syn match yardVersion "@version" contained
syn match yardYield "@yield" contained
syn match yardYieldParam "@yieldparam" contained
syn match yardYieldReturn "@yieldreturn" contained
syn cluster yardTags contains=yardGenericTag,yardAbstract,yardApi,yardAttr,yardAttrReader,yardAttrWriter,yardAuthor,yardDeprecated,yardExample,yardNote,yardOption,yardOverload,yardParam,yardPrivate,yardRaise,yardReturn,yardSee,yardSince,yardTodo,yardVersion,yardYield,yardYieldParam,yardYieldReturn

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Directives
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syn match yardGenericDirective "@!\h\+" contained
syn match yardAttribute "@!attribute" contained
syn match yardEndGroup "@!endgroup" contained
syn match yardGroup "@!group" contained
syn match yardMacro "@!macro" contained
syn match yardMethod "@!method" contained
syn match yardParse "@!parse" contained
syn match yardScope "@!scope" contained
syn match yardVisibility "@!visibility" contained

syn cluster yardDirectives contains=yardGenericDirective,yardAttribute,yardEndGroup,yardGroup,yardMacro,yardMethod,yardParse,yardScope,yardVisibility

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Types, Lists, and Hashes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syn match yardDuckType "#\h\+" contained
syn match yardType "[A-Z]\h\+" contained
syn match yardLiteral "\(true\|false\|nil\|self\|void\)" contained
syn match yardComma "," nextgroup=@yardTypes contained
syn match yardArrow "=>" nextgroup=@yardTypes contained

syn region yardParametricType start="[A-Z]\+\h\+<" end=">" contains=yardType,yardOrderDependentList,yardComma skipwhite contained
syn region yardOrderDependentList start="(" end=")" contains=@yardTypes,yardComma skipwhite contained
syn region yardTypeList start="\[" end="]" contains=@yardTypes,yardOrderDependentList,@yardHashes skipwhite contained
syn region yardHashAngle start="Hash<" end=">" contains=yardDuckType,yardType,yardLiteral,yardArrow,yardComma skipwhite contained
syn region yardHashCurly start="Hash{" end="}" contains=@yardTypes,yardArrow,yardComma skipwhite contained

syn cluster yardTypes contains=yardDuckType,yardType,yardLiteral,yardParametricType
syn cluster yardHashes contains=yardArrow,yardHashAngle,yardHashCurly
syn cluster yardLists contains=yardComma,yardTypeList,yardOrderDependentList

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Yard
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syn match yardComment "#\s*@!\{,1}\h\+.*" contains=@yardTags,@yardDirectives,yardTypeList
syn match rubyComment "#.*" contains=rubySharpBang,rubySpaceError,rubyTodo,@Spell,yardComment
syn region rubyMultilineComment start="\%(\%(^\s*#.*\n\)\@<!\%(^\s*#.*\n\)\)\%(\(^\s*#.*\n\)\{1,}\)\@=" end="\%(^\s*#.*\n\)\@<=\%(^\s*#.*\n\)\%(^\s*#\)\@!" contains=rubyComment transparent fold keepend
syn cluster rubyNotTop add=@yardTags,@yardDirectives,@yardTypes,@yardLists,@yardHashes

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Links
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi def link yardComment rubyComment
" Tags
hi def link yardGenericTag rubyKeyword
hi def link yardAbstract yardGenericTag
hi def link yardApi yardGenericTag
hi def link yardAttr yardGenericTag
hi def link yardAttrReader yardGenericTag
hi def link yardAttrWriter yardGenericTag
hi def link yardAuthor yardGenericTag
hi def link yardDeprecated yardGenericTag
hi def link yardExample yardGenericTag
hi def link yardNote yardGenericTag
hi def link yardOption yardGenericTag
hi def link yardOverload yardGenericTag
hi def link yardParam yardGenericTag
hi def link yardPrivate yardGenericTag
hi def link yardRaise yardGenericTag
hi def link yardReturn yardGenericTag
hi def link yardSee yardGenericTag
hi def link yardSince yardGenericTag
hi def link yardTodo yardGenericTag
hi def link yardVersion yardGenericTag
hi def link yield yardGenericTag
hi def link yieldparam yardGenericTag
hi def link yieldreturn yardGenericTag
" Directives
hi def link yardGenericDirective rubyKeyword
hi def link yardAttribute yardGenericDirective
hi def link yardEndGroup yardGenericDirective
hi def link yardGroup yardGenericDirective
hi def link yardMacro yardGenericDirective
hi def link yardMethod yardGenericDirective
hi def link yardParse yardGenericDirective
hi def link yardScope yardGenericDirective
hi def link yardVisibility yardGenericDirective
" Types
hi def link yardComma yardComment
hi def link yardType yardComment
hi def link yardDuckType yardComment
hi def link yardLiteral yardComment
" Lists
hi def link yardTypeList yardComment
hi def link yardParametricType yardComment
" Hashes
hi def link yardArrow yardComment
hi def link yardHashAngle yardComment
hi def link yardHashCurly yardComment

endif
