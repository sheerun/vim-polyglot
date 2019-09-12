if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ocaml') == -1

if exists("b:current_syntax")
    finish
endif

syn keyword oasisSpecialFeatures ocamlbuild_more_args compiled_setup_ml pure_interface stdfiles_markdown
syn keyword oasisTodo FIXME NOTE NOTES TODO XXX contained
syn match oasisComment "#.*$" contains=oasisTodo,@Spell
syn keyword oasisPlugin META DevFiles StdFiles

syn match oasisOperator "(\|)\|>=\|,\|&&"
syn match oasisVariable "$\w\+"
syn match oasisVersion "\<\d\+\(.\(\d\)\+\)\+\>"
syn region oasisString start=/"/ end=/"/

syntax keyword oasisSection Document Executable Flag Library Document Test SourceRepository

syntax match oasisKey "OASISFormat:"
syntax match oasisKey "OCamlVersion:"
syntax match oasisKey "Copyrights:"
syntax match oasisKey "Maintainers:"
syntax match oasisKey "XStdFilesAUTHORS:"
syntax match oasisKey "XStdFilesREADME:"
syntax match oasisKey "FindlibVersion:"
syntax match oasisKey "Name:"
syntax match oasisKey "Version:"
syntax match oasisKey "Synopsis:"
syntax match oasisKey "Authors:"
syntax match oasisKey "Homepage:"
syntax match oasisKey "License:"
syntax match oasisKey "LicenseFile:"
syntax match oasisKey "BuildTools:"
syntax match oasisKey "Plugins:"
syntax match oasisKey "Description:"
syntax match oasisKey "AlphaFeatures:"
syntax match oasisKey "BetaFeatures:"
syntax match oasisKey "PostConfCommand:"
syntax match oasisKey "FilesAB:"

syntax match oasisKey2 "\c\s\+Index\$\=:"
syntax match oasisKey2 "\c\s\+Format\$\=:"
syntax match oasisKey2 "\c\s\+TestTools\$\=:"
syntax match oasisKey2 "\c\s\+Description\$\=:"
syntax match oasisKey2 "\c\s\+Pack\$\=:"
syntax match oasisKey2 "\c\s\+Default\$\=:"
syntax match oasisKey2 "\c\s\+Path\$\=:"
syntax match oasisKey2 "\c\s\+Findlibname\$\=:"
syntax match oasisKey2 "\c\s\+Modules\$\=:"
syntax match oasisKey2 "\c\s\+BuildDepends\$\=:"
syntax match oasisKey2 "\c\s\+MainIs\$\=:"
syntax match oasisKey2 "\c\s\+Install\$\=:"
syntax match oasisKey2 "\c\s\+Custom\$\=:"
syntax match oasisKey2 "\c\s\+InternalModules\$\=:"
syntax match oasisKey2 "\c\s\+Build\$\=:"
syntax match oasisKey2 "\c\s\+CompiledObject\$\=:"
syntax match oasisKey2 "\c\s\+Title\$\=:"
syntax match oasisKey2 "\c\s\+Type\$\=:"
syntax match oasisKey2 "\c\s\+FindlibParent\$\=:"
syntax match oasisKey2 "\c\s\+Command\$\=:"
syntax match oasisKey2 "\c\s\+Run\$\=:"
syntax match oasisKey2 "\c\s\+WorkingDirectory\$\=:"
syntax match oasisKey2 "\c\s\+BuildTools+:"
syntax match oasisKey2 "\c\s\+XMETARequires\$\=:"
syntax match oasisKey2 "\c\s\+XMETADescription\$\=:"
syntax match oasisKey2 "\c\s\+XMETAType\$\=:"
syntax match oasisKey2 "\c\s\+XMETAExtraLines\$\=:"
syntax match oasisKey2 "\c\s\+XMETAEnable\$\=:"
syntax match oasisKey2 "\c\s\+InstallDir\$\=:"
syntax match oasisKey2 "\c\s\+XOCamlbuildLibraries\$\=:"
syntax match oasisKey2 "\c\s\+XOCamlbuildPath\$\=:"
syntax match oasisKey2 "\c\s\+XOCamlbuildExtraArgs\$\=:"
syntax match oasisKey2 "\c\s\+XOCamlbuildModules\$\=:"
syntax match oasisKey2 "\c\s\+Type\$\=:"
syntax match oasisKey2 "\c\s\+Location\$\=:"
syntax match oasisKey2 "\c\s\+Branch\$\=:"
syntax match oasisKey2 "\c\s\+Browser\$\=:"
syntax match oasisKey2 "\c\s\+CSources\$\=:"
syntax match oasisKey2 "\c\s\+CCLib\$\=:"
syntax match oasisKey2 "\c\s\+CCOpt\$\=:"
syntax match oasisKey2 "\c\s\+ByteOpt\$\=:"
syntax match oasisKey2 "\c\s\+NativeOpt\$\=:"
syntax match oasisKey2 "\c\s\+Tag\$\=:"

highlight link oasisSection Keyword
highlight link oasisKey Identifier
highlight link oasisKey2 Function
highlight link oasisTodo Todo
highlight link oasisComment Comment
highlight link oasisPlugin Type
highlight link oasisSpecialFeatures Exception 
highlight link oasisOperator Operator
highlight link oasisVariable Statement
highlight link oasisString String
highlight link oasisVersion Number

let b:current_syntax = "oasis"

endif
