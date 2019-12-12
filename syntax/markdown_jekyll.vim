if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'markdown') == -1

let b:markdown_in_jekyll=0

if getline(1) =~ '^---\s*$'
  let b:markdown_in_jekyll=1

  syn region markdownJekyllFrontMatter matchgroup=markdownJekyllDelimiter contains=@NoSpell
    \ start="\%^---" end="^---$"

  syn region markdownJekyllLiquidTag matchgroup=markdownJekyllDelimiter contains=@NoSpell oneline
    \ start="{%" end="%}"

  syn region markdownJekyllLiquidOutputTag matchgroup=markdownJekyllDelimiter contains=@NoSpell oneline
    \ start="{{" skip=/"}}"/ end="}}"

  syn region markdownJekyllLiquidBlockTag matchgroup=markdownJekyllDelimiter contains=@NoSpell
    \ start="{%\s*\z(comment\|raw\|highlight\)[^%]*%}" end="{%\s*\%(no\|end\)\z1\s*%}"

  silent spell! nocomment
  silent spell! endcomment
  silent spell! nohighlight
  silent spell! endhighlight
  silent spell! noraw
  silent spell! endraw

  hi def link markdownJekyllFrontMatter         NonText
  hi def link markdownJekyllLiquidTag           NonText
  hi def link markdownJekyllLiquidOutputTag     NonText
  hi def link markdownJekyllLiquidBlockTag      NonText
  hi def link markdownJekyllDelimiter           Delimiter
endif

endif
