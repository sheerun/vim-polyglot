if polyglot#init#is_disabled(expand('<sfile>:p'), 'smt2', 'autoload/smt2/parser.vim')
  finish
endif

vim9script
const debug = false
set maxfuncdepth=100000000 # SMT files tend to be highly nested

# TODO: Retry iterative parsing now that we have a scanner and simpler grammar
# TODO: Refer to token kind by name, e.g. token_comment instead of 8
# TODO: Change Ast.kind type from string to enum/number?

# ------------------------------------------------------------------------------
# AST nodes
#
# Note: pos_from, pos_to and contains_comment allow for a fast FitsOneLine(ast)
#       function in the formatter.
#       Here, pos_from and pos_to refer to indices of characters -- not tokens.
# ------------------------------------------------------------------------------
def Ast(kind: string, value: any, pos_from: number, pos_to: number, contains_comment: bool, scanner: dict<any>): dict<any>
    # User-facing functionality wants start/end line and column -- not positions
    def CalcCoords(): list<dict<number>>
        const from = scanner.calcCoord(pos_from)
        # If expression ends at end of line, pos_to will be in next line.
        # That's undesired. Stay in the actual last line.
        var to = scanner.calcCoord(pos_to - 1)
        to.col += 1
        return [from, to]
    enddef
    return {kind: kind, value: value, pos_from: pos_from, pos_to: pos_to, contains_comment: contains_comment, CalcCoords: CalcCoords}
enddef

def FileAst(paragraphs: list<dict<any>>, pos_from: number, pos_to: number, scanner: dict<any>): dict<any>
    var contains_comment = false
    for paragraph in paragraphs
        if paragraph.contains_comment
            contains_comment = true
            break
        endif
    endfor
    return Ast('File', paragraphs, pos_from, pos_to, contains_comment, scanner)
enddef

def ParagraphAst(exprs: list<dict<any>>, pos_from: number, pos_to: number, scanner: dict<any>): dict<any>
    var contains_comment = false
    for expr in exprs
        if expr.contains_comment
            contains_comment = true
            break
        endif
    endfor
    return Ast('Paragraph', exprs, pos_from, pos_to, contains_comment, scanner)
enddef

def SExprAst(exprs: list<dict<any>>, pos_from: number, pos_to: number, scanner: dict<any>): dict<any>
    var contains_comment = false
    for expr in exprs
        if expr.contains_comment
            contains_comment = true
            break
        endif
    endfor
    return Ast('SExpr', exprs, pos_from, pos_to, contains_comment, scanner)
enddef

def AtomAst(token: dict<any>, scanner: dict<any>): dict<any>
    return Ast('Atom', token, token.pos, token.pos + len(token.lexeme), token.kind == 8, scanner)
enddef

def PrintAst(ast: dict<any>, indent = 0)
    const coords = ast.CalcCoords()

    echo printf("[%5d-%-5d) [%4d:%-3d-%4d:%-3d) %s[%s] ",
        ast.pos_from, ast.pos_to,
        coords[0].line, coords[0].col,
        coords[1].line, coords[1].col,
        repeat(' ', indent * 2),
        ast.kind)

    if ast.kind ==# 'Atom'
        echon ast.value.lexeme
    elseif ast.kind ==# 'SExpr'
        for v in ast.value
            call PrintAst(v, indent + 1)
        endfor
    elseif ast.kind ==# 'Paragraph'
        for v in ast.value
            call PrintAst(v, indent + 1)
        endfor
    elseif ast.kind ==# 'File'
        for v in ast.value
            call PrintAst(v, indent + 1)
        endfor
    endif
enddef

# ------------------------------------------------------------------------------
# Grammar
# ------------------------------------------------------------------------------
# File      ::= Paragraph+
# Paragraph ::= Expr+ EndOfParagraph
# Expr      ::= SExpr | Atom
# SExpr     ::= '(' Expr* ')'

# ------------------------------------------------------------------------------
# LParen
# ------------------------------------------------------------------------------
def AtStartOfLParen(scanner: dict<any>): bool
    return scanner.cur_token.kind == 0 # token_lparen
