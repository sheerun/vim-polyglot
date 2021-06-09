if polyglot#init#is_disabled(expand('<sfile>:p'), 'smt2', 'autoload/smt2/formatter.vim')
  finish
endif

" Formatting requires a rather recent Vim version
if !((v:version > 802) || (v:version == 802 && has("patch2725")))
    const s:errmsg_oldvim = "Vim >= 8.2.2725 required for auto-formatting"

    "Dummies
    function! smt2#formatter#FormatCurrentParagraph()
        echoerr s:errmsg_oldvim
    endfunction
    function! smt2#formatter#FormatAllParagraphs()
        echoerr s:errmsg_oldvim
    endfunction

    finish
endif
vim9script

# ------------------------------------------------------------------------------
# Config
# ------------------------------------------------------------------------------
# Length of "short" S-expressions
if !exists("g:smt2_formatter_short_length")
    g:smt2_formatter_short_length = 80
endif

# String to use for indentation
if !exists("g:smt2_formatter_indent_str")
    g:smt2_formatter_indent_str = '  '
endif

# ------------------------------------------------------------------------------
# Formatter
# ------------------------------------------------------------------------------
def FitsOneLine(ast: dict<any>): bool
    # A paragraph with several entries should not be formatted in one line
    if ast.kind ==# 'Paragraph' && len(ast.value) != 1
        return false
    endif
    return ast.pos_to - ast.pos_from < g:smt2_formatter_short_length && !ast.contains_comment
enddef

def FormatOneLine(ast: dict<any>): string
    if ast.kind ==# 'Atom'
        return ast.value.lexeme
    elseif ast.kind ==# 'SExpr'
        var formatted = []
        for expr in ast.value
            call formatted->add(expr->FormatOneLine())
        endfor
        return '(' .. formatted->join(' ') .. ')'
    elseif ast.kind ==# 'Paragraph'
        return ast.value[0]->FormatOneLine()
    endif
    throw 'Cannot format AST node: ' .. string(ast)
    return '' # Unreachable
enddef

def Format(ast: dict<any>, indent = 0): string
    const indent_str = repeat(g:smt2_formatter_indent_str, indent)

    if ast.kind ==# 'Atom'
        return indent_str .. ast.value.lexeme
    elseif ast.kind ==# 'SExpr'
        # Short expression -- avoid line breaks
        if ast->FitsOneLine()
            return indent_str .. ast->FormatOneLine()
        endif

        # Long expression -- break lines and indent subexpressions.
        # Don't break before first subexpression if it's an atom
        # Note: ast.value->empty() == false; otherwise it would fit in one line
        var formatted = []
        if (ast.value[0].kind ==# 'Atom')
            call formatted->add(ast.value[0]->Format(0))
        else
            call formatted->add("\n" .. ast.value[0]->Format(indent + 1))
        endif
        for child in ast.value[1 :]
            call formatted->add(child->Format(indent + 1))
        endfor
        return indent_str .. "(" .. formatted->join("\n") .. ")"
    elseif ast.kind ==# 'Paragraph'
        var formatted = []
        for child in ast.value
            call formatted->add(child->Format())
        endfor
        return formatted->join("\n")
    endif
    throw 'Cannot format AST node: ' .. string(ast)
    return '' # Unreachable
enddef

# ------------------------------------------------------------------------------
# Public functions
# ------------------------------------------------------------------------------
def smt2#formatter#FormatCurrentParagraph()
    const cursor = getpos('.')
    const ast = smt2#parser#ParseCurrentParagraph()

    # Identify on which end of the buffer we are (to fix newlines later)
    silent! normal! {
    const is_first_paragraph = line('.') == 1
    silent! normal! }
    const is_last_paragraph = line('.') == line('$')

    # Replace paragraph by formatted lines
    const lines = split(Format(ast), '\n')
    silent! normal! {d}
    if is_last_paragraph && !is_first_paragraph
        call append('.', [''] + lines)
    else
        call append('.', lines + [''])
    endif

    # Remove potentially introduced first empty line
    if is_first_paragraph | silent! :1delete | endif

    # Restore cursor position
    call setpos('.', cursor)
enddef

def smt2#formatter#FormatAllParagraphs()
    const cursor = getpos('.')
    const asts = smt2#parser#ParseAllParagraphs()

    # Clear buffer & insert formatted paragraphs
    silent! :1,$delete
    for ast in asts
        const lines = split(Format(ast), '\n') + ['']
        call append('$', lines)
    endfor

    # Remove first & trailing empty lines
    silent! :1delete
    silent! :$delete

    # Restore cursor position
    call setpos('.', cursor)
enddef
