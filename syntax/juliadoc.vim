if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'julia') == -1

" Vim syntax file for julia document view
scriptencoding utf-8

if exists('b:current_syntax')
  finish
endif

syntax sync fromstart

syntax region juliadocCode matchgroup=juliadocCodeDelimiter start="`" end="`" concealends display oneline
syntax region juliadocCode matchgroup=juliadocCodeDelimiter start="``" end="``" concealends display oneline contains=juliadocCodeLatex
syntax region juliadocCode matchgroup=juliadocCodeDelimiter start="^\s*```.*$" end='^\s*```' concealends
syntax region juliadocH1 matchgroup=juliadocHeadingDelimiter start="##\@!"      end="$" concealends display oneline
syntax region juliadocH2 matchgroup=juliadocHeadingDelimiter start="###\@!"     end="$" concealends display oneline
syntax region juliadocH3 matchgroup=juliadocHeadingDelimiter start="####\@!"    end="$" concealends display oneline
syntax region juliadocH4 matchgroup=juliadocHeadingDelimiter start="#####\@!"   end="$" concealends display oneline
syntax region juliadocH5 matchgroup=juliadocHeadingDelimiter start="######\@!"  end="$" concealends display oneline
syntax region juliadocH6 matchgroup=juliadocHeadingDelimiter start="#######\@!" end="$" concealends display oneline
syntax match juliadocLink "\[\^\@!.\{-1,}\](.\{-1,})" contains=juliadocLinkBody,juliadocLinkUrl display keepend
syntax region juliadocLinkBody matchgroup=juliadocLinkDelimiter start="\[" end="\]" concealends display contained oneline
syntax match juliadocLinkUrl "(\zs@ref\s\+.\{-1,}\ze)" contains=juliadocLinkUrlConceal display keepend
syntax match juliadocLinkUrlConceal "@ref\s\+" conceal display contained
syntax match juliadocCrossref "\[`.\{-1,}`\](@ref)" contains=juliadocCrossrefBody display keepend
syntax region juliadocCrossrefBody matchgroup=juliadocCrossrefDelimiter start="\[`" end="`\](@ref)" concealends display contained oneline
syntax region juliadocMath matchgroup=juliadocMathDelimiter start="\$" end="\$" concealends display oneline
syntax match juliadocListing "^\s*\zs\%([-+*]\|\d\+[.)]\)\ze\s" display
syntax match juliadocFootnote "^\s*\[\^[[:alnum:]]\+\]:\s*" display contains=juliadocFootnoteBody keepend
syntax region juliadocFootnoteBody matchgroup=juliadocFootnoteDelimiter start="^\s*\zs\[\^" end="\]" concealends display contained oneline
syntax match juliadocFootnoteRef "\s\[\^[[:alnum:]]\+\]" display contains=juliadocFootnoteRefBody,juliadocFootnoteRefConceal keepend
syntax match juliadocFootnoteRefBody "[[:alnum:]]\+" display contained
syntax match juliadocFootnoteRefConceal "\^" conceal display contained
syntax region juliadocBlockquote matchgroup=juliadocBlockquoteDelimiter start="^\s*>\s" end="$" concealends display oneline
syntax match juliadocRules "^-\{3,}" display
syntax region juliadocAdmonitions matchgroup=juliadocAdmonitionsDelimiter start="^\s*!!!" end="$" concealends display contains=juliadocAdmonitionsType,juliadocAdmonitionsTitle oneline keepend
syntax match juliadocAdmonitionsType "\c\%(danger\|warning\|info\|note\|tip\)\>" display contained
syntax region juliadocAdmonitionsTitle matchgroup=juliadocAdmonitionsTitleDelimiter start='"' end='"' display contained oneline

if &encoding ==# 'utf-8'
  for [s:from, s:to] in items(julia_latex_symbols#get_dict())
    execute printf('syntax match juliadocCodeLatex "\\%s" conceal cchar=%s display contained', escape(s:from, '~"\.^$[]*'), s:to)
  endfor
endif

highlight default link juliadocCode String
highlight default link juliadocCodeLatex String
highlight default link juliadocH1 Title
highlight default link juliadocH2 Title
highlight default link juliadocH3 Title
highlight default link juliadocH4 Title
highlight default link juliadocH5 Title
highlight default link juliadocH6 Title
highlight default link juliadocLinkBody Identifier
highlight default link juliadocLinkUrl Underlined
highlight default link juliadocCrossref Underlined
highlight default link juliadocCrossrefBody Underlined
highlight default link juliadocMath Special
highlight default link juliadocListing PreProc
highlight default link juliadocFootnoteBody PreProc
highlight default link juliadocFootnoteRefBody PreProc
highlight default link juliadocBlockquote Comment
highlight default link juliadocRules PreProc
highlight default link juliadocAdmonitionsType Todo
highlight default link juliadocAdmonitionsTitle Title

let b:current_syntax = "juliadoc"

endif
