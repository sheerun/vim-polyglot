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
# AST nodes -- essentially named token wrappers
#
# Note: pos_from, pos_to and contains_comment were only introduced to allow for
#       a fast FitsOneLine(ast) function in the formatter.
#       Here, pos_from and pos_to refer to indices of characters -- not tokens
# ------------------------------------------------------------------------------
def Ast(kind: string, value: any, pos_from: number, pos_to: number, contains_comment: bool): dict<any>
    return {kind: kind, value: value, pos_from: pos_from, pos_to: pos_to, contains_comment: contains_comment}
enddef

def ParagraphAst(exprs: list<dict<any>>, pos_from: number, pos_to: number): dict<any>
    var contains_comment = false
    for expr in exprs
        if expr.contains_comment
            contains_comment = true
            break
        endif
    endfor
    return Ast('Paragraph', exprs, pos_from, pos_to, contains_comment)
enddef

def SExprAst(exprs: list<dict<any>>, pos_from: number, pos_to: number): dict<any>
    var contains_comment = false
    for expr in exprs
        if expr.contains_comment
            contains_comment = true
            break
        endif
    endfor
    return Ast('SExpr', exprs, pos_from, pos_to, contains_comment)
enddef

def AtomAst(token: dict<any>): dict<any>
    return Ast('Atom', token, token.pos, token.pos + len(token.lexeme), token.kind == 8)
enddef

def PrintAst(ast: dict<any>, indent = 0)
    echo repeat(' ', indent * 2) .. '[' .. ast.kind .. '] '

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
    endif
enddef

# ------------------------------------------------------------------------------
# Grammar
# ------------------------------------------------------------------------------
# Paragraph ::= Expr+
# Expr      ::= SExpr | Atom
# SExpr     ::= '(' Expr* ')'

# ------------------------------------------------------------------------------
# LParen
# ------------------------------------------------------------------------------
def AtStartOfLParen(scanner: dict<any>): bool
    return scanner.cur_token.kind == 0 # token_lparen
enddef

def ParseLParen(scanner: dict<any>) # consumes token; no return
    if debug
        scanner->smt2#scanner#Enforce(scanner->AtStartOfLParen(),
            "ParseLParen called but not at start of LParen",
            scanner.cur_token.pos)
    endif

    scanner->smt2#scanner#NextToken()
enddef

# ------------------------------------------------------------------------------
# RParen
# ------------------------------------------------------------------------------
def AtStartOfRParen(scanner: dict<any>): bool
    return scanner.cur_token.kind == 1 # token_rparen
enddef

def ParseRParen(scanner: dict<any>) # consumes token; no return
    if debug
        scanner->smt2#scanner#Enforce(scanner->AtStartOfRParen(),
            "ParseRParen called but not at start of RParen",
            scanner.cur_token.pos)
    endif

    scanner->smt2#scanner#NextToken()
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

    const ast = AtomAst(scanner.cur_token)
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
    var exprs: list<any>
    while scanner->AtStartOfExpr()
        exprs->add(scanner->ParseExpr())
    endwhile

    scanner->smt2#scanner#Enforce(scanner->AtStartOfRParen(),
        printf("Expected RParen but got %s", scanner.cur_token.kind->smt2#scanner#TokenKind2Str()),
        scanner.cur_token.pos)
    scanner->ParseRParen()

    const pos_to = scanner.cur_token.pos
    return SExprAst(exprs, pos_from, pos_to)
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

    const pos_to = scanner.cur_token.pos
    return ParagraphAst(exprs, pos_from, pos_to)
enddef

# ------------------------------------------------------------------------------
# Public functions
# ------------------------------------------------------------------------------
def smt2#parser#ParseCurrentParagraph(): dict<any>
    # source = [start of current paragraph, EOF]
    # Note: This is needed since `silent! normal! {y}` may not yank full paragraphs
    #       in the context of multiline expressions
    const cursor = getpos('.')
    silent! normal! {
    const line_offset = line('.')
    const source = join(getline('.', '$'), "\n")
    call setpos('.', cursor)

    var scanner = smt2#scanner#Scanner(source, line_offset)
    const ast = scanner->ParseParagraph()

    if debug | ast->PrintAst() | endif
    return ast
enddef

def smt2#parser#ParseAllParagraphs(): list<dict<any>>
    # source = current buffer
    const source = join(getline(1, '$'), "\n")

    var scanner = smt2#scanner#Scanner(source)
    var asts = []
    while scanner.cur_token.kind != 9 # token_eof
        const ast = scanner->ParseParagraph()
        asts->add(ast)

        if debug | ast->PrintAst() | endif
    endwhile
    return asts
enddef
