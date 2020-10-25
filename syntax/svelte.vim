if has_key(g:polyglot_is_disabled, 'svelte')
  finish
endif

" Vim syntax file
" Language:   Svelte 3 (HTML/JavaScript)
" Author:     Evan Lecklider <evan@lecklider.com>
" Maintainer: Evan Lecklide <evan@lecklider.com>
" Depends:    pangloss/vim-javascript
" URL:        https://github.com/evanleck/vim-svelte
"
" Like vim-jsx, this depends on the pangloss/vim-javascript syntax package (and
" is tested against it exclusively). If you're using vim-polyglot, then you're
" all set.

if exists("b:current_syntax")
  finish
endif

" Read HTML to begin with.
runtime! syntax/html.vim
unlet! b:current_syntax

" Expand HTML tag names to include mixed case, periods, and colons.
syntax match htmlTagName contained "\<[a-zA-Z:\.]*\>"

" Special attributes that include some kind of binding e.g. "on:click",
" "bind:something", etc.
syntax match svelteKeyword "\<[a-z]\+:[a-zA-Z|]\+=" contained containedin=htmlTag

" The "slot" attribute has special meaning.
syntax keyword svelteKeyword slot contained containedin=htmlTag

" According to vim-jsx, you can let jsBlock take care of ending the region.
"   https://github.com/mxw/vim-jsx/blob/master/after/syntax/jsx.vim
syntax region svelteExpression start="{" end="" contains=jsBlock,javascriptBlock containedin=htmlString,htmlTag,htmlArg,htmlValue,htmlH1,htmlH2,htmlH3,htmlH4,htmlH5,htmlH6,htmlHead,htmlTitle,htmlBoldItalicUnderline,htmlUnderlineBold,htmlUnderlineItalicBold,htmlUnderlineBoldItalic,htmlItalicUnderline,htmlItalicBold,htmlItalicBoldUnderline,htmlItalicUnderlineBold,htmlLink,htmlLeadingSpace,htmlBold,htmlBoldUnderline,htmlBoldItalic,htmlBoldUnderlineItalic,htmlUnderline,htmlUnderlineItalic,htmlItalic,htmlStrike,javaScript

syntax region svelteSurroundingTag contained start=+<\(script\|style\|template\)+ end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent

" Block conditionals.
syntax match svelteConditional "#if" contained containedin=jsBlock,javascriptBlock
syntax match svelteConditional "/if" contained containedin=jsBlock,javascriptBlock
syntax match svelteConditional ":else if" contained containedin=jsBlock,javascriptBlock
syntax match svelteConditional ":else" contained containedin=jsBlock,javascriptBlock

" Block keywords.
syntax match svelteKeyword "#await" contained containedin=jsBlock,javascriptBlock
syntax match svelteKeyword "/await" contained containedin=jsBlock,javascriptBlock
syntax match svelteKeyword ":catch" contained containedin=jsBlock,javascriptBlock
syntax match svelteKeyword ":then" contained containedin=jsBlock,javascriptBlock

" Inline keywords.
syntax match svelteKeyword "@html" contained containedin=jsBlock,javascriptBlock
syntax match svelteKeyword "@debug" contained containedin=jsBlock,javascriptBlock

" Repeat functions.
syntax match svelteRepeat "#each" contained containedin=jsBlock,javascriptBlock
syntax match svelteRepeat "/each" contained containedin=jsBlock,javascriptBlock

highlight def link svelteConditional Conditional
highlight def link svelteKeyword Keyword
highlight def link svelteRepeat Repeat

" Preprocessed languages that aren't supported out of the box by Svelte require
" additional syntax files to be pulled in and can slow Vim down a bit. For that
" reason, preprocessed languages must be enabled manually. Note that some may
" require additional plugins that contain the actual syntax definitions.
"
" Heavily cribbed from https://github.com/posva/vim-vue and largely completed by
" @davidroeca (thank you!).

" A syntax should be registered if there's a valid syntax definition known to
" Vim and it is enabled for the Svelte plugin.
function! s:enabled(language)
  " Check whether a syntax file for {language} exists
  let s:syntax_name = get(a:language, 'as', a:language.name)
  if empty(globpath(&runtimepath, 'syntax/' . s:syntax_name . '.vim'))
    return 0
  endif

  " If g:svelte_preprocessors is set, check for it there, otherwise return 0.
  if exists('g:svelte_preprocessors') && type(g:svelte_preprocessors) == v:t_list
    return index(g:svelte_preprocessors, a:language.name) != -1
  else
    return 0
  endif
endfunction

" Default tag definitions.
let s:languages = [
      \ { 'name': 'less', 'tag': 'style' },
      \ { 'name': 'scss', 'tag': 'style' },
      \ { 'name': 'sass', 'tag': 'style' },
      \ { 'name': 'stylus', 'tag': 'style' },
      \ { 'name': 'typescript', 'tag': 'script' },
      \ ]

" Add global tag definitions to our defaults.
if exists('g:svelte_preprocessor_tags') && type(g:svelte_preprocessor_tags) == v:t_list
  let s:languages += g:svelte_preprocessor_tags
endif

for s:language in s:languages
  let s:attr = '\(lang\|type\)=\("\|''\)[^\2]*' . s:language.name . '[^\2]*\2'
  let s:start = '<' . s:language.tag . '\>\_[^>]*' . s:attr . '\_[^>]*>'

  if s:enabled(s:language)
    execute 'syntax include @' . s:language.name . ' syntax/' . get(s:language, 'as', s:language.name) . '.vim'
    unlet! b:current_syntax

    execute 'syntax region svelte_' . s:language.name
          \ 'keepend'
          \ 'start=/' . s:start . '/'
          \ 'end="</' . s:language.tag . '>"me=s-1'
          \ 'contains=@' . s:language.name . ',svelteSurroundingTag'
          \ 'fold'
  endif
endfor

" Cybernetically enhanced web apps.
let b:current_syntax = "svelte"

" Sync from start because of the wacky nesting.
syntax sync fromstart
