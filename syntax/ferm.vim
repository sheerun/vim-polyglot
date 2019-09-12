if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ferm') == -1

"============================================================================
" ferm syntax highlighter
"
" Language:    ferm; "For Easy Rule Making", a frontend for iptables
" Ferm Info:   http://ferm.foo-projects.org/ 
" Version:     0.03
" Date:        2013-01-09
" Maintainer:  Benjamin Leopold <benjamin-at-cometsong-dot-net>
" URL:         http://github.com/cometsong/ferm.vim
" Credits:     Modeled after Eric Haarbauer's iptables syntax file.
"
"============================================================================
" Section:  Initialization  {{{1
"============================================================================

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'ferm'
endif

" Don't use standard HiLink, it will not work with included syntax files
if version < 508
  command! -nargs=+ FermHiLink highlight link <args>
else
  command! -nargs=+ FermHiLink highlight default link <args>
endif

syntax case match

if version < 600
    set iskeyword+=-
else
    setlocal iskeyword+=-
endif

" Initialize global public variables:  {{{2

" Support deprecated variable name used prior to release 1.07.
if exists("g:fermSpecialDelimiters") &&
\ !exists("g:Ferm_SpecialDelimiters")

    let   g:Ferm_SpecialDelimiters = g:fermSpecialDelimiters
    unlet g:fermSpecialDelimiters
    " echohl WarningMsg | echo "Warning:" | echohl None
    " echo "The g:fermSpecialDelimiters variable is deprecated."
    " echo "Please use g:Ferm_SpecialDelimiters in your .vimrc instead"

endif

if exists("g:Ferm_SpecialDelimiters")
    let s:Ferm_SpecialDelimiters = g:Ferm_SpecialDelimiters
else
    let s:Ferm_SpecialDelimiters = 0
endif

"============================================================================
" Section:  Syntax Definitions  {{{1
"============================================================================

syntax keyword fermLocation domain table chain policy @subchain

syntax keyword fermMatch interface outerface protocol proto
    \ saddr daddr fragment sport dport syn module mod

syntax keyword fermBuiltinChain
    \ INPUT OUTPUT FORWARD PREROUTING POSTROUTING

syntax match fermInterface "[eth|ppp]\d"

syntax keyword fermTable filter nat mangle raw

" TODO: check the use of duplicate terms in two syntax defs; then enable (arp|eb) tables.
"syntax keyword fermArpTables source-ip destination-ip source-mac destination-mac
    "\ interface outerface h-length opcode h-type proto-type 
    "\ mangle-ip-s mangle-ip-d mangle-mac-s mangle-mac-d mangle-target
"syntax keyword fermEbTables proto interface outerface logical-in logical-out saddr daddr 
    "\ 802.3 arp ip mark_m pkttype stp vlan log

syntax keyword fermTarget
    \ ACCEPT DROP QUEUE RETURN BALANCE CLASSIFY CLUSTERIP CONNMARK
    \ CONNSECMARK CONNTRACK DNAT DSCP ECN HL IPMARK IPV4OPSSTRIP LOG
    \ MARK MASQUERADE MIRROR NETMAP NFLOG NFQUEUE NOTRACK REDIRECT REJECT
    \ ROUTE SAME SECMARK SET SNAT TARPIT TCPMSS TOS TRACE TTL ULOG XOR

syntax keyword fermModuleName contained
    \ account addrtype ah childlevel comment condition connbytes connlimit
    \ connmark connrate conntrack dccp dscp dstlimit ecn esp fuzzy hashlimit
    \ helper icmp iprange ipv4options length limit lo mac mark mport multiport
    \ nth osf owner physdev pkttype policy psd quota random realm recent
    \ sctp set state string tcp tcpmss time tos ttl u32 udp unclean

syntax keyword fermModuleType
    \ UNSPEC UNICAST LOCAL BROADCAST ANYCAST MULTICAST BLACKHOLE UNREACHABLE
    \ PROHIBIT THROW NAT XRESOLVE INVALID ESTABLISHED NEW RELATED SYN ACK FIN
    \ RST URG PSH ALL NONE

" From --reject-with option
syntax keyword fermModuleType
    \ icmp-net-unreachable
    \ icmp-host-unreachable
    \ icmp-port-unreachable
    \ icmp-proto-unreachable
    \ icmp-net-prohibited
    \ icmp-host-prohibited
    \ icmp-admin-prohibited

" From --icmp-type option
syntax keyword fermModuleType
    \ any
    \ echo-reply
    \ destination-unreachable
    \    network-unreachable
    \    host-unreachable
    \    protocol-unreachable
    \    port-unreachable
    \    fragmentation-needed
    \    source-route-failed
    \    network-unknown
    \    host-unknown
    \    network-prohibited
    \    host-prohibited
    \    TOS-network-unreachable
    \    TOS-host-unreachable
    \    communication-prohibited
    \    host-precedence-violation
    \    precedence-cutoff
    \ source-quench
    \ redirect
    \    network-redirect
    \    host-redirect
    \    TOS-network-redirect
    \    TOS-host-redirect
    \ echo-request
    \ router-advertisement
    \ router-solicitation
    \ time-exceeded
    \    ttl-zero-during-transit
    \    ttl-zero-during-reassembly
    \ parameter-problem
    \    ip-header-bad
    \    required-option-missing
    \ timestamp-request
    \ timestamp-reply
    \ address-mask-request
    \ address-mask-reply

" TODO: check ferm "$variable" & "&function" character matches
syntax match fermVariable "$[_A-Za-z0-9]+"
syntax keyword fermVarDefine @def 

syntax keyword fermFunction @if @else @include @hook
    \ @eq @ne @not @resolve @cat @substr @length
    \ @basename @dirname @ipfilter

syntax keyword fermUserFunction "&[_A-Za-z0-9]+" 

syntax region fermString start=+"+ skip=+\\"+ end=+"+
syntax region fermString start=+'+ skip=+\\'+ end=+'+

syntax region fermCommand start=+`+ skip=+\\'+ end=+`+

syntax match fermComment    "#.*"

"============================================================================
" Section:  Group Linking  {{{1
"============================================================================

FermHiLink  fermLocation        Title
FermHiLink  fermMatch           Special
FermHiLink  fermTable           ErrorMsg
FermHiLink  fermBuiltinChain    Underlined
FermHiLink  fermTarget          Statement
FermHiLink  fermFunction        Identifier
FermHiLink  fermUserFunction    Function
FermHiLink  fermModuleName      PreProc
FermHiLink  fermModuleType      Type
FermHiLink  fermVarDefine       PreProc
FermHiLink  fermVariable        Operator
FermHiLink  fermString          Constant
FermHiLink  fermCommand         Identifier
FermHiLink  fermComment         Comment

"============================================================================
" Section:  Clean Up    {{{1
"============================================================================

delcommand FermHiLink

let b:current_syntax = "ferm"

if main_syntax == 'ferm'
  unlet main_syntax
endif

" Autoconfigure vim indentation settings
" vim:ts=4:sw=4:sts=4:fdm=marker:iskeyword+=-


endif
