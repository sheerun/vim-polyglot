if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'twig') == -1

if exists("b:ran_once")
	finish
endif

let b:ran_once = 1

let s:baseIndentExpr=&indentexpr
setlocal indentexpr=GetTwigIndent(v:lnum)

fun! GetTwigIndent(currentLineNumber)
	let currentLine = getline(a:currentLineNumber)
	let previousLineNumber = prevnonblank(a:currentLineNumber - 1)
	let previousLine = getline(previousLineNumber)

	if (previousLine =~ s:startStructures || previousLine =~ s:middleStructures) && (currentLine !~ s:endStructures && currentLine !~ s:middleStructures)
		return indent(previousLineNumber) + &shiftwidth
	elseif currentLine =~ s:endStructures || currentLine =~ s:middleStructures
		let previousOpenStructureNumber = s:FindPreviousOpenStructure(a:currentLineNumber)
		let previousOpenStructureLine = getline(previousOpenStructureNumber)
		return indent(previousOpenStructureNumber)
	endif

    return s:CallBaseIndent()
endf

function! s:CallBaseIndent()
    exe 'redir => s:outputOfBaseIndent'
    exe 'silent echo ' . s:baseIndentExpr
    exe 'redir END'
    return split(s:outputOfBaseIndent)[0]
endf


function! s:FindPreviousOpenStructure(lineNumber)
	let countOpen = 0
	let countClosed = 0
	let lineNumber = a:lineNumber
	while lineNumber != 1 && countOpen <= countClosed
		let lineNumber -= 1
		let currentLine = getline(lineNumber)

		if currentLine =~ s:startStructures
			let countOpen += 1
		elseif currentLine =~ s:endStructures
			let countClosed += 1
		endif
	endwhile

	return lineNumber
endfunction

function! s:StartStructure(name)
	return '^\s*{%\s*' . a:name . '.*%}'
endfunction

function! s:EndStructure(name)
	return '^\s*{%\s*end' . a:name . '.*%}'
endfunction

function! s:Map(Fun, list)
    if len(a:list) == 0
        return []
    else
        return [a:Fun(a:list[0])] + s:Map(a:Fun, a:list[1:])
    endif
endfunction

fun! s:BuildStructures()
	let structures = ['if','for','block']
	let mStructures = ['elseif','else']
	let s:startStructures = join(s:Map(function('s:StartStructure'), structures), '\|')
	let s:endStructures = join(s:Map(function('s:EndStructure'), structures), '\|')
	let s:middleStructures = join(s:Map(function('s:StartStructure'), mStructures), '\|')
endfun

call s:BuildStructures()

endif
