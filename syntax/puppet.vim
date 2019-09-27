if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'puppet') == -1

" Language:     Puppet
" Maintainer:   Voxpupuli
" URL:          https://github.com/voxpupuli/vim-puppet
"
" Thanks to Doug Kearns who maintains the vim syntax file for Ruby. Many constructs, including interpolation
" and heredoc was copied from ruby and then modified to comply with Puppet syntax.

" Prelude {{{1
if exists("b:current_syntax")
  finish
endif

" this file uses line continuations
let s:cpo_sav = &cpo
set cpo&vim

syn cluster puppetNotTop contains=@puppetExtendedStringSpecial,@puppetRegexpSpecial,@puppetDeclaration,puppetConditional,puppetExceptional,puppetMethodExceptional,puppetTodo

syn match puppetSpaceError display excludenl "\s\+$"
syn match puppetSpaceError display " \+\t"me=e-1

" one character operators
syn match  puppetOperator "[=><+/*%!.|@:,;?~-]"

" two character operators
syn match  puppetOperator "+=\|-=\|==\|!=\|=\~\|!\~\|>=\|<=\|<-\|<\~\|=>\|+>\|->\|\~>\|<<\||>\|@@"

" three character operators
syn match  puppetOperator "<<|\||>>"

syn region puppetBracketOperator matchgroup=puppetDelimiter start="\[\s*" end="\s*]" contains=ALLBUT,@puppetNotTop
syn region puppetBraceOperator matchgroup=puppetDelimiter start="{\s*" end="\s*}" contains=ALLBUT,@puppetNotTop
syn region puppetParenOperator matchgroup=puppetDelimiter start="(\s*" end="\s*)" contains=ALLBUT,@puppetNotTop

" Expression Substitution and Backslash Notation {{{1
syn match puppetStringEscape "\\\\\|\\[abefnrstv]\|\\\o\{1,3}\|\\x\x\{1,2}" contained display
syn match puppetStringEscape "\%(\\M-\\C-\|\\C-\\M-\|\\M-\\c\|\\c\\M-\|\\c\|\\C-\|\\M-\)\%(\\\o\{1,3}\|\\x\x\{1,2}\|\\\=\S\)" contained display
syn match puppetQuoteEscape  "\\[\\']" contained display

syn region puppetInterpolation   matchgroup=puppetInterpolationDelimiter start="${" end="}" contained contains=ALLBUT,@puppetNotTop
syn match  puppetInterpolation   "$\%(::\)\?\w\+"                        display contained contains=puppetInterpolationDelimiter,puppetVariable
syn match  puppetInterpolationDelimiter "$\ze\$\w\+"            display contained
syn match  puppetInterpolation   "$\$\%(-\w\|\W\)"              display contained contains=puppetInterpolationDelimiter,puppetVariable,puppetInvalidVariable
syn match  puppetInterpolationDelimiter "$\ze\$\%(-\w\|\W\)"    display contained
syn region puppetNoInterpolation start="\\${" end="}"	        contained
syn match  puppetNoInterpolation "\\${"		                    display contained
syn match  puppetNoInterpolation "\\$\w\+"                      display contained

syn match puppetDelimiterEscape	"\\[(<{\[)>}\]]" transparent display contained contains=NONE

syn region puppetNestedParentheses    start="("  skip="\\\\\|\\)"  matchgroup=puppetString end=")"	transparent contained
syn region puppetNestedCurlyBraces    start="{"  skip="\\\\\|\\}"  matchgroup=puppetString end="}"	transparent contained
syn region puppetNestedAngleBrackets  start="<"  skip="\\\\\|\\>"  matchgroup=puppetString end=">"	transparent contained
syn region puppetNestedSquareBrackets start="\[" skip="\\\\\|\\\]" matchgroup=puppetString end="\]"	transparent contained

