if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dlang') == -1

if &filetype == "ddoc"
    "ddoc file type
    " Quit when a syntax file was already loaded
    if exists("b:current_syntax")
      finish
    endif

    " Support cpoptions
    let s:cpo_save = &cpo
    set cpo&vim

    " Set the current syntax to be known as ddoc
    let b:current_syntax = "ddoc"

    syn match ddocIdentifier     "\$(\zs\a\w*\ze\_W*"    display conceal contained
    syn match ddocIdentifierDecl "^\s*\zs\a\w*\ze\s*=" display contained
    syn region ddocDecl start="^\s*\a\w*\s*=" end="\(\n\_^\s*\_$\|\n^\s*\a\w*\s*=\)" transparent fold contains=ddocIdentifierDecl,ddocIdentifier

    "use html comment when fold method is marker
    set commentstring=<!--%s-->

    hi! def link ddocIdentifier       Macro
    hi! def link ddocIdentifierDecl   Macro

    let &cpo = s:cpo_save
    unlet s:cpo_save

elseif &filetype == "dd" || &filetype == "d" && getline(1) =~ "^Ddoc"
    "Ddoc source file or .d File begining with Ddoc
    " Quit when a syntax file was already loaded
    if exists("b:current_syntax")
      finish
    endif

    " Support cpoptions
    let s:cpo_save = &cpo
    set cpo&vim
    " Set the current syntax to be known as ddoc
    let b:current_syntax = "ddoc"

    syn match ddocKeyword        "\%^Ddoc"               display
    syn keyword ddocKeyword      MACROS                  contained
    syn match ddocIdentifier     "\$(\zs\a\w*\ze\_W*"    display conceal
    syn match ddocIdentifierDecl "^\s*\zs\a\w*\ze\s*="   display contained
    "can slow down to much
    "syn match ddocIdentifierDecl "\(^\s*MACROS:\s\+\)\@<=\zs\a\w*\ze\s*=" display contained
    syn region ddocDecl    start="^\s*MACROS:\_s\+" end="\%$" transparent fold contains=ddocKeyword,ddocIdentifierDecl,ddocIdentifier

    "use html comment when fold method is marker
    set commentstring=<!--%s-->

    " highlight only ddoc Identifiers
    hi! def link ddocIdentifier       Macro
    hi! def link ddocIdentifierDecl   Macro
    hi! def link ddocKeyword          Macro
    let &cpo = s:cpo_save
    unlet s:cpo_save
    finish
elseif &filetype == "d"
    "Ddoc inside comments
    syn keyword ddocKeyword            MACROS                      contained
    syn match ddocIdentifier           "\$(\zs\a\w*\ze\_W*"        display contained conceal containedin=@ddocComment

    syn match ddocIdentifierBlockDecl  "^\*\=\s*\a\w*\ze\s*=" display contained
    "can slow down to much
    "syn match ddocIdentifierBlockDecl "\(^*\=\s*MACROS:\s\+\)\@<=\zs\a\w*\ze\s*="     display contained

    syn region ddocBlockDecl start="^\*\=\s*\zsMACROS:\_s\+" end="\ze\*/" transparent fold contained containedin=ddocBlockComment  contains=ddocKeyword,ddocIdentifierBlockDecl,ddocIdentifier

    syn match ddocIdentifierNestedDecl "^+\=\s*\a\w*\ze\s*="  display contained
    "can slow down to much
    "syn match ddocIdentifierNestedDecl "\(^+\=\s*MACROS:\s\+\)\@<=\zs\a\w*\ze\s*="     display contained

    syn region ddocNestedDecl start="^+\=\s*\zsMACROS:\_s\+" end="\ze+/"  transparent fold contained containedin=ddocNestedComment contains=ddocKeyword,ddocIdentifierNestedDecl,ddocIdentifier

    "reset to default commentstring
    set commentstring=/*%s*/
    hi! def link ddocIdentifier            Macro
    hi! def link ddocIdentifierBlockDecl   Macro
    hi! def link ddocIdentifierNestedDecl  Macro
    hi! def link ddocKeyword               Macro
endif

endif
