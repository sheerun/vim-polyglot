if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'haproxy') == -1

" Vim syntax file
" Language:    HAproxy
" Maintainer:  Dan Reif
" Last Change: Mar 2, 2018
" Version:     0.5
" URL:         https://github.com/CH-DanReif/haproxy.vim

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if version >= 600
  setlocal iskeyword=_,-,a-z,A-Z,48-57
else
  set iskeyword=_,-,a-z,A-Z,48-57
endif


" Escaped chars
syn match   hapEscape    +\\\(\\\| \|n\|r\|t\|#\|x\x\x\)+

" Match whitespace at the end of a line
syn match   hapNothingErr /\s\+\ze\(#.*\)\?$/    contained nextgroup=hapGreedyComment
" Match anything other than whitespace; flag as error if found.  'contained'
" because comments are valid where otherwise only hapNothing is.
syn match   hapNothingErr /\s*\zs[^# \t][^#]*/   contained nextgroup=hapGreedyComment

" Comments
syn match   hapComment   /\(^\|\s\)#.*$/         contains=hapTodo
" `acl foo path_reg hi[#]mom` is an error because [ is unclosed.  (!!!)
syn match   hapGreedyComment /#.*$/              contained containedin=hapAclRemainder contains=hapTodo
syn keyword hapTodo      TODO FIXME XXX          contained

" `daemon#hi mom` is perfectly valid.  :/
syn cluster hapNothing    contains=hapNothingErr,hapGreedyComment

" Case-insensitive matching
syn case ignore

" Sections
syn match   hapSection   /^\s*\(global\|defaults\)/
syn match   hapSection   /^\s*\(backend\|frontend\|listen\|ruleset\|userlist\)/ skipwhite nextgroup=hapSectLabel
syn match   hapSectLabel /\S\+/                                                 skipwhite nextgroup=hapIp1 contained
syn match   hapIp1       /\(\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}\)\?:\d\{1,5}/          nextgroup=hapIp2 contained
syn match   hapIp2       /,\(\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}\)\?:\d\{1,5}/hs=s+1   nextgroup=hapIp2 contained

" Timeouts.  We try to hint towards the use of 'ms' and 's' when
" g:haproxy_guess_ms_sec is set.  We consider the lack of either 'ms' or 's'
" as an error when haproxy_enforce_ms_sec is set.  (HAproxy's default is 'ms',
" but that arguably leads to ambiguity in the config.)
if get(g:, 'haproxy_guess_ms_sec', 1)
  " Timeouts and such specified in ms, where seconds are *allowed*, but are
  " probably a mistake.
  syn match   hapNumberMS  /\d\+m\?s/                                        contained transparent
  syn match   hapError     /\d\+\zss\ze/                                     contained containedin=hapNumberMS
endif
if get(g:, 'haproxy_enforce_ms_sec', 1)
  syn match   hapNumberMS  /\d\+\(m\?s\)\?/                                  contained transparent
  syn match   hapError     /\d\+\(m\?s\)\@!\(\D\|$\)/                        contained containedin=hapNumberMS
  syn match   hapNumberMS  /\d\+m\?s/                                        contained
else
  syn match   hapNumberMS  /\d\+m\?s/                                        contained
endif
if get(g:, 'haproxy_guess_ms_sec', 1)
  " Timeouts generally specified in whole seconds, where we want to highlight
  " errant 'm's.
  syn match   hapNumberSec /\d\+m\?s/                                        contained transparent
  syn match   hapError     /\d\+\zsm\zes/                                    contained containedin=hapNumberSec
endif
if get(g:, 'haproxy_enforce_ms_sec', 1)
  syn match   hapNumberSec /\d\+\(m\?s\)\?/                                  contained transparent
  syn match   hapError     /\d\+\(m\?s\)\@!\(\D\|$\)/                        contained containedin=hapNumberSec
  syn match   hapNumberSec /\d\+m\?s/                                        contained
else
  syn match   hapNumberSec /\d\+m\?s/                                        contained
endif
" Other numbers, no 'ms'.
syn match   hapNumber    /[0-9]\+/                                           contained

" Timeout types
syn keyword hapTimeoutType connect client server                             contained skipwhite nextgroup=hapNumberMS

" URIs
syn match hapAbsURI   /\/\S*/                                                contained
syn match hapURI      /\S*/                                                  contained

" File paths (always absolute, and never just '/' unless you're insane)
syn match hapFilePath /\/\S\+/                                               contained

" SSL configuration keywords
syn match hapSSLCiphersAll   /\s\+\zs.*/                                     contained transparent
syn match hapSSLCiphersError /.\+/                                           contained containedin=hapSSLCiphersAll
syn match hapSSLCiphers      /\([-+!]\?[A-Z0-9-]\+[:+]\)*[-+!]\?[A-Z0-9-]\+/ contained containedin=hapSSLCiphersAll

"
" ACLs
"

" This comes first, lest it gobble up everything else.
syn match hapAclName               /\S\+/               contained skipwhite nextgroup=hapAclCriterion
syn match hapAclCriterion          /FALSE\|HTTP\|HTTP_1\.0\|HTTP_1\.1\|HTTP_CONTENT\|HTTP_URL_ABS\|HTTP_URL_SLASH\|HTTP_URL_STAR\|LOCALHOST\|METH_CONNECT\|METH_GET\|METH_HEAD\|METH_OPTIONS\|METH_POST\|METH_TRACE\|RDP_COOKIE\|REQ_CONTENT\|TRUE\|WAIT_END\|\(req_rdp_cookie\|s\?cook\|s\?hdr\|http_auth_group\|urlp\)\(_\(beg\|dir\|dom\|end\|len\|reg\|sub\|cnt\)\)\?([^)]*)\|\(req_ssl_[a-z]\+\|base\|method\|path\|req_ver\|resp_ver\|url\)\(_\(beg\|dir\|dom\|end\|len\|reg\|sub\|cnt\)\)\?/ contained skipwhite nextgroup=hapAclConverterOrNothing
" This one's a bit tricky.  Match zero or more converters, and then *require* the
" space afterwards.  Strictly speaking, deviates from the BNF, but only in
" pathological cases ('acl lolwat TRUE,upper').
syn match hapAclConverterOrNothing /\(,\(\(base64\|bool\|cpl\|debug\|even\|hex\|lower\|neg\|not\|odd\|upper\|url_dec\)\|\(add\|and\|bytes\|crc32\|da-csv-conv\|div\|djb2\|field\|http_date\|in_table\|ipmask\|json\|language\|ltime\|map\|mod\|mul\|or\|regsub\|capture-req\|capture-res\|sdbm\|sub\|table_[a-z0-9_]\+\|utime\|word\|wt6\|xor\)([^)]*)\)\)*\s\+/ contained nextgroup=hapAclFlag,hapAclFlagWithParameter,hapAclOperator
syn match hapAclFlag               /-[-in]/             contained skipwhite nextgroup=hapAclFlag,hapAclFlagWithParameter,hapAclOperator
syn match hapAclFlagWithParameter  /-[fmMu]/            contained skipwhite nextgroup=hapAclFlagParameter
syn match hapAclFlagParameter      /\S\+/               contained skipwhite nextgroup=hapAclFlag,hapAclFlagWithParameter,hapAclOperator
syn match hapAclOperator           /eq\|ge\|gt\|le\|lt/ contained skipwhite
syn match hapAclRemainder          /.*/                 contained transparent

