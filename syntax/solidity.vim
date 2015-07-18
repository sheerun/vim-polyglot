if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'solidity') == -1
  
" Vim syntax file
" Language:     Solidity
" Maintainer:   Tomlion (qycpublic@gmail.com)
" URL:          https://github.com/tomlion/vim-solidity

if exists("b:current_syntax")
  finish
endif

" basic
syn keyword solKeyword           break case const continue default delete do else for if in mapping
syn keyword solKeyword           new private public return returns struct switch this var while constant
syn keyword solKeyword           modifier suicide
syn keyword solConstant          true false wei szabo finny ether
syn keyword solBuiltinType       mapping real string text msg block tx ureal address bool bytes
syn keyword solBuiltinType       int int8 int16 int24 int32 int40 int48 int56 int64 int72 int80 int88 int96 int104 int112 int120 int128 int136 int144 int152 int160 int168 int178 int184 int192 int200 int208 int216 int224 int232 int240 int248 int256
syn keyword solBuiltinType       uint uint8 uint16 uint24 uint32 uint40 uint48 uint56 uint64 uint72 uint80 uint88 uint96 uint104 uint112 uint120 uint128 uint136 uint144 uint152 uint160 uint168 uint178 uint184 uint192 uint200 uint208 uint216 uint224 uint232 uint240 uint248 uint256
syn keyword solBuiltinType       hash hash8 hash16 hash24 hash32 hash40 hash48 hash56 hash64 hash72 hash80 hash88 hash96 hash104 hash112 hash120 hash128 hash136 hash144 hash152 hash160 hash168 hash178 hash184 hash192 hash200 hash208 hash216 hash224 hash232 hash240 hash248 hash256
syn keyword solBuiltinType       string1 string2 string3 string4 string5 string6 string7 string8 string9 string10 string11 string12 string13 string14 string15 string16 string17 string18 string19 string20 string21 string22 string23 string24 string25 string26 string27 string28 string29 string30 string31 string32
syn keyword solBuiltinType       bytes1 bytes2 bytes3 bytes4 bytes5 bytes6 bytes7 bytes8 bytes9 bytes10 bytes11 bytes12 bytes13 bytes14 bytes15 bytes16 bytes17 bytes18 bytes19 bytes20 bytes21 bytes22 bytes23 bytes24 bytes25 bytes26 bytes27 bytes28 bytes29 bytes30 bytes31 bytes32

hi def link solKeyword           Keyword
hi def link solConstant          Constant
hi def link solBuiltinType       Type

syn match   solOperator          /\(!\||\|&\|+\|-\|<\|>\|=\|%\|\/\|*\|\~\|\^\)/
syn match   solNumber            /\<-\=\d\+L\=\>\|\<0[xX]\x\+\>/
syn match   solFloat             /\<-\=\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%([eE][+-]\=\d\+\)\=\>/
syn region  solString            start=+"+  skip=+\\\\\|\\$"+  end=+"+
syn region  solString            start=+'+  skip=+\\\\\|\\$'+  end=+'+

hi def link solOperator          Operator
hi def link solNumber            Number
hi def link solFloat             Float
hi def link solString            String

" Function
syn match   solFunction          /\<function\>/ nextgroup=solFuncName,solFuncArgs skipwhite
syn match   solFuncName          contained /\<[a-zA-Z_$][0-9a-zA-Z_$]*/ nextgroup=solFuncArgs skipwhite
syn region  solFuncArgs          contained matchgroup=solFuncParens start='(' end=')' contains=solFuncArgCommas,solBuiltinType nextgroup=solFuncBlock,solFuncModifier keepend skipwhite skipempty
syn match   solFuncModifier      contained /\<[a-zA-Z_$][0-9a-zA-Z_$]*/ skipwhite
syn match   solFuncArgCommas     contained ','

hi def link solFunction          Type
hi def link solFuncName          Function
hi def link solFuncModifier      Function

" Contract
syn match   solContract          /\<contract\>/ nextgroup=solContractName skipwhite
syn match   solContractName      contained /\<[a-zA-Z_$][0-9a-zA-Z_$]*/ nextgroup=solContractParent skipwhite
syn region  solContractParent    contained start='is' end='{' contains=solContractName,solContractNoise,solContractCommas skipwhite skipempty
syn match   solContractNoise     contained 'is' containedin=solContractParent
syn match   solContractCommas    contained ','

hi def link solContract          Type
hi def link solContractName      Function

" Event
syn match   solEvent             /\<event\>/ nextgroup=solEventName,solEventArgs skipwhite
syn match   solEventName         contained /\<[a-zA-Z_$][0-9a-zA-Z_$]*/ nextgroup=solEventArgs skipwhite
syn region  solEventArgs         contained matchgroup=solFuncParens start='(' end=')' contains=solEventArgCommas,solBuiltinType,solEventArgSpecial skipwhite skipempty
syn match   solEventArgCommas    contained ','
syn match   solEventArgSpecial   contained 'indexed'

hi def link solEvent             Type
hi def link solEventName         Function
hi def link solEventArgSpecial   Label

" Comment
syn keyword solCommentTodo       TODO FIXME XXX TBD contained
syn region  solLineComment       start=+\/\/+ end=+$+ contains=solCommentTodo,@Spell
syn region  solLineComment       start=+^\s*\/\/+ skip=+\n\s*\/\/+ end=+$+ contains=solCommentTodo,@Spell fold
syn region  solComment           start="/\*"  end="\*/" contains=solCommentTodo,@Spell fold

hi def link solCommentTodo       Comment
hi def link solLineComment       Comment
hi def link solComment           Comment

endif