" Regular Expression Metacharacters {{{1
" These are mostly Oniguruma ready
syn region puppetRegexpComment	matchgroup=puppetRegexpSpecial   start="(?#"	skip="\\)"  end=")"  contained
syn region puppetRegexpParens	matchgroup=puppetRegexpSpecial   start="(\(?:\|?<\=[=!]\|?>\|?<[a-z_]\w*>\|?[imx]*-[imx]*:\=\|\%(?#\)\@!\)" skip="\\)"  end=")"  contained transparent contains=@puppetRegexpSpecial
syn region puppetRegexpBrackets	matchgroup=puppetRegexpCharClass start="\[\^\=" skip="\\\]" end="\]" contained transparent contains=puppetStringEscape,puppetRegexpEscape,puppetRegexpCharClass oneline
syn match  puppetRegexpCharClass	"\\[DdHhSsWw]"	       contained display
syn match  puppetRegexpCharClass	"\[:\^\=\%(alnum\|alpha\|ascii\|blank\|cntrl\|digit\|graph\|lower\|print\|punct\|space\|upper\|xdigit\):\]" contained
syn match  puppetRegexpEscape	"\\[].*?+^$|\\/(){}[]" contained
syn match  puppetRegexpQuantifier	"[*?+][?+]\="	       contained display
syn match  puppetRegexpQuantifier	"{\d\+\%(,\d*\)\=}?\=" contained display
syn match  puppetRegexpAnchor	"[$^]\|\\[ABbGZz]"     contained display
syn match  puppetRegexpDot	"\."		       contained display
syn match  puppetRegexpSpecial	"|"		       contained display
syn match  puppetRegexpSpecial	"\\[1-9]\d\=\d\@!"     contained display
syn match  puppetRegexpSpecial	"\\k<\%([a-z_]\w*\|-\=\d\+\)\%([+-]\d\+\)\=>" contained display
syn match  puppetRegexpSpecial	"\\k'\%([a-z_]\w*\|-\=\d\+\)\%([+-]\d\+\)\='" contained display
syn match  puppetRegexpSpecial	"\\g<\%([a-z_]\w*\|-\=\d\+\)>" contained display
syn match  puppetRegexpSpecial	"\\g'\%([a-z_]\w*\|-\=\d\+\)'" contained display

syn cluster puppetStringSpecial	      contains=puppetInterpolation,puppetNoInterpolation,puppetStringEscape
syn cluster puppetExtendedStringSpecial contains=@puppetStringSpecial,puppetNestedParentheses,puppetNestedCurlyBraces,puppetNestedAngleBrackets,puppetNestedSquareBrackets
syn cluster puppetRegexpSpecial	      contains=puppetRegexpSpecial,puppetRegexpEscape,puppetRegexpBrackets,puppetRegexpCharClass,puppetRegexpDot,puppetRegexpQuantifier,puppetRegexpAnchor,puppetRegexpParens,puppetRegexpComment

syn match puppetInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<0[xX]\x\+\%(_\x\+\)*r\=i\=\>" display
syn match puppetInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<\%(0[dD]\)\=\%(0\|[1-9]\d*\%(_\d\+\)*\)r\=i\=\>" display
syn match puppetInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<0[oO]\=\o\+\%(_\o\+\)*r\=i\=\>" display
syn match puppetInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<0[bB][01]\+\%(_[01]\+\)*r\=i\=\>" display
syn match puppetFloat	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<\%(0\|[1-9]\d*\%(_\d\+\)*\)\.\d\+\%(_\d\+\)*r\=i\=\>" display
syn match puppetFloat	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<\%(0\|[1-9]\d*\%(_\d\+\)*\)\%(\.\d\+\%(_\d\+\)*\)\=\%([eE][-+]\=\d\+\%(_\d\+\)*\)r\=i\=\>" display

syn match puppetVariable "$\%(::\)\=\w\+\%(::\w\+\)*" display
syn match puppetName "\%(::\)\=[a-z]\w*\%(::[a-z]\w*\)*" display
syn match puppetType "\%(::\)\=[A-Z]\w*\%(::[A-Z]\w*\)*" display
syn match puppetWord "\%(\%(::\)\=\%(_[\w-]*\w\+\)\|\%([a-z]\%(\w*-\)\+\w\+\)\)\+" display

" bad name containing combinations of segment starting with lower case and segement starting with upper case (or vice versa)
syn match puppetNameBad "\%(::\)\=\%(\w\+::\)*\%(\%([a-z]\w*::[A-Z]\w*\)\|\%([A-Z]\w*::[a-z]\w*\)\)\%(::\w\+\)*" display
syn cluster puppetNameOrType contains=puppetVariable,puppetName,puppetType,puppetWord,puppetNameBad

syn keyword puppetControl  case and or in
syn keyword puppetKeyword  class define inherits node undef function type attr private
syn keyword puppetKeyword  application consumes produces site
syn keyword puppetKeyword  present absent purged latest installed running stopped mounted unmounted role configured file directory link on_failure contained
syn keyword puppetConstant default undef
syn keyword puppetConditional if else elsif unless
syn keyword puppetBoolean  true false

