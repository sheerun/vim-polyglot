if polyglot#init#is_disabled(expand('<sfile>:p'), 'smt2', 'autoload/smt2/scanner.vim')
  finish
endif

vim9script
const debug = false

# ------------------------------------------------------------------------------
# Ref: http://smtlib.cs.uiowa.edu/papers/smt-lib-reference-v2.6-r2021-05-12.pdf
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Token
# ------------------------------------------------------------------------------
const token_lparen = 0
const token_rparen = 1
const token_numeral = 2
const token_decimal = 3
const token_bv = 4
const token_string = 5
const token_symbol = 6
const token_keyword = 7
const token_comment = 8
const token_eof = 9

def Token(kind: number, pos: number, lexeme: string): dict<any>
    return {kind: kind, pos: pos, lexeme: lexeme}
enddef

def smt2#scanner#TokenKind2Str(kind: number): string
    if kind == token_lparen
        return "LParen"
    elseif kind == token_rparen
        return "RParen"
    elseif kind == token_numeral
        return "Numeral"
    elseif kind == token_decimal
        return "Decimal"
    elseif kind == token_bv
        return "Bv"
    elseif kind == token_string
        return "String"
    elseif kind == token_symbol
        return "Symbol"
    elseif kind == token_keyword
        return "Keyword"
    elseif kind == token_comment
        return "Comment"
    elseif kind == token_eof
        return "EOF"
    else
        echoerr "Unexpected token kind: " .. kind
        return ''
    endif
enddef