" Generic tune.ssl
syn match hapParam /tune\.ssl\.[a-z0-9-]\+/
" tune.ssl where we know what follows
syn match hapParam /tune\.ssl\.default-dh-param/  skipwhite nextgroup=hapNumber

syn keyword hapSSLServerVerify none required      contained skipwhite nextgroup=@hapNothing

" Keywords deprecated for at least a decade.  Kill 'em.
syn keyword hapError     cliexp srvexp

" Parameters
syn keyword hapParam     timeout                  skipwhite nextgroup=hapTimeoutType
syn keyword hapParam     chroot pidfile           skipwhite nextgroup=hapFilePath
syn keyword hapParam     clitimeout               skipwhite nextgroup=hapNumberMS
syn keyword hapParam     contimeout               skipwhite nextgroup=hapNumberMS
syn keyword hapParam     daemon debug disabled    skipwhite nextgroup=@hapNothing
syn keyword hapParam     enabled                  skipwhite nextgroup=@hapNothing
syn keyword hapParam     fullconn maxconn         skipwhite nextgroup=hapNumber
syn keyword hapParam     gid                      skipwhite nextgroup=hapNumber
syn keyword hapParam     group
syn keyword hapParam     grace                    skipwhite nextgroup=hapNumberMS
syn keyword hapParam     monitor-uri              skipwhite nextgroup=hapAbsURI
syn keyword hapParam     nbproc                   skipwhite nextgroup=hapNumber
syn keyword hapParam     noepoll nopoll           skipwhite nextgroup=@hapNothing
syn keyword hapParam     quiet                    skipwhite nextgroup=@hapNothing
syn keyword hapParam     redispatch retries       skipwhite nextgroup=hapNumber
" 'add' takes exactly one string, not regexes
syn keyword hapParam     reqadd reqiadd           skipwhite nextgroup=hapOneStringIfUnless
syn keyword hapParam     rspadd rspiadd           skipwhite nextgroup=hapOneStringIfUnless
" All of these take exactly one regexp
syn match   hapParam     /reqi\?\(allow\|del\)/   skipwhite nextgroup=hapOneRegexpIfUnless
syn match   hapParam     /reqi\?\(deny\|pass\)/   skipwhite nextgroup=hapOneRegexpIfUnless
syn match   hapParam     /reqi\?\(tarpit\)/       skipwhite nextgroup=hapOneRegexpIfUnless
syn match   hapParam     /rspi\?\(del\|deny\)/    skipwhite nextgroup=hapOneRegexpIfUnless
" 'rep' is unique in taking two regexes (one search, one replace)
syn keyword hapParam     reqrep reqirep           skipwhite nextgroup=hapRegSearchReplIfUnless
syn keyword hapParam     rsprep rspirep           skipwhite nextgroup=hapRegSearchReplIfUnless
syn keyword hapParam     reqsetbe reqisetbe       skipwhite nextgroup=hapRegexpBE
syn keyword hapParam     server source
syn keyword hapParam     srvtimeout               skipwhite nextgroup=hapNumberMS
syn keyword hapParam     uid ulimit-n             skipwhite nextgroup=hapNumber
syn keyword hapParam     user
syn keyword hapParam     acl                      skipwhite nextgroup=hapAclName
syn keyword hapParam     errorloc                 skipwhite nextgroup=hapStatusURI
syn keyword hapParam     errorloc302 errorloc303  skipwhite nextgroup=hapStatusURI
syn keyword hapParam     default_backend          skipwhite nextgroup=hapSectLabel
syn keyword hapParam     use_backend              skipwhite nextgroup=hapSectLabel
syn keyword hapParam     appsession               skipwhite nextgroup=hapAppSess
syn keyword hapParam     bind                     skipwhite nextgroup=hapIp1
syn keyword hapParam     balance                  skipwhite nextgroup=hapBalance
syn keyword hapParam     cookie                   skipwhite nextgroup=hapCookieNam
syn keyword hapParam     capture                  skipwhite nextgroup=hapCapture
syn keyword hapParam     dispatch                 skipwhite nextgroup=hapIpPort
syn keyword hapParam     source                   skipwhite nextgroup=hapIpPort
syn keyword hapParam     mode                     skipwhite nextgroup=hapMode
syn keyword hapParam     monitor-net              skipwhite nextgroup=hapIPv4Mask
syn keyword hapParam     option                   skipwhite nextgroup=hapOption
syn keyword hapParam     stats                    skipwhite nextgroup=hapStats
syn keyword hapParam     server                   skipwhite nextgroup=hapServerN
syn keyword hapParam     source                   skipwhite nextgroup=hapServerEOL
syn keyword hapParam     log                      skipwhite nextgroup=hapGLog,hapLogIp,hapFilePath
syn keyword hapParam     ca-base                  skipwhite nextgroup=hapFilePath
syn keyword hapParam     crt-base                 skipwhite nextgroup=hapFilePath
syn keyword hapParam     ssl-default-bind-ciphers skipwhite nextgroup=hapSSLCiphersAll
syn keyword hapParam     ssl-default-bind-options skipwhite nextgroup=hapGLog,hapLogIp
syn keyword hapParam     ssl-server-verify        skipwhite nextgroup=hapSSLServerVerify
syn keyword hapParam     errorfile                skipwhite nextgroup=hapStatusPath
syn keyword hapParam     http-request             skipwhite nextgroup=hapHttpRequestVerb
" Transparent is a Vim keyword, so we need a regexp to match it
syn match   hapParam     /transparent/

