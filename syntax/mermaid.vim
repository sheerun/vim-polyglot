if polyglot#init#is_disabled(expand('<sfile>:p'), 'mermaid', 'syntax/mermaid.vim')
  finish
endif

setlocal iskeyword+=-

syntax keyword mermaidDiagramType classDiagram classDiagram-v2 erDiagram gantt graph flowchart pie sequenceDiagram stateDiagram stateDiagram-v2 gitGraph
syntax match mermaidOperator /\v(-|\<|\>|\+|\||\=)/
syntax match mermaidComment /\v^(\s?)+\%\%.*$/
syntax region mermaidString start=/"/ end=/"/ skip=/\\"/
" is used in both class and state diagrams
syntax match mermaidSpecialAnnotation /\v\<\<\w+\>\>/
syntax match mermaidKeyword /\v^\s+(subgraph|loop|alt|else|opt|par[^a-z]|and|rect|end|participant|activate|deactivate)/

syntax match mermaidGraphOperator /\v(\.-|-\.|\&|o-|-o|x-|-x)/
syntax keyword mermaidGraphClickKeyword click

syntax match mermaidNote /\v^\s+(note[^s]|Note[^s]|end note)/ nextgroup=mermaidNoteDirection
syntax match mermaidNoteDirection /\v(left of|right of|over[^a-z])/

syntax keyword mermaidSequenceFunction rgb

" TODO: support class dashed link operator: `..`
syntax match mermaidClassOperator /\v(\*-|-\*|\<\.\.|\.\.\>|\|\.\.|\.\.\|)/
syntax keyword mermaidClassClassKeyword class
syntax keyword mermaidClassType
			\ int[eger] bool[ean] string float bigdec[imal] char[cter] double symbol
syntax match mermaidClassGenericType /\v\w+\~\w+\~/
			\ contains=ALLBUT,mermaidClassGenericType
" TODO Fix matching on graph/flowchart round shape: `SecondStep(Go Shopping)`
syntax match mermaidClassFunction /\v\w+\(((\w+|\s+|\~)?,?)+\)/ contains=ALLBUT,mermaidClassFunction
" TODO support class visibility operators
" https://mermaid-js.github.io/mermaid/#/classDiagram?id=visibility

syntax match mermaidStateFinalKeyword /\[\*\]/
syntax match mermaidStateKeyword /\v(\s+as[^a-z]|^\s+state)/

syntax match mermaidGitOption /\v^(options|end)/
syntax match mermaidGitCommands /\v^(commit|branch|merge|reset|checkout)/

" TODO highlight gantt keywords

" TODO improve er operators
syntax match mermaidErOperator /\v(\}\||\|\{|o\{)/

highlight link mermaidDiagramType Constant
highlight link mermaidOperator Operator
highlight link mermaidComment Comment
highlight link mermaidString String
highlight link mermaidSpecialAnnotation Label
highlight link mermaidNote Keyword
highlight link mermaidNoteDirection Keyword

highlight link mermaidGraphOperator Operator
highlight link mermaidGraphClickKeyword Keyword

highlight link mermaidKeyword Keyword
highlight link mermaidSequenceFunction Function

highlight link mermaidClassClassKeyword Keyword
highlight link mermaidClassOperator Operator
highlight link mermaidClassType Type
highlight link mermaidClassGenericType Type

highlight link mermaidStateFinalKeyword Keyword
highlight link mermaidStateKeyword Keyword

highlight link mermaidErOperator Operator

highlight link mermaidGitOption Keyword
highlight link mermaidGitCommands Keyword