def PrettyPrint(scanner: dict<any>, token: dict<any>)
    const coord = scanner->Pos2Coord(token.pos)
    echo printf("%4d:%-3d (%5d) %8s %s", coord.line, coord.col, token.pos, token.kind->smt2#scanner#TokenKind2Str(), token.lexeme)
enddef

# ------------------------------------------------------------------------------
# Scanner
#
# Note: The public interface is limited to the
#       - field cur_token
#       - method NextToken
#       - field at_new_paragraph (needed to distinguish paragraphs in parser)
#
#       The other fields should only be used internally / in this file
# ------------------------------------------------------------------------------
# TODO: Enforce restriction to ASCII? We should if we use the lookup table below
# TODO: Do not take a string but a character stream (or just buffer and pos)?

def smt2#scanner#Scanner(source: string, line_offset = 1): dict<any>
    var scanner = {
        chars: source->trim(" \t\n\r", 2)->split('\zs'),
        line_offset: line_offset, # start line of source string in buffer
        pos: 0,                   # pos in source string -- not column in line
        at_new_paragraph: false}

    if scanner.chars->empty()
        scanner.at_eof = true
        scanner.cur_char = ''
    else
        scanner.at_eof = false
        scanner.cur_char = scanner.chars[0]
    endif
    scanner.cur_char_nr = scanner.cur_char->char2nr()
    scanner.chars_len = len(scanner.chars)
    scanner.cur_token = {}
    scanner->smt2#scanner#NextToken()
    return scanner
enddef

def smt2#scanner#NextToken(scanner: dict<any>)
    if scanner.at_eof
        scanner.cur_token = Token(token_eof, scanner.pos, '')
    else
        scanner->SkipWhitespace() # Cannot end up at eof since end is trimmed

        const nr = scanner.cur_char_nr
        if nr == 40 # '('
            scanner.cur_token = Token(token_lparen, scanner.pos, '(')
            scanner->NextPos()
        elseif nr == 41 # ')'
            scanner.cur_token = Token(token_rparen, scanner.pos, ')')
            scanner->NextPos()
        elseif nr->IsStartOfSimpleSymbol()
            scanner.cur_token = scanner->ReadSimpleSymbol()
        elseif nr == 124 # '|'
            scanner.cur_token = scanner->ReadQuotedSymbol()
        elseif nr == 58 # ':'
            scanner.cur_token = scanner->ReadKeyword()
        elseif nr->IsDigit()
            scanner.cur_token = scanner->ReadNumber()
        elseif nr == 35 # '#'
            scanner.cur_token = scanner->ReadBv()
        elseif nr == 34 # '"'
            scanner.cur_token = scanner->ReadString()
        elseif nr == 59 # ';'
            scanner.cur_token = scanner->ReadComment()
        else
            scanner->smt2#scanner#Enforce(false, printf("Unexpected character '%s'", scanner.cur_char), scanner.pos)
        endif
    endif

    if debug
        if scanner.at_new_paragraph | echo "\n" | endif
        scanner->PrettyPrint(scanner.cur_token)
    endif
enddef

def NextPos(scanner: dict<any>)
    if debug | scanner->smt2#scanner#Enforce(!scanner.at_eof, "Already at EOF", scanner.pos) | endif

    scanner.pos += 1
    scanner.at_eof = scanner.pos == scanner.chars_len
    scanner.cur_char = scanner.at_eof ? '' : scanner.chars[scanner.pos]
    scanner.cur_char_nr = scanner.cur_char->char2nr()
enddef

def smt2#scanner#Enforce(scanner: dict<any>, expr: bool, msg: string, pos: number)
    if !expr
        const coord = scanner->Pos2Coord(pos)
        throw printf("Syntax error (at %d:%d): %s ", coord.line, coord.col, msg)
    endif
enddef

# This is slow and intended for use in error messages & debugging only
def Pos2Coord(scanner: dict<any>, pos: number): dict<number>
    const line = scanner.chars[: pos]->count("\n") + scanner.line_offset

    var cur_pos = pos - 1
    while cur_pos >= 0 && scanner.chars[cur_pos] != "\n"
        cur_pos -= 1
    endwhile

    return {line: line, col: pos - cur_pos}
enddef

# ------------------------------------------------------------------------------
# <white_space_char> ::= 9 (tab), 10 (lf), 13 (cr), 32 (space)
#
# Note: The source string has all lines joined by "\n" so "\r" can be ignored
# ------------------------------------------------------------------------------
def SkipWhitespace(scanner: dict<any>)
    var newlines = 0
    while !scanner.at_eof
        const nr = scanner.cur_char_nr
        if nr == 32 || nr == 9
            scanner->NextPos()
        elseif nr == 10
            newlines += 1
            scanner->NextPos()
        else
            break
        endif
    endwhile
    scanner.at_new_paragraph = newlines > 1
enddef

# ------------------------------------------------------------------------------
# A comment is any character sequence not contained within a string literal or a
# quoted symbol that begins with ; and ends with the first subsequent
# line-breaking character, i.e. 10 (lf) or 13 (cr)
#
# Note: The source string has all lines joined by "\n" so "\r" can be ignored
# ------------------------------------------------------------------------------
def ReadComment(scanner: dict<any>): dict<any>
    if debug | scanner->smt2#scanner#Enforce(scanner.cur_char == ';', "Not the start of a comment", scanner.pos) | endif

    const start_pos = scanner.pos
    scanner->NextPos()
    while !scanner.at_eof && scanner.cur_char_nr != 10
        scanner->NextPos()
    endwhile
    return Token(token_comment, start_pos, scanner.chars[start_pos : scanner.pos - 1]->join(''))
enddef

# ------------------------------------------------------------------------------
# <numeral> ::= 0
#             | a non-empty sequence of digits not starting with 0
#
# <decimal> ::= <numeral>.0*<numeral>
# ------------------------------------------------------------------------------
def IsDigit(char_nr: number): bool
    # '0'->char2nr() == 48 && '9'->char2nr() == 57
    return 48 <= char_nr && char_nr <= 57
enddef

def ReadNumber(scanner: dict<any>): dict<any>
    if debug | scanner->smt2#scanner#Enforce(scanner.cur_char_nr->IsDigit(), "Not the start of a number", scanner.pos) | endif

    const starts_with_zero = scanner.cur_char == '0'
    const start_pos = scanner.pos
    scanner->NextPos()
    # Note: We aren't strict about numbers not starting with 0 when not debugging
    if debug | scanner->smt2#scanner#Enforce(!starts_with_zero || scanner.cur_char != '0', "Numeral may not start with 0", scanner.pos) | endif

    var is_decimal = false
    while !scanner.at_eof
        const nr = scanner.cur_char_nr
        if 48 <= nr && nr <= 57 # inlined IsDigit
            scanner->NextPos()
        elseif scanner.cur_char == '.'
            if is_decimal
                break
            else
                is_decimal = true
                scanner->NextPos()
            endif
        else
            break
        endif
    endwhile
    const kind = is_decimal ? token_decimal : token_numeral
    return Token(kind, start_pos, scanner.chars[start_pos : scanner.pos - 1]->join(''))
enddef

# ------------------------------------------------------------------------------
# <hexadecimal> ::= #x followed by a non-empty sequence of digits and letters
#                   from A to F, capitalized or not
#
# <binary> ::= #b followed by a non-empty sequence of 0 and 1 characters
# ------------------------------------------------------------------------------

# Build lookup table for char->match('\m\C^[0-9a-fA-F]')
def InitIsAlphaNumericCharNr(): list<bool>
    var lookup_table = []
    var char_nr = 0
    while char_nr < 255
        lookup_table->add(char_nr->nr2char()->match('\m\C^[0-9a-fA-F]') != -1)
        char_nr += 1
    endwhile
    return lookup_table
enddef
const is_alphanumeric_char_nr = InitIsAlphaNumericCharNr()

def ReadBv(scanner: dict<any>): dict<any>
    if debug | scanner->smt2#scanner#Enforce(scanner.cur_char == '#', "Not the start of a bit vector literal", scanner.pos) | endif

    const start_pos = scanner.pos
    scanner->NextPos()
    if scanner.cur_char == 'x'
        scanner->NextPos()
        scanner->smt2#scanner#Enforce(!scanner.at_eof && is_alphanumeric_char_nr[scanner.cur_char_nr],
            "hexadecimal literal may not be empty",
            scanner.pos)
        while !scanner.at_eof && is_alphanumeric_char_nr[scanner.cur_char_nr]
            scanner->NextPos()
        endwhile
    elseif scanner.cur_char == 'b'
        scanner->NextPos()
        # '0'->char2nr() == 48 && '1'->char2nr() == 49
        scanner->smt2#scanner#Enforce(!scanner.at_eof && scanner.cur_char_num == 48 || scanner.cur_char_num == 49,
            "binary literal may not be empty",
            scanner.pos)
        while !scanner.at_eof && scanner.cur_char_num == 48 || scanner.cur_char_num == 49
            scanner->NextPos()
        endwhile
    else
        scanner->smt2#scanner#Enforce(false, "invalid bit vector literal -- expected 'x' or 'b'", scanner.pos)
    endif
    return Token(token_bv, start_pos, scanner.chars[start_pos : scanner.pos - 1]->join(''))