" Core functions
syn match puppetFunction "\<alert\>"
syn match puppetFunction "\<assert_type\>"
syn match puppetFunction "\<binary_file\>"
syn match puppetFunction "\<break\>"
syn match puppetFunction "\<contain\>"
syn match puppetFunction "\<crit\>"
syn match puppetFunction "\<create_resources\>"
syn match puppetFunction "\<debug\>"
syn match puppetFunction "\<defined\>"
syn match puppetFunction "\<dig\>"
syn match puppetFunction "\<each\>"
syn match puppetFunction "\<emerg\>"
syn match puppetFunction "\<epp\>"
syn match puppetFunction "\<err\>"
syn match puppetFunction "\<fail\>"
syn match puppetFunction "\<file\>"
syn match puppetFunction "\<filter\>"
syn match puppetFunction "\<find_file\>"
syn match puppetFunction "\<fqdn_rand\>"
syn match puppetFunction "\<hiera\>"
syn match puppetFunction "\<hiera_array\>"
syn match puppetFunction "\<hiera_hash\>"
syn match puppetFunction "\<hiera_include\>"
syn match puppetFunction "\<import\>"
syn match puppetFunction "\<include\>"
syn match puppetFunction "\<info\>"
syn match puppetFunction "\<inline_epp\>"
syn match puppetFunction "\<lest\>"
syn match puppetFunction "\<lookup\>"
syn match puppetFunction "\<map\>"
syn match puppetFunction "\<match\>"
syn match puppetFunction "\<new\>"
syn match puppetFunction "\<next\>"
syn match puppetFunction "\<notice\>"
syn match puppetFunction "\<realize\>"
syn match puppetFunction "\<reduce\>"
syn match puppetFunction "\<regsubst\>"
syn match puppetFunction "\<require\>"
syn match puppetFunction "\<return\>"
syn match puppetFunction "\<reverse_each\>"
syn match puppetFunction "\<scanf\>"
syn match puppetFunction "\<sha1\>"
syn match puppetFunction "\<shellquote\>"
syn match puppetFunction "\<slice\>"
syn match puppetFunction "\<split\>"
syn match puppetFunction "\<sprintf\>"
syn match puppetFunction "\<step\>"
syn match puppetFunction "\<strftime\>"
syn match puppetFunction "\<tag\>"
syn match puppetFunction "\<tagged\>"
syn match puppetFunction "\<template\>"
syn match puppetFunction "\<then\>"
syn match puppetFunction "\<type\>"
syn match puppetFunction "\<unwrap\>"
syn match puppetFunction "\<versioncmp\>"
syn match puppetFunction "\<warning\>"
syn match puppetFunction "\<with\>"