" Options and additional parameters
syn keyword hapAppSess   len timeout                                                   contained
syn keyword hapBalance   roundrobin source                                             contained
syn keyword hapLen       len                                                           contained
syn keyword hapGLog      global                                                        contained
syn keyword hapMode      http tcp health                                               contained
syn keyword hapOption    abortonclose allbackups checkcache clitcpka dontlognull       contained
syn keyword hapOption    forceclose forwardfor http-server-close                       contained
syn keyword hapOption    httpchk httpclose httplog keepalive logasap                   contained
syn keyword hapOption    persist srvtcpka ssl-hello-chk                                contained
syn keyword hapOption    tcplog tcpka tcpsplice                                        contained
syn keyword hapOption    except                                                        contained skipwhite nextgroup=hapIPv4Mask
" Transparent is a Vim keyword, so we need a regexp to match it
syn match   hapOption    /transparent/                                                 contained
syn keyword hapStats     realm auth scope enable                                       contained
syn keyword hapStats     uri                                                           contained skipwhite nextgroup=hapAbsURI
syn keyword hapStats     socket                                                        contained skipwhite nextgroup=hapFilePath
syn keyword hapStats     timeout                                                       contained skipwhite nextgroup=hapNumberMS
syn keyword hapLogFac    kern user mail daemon auth syslog lpr news                    contained skipwhite nextgroup=hapLogLvl
syn keyword hapLogFac    uucp cron auth2 ftp ntp audit alert cron2                     contained skipwhite nextgroup=hapLogLvl
syn keyword hapLogFac    local0 local1 local2 local3 local4 local5 local6 local7       contained skipwhite nextgroup=hapLogLvl
syn keyword hapLogLvl    emerg alert crit err warning notice info debug                contained
syn keyword hapCookieKey rewrite insert nocache postonly indirect prefix               contained skipwhite nextgroup=hapCookieKey
syn keyword hapCapture   cookie                                                        contained skipwhite nextgroup=hapNameLen
syn keyword hapCapture   request response                                              contained skipwhite nextgroup=hapHeader
syn keyword hapHeader    header                                                        contained skipwhite nextgroup=hapNameLen
syn keyword hapSrvKey    backup cookie check inter rise fall port                      contained
syn keyword hapSrvKey    source minconn maxconn weight usesrc                          contained
syn match   hapStatus    /\d\{3}/                                                      contained
syn match   hapStatusPath /\d\{3}/                                                     contained skipwhite nextgroup=hapFilePath
syn match   hapStatusURI /\d\{3}/                                                      contained skipwhite nextgroup=hapURI
syn match   hapIPv4Mask  /\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}\(\/\d\{1,2}\)\?/      contained
syn match   hapLogIp     /\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}/                      contained skipwhite nextgroup=hapLogFac
syn match   hapIpPort    /\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}:\d\{1,5}/             contained
syn match   hapServerAd  /\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}\(:[+-]\?\d\{1,5}\)\?/ contained skipwhite nextgroup=hapSrvEOL
syn match   hapNameLen   /\S\+/                                                        contained skipwhite nextgroup=hapLen
syn match   hapCookieNam /\S\+/                                                        contained skipwhite nextgroup=hapCookieKey
syn match   hapServerN   /\S\+/                                                        contained skipwhite nextgroup=hapServerAd
syn region  hapSrvEOL    start=/\S/ end=/$/                         contains=hapSrvKey contained

