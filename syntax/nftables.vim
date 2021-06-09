if polyglot#init#is_disabled(expand('<sfile>:p'), 'nftables', 'syntax/nftables.vim')
  finish
endif

if exists('b:current_syntax')
    finish
endif

syn match nftablesSet /{.*}/ contains=nftablesSetEntry
syn match nftablesSetEntry /[a-zA-Z0-9]\+/ contained
hi def link nftablesSet Keyword
hi def link nftablesSetEntry Operator

syn match nftablesNumber "\<[0-9A-Fa-f./:]\+\>" contains=nftablesMask,nftablesDelimiter
syn match nftablesHex "\<0x[0-9A-Fa-f]\+\>"
syn match nftablesDelimiter "[./:]" contained
syn match nftablesMask "/[0-9.]\+" contained contains=nftablesDelimiter
hi def link nftablesNumber Number
hi def link nftablesHex Number
hi def link nftablesDelimiter Operator
hi def link nftablesMask Operator

syn region Comment start=/#/ end=/$/
syn region String start=/"/ end=/"/
syn keyword Function flush
syn keyword Function table chain map
syn keyword Statement type hook
syn keyword Type ip ip6 inet arp bridge
syn keyword Type filter nat route
syn keyword Type ether vlan arp ip icmp igmp ip6 icmpv6 tcp udp udplite sctp dccp ah esp comp icmpx
syn keyword Type ct
syn keyword Type length protocol priority mark iif iifname iiftype oif oifname oiftype skuid skgid rtclassid
syn keyword Constant prerouting input forward output postrouting

syn keyword Special snat dnat masquerade redirect
syn keyword Special accept drop reject queue
syn keyword Keyword continue return jump goto
syn keyword Keyword counter log limit
syn keyword Keyword define

let b:current_syntax = 'nftables'
