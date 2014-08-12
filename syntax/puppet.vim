" puppet syntax file
" Filename:     puppet.vim
" Language:     puppet configuration file
" Maintainer:   Luke Kanies <luke@madstop.com>
" URL:
" Last Change:
" Version:
"

" Copied from the cfengine, ruby, and perl syntax files
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" match class/definition/node declarations
syn region  puppetDefine        start="^\s*\(class\|define\|node\)\s" end="{" contains=puppetDefType,puppetDefName,puppetDefArguments,puppetNodeRe,@NoSpell
syn keyword puppetDefType       class define node inherits contained
syn region  puppetDefArguments  start="(" end=")" contained contains=puppetArgument,puppetString,puppetComment,puppetMultilineComment
syn match   puppetArgument      "\w\+" contained
syn match   puppetArgument      "\$\w\+" contained
syn match   puppetArgument      "'[^']+'" contained
syn match   puppetArgument      '"[^"]+"' contained
syn match   puppetDefName       "\w\+" contained
syn match   puppetNodeRe        "/.*/" contained

" match 'foo' in 'class foo { ...'
" match 'foo::bar' in 'class foo::bar { ...'
" match 'Foo::Bar' in 'Foo::Bar["..."]
"FIXME: "Foo-bar" doesn't get highlighted as expected, although "foo-bar" does.
syn match   puppetInstance      "[A-Za-z0-9_-]\+\(::[A-Za-z0-9_-]\+\)*\s*{" contains=puppetTypeName,puppetTypeDefault,@NoSpell
syn match   puppetInstance      "[A-Z][a-z_-]\+\(::[A-Z][a-z_-]\+\)*\s*[[{]" contains=puppetTypeName,puppetTypeDefault,@NoSpell
syn match   puppetInstance      "[A-Z][a-z_-]\+\(::[A-Z][a-z_-]\+\)*\s*<\?<|" contains=puppetTypeName,puppetTypeDefault,@NoSpell
syn match   puppetTypeName      "[a-z]\w*" contained
syn match   puppetTypeDefault   "[A-Z]\w*" contained

syn match   puppetParam           "\w\+\s*\(=\|+\)>" contains=puppetTypeRArrow,puppetParamName
syn match   puppetParamRArrow       "\(=\|+\)>" contained
syn match   puppetParamName       "\w\+" contained contains=@NoSpell
syn match   puppetVariable           "$\(\(\(::\)\?\w\+\)\+\|{\(\(::\)\?\w\+\)\+}\)"
syn match   puppetParen           "("
syn match   puppetParen           ")"
syn match   puppetBrace           "{"
syn match   puppetBrace           "}"
syn match   puppetBrack           "\["
syn match   puppetBrack           "\]"
syn match   puppetBrack           "<|"
syn match   puppetBrack           "|>"

" match 'present' in 'ensure => present'
" match '2755' in 'mode => 2755'
" don't match 'bar' in 'foo => bar'
syn match   puppetParam         "\w\+\s*[=+]>\s*[a-z0-9]\+" contains=puppetParamString,puppetParamName
syn match   puppetParamString   "[=+]>\s*\w\+" contains=puppetParamKeyword,puppetParamSpecial,puppetParamDigits contained
syn keyword puppetParamKeyword  present absent purged latest installed running stopped mounted unmounted role configured file directory link contained
syn keyword puppetParamSpecial  true false undef contained
syn match   puppetParamDigits   "[0-9]\+"

" match 'template' in 'content => template("...")'
syn match   puppetParam         "\w\+\s*[=+]>\s*\w\+\s*(" contains=puppetFunction,puppetParamName
" statements
syn region  puppetFunction      start="^\s*\(alert\|crit\|debug\|emerg\|err\|fail\|include\|info\|notice\|realize\|require\|search\|tag\|warning\)\s*(" end=")" contained contains=puppetString
" rvalues
syn region  puppetFunction      start="^\s*\(defined\|file\|fqdn_rand\|generate\|inline_template\|regsubst\|sha1\|shellquote\|split\|sprintf\|tagged\|template\|versioncmp\)\s*(" end=")" contained contains=puppetString

syn match   puppetVariable      "$[a-zA-Z0-9_:]\+" contains=@NoSpell
syn match   puppetVariable      "${[a-zA-Z0-9_:]\+}" contains=@NoSpell

