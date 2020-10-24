let files = filter(globpath(&rtp, 'compiler/cake.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'coffee-script') == -1

" Language:    CoffeeScript
" Maintainer:  Mick Koch <mick@kochm.co>
" URL:         http://github.com/kchmck/vim-coffee-script
" License:     WTFPL

if exists('current_compiler')
  finish
endif

let current_compiler = 'cake'
call coffee#CoffeeSetUpVariables()

exec 'CompilerSet makeprg=' . escape(g:coffee_cake . ' ' .
\                                    g:coffee_cake_options . ' $*', ' ')
call coffee#CoffeeSetUpErrorFormat()

endif
