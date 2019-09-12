if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'objc') == -1

" ARC type modifiers
syn keyword objcTypeModifier __bridge __bridge_retained __bridge_transfer __autoreleasing __strong __weak __unsafe_unretained

" Block modifiers
syn keyword objcTypeModifier __block

" Remote messaging modifiers
syn keyword objcTypeModifier byref

" Property keywords - these are only highlighted inside '@property (...)'
syn keyword objcPropertyAttribute contained getter setter readwrite readonly strong weak copy assign retain nonatomic
syn match objcProperty display "^\s*@property\>\s*([^)]*)" contains=objcPropertyAttribute

" The @property directive must be defined after objcProperty or it won't be
" highlighted
syn match objcDirective "@property\|@synthesize\|@dynamic\|@package"

" Highlight property attributes as if they were type modifiers
hi def link objcPropertyAttribute objcTypeModifier

endif
