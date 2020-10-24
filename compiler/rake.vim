let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'compiler/rake.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ruby') == -1

" Vim compiler file
" Language:		Rake
" Maintainer:		Tim Pope <vimNOSPAM@tpope.org>
" URL:			https://github.com/vim-ruby/vim-ruby
" Release Coordinator:	Doug Kearns <dougkearns@gmail.com>

if exists("current_compiler")
  finish
endif
let current_compiler = "rake"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=rake

CompilerSet errorformat=
      \%D(in\ %f),
      \%\\s%#%\\d%#:%#\ %#from\ %f:%l:%m,
      \%\\s%#%\\d%#:%#\ %#from\ %f:%l:,
      \%\\s%##\ %f:%l:%m%\\&%.%#%\\D:%\\d%\\+:%.%#,
      \%\\s%##\ %f:%l%\\&%.%#%\\D:%\\d%\\+,
      \%\\s%#[%f:%l:\ %#%m%\\&%.%#%\\D:%\\d%\\+:%.%#,
      \%\\s%#%f:%l:\ %#%m%\\&%.%#%\\D:%\\d%\\+:%.%#,
      \%\\s%#%f:%l:,
      \%m\ [%f:%l]:,
      \%+Erake\ aborted!,
      \%+EDon't\ know\ how\ to\ build\ task\ %.%#,
      \%+Einvalid\ option:%.%#,
      \%+Irake\ %\\S%\\+%\\s%\\+#\ %.%#

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8:

endif