" Brutally stolen from https://github.com/vim-perl/vim-perl:
syn match   hapPerlSpecialMatch "\\\%(\o\{1,3}\|x\%({\x\+}\|\x\{1,2}\)\|c.\|[^cx]\)" contained extend
syn match   hapPerlSpecialMatch "\\." extend contained contains=NONE
syn match   hapPerlSpecialMatch "\\\\" contained
syn match   hapPerlSpecialMatch "\\[1-9]" contained extend
syn match   hapPerlSpecialMatch "\\g\%(\d\+\|{\%(-\=\d\+\|\h\w*\)}\)" contained
syn match   hapPerlSpecialMatch "\\k\%(<\h\w*>\|'\h\w*'\)" contained
syn match   hapPerlSpecialMatch "{\d\+\%(,\%(\d\+\)\=\)\=}" contained
syn match   hapPerlSpecialMatch "\[[]-]\=[^\[\]]*[]-]\=\]" contained extend
syn match   hapPerlSpecialMatch "[+*()?.]" contained
syn match   hapPerlSpecialMatch "(?[#:=!]" contained
syn match   hapPerlSpecialMatch "(?[impsx]*\%(-[imsx]\+\)\=)" contained
syn match   hapPerlSpecialMatch "(?\%([-+]\=\d\+\|R\))" contained
syn match   hapPerlSpecialMatch "(?\%(&\|P[>=]\)\h\w*)" contained