enddef

def ParseLParen(scanner: dict<any>): dict<any>
    if debug
        scanner->smt2#scanner#Enforce(scanner->AtStartOfLParen(),
            "ParseLParen called but not at start of LParen",
            scanner.cur_token.pos)
    endif

    const token = scanner.cur_token
    scanner->smt2#scanner#NextToken()
    return token
enddef

# ------------------------------------------------------------------------------
# RParen
# ------------------------------------------------------------------------------
def AtStartOfRParen(scanner: dict<any>): bool
    return scanner.cur_token.kind == 1 # token_rparen
enddef

def ParseRParen(scanner: dict<any>): dict<any>
    if debug
        scanner->smt2#scanner#Enforce(scanner->AtStartOfRParen(),
            "ParseRParen called but not at start of RParen",
            scanner.cur_token.pos)
    endif

    const token = scanner.cur_token
    scanner->smt2#scanner#NextToken()
    return token
enddef

# ------------------------------------------------------------------------------
# Atom
# ------------------------------------------------------------------------------
def AtStartOfAtom(scanner: dict<any>): bool
    return 2 <= scanner.cur_token.kind && scanner.cur_token.kind <= 8
enddef

def ParseAtom(scanner: dict<any>): dict<any>
    if debug
        scanner->smt2#scanner#Enforce(scanner->AtStartOfAtom(),
            "ParseAtom called but not at start of Atom",
            scanner.cur_token.pos)
    endif

    const ast = AtomAst(scanner.cur_token, scanner)
    scanner->smt2#scanner#NextToken()
    return ast
enddef

# ------------------------------------------------------------------------------
# Expr
# ------------------------------------------------------------------------------
def AtStartOfExpr(scanner: dict<any>): bool
    return scanner->AtStartOfSExpr() || scanner->AtStartOfAtom()
enddef

def ParseExpr(scanner: dict<any>): dict<any>
    if debug
        scanner->smt2#scanner#Enforce(scanner->AtStartOfExpr(),
            "ParseExpr called but not at start of Expr",
            scanner.cur_token.pos)
    endif

    if scanner->AtStartOfSExpr()
        return scanner->ParseSExpr()
    endif
    return scanner->ParseAtom()
enddef

# ------------------------------------------------------------------------------
# SExpr
# ------------------------------------------------------------------------------
const AtStartOfSExpr = funcref(AtStartOfLParen)

def ParseSExpr(scanner: dict<any>): dict<any>
    const pos_from = scanner.cur_token.pos

    if debug
        scanner->smt2#scanner#Enforce(scanner->AtStartOfSExpr(),
            "ParseSExpr called but not at start of SExpr",
            pos_from)
    endif
    scanner->ParseLParen()

    # Expr*
    var exprs: list<dict<any>>
    while scanner->AtStartOfExpr()
        exprs->add(scanner->ParseExpr())
    endwhile

    scanner->smt2#scanner#Enforce(scanner->AtStartOfRParen(),
        printf("Expected RParen but got %s", scanner.cur_token.kind->smt2#scanner#TokenKind2Str()),
        scanner.cur_token.pos)
    const end_token = scanner->ParseRParen()

    const pos_to = end_token.pos + 1
    return SExprAst(exprs, pos_from, pos_to, scanner)
enddef

# ------------------------------------------------------------------------------
# Paragraph
# ------------------------------------------------------------------------------
def ParseParagraph(scanner: dict<any>): dict<any>
    const pos_from = scanner.cur_token.pos

    # Expr+
    scanner->smt2#scanner#Enforce(scanner->AtStartOfExpr(),
        printf("Expected Expr but got %s", scanner.cur_token.kind->smt2#scanner#TokenKind2Str()),
        pos_from)

    var exprs = [scanner->ParseExpr()]
    while scanner->AtStartOfExpr() && !scanner.at_new_paragraph
        exprs->add(scanner->ParseExpr())
    endwhile

    const pos_to = exprs[-1].pos_to
    return ParagraphAst(exprs, pos_from, pos_to, scanner)
