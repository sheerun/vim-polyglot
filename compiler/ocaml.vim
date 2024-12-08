if polyglot#init#is_disabled(expand('<sfile>:p'), 'ocaml', 'compiler/ocaml.vim')
  finish
endif

" Vim Compiler File
" Compiler:    ocaml
" Maintainer:  Markus Mottl <markus.mottl@gmail.com>
" URL:         https://github.com/ocaml/vim-ocaml
" Last Change:
"              2023 Nov 24 - Improved error format (Samuel Hym)
"              2021 Nov 03 - Improved error format (Jules Aguillon)
"              2020 Mar 28 - Improved error format (Thomas Leonard)
"              2017 Nov 26 - Improved error format (Markus Mottl)
"              2013 Aug 27 - Added a new OCaml error format (Markus Mottl)
"
" Marc Weber's comments:
" Setting makeprg doesn't make sense, because there is ocamlc, ocamlopt,
" ocamake and whatnot. So which one to use?

if exists("current_compiler")
    finish
endif
let current_compiler = "ocaml"

let s:cpo_save = &cpo
set cpo&vim

" Patch 8.2.4329 introduces %e and %k as end line and end column positions

if has('patch-8.2.4329')
  CompilerSet errorformat =
        \%EFile\ \"%f\"\\,\ lines\ %l-%e\\,\ characters\ %c-%k:,
        \%EFile\ \"%f\"\\,\ line\ %l\\,\ characters\ %c-%k:,
        \%EFile\ \"%f\"\\,\ line\ %l\\,\ characters\ %c-%k\ %.%#,
else
  CompilerSet errorformat =
        \%EFile\ \"%f\"\\,\ lines\ %l-%*\\d\\,\ characters\ %c-%*\\d:,
        \%EFile\ \"%f\"\\,\ line\ %l\\,\ characters\ %c-%*\\d:,
        \%EFile\ \"%f\"\\,\ line\ %l\\,\ characters\ %c-%*\\d\ %.%#,
endif

CompilerSet errorformat +=
      \%EFile\ \"%f\"\\,\ line\ %l\\,\ character\ %c:%m,
      \%EFile\ \"%f\"\\,\ line\ %l:,
      \%+EReference\ to\ unbound\ regexp\ name\ %m,
      \%Eocamlyacc:\ e\ -\ line\ %l\ of\ \"%f\"\\,\ %m,
      \%Wocamlyacc:\ w\ -\ %m,
      \%-Zmake%.%#

if get(g:, "ocaml_compiler_compact_messages", v:true)
  CompilerSet errorformat +=
        \%C%*\\d\ \|%.%#,
        \%C%p^%#,
        \%C%m
endif

CompilerSet errorformat +=
      \%Z,
      \%D%*\\a[%*\\d]:\ Entering\ directory\ `%f',
      \%X%*\\a[%*\\d]:\ Leaving\ directory\ `%f',
      \%D%*\\a:\ Entering\ directory\ `%f',
      \%X%*\\a:\ Leaving\ directory\ `%f',
      \%D%*\\a[%*\\d]:\ Entering\ directory\ '%f',
      \%X%*\\a[%*\\d]:\ Leaving\ directory\ '%f',
      \%D%*\\a:\ Entering\ directory\ '%f',
      \%X%*\\a:\ Leaving\ directory\ '%f',
      \%DEntering\ directory\ '%f',
      \%XLeaving\ directory\ '%f',
      \%DMaking\ %*\\a\ in\ %f

if get(g:, "ocaml_compiler_compact_messages", v:true)
  CompilerSet errorformat +=
        \%+G%m
endif


let &cpo = s:cpo_save
unlet s:cpo_save
