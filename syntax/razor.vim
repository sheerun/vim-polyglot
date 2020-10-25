if has_key(g:polyglot_is_disabled, 'razor')
  finish
endif

if exists("b:current_syntax")
  finish
endif

runtime! syntax/html.vim

"razor
syn cluster rBlocks add=rCodeBlock,rCodeLine,rComment,rInherits,rUsing
syn match rCodeLine "@[a-zA-Z0-9_\.()]*" containedin=ALLBUT,@rBlocks
syn region rCodeBlock start="@{" end="}" contains=@rcsAll containedin=ALLBUT,@rBlocks keepend
syn region rComment start="@\*" end="\*@" contains=rcsComment containedin=ALLBUT,@rBlocks keepend

"not recursive for namespaces with generic types
syn region rInherits start="^@inherits" end="$" containedin=ALLBUT,@rBlocks
syn match rNamespacedGenericType "\s\+\w\+\(\.\w\+\)*\(<\w\+\(\.\w\+\)*>\)\?" containedin=rInherits contained

syn region rUsing start="^@using " end="$" containedin=ALLBUT,@rBlocks
syn match rNamespace "\s\+\w\+\(\.\w\+\)*" containedin=rUsing contained

syn match rCodeInCodeBlock "[a-zA-Z]\+" containedin=rCodeBlock contained


"cs
syn keyword rcsType	contained bool byte char decimal double float int
syn keyword rcsType contained long object sbyte short string uint ulong
syn keyword rcsType contained ushort void var
syn keyword rcsRepeat contained break continue do for foreach goto return
syn keyword rcsRepeat contained while yield
syn keyword rcsConditional contained if else switch
syn keyword rcsLabel contained case default
syn region rcsComment start="/\*" end="\*/" contained
syn match rcsComment "//.*$" contained
syn cluster rcsAll add=rcsType,rcsRepeat,rcsConditional,rcsLabel,rcsComment

"Highlighting
"cs
hi def link rcsType Type
hi def link rcsRepeat Repeat
hi def link rcsConditional Conditional
hi def link rcsLabel Label
hi def link rcsComment Comment

"razor
hi def link rCodeLine Special
hi def link rComment Comment
hi def link rInherits Preproc
hi def link rNamespacedGenericType Type
hi def link rUsing Preproc
hi def link rNamespace Type

let b:current_syntax = "razor"