enddef

# ------------------------------------------------------------------------------
# <string> ::= sequence of whitespace and printable characters in double
#              quotes with escape sequence ""
# ------------------------------------------------------------------------------
# TODO: Allow only printable characters, i.e. ranges [32, 126], [128-255]?
def ReadString(scanner: dict<any>): dict<any>
    if debug | scanner->smt2#scanner#Enforce(scanner.cur_char == '"', "Not the start of a string", scanner.pos) | endif

    const start_pos = scanner.pos
    scanner->NextPos()
    while true
        scanner->smt2#scanner#Enforce(!scanner.at_eof, "unexpected end of string", scanner.pos)

        if scanner.cur_char == '"'
            scanner->NextPos()
            if scanner.cur_char != '"'
                break
            endif
        endif
        scanner->NextPos()
    endwhile
    return Token(token_string, start_pos, scanner.chars[start_pos : scanner.pos - 1]->join(''))
enddef

# ------------------------------------------------------------------------------
# <simple symbol> ::= a non-empty sequence of letters, digits and the characters
#                     + - / * = % ? ! . $ _ ~ & ^ < > @ that does not start with
#                     a digit
# ------------------------------------------------------------------------------

# Build lookup table for char->match('\m\C^[a-zA-Z0-9+-/*=%?!.$_~&^<>@]')
def InitIsSimpleSymbolCharNr(): list<bool>
    var lookup_table = []
    var char_nr = 0
    while char_nr < 255
        lookup_table->add(char_nr->nr2char()->match('\m\C^[a-zA-Z0-9+-/*=%?!.$_~&^<>@]') != -1)
        char_nr += 1
    endwhile
    return lookup_table
enddef
const is_simple_symbol_char_nr = InitIsSimpleSymbolCharNr()

def IsStartOfSimpleSymbol(char_nr: number): bool
    # '0'->char2nr() == 48 && '9'->char2nr() == 57
    return is_simple_symbol_char_nr[char_nr] && !(48 <= char_nr && char_nr <= 57)
enddef

def ReadSimpleSymbol(scanner: dict<any>): dict<any>
    if debug | scanner->smt2#scanner#Enforce(scanner.cur_char_nr->IsStartOfSimpleSymbol(), "Not the start of a simple symbol", scanner.pos) | endif

    const start_pos = scanner.pos
    scanner->NextPos()
    while !scanner.at_eof && is_simple_symbol_char_nr[scanner.cur_char_nr]
        scanner->NextPos()
    endwhile
    return Token(token_symbol, start_pos, scanner.chars[start_pos : scanner.pos - 1]->join(''))
enddef

# ------------------------------------------------------------------------------
# <symbol> ::= <simple symbol>
#            | a sequence of whitespace and printable characters that starts
#              and ends with '|' and does not otherwise include '|' or '\'
# ------------------------------------------------------------------------------
# TODO: Allow only printable characters, i.e. ranges [32, 126], [128-255]?
def ReadQuotedSymbol(scanner: dict<any>): dict<any>
    if debug | scanner->smt2#scanner#Enforce(scanner.cur_char == '|', "Not the start of a quoted symbol", scanner.pos) | endif

    const start_pos = scanner.pos
    scanner->NextPos()
    while true
        scanner->smt2#scanner#Enforce(!scanner.at_eof, "unexpected end of quoted symbol", scanner.pos)
        scanner->smt2#scanner#Enforce(scanner.cur_char != '\\', "quoted symbol may not contain '\'", scanner.pos)
        if scanner.cur_char == '|'
            break
        endif
        scanner->NextPos()
    endwhile
    scanner->NextPos()
    return Token(token_symbol, start_pos, scanner.chars[start_pos : scanner.pos - 1]->join(''))
enddef

# ------------------------------------------------------------------------------
# <keyword> ::= :<simple symbol>
# ------------------------------------------------------------------------------
def ReadKeyword(scanner: dict<any>): dict<any>
    if debug | scanner->smt2#scanner#Enforce(scanner.cur_char == ':', "Not the start of a keyword", scanner.pos) | endif

    const start_pos = scanner.pos
    scanner->NextPos()
    while !scanner.at_eof && is_simple_symbol_char_nr[scanner.cur_char_nr]
        scanner->NextPos()
    endwhile
    return Token(token_keyword, start_pos, scanner.chars[start_pos : scanner.pos - 1]->join(''))
enddef