" match anything between simple/double quotes.
" don't match variables if preceded by a backslash.
syn region  puppetString        start=+'+ skip=+\\\\\|\\'+ end=+'+
syn region  puppetString        start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=puppetVariable,puppetNotVariable
syn match   puppetNotVariable   "\\$\w\+" contained
syn match   puppetNotVariable   "\\${\w\+}" contained

syn keyword puppetKeyword       import inherits include require contains
syn keyword puppetControl       case default if else elsif
syn keyword puppetSpecial       true false undef

syn match   puppetClass         "[A-Za-z0-9_-]\+\(::[A-Za-z0-9_-]\+\)\+" contains=@NoSpell

" Match the Regular Expression type
" XXX: Puppet does not currently support a few features available in the
" full Ruby Regexp class, namely, interpolation, lookbehind and named
" sub-expressions.  Matches for these features are included in the
" commented-out versions of puppetRegexParen and puppetRegexSubName,
" plus the supporting groups puppetRegexAngBrack and puppetRegexTick.
syn region  puppetRegex            start="/" skip="\\/" end="/" contains=puppetRegexParen,puppetRegexBrace,puppetRegexOrpuppetRegexBrack,puppetRegexComment
syn match   puppetRegexParen       "(\(?\([imx]\{0,4}:\|[=!]\)\)\?" contains=puppetRegexSpecChar,puppetRegexSubName contained
"syn match   puppetRegexParen       "(\(?\([imxo]\{0,4}:\|['<][[:alnum:]]\+[>']\|<?[=!]\)\)\?" contains=puppetRegexSpecChar,puppetRegexSubName contained
syn match   puppetRegexParen       ")" contained
syn match   puppetRegexBrace       "{" contained
syn match   puppetRegexBrace       "}" contained
syn match   puppetRegexBrack       "\[" contained
syn match   puppetRegexBrack       "\]" contained
"syn match   puppetRegexAngBrack    "<" contained
"syn match   puppetRegexAngBrack    ">" contained
"syn match   puppetRegexTick        +'+ contained
syn match   puppetRegexOr          "|" contained
"syn match   puppetRegexSubName     "['<][[:alnum:]]\+[>']" contains=puppetRegexAngBrack,puppetRegexTick contained
syn match   puppetRegexSpecialChar "[?:imx]\|\(<?[=!]\)" contained
syn region  puppetRegexComment     start="(?#" skip="\\)" end=")" contained

" comments last overriding everything else
syn match   puppetComment            "\s*#.*$" contains=puppetTodo,@Spell
syn region  puppetMultilineComment  start="/\*" end="\*/" contains=puppetTodo,@Spell
syn keyword puppetTodo               TODO NOTE FIXME XXX BUG HACK contained
syn keyword puppetTodo               TODO: NOTE: FIXME: XXX: BUG: HACK: contained

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_puppet_syn_inits")
  if version < 508
    let did_puppet_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink puppetVariable             Identifier
  HiLink puppetType                 Identifier
  HiLink puppetKeyword              Keyword
  HiLink puppetComment              Comment
  HiLink puppetMultilineComment     Comment
  HiLink puppetString               String
  HiLink puppetRegex                Constant
  HiLink puppetRegexParen           Delimiter
  HiLink puppetRegexBrace           Delimiter
  HiLink puppetRegexBrack           Delimiter
  HiLink puppetRegexAngBrack        Delimiter
  HiLink puppetRegexTick            Delimiter
  HiLink puppetRegexOr              Delimiter
  HiLink puppetRegexSubName         Identifier
  HiLink puppetRegexSpecChar        SpecialChar
  HiLink puppetRegexComment         Comment
  HiLink puppetParamKeyword         Keyword
  HiLink puppetParamDigits          String
  HiLink puppetNotVariable          String
  HiLink puppetParamSpecial         Boolean
  HiLink puppetSpecial              Special
  HiLink puppetTodo                 Todo
  HiLink puppetBrack                Delimiter
  HiLink puppetTypeBrack            Delimiter
  HiLink puppetBrace                Delimiter
  HiLink puppetTypeBrace            Delimiter
  HiLink puppetParen                Delimiter
  HiLink puppetDelimiter            Delimiter
  HiLink puppetControl              Statement
  HiLink puppetDefType              Define
  HiLink puppetDefName              Type
  HiLink puppetNodeRe               Type
  HiLink puppetTypeName             Statement
  HiLink puppetTypeDefault          Type
  HiLink puppetParamName            Identifier
  HiLink puppetArgument             Identifier
  HiLink puppetFunction             Function
  HiLink puppetClass                Include

  delcommand HiLink
endif

let b:current_syntax = "puppet"