" Stdlib functions
syn match puppetStdLibFunction "\<abs\>"
syn match puppetStdLibFunction "\<any2array\>"
syn match puppetStdLibFunction "\<any2bool\>"
syn match puppetStdLibFunction "\<assert_private\>"
syn match puppetStdLibFunction "\<base64\>"
syn match puppetStdLibFunction "\<basename\>"
syn match puppetStdLibFunction "\<bool2num\>"
syn match puppetStdLibFunction "\<bool2str\>"
syn match puppetStdLibFunction "\<camelcase\>"
syn match puppetStdLibFunction "\<capitalize\>"
syn match puppetStdLibFunction "\<ceiling\>"
syn match puppetStdLibFunction "\<chomp\>"
syn match puppetStdLibFunction "\<chop\>"
syn match puppetStdLibFunction "\<clamp\>"
syn match puppetStdLibFunction "\<concat\>"
syn match puppetStdLibFunction "\<convert_base\>"
syn match puppetStdLibFunction "\<count\>"
syn match puppetStdLibFunction "\<deep_merge\>"
syn match puppetStdLibFunction "\<defined_with_params\>"
syn match puppetStdLibFunction "\<delete\>"
syn match puppetStdLibFunction "\<delete_at\>"
syn match puppetStdLibFunction "\<delete_regex\>"
syn match puppetStdLibFunction "\<delete_undef_values\>"
syn match puppetStdLibFunction "\<delete_values\>"
syn match puppetStdLibFunction "\<deprecation\>"
syn match puppetStdLibFunction "\<difference\>"
syn match puppetStdLibFunction "\<dig\>"
syn match puppetStdLibFunction "\<dig44\>"
syn match puppetStdLibFunction "\<dirname\>"
syn match puppetStdLibFunction "\<dos2unix\>"
syn match puppetStdLibFunction "\<downcase\>"
syn match puppetStdLibFunction "\<empty\>"
syn match puppetStdLibFunction "\<enclose_ipv6\>"
syn match puppetStdLibFunction "\<ensure_packages\>"
syn match puppetStdLibFunction "\<ensure_resource\>"
syn match puppetStdLibFunction "\<ensure_resources\>"
syn match puppetStdLibFunction "\<flatten\>"
syn match puppetStdLibFunction "\<floor\>"
syn match puppetStdLibFunction "\<fqdn_rand_string\>"
syn match puppetStdLibFunction "\<fqdn_rotate\>"
syn match puppetStdLibFunction "\<get_module_path\>"
syn match puppetStdLibFunction "\<getparam\>"
syn match puppetStdLibFunction "\<getvar\>"
syn match puppetStdLibFunction "\<grep\>"
syn match puppetStdLibFunction "\<has_interface_with\>"
syn match puppetStdLibFunction "\<has_ip_address\>"
syn match puppetStdLibFunction "\<has_ip_network\>"
syn match puppetStdLibFunction "\<has_key\>"
syn match puppetStdLibFunction "\<hash\>"
syn match puppetStdLibFunction "\<intersection\>"
syn match puppetStdLibFunction "\<is_absolute_path\>"
syn match puppetStdLibFunction "\<is_array\>"
syn match puppetStdLibFunction "\<is_bool\>"
syn match puppetStdLibFunction "\<is_domain_name\>"
syn match puppetStdLibFunction "\<is_email_address\>"
syn match puppetStdLibFunction "\<is_float\>"
syn match puppetStdLibFunction "\<is_function_available\>"
syn match puppetStdLibFunction "\<is_hash\>"
syn match puppetStdLibFunction "\<is_integer\>"
syn match puppetStdLibFunction "\<is_ip_address\>"
syn match puppetStdLibFunction "\<is_ipv4_address\>"
syn match puppetStdLibFunction "\<is_ipv6_address\>"
syn match puppetStdLibFunction "\<is_mac_address\>"
syn match puppetStdLibFunction "\<is_numeric\>"
syn match puppetStdLibFunction "\<is_string\>"
syn match puppetStdLibFunction "\<join\>"
syn match puppetStdLibFunction "\<join_keys_to_values\>"
syn match puppetStdLibFunction "\<keys\>"
syn match puppetStdLibFunction "\<load_module_metadata\>"
syn match puppetStdLibFunction "\<loadjson\>"
syn match puppetStdLibFunction "\<loadyaml\>"
syn match puppetStdLibFunction "\<lstrip\>"
syn match puppetStdLibFunction "\<max\>"
syn match puppetStdLibFunction "\<member\>"
syn match puppetStdLibFunction "\<merge\>"
syn match puppetStdLibFunction "\<min\>"
syn match puppetStdLibFunction "\<num2bool\>"
syn match puppetStdLibFunction "\<parsejson\>"
syn match puppetStdLibFunction "\<parseyaml\>"
syn match puppetStdLibFunction "\<pick\>"
syn match puppetStdLibFunction "\<pick_default\>"
syn match puppetStdLibFunction "\<prefix\>"
syn match puppetStdLibFunction "\<private\>"
syn match puppetStdLibFunction "\<pw_hash\>"
syn match puppetStdLibFunction "\<range\>"
syn match puppetStdLibFunction "\<regexpescape\>"
syn match puppetStdLibFunction "\<reject\>"
syn match puppetStdLibFunction "\<reverse\>"
syn match puppetStdLibFunction "\<rstrip\>"
syn match puppetStdLibFunction "\<seeded_rand\>"
syn match puppetStdLibFunction "\<shell_escape\>"
syn match puppetStdLibFunction "\<shell_join\>"
syn match puppetStdLibFunction "\<shell_split\>"
syn match puppetStdLibFunction "\<shuffle\>"
syn match puppetStdLibFunction "\<size\>"
syn match puppetStdLibFunction "\<sort\>"
syn match puppetStdLibFunction "\<squeeze\>"
syn match puppetStdLibFunction "\<str2bool\>"
syn match puppetStdLibFunction "\<str2saltedsha512\>"
syn match puppetStdLibFunction "\<strftime\>"
syn match puppetStdLibFunction "\<strip\>"
syn match puppetStdLibFunction "\<suffix\>"
syn match puppetStdLibFunction "\<swapcase\>"
syn match puppetStdLibFunction "\<time\>"
syn match puppetStdLibFunction "\<to_bytes\>"
syn match puppetStdLibFunction "\<try_get_value\>"
syn match puppetStdLibFunction "\<type\>"
syn match puppetStdLibFunction "\<type3x\>"
syn match puppetStdLibFunction "\<union\>"
syn match puppetStdLibFunction "\<unique\>"
syn match puppetStdLibFunction "\<unix2dos\>"
syn match puppetStdLibFunction "\<upcase\>"
syn match puppetStdLibFunction "\<uriescape\>"
syn match puppetStdLibFunction "\<validate_absolute_path\>"
syn match puppetStdLibFunction "\<validate_array\>"
syn match puppetStdLibFunction "\<validate_augeas\>"
syn match puppetStdLibFunction "\<validate_bool\>"
syn match puppetStdLibFunction "\<validate_cmd\>"
syn match puppetStdLibFunction "\<validate_email_address\>"
syn match puppetStdLibFunction "\<validate_hash\>"
syn match puppetStdLibFunction "\<validate_integer\>"
syn match puppetStdLibFunction "\<validate_ip_address\>"
syn match puppetStdLibFunction "\<validate_ipv4_address\>"
syn match puppetStdLibFunction "\<validate_ipv6_address\>"
syn match puppetStdLibFunction "\<validate_numeric\>"
syn match puppetStdLibFunction "\<validate_re\>"
syn match puppetStdLibFunction "\<validate_slength\>"
syn match puppetStdLibFunction "\<validate_string\>"
syn match puppetStdLibFunction "\<validate_x509_rsa_key_pair\>"
syn match puppetStdLibFunction "\<values\>"
syn match puppetStdLibFunction "\<values_at\>"
syn match puppetStdLibFunction "\<zip\>"