syn region  hapOneRegexpIfUnless     contained start=/\S/ end=/\(\ze\s\|$\)/ skip=/\\ / contains=hapPerlSpecialMatch nextgroup=hapIfUnless,@hapNothing skipwhite
syn region  hapRegSearchReplIfUnless contained start=/\S/ end=/\(\s\|$\)/    skip=/\\ / contains=hapPerlSpecialMatch nextgroup=hapRegReplIfUnless      skipwhite
syn region  hapRegReplIfUnless       contained start=/\S/ end=/$/  contains=hapComment,hapEscape,hapPerlSpecialMatch nextgroup=hapIfUnless             skipwhite
syn region  hapRegexpBE              contained start=/\S/ end=/\(\s\|$\)/    skip=/\\ / contains=hapPerlSpecialMatch nextgroup=hapSectLabel            skipwhite

"
" http-request
"
" http-request verbs that don't allow parameters
syn keyword hapHttpRequestVerb  allow tarpit silent-drop                               contained skipwhite nextgroup=hapHttpIfUnless
" http-request verbs with optional parameters
syn keyword hapHttpRequestVerb  auth deny                                              contained skipwhite nextgroup=hapHttpIfUnless,hapHttpRequestParam
" http-request verbs with required parameters
syn keyword hapHttpRequestVerb  redirect add-header set-header capture                 contained skipwhite nextgroup=hapHttpRequestParam
syn keyword hapHttpRequestVerb  del-header set-nice set-log-level replace-header       contained skipwhite nextgroup=hapHttpRequestParam
syn keyword hapHttpRequestVerb  replace-value set-method set-path set-query            contained skipwhite nextgroup=hapHttpRequestParam
syn keyword hapHttpRequestVerb  set-uri set-tos set-mark                               contained skipwhite nextgroup=hapHttpRequestParam
" http-request verbs with both parenthetical arguments and required parameters
syn match   hapHttpRequestVerb  /\(add-acl\|del-acl\|del-map\|set-map\)([^)]*)/        contained skipwhite nextgroup=hapHttpRequestParam
syn match   hapHttpRequestVerb  /\(set-var\|unset-var\)([^)]*)/                        contained skipwhite nextgroup=hapHttpRequestParam
syn match   hapHttpRequestVerb  /\(sc-inc-gpc0\|sc-set-gpt0\)([^)]*)/                  contained skipwhite nextgroup=hapHttpRequestParam
" http-request verbs with parenthetical arguments, but without parameters
syn match   hapHttpRequestVerb  /\(unset-var\|sc-inc-gpc0\)([^)]*)/                    contained skipwhite nextgroup=hapHttpIfUnless