enddef

# ------------------------------------------------------------------------------
# File
# ------------------------------------------------------------------------------
def ParseFile(scanner: dict<any>): dict<any>
    const pos_from = scanner.cur_token.pos

    var paragraphs = []
    while scanner.cur_token.kind != 9 # token_eof
        const ast = scanner->ParseParagraph()
        paragraphs->add(ast)
    endwhile

    const pos_to = empty(paragraphs) ? pos_from : paragraphs[-1].pos_to
    return FileAst(paragraphs, pos_from, pos_to, scanner)
enddef

# ------------------------------------------------------------------------------
# Auxiliary
#
# TODO: MoveTo* functions rely on local search instead of proper (but slow)
#       scanning of the whole file and may be incorrect in corner cases.
#       Consider tweaking.
# ------------------------------------------------------------------------------

# Returns true if successful, i.e. on move to '(' of outermost SExpr
def MoveToOutermostSExpr(): bool
    var cur_pos = getpos('.')
    while true
        silent! normal! [(
        const new_pos = getpos('.')
        if cur_pos == new_pos
            break
        else
            cur_pos = new_pos
        endif
    endwhile

    const cur_char = getline('.')[charcol('.') - 1]
    return cur_char == '('
enddef

def CursorInSExpr(): bool
    const cursor = getpos('.')
    silent! normal! [(
    const res = cursor != getpos('.')
    call setpos('.', cursor)
    return res
enddef

def MoveToStartOfCurrentParagraph()
    # Empty (or whitespace) lines outside of S-expressions separate paragraphs.
    # Nothing to do if cursor is already at such a line.
    if !(getline('.')->trim()->empty() && !CursorInSExpr())
        # Move backwards until an empty line that is not in an SExpr is found,
        # or -- if there is none -- to the first line of the file
        while true
            const empty_line = search('\m\C^\s*$', 'b', 1)
            if !CursorInSExpr()
                break
            elseif empty_line == 0
                cursor(1, 1)
                break
            endif
        endwhile
    endif
enddef

# ------------------------------------------------------------------------------
# Public functions
# ------------------------------------------------------------------------------
def smt2#parser#ParseCurrentParagraph(): dict<any>
    const cursor = getpos('.')
    MoveToStartOfCurrentParagraph()
    const from = getpos('.')
    call setpos('.', cursor)

    # source = [paragraph of outermost SExpr, EOF]
    # Note: This is needed since `silent! normal! {` is not guaranteed to jump
    #       to the start of the paragraph, e.g. if newlines occur in between.
    const lines_to_format = getline(from[1], '$')
    const source = join(lines_to_format, "\n")

    var scanner = smt2#scanner#Scanner(source, from[1], from[2])
    const ast = scanner->ParseParagraph()

    if debug | ast->PrintAst() | endif
    return ast
enddef

def smt2#parser#ParseOutermostSExpr(): dict<any>
    const cursor = getpos('.')
    if ! MoveToOutermostSExpr()
        throw "Cursor is not in an S-expression!"
    endif
    const from = getpos('.')
    call setpos('.', cursor)

    # source = [start of outermost SExpr, EOF]
    # Note: This is needed since `silent! normal! %` is not guaranteed to jump
    #       to the matching ')', e.g. if an unmatched '(' occurs in a comment.
    const lines_to_format = getline(from[1], '$')
    const source = join(lines_to_format, "\n")

    var scanner = smt2#scanner#Scanner(source, from[1], from[2])
    const ast = scanner->ParseSExpr()

    if debug | ast->PrintAst() | endif
    return ast
enddef

def smt2#parser#ParseFile(): dict<any>
    const cursor = getpos('.')
    cursor(1, 1)
    const first_non_empty_line = search('.')
    call setpos('.', cursor)

    # source = [first non-empty line, EOF]
    const source = join(getline(first_non_empty_line, '$'), "\n")

    var scanner = smt2#scanner#Scanner(source, first_non_empty_line)
    const ast = scanner->ParseFile()

    if debug | ast->PrintAst() | endif
    return ast
enddef
