if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ocaml') == -1

if exists("b:current_syntax")
  finish
endif

syn keyword ocamlbuild_tagsOperator ",\|:\|-\|(\|)"
syn keyword ocamlbuild_tagsTodo FIXME NOTE NOTES TODO XXX contained

syn keyword ocamlbuild_tagsKeyword1 true annot bin_annot traverse not_hygienic custom package include debug principal strict_sequence strict_formats short_paths or no_alias_deps safe_string warn syntax thread
syn match ocamlbuild_tagsKeyword2 "for-pack"

syn match ocamlbuild_tagsOr "or" contained

syn region ocamlbuild_tagsString start=/"/ end=/"/
syn region ocamlbuild_tagsPattern start=/</ end=/>/ contains=ocamlbuild_tagsGlob,ocamlbuild_tagsAlt,ocamlbuild_tagsOr

syn match ocamlbuild_tagsComment "#.*$" contains=ocamlbuild_tagsTodo,@Spell

syn match ocamlbuild_tagsGlob "\*\|\*\*\|\/" contained

syn match ocamlbuild_tagsComma ","
syn region ocamlbuild_tagsAlt start=/{/ end=/}/ contains=ocamlbuild_tagsComma contained

syn match ocamlbuild_tagsFindlibPkg "\vpkg_[a-zA-Z_.]+"

hi! link ocamlbuild_tagsKeyword1 Keyword
hi! link ocamlbuild_tagsKeyword2 Keyword
hi! link ocamlbuild_tagsOr Keyword

hi! link ocamlbuild_tagsString String
hi! link ocamlbuild_tagsPattern Statement

hi! link ocamlbuild_tagsGlob Operator
hi! link ocamlbuild_tagsOperator Operator
hi! link ocamlbuild_tagsComma Operator

hi! link ocamlbuild_tagsComment Comment

hi link ocamlbuild_tagsFindlibPkg Identifier

let b:current_syntax = "ocamlbuild_tags"

endif
