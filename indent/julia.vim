" Vim indent file
" Language:	Julia
" Maintainer:	Carlo Baldassi <carlobaldassi@gmail.com>
" Last Change:	2014 may 29
" Notes:        based on Bram Moneaar's indent file for vim

setlocal autoindent

setlocal indentexpr=GetJuliaIndent()
setlocal indentkeys+==end,=else,=catch,=finally
setlocal indentkeys-=0#
setlocal indentkeys-=:
setlocal indentkeys-=0{
setlocal indentkeys-=0}
setlocal nosmartindent

" Only define the function once.
if exists("*GetJuliaIndent")
  finish
endif

let s:skipPatterns = '\<julia\%(ComprehensionFor\|RangeEnd\|CommentL\|\%([EILbf]\|Shell\)\=String\|RegEx\|InQuote\)\>'

function JuliaMatch(lnum, str, regex, st)
  let s = a:st
  while 1
    let f = match(a:str, a:regex, s)
    if f >= 0
      let attr = synIDattr(synID(a:lnum,f+1,1),"name")
      if attr =~ s:skipPatterns
        let s = f+1
        continue
      endif
    endif
    break
  endwhile
  return f
endfunction

function GetJuliaNestingStruct(lnum)
  " Auxiliary function to inspect the block structure of a line
  let line = getline(a:lnum)
  let s = 0
  let blocks_stack = []
  let num_closed_blocks = 0
  while 1
    let fb = JuliaMatch(a:lnum, line, '@\@<!\<\%(if\|else\%(if\)\=\|while\|for\|try\|catch\|finally\|\%(staged\)\?function\|macro\|begin\|type\|immutable\|let\|\%(bare\)\?module\|quote\|do\)\>', s)
    let fe = JuliaMatch(a:lnum, line, '@\@<!\<end\>', s)

    if fb < 0 && fe < 0
      " No blocks found
      break
    end

    if fb >= 0 && (fb < fe || fe < 0)
      " The first occurrence is an opening block keyword
      " Note: some keywords (elseif,else,catch,finally) are both
      "       closing blocks and opening new ones

      let i = JuliaMatch(a:lnum, line, '@\@<!\<if\>', s)
      if i >= 0 && i == fb
        let s = i+1
        call add(blocks_stack, 'if')
        continue
      endif
      let i = JuliaMatch(a:lnum, line, '@\@<!\<elseif\>', s)
      if i >= 0 && i == fb
        let s = i+1
        if len(blocks_stack) > 0 && blocks_stack[-1] == 'if'
          let blocks_stack[-1] = 'elseif'
        elseif (len(blocks_stack) > 0 && blocks_stack[-1] != 'elseif') || len(blocks_stack) == 0
          call add(blocks_stack, 'elseif')
          let num_closed_blocks += 1
        endif
        continue
      endif
      let i = JuliaMatch(a:lnum, line, '@\@<!\<else\>', s)
      if i >= 0 && i == fb
        let s = i+1
        if len(blocks_stack) > 0 && blocks_stack[-1] =~ '\<\%(else\)\=if\>'
          let blocks_stack[-1] = 'else'
        else
          call add(blocks_stack, 'else')
          let num_closed_blocks += 1
        endif
        continue
      endif

      let i = JuliaMatch(a:lnum, line, '@\@<!\<try\>', s)
      if i >= 0 && i == fb
        let s = i+1
        call add(blocks_stack, 'try')
        continue
      endif
      let i = JuliaMatch(a:lnum, line, '@\@<!\<catch\>', s)
      if i >= 0 && i == fb
        let s = i+1
        if len(blocks_stack) > 0 && blocks_stack[-1] == 'try'
          let blocks_stack[-1] = 'catch'
        else
          call add(blocks_stack, 'catch')
          let num_closed_blocks += 1
        endif
        continue
      endif
      let i = JuliaMatch(a:lnum, line, '@\@<!\<finally\>', s)
      if i >= 0 && i == fb
        let s = i+1
        if len(blocks_stack) > 0 && (blocks_stack[-1] == 'try' || blocks_stack[-1] == 'catch')
          let blocks_stack[-1] = 'finally'
        else
          call add(blocks_stack, 'finally')
          let num_closed_blocks += 1
        endif
        continue
      endif

      let i = JuliaMatch(a:lnum, line, '@\@<!\<\%(bare\)\?module\>', s)
      if i >= 0 && i == fb
        let s = i+1
        if i == 0
          call add(blocks_stack, 'col1module')
        else
          call add(blocks_stack, 'other')
        endif
        continue
      endif

      let i = JuliaMatch(a:lnum, line, '@\@<!\<\%(while\|for\|\%(staged\)\?function\|macro\|begin\|type\|immutable\|let\|quote\|do\)\>', s)
      if i >= 0 && i == fb
        let s = i+1
        call add(blocks_stack, 'other')
        continue
      endif

      " Note: it should be impossible to get here
      break

    else
      " The first occurrence is an 'end'

      let s = fe+1
      if len(blocks_stack) == 0
        let num_closed_blocks += 1
      else
        call remove(blocks_stack, -1)
      endif
      continue

    endif

    " Note: it should be impossible to get here
    break
  endwhile
  let num_open_blocks = len(blocks_stack) - count(blocks_stack, 'col1module')
  return [num_open_blocks, num_closed_blocks]
endfunction

function GetJuliaIndent()
  let s:save_ignorecase = &ignorecase
  set noignorecase

  " Find a non-blank line above the current line.
  let lnum = prevnonblank(v:lnum - 1)

  " At the start of the file use zero indent.
  if lnum == 0
    let &ignorecase = s:save_ignorecase
    unlet s:save_ignorecase
    return 0
  endif

  let ind = indent(lnum)

  " Analyse previous line
  let [num_open_blocks, num_closed_blocks] = GetJuliaNestingStruct(lnum)

  " Increase indentation for each newly opened block
  " in the previous line
  while num_open_blocks > 0
    let ind += &sw
    let num_open_blocks -= 1
  endwhile

  " Analyse current line
  let [num_open_blocks, num_closed_blocks] = GetJuliaNestingStruct(v:lnum)

  " Decrease indentation for each closed block
  " in the current line
  while num_closed_blocks > 0
    let ind -= &sw
    let num_closed_blocks -= 1
  endwhile

  let &ignorecase = s:save_ignorecase
  unlet s:save_ignorecase
  return ind
endfunction
