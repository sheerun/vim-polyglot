" Vim syntax file
" Language:           Windows PowerShell XML
" Maintainer:         Peter Provost <peter@provost.org>
" Version:            2.10
" Project Repository: https://github.com/PProvost/vim-ps1
" Vim Script Page:    http://www.vim.org/scripts/script.php?script_id=1327"

" Compatible VIM syntax file start
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let s:ps1xml_cpo_save = &cpo
set cpo&vim

doau syntax xml
unlet b:current_syntax

syn case ignore
syn include @ps1xmlScriptBlock <sfile>:p:h/ps1.vim
unlet b:current_syntax

syn region ps1xmlScriptBlock
      \ matchgroup=xmlTag     start="<Script>"
      \ matchgroup=xmlEndTag  end="</Script>"
      \ fold
      \ contains=@ps1xmlScriptBlock
      \ keepend
syn region ps1xmlScriptBlock
      \ matchgroup=xmlTag     start="<ScriptBlock>"
      \ matchgroup=xmlEndTag  end="</ScriptBlock>"
      \ fold
      \ contains=@ps1xmlScriptBlock
      \ keepend
syn region ps1xmlScriptBlock
      \ matchgroup=xmlTag     start="<GetScriptBlock>"
      \ matchgroup=xmlEndTag  end="</GetScriptBlock>"
      \ fold
      \ contains=@ps1xmlScriptBlock
      \ keepend
syn region ps1xmlScriptBlock
      \ matchgroup=xmlTag     start="<SetScriptBlock>"
      \ matchgroup=xmlEndTag  end="</SetScriptBlock>"
      \ fold
      \ contains=@ps1xmlScriptBlock
      \ keepend

syn cluster xmlRegionHook add=ps1xmlScriptBlock

let b:current_syntax = "ps1xml"

let &cpo = s:ps1xml_cpo_save
unlet s:ps1xml_cpo_save