syn match puppetType "\<Any\>"
syn match puppetType "\<Array\>"
syn match puppetType "\<Binary\>"
syn match puppetType "\<Boolean\>"
syn match puppetType "\<Callable\>"
syn match puppetType "\<CatalogEntry\>"
syn match puppetType "\<Class\>"
syn match puppetType "\<Collection\>"
syn match puppetType "\<Data\>"
syn match puppetType "\<Default\>"
syn match puppetType "\<Enum\>"
syn match puppetType "\<Float\>"
syn match puppetType "\<Hash\>"
syn match puppetType "\<Integer\>"
syn match puppetType "\<Iterable\>"
syn match puppetType "\<Iterator\>"
syn match puppetType "\<NotUndef\>"
syn match puppetType "\<Numeric\>"
syn match puppetType "\<Object\>"
syn match puppetType "\<Optional\>"
syn match puppetType "\<Pattern\>"
syn match puppetType "\<Regexp\>"
syn match puppetType "\<Resource\>"
syn match puppetType "\<Runtime\>"
syn match puppetType "\<Scalar\>"
syn match puppetType "\<ScalarData\>"
syn match puppetType "\<SemVer\>"
syn match puppetType "\<SemVerRange\>"
syn match puppetType "\<Sensitive\>"
syn match puppetType "\<String\>"
syn match puppetType "\<Struct\>"
syn match puppetType "\<TimeSpan\>"
syn match puppetType "\<Timestamp\>"
syn match puppetType "\<Tuple\>"
syn match puppetType "\<Type\>"
syn match puppetType "\<TypeAlias\>"
syn match puppetType "\<TypeReference\>"
syn match puppetType "\<TypeSet\>"
syn match puppetType "\<Undef\>"
syn match puppetType "\<Unit\>"
syn match puppetType "\<Variant\>"