" Listed first because we want to match this rather than hapHttpRequestParam,
" which can be just about anything (including these two keywords).  'keyword'
" is actually higher priority inside the highlighter, but we'll play it extra
" safe by doing this ordering trick, too.
syn keyword hapIfUnless         if unless                                              contained skipwhite nextgroup=hapIfUnlessCond

" A little bit of fancy footwork here, because we want to match the log-format
" parameters inside of the string separately.
syn match   hapHttpRequestParam /|S\+/                  contained skipwhite nextgroup=hapIfUnless,hapHttpRequestParam transparent
syn match   hapHttpLogFormatStr /%\[[^][]\+\]/          contained containedin=hapHttpRequestParam
syn match   hapHttpLogFormatErr /%\(\[[^][]\+\]\)\@!.*/ contained containedin=hapHttpRequestParam
syn match   hapHttpRequestParamLiteral /[^%]\+/         contained containedin=hapHttpRequestParam


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version < 508
  command -nargs=+ HiLink hi link <args>
else
  command -nargs=+ HiLink hi def link <args>
endif

HiLink hapError                   Error
HiLink hapNothingErr              hapError
HiLink hapEscape                  SpecialChar
HiLink hapComment                 Comment
HiLink hapGreedyComment           Comment
HiLink hapTodo                    Todo
HiLink hapSection                 Underlined
HiLink hapSectLabel               Identifier
HiLink hapParam                   Keyword
HiLink hapSSLCiphers              String
HiLink hapSSLCiphersError         Error
HiLink hapTimeoutType             hapParam

HiLink hapOneRegexpIfUnless       String
HiLink hapTwoRegexpsIfUnless      hapRegexp
HiLink hapRegReplIfUnless         hapRegexp
HiLink hapRegexpBE                hapRegexp
HiLink hapPerlSpecialMatch        Special
HiLink hapFilePath                String
HiLink hapURI                     String
HiLink hapAbsURI                  hapURI
HiLink hapIp1                     Number
HiLink hapIp2                     hapIp1
HiLink hapLogIp                   hapIp1
HiLink hapIpPort                  hapIp1
HiLink hapIPv4Mask                hapIp1
HiLink hapServerAd                hapIp1
HiLink hapStatus                  Number
HiLink hapStatusPath              hapStatus
HiLink hapStatusURI               hapStatus
HiLink hapNumber                  Number
HiLink hapNumberMS                hapNumber
HiLink hapNumberSec               hapNumber

HiLink hapAclName                 Identifier
HiLink hapAclCriterion            String
HiLink hapAclConverterOrNothing   Special
HiLink hapAclFlag                 Special
HiLink hapAclFlagWithParameter    Special
HiLink hapAclFlagParameter        String
HiLink hapAclOperator             Operator
HiLink hapAclPattern              String

HiLink hapHttpRequestVerb         Operator
HiLink hapIfUnless            Operator
HiLink hapHttpRequestParamLiteral String
HiLink hapHttpLogFormatStr        Special
HiLink hapHttpLogFormatErr        Error

HiLink hapOption                  Operator
HiLink hapAppSess                 hapOption
HiLink hapBalance                 hapOption
HiLink hapCapture                 hapOption
HiLink hapCookieKey               hapOption
HiLink hapHeader                  hapOption
HiLink hapGLog                    hapOption
HiLink hapLogFac                  hapOption
HiLink hapLogLvl                  hapOption
HiLink hapMode                    hapOption
HiLink hapStats                   hapOption
HiLink hapLen                     hapOption
HiLink hapSrvKey                  hapOption


delcommand HiLink

let b:current_syntax = "haproxy"
" vim: ts=8

endif
