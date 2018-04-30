if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jenkins') == -1
  
runtime syntax/groovy.vim
syn keyword jenkinsfileBuiltInVariable currentBuild

syn keyword jenkinsfileCoreStep checkout
syn keyword jenkinsfileCoreStep node
syn keyword jenkinsfileCoreStep scm
syn keyword jenkinsfileCoreStep sh
syn keyword jenkinsfileCoreStep stage
syn keyword jenkinsfileCoreStep step
syn keyword jenkinsfileCoreStep tool

syn keyword jenkinsfilePluginStep docker
syn keyword jenkinsfilePluginStep emailext
syn keyword jenkinsfilePluginStep exwsAllocate
syn keyword jenkinsfilePluginStep exws
syn keyword jenkinsfilePluginStep httpRequest
syn keyword jenkinsfilePluginStep junit

hi link jenkinsfileCoreStep Function
hi link jenkinsfilePluginStep Include
hi link jenkinsfileBuiltInVariable Identifier

let b:current_syntax = "Jenkinsfile"

endif