syn match puppetType "\<augeas\>"
syn match puppetType "\<computer\>"
syn match puppetType "\<cron\>"
syn match puppetType "\<exec\>"
syn match puppetType "\<file\>"
syn match puppetType "\<filebucket\>"
syn match puppetType "\<group\>"
syn match puppetType "\<host\>"
syn match puppetType "\<interface\>"
syn match puppetType "\<k5login\>"
syn match puppetType "\<macauthorization\>"
syn match puppetType "\<mailalias\>"
syn match puppetType "\<maillist\>"
syn match puppetType "\<mcx\>"
syn match puppetType "\<mount\>"
syn match puppetType "\<nagios_command\>"
syn match puppetType "\<nagios_contact\>"
syn match puppetType "\<nagios_contactgroup\>"
syn match puppetType "\<nagios_host\>"
syn match puppetType "\<nagios_hostdependency\>"
syn match puppetType "\<nagios_hostescalation\>"
syn match puppetType "\<nagios_hostextinfo\>"
syn match puppetType "\<nagios_hostgroup\>"
syn match puppetType "\<nagios_service\>"
syn match puppetType "\<nagios_servicedependency\>"
syn match puppetType "\<nagios_serviceescalation\>"
syn match puppetType "\<nagios_serviceextinfo\>"
syn match puppetType "\<nagios_servicegroup\>"
syn match puppetType "\<nagios_timeperiod\>"
syn match puppetType "\<notify\>"
syn match puppetType "\<package\>"
syn match puppetType "\<resources\>"
syn match puppetType "\<router\>"
syn match puppetType "\<schedule\>"
syn match puppetType "\<scheduled_task\>"
syn match puppetType "\<selboolean\>"
syn match puppetType "\<selmodule\>"
syn match puppetType "\<service\>"
syn match puppetType "\<ssh_authorized_key\>"
syn match puppetType "\<sshkey\>"
syn match puppetType "\<stage\>"
syn match puppetType "\<tidy\>"
syn match puppetType "\<user\>"
syn match puppetType "\<vlan\>"
syn match puppetType "\<whit\>"
syn match puppetType "\<yumrepo\>"
syn match puppetType "\<zfs\>"
syn match puppetType "\<zone\>"
syn match puppetType "\<zpool\>"

" Normal String {{{1
syn region puppetString matchgroup=puppetStringDelimiter start="\"" end="\"" skip="\\\\\|\\\"" contains=@puppetStringSpecial
syn region puppetString matchgroup=puppetStringDelimiter start="'" end="'" skip="\\\\\|\\'" contains=puppetQuoteEscape

" Normal Regular Expression {{{1
syn region puppetRegexp matchgroup=puppetRegexpDelimiter start="\%(\%(^\|\<\%(and\|or\|while\|until\|unless\|if\|elsif\|when\|not\|then\|else\)\|[;\~=!|&(,{[<>?:*+-]\)\s*\)\@<=/" end="/" skip="\\\\\|\\/" contains=@puppetRegexpSpecial
syn region puppetRegexp matchgroup=puppetRegexpDelimiter start="\%(\h\k*\s\+\)\@<=/[ \t=]\@!" end="/" skip="\\\\\|\\/" contains=@puppetRegexpSpecial

" Here Document {{{1
syn region puppetHeredocStart matchgroup=puppetStringDelimiter start=+@(\s*\%("[^"]\+"\|\w\+\)\%(/[nrtsuL$\\]*\)\=)+ end=+$+ oneline contains=ALLBUT,@puppetNotTop

syn region puppetString start=+@(\s*"\z([^"]\+\)"\%(/[nrtsuL$\\]*\)\=+hs=s+2  matchgroup=puppetStringDelimiter end=+^\s*|\=\s*-\=\s*\zs\z1$+ contains=puppetHeredocStart,@puppetStringSpecial keepend
syn region puppetString start=+@(\s*\z(\w\+\)\%(/[nrtsuL$\\]*\)\=+hs=s+2  matchgroup=puppetStringDelimiter end=+^\s*|\=\s*-\=\s*\zs\z1$+ contains=puppetHeredocStart		    keepend

" comments last overriding everything else
syn match   puppetComment       "\s*#.*$" contains=puppetTodo,@Spell
syn region  puppetComment       start="/\*" end="\*/" contains=puppetTodo,@Spell extend
syn keyword puppetTodo          TODO NOTE FIXME XXX BUG HACK contained

" Define the default highlighting.
command -nargs=+ HiLink hi def link <args>

HiLink puppetRegexp               puppetConstant
HiLink puppetStdLibFunction       puppetFunction
HiLink puppetNoInterpolation      puppetString
HiLink puppetFunction             Function
HiLink puppetOperator             Operator
HiLink puppetString               String
HiLink puppetWord                 String
HiLink puppetFloat                Float
HiLink puppetInteger              Number
HiLink puppetBoolean              Boolean
HiLink puppetName                 puppetIdentifier
HiLink puppetNameBad              Error
HiLink puppetVariable             puppetIdentifier
HiLink puppetIdentifier           Identifier
HiLink puppetType                 Type
HiLink puppetConditional          Conditional
HiLink puppetConstant             Constant
HiLink puppetControl              Statement
HiLink puppetKeyword              Keyword
HiLink puppetStringDelimiter      Delimiter
HiLink puppetDelimiter            Delimiter
HiLink puppetTodo                 Todo
HiLink puppetComment              Comment

delcommand HiLink

let b:current_syntax = "puppet"

endif
