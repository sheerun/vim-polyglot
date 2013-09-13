" Vim syntax file
" Language:	    WAI-ARIA
" Maintainer:	othree <othree@gmail.com>
" URL:		    http://github.com/othree/html5-syntax.vim
" Last Change:  2010-09-25
" License:      MIT
" Changes:      update to Draft 16 September 2010

setlocal iskeyword+=-

" WAI-ARIA States and Properties
" http://www.w3.org/TR/wai-aria/states_and_properties
syn keyword  htmlArg contained role

" Global States and Properties
syn keyword  htmlArg contained aria-atomic aria-busy aria-controls aria-describedby
syn keyword  htmlArg contained aria-disabled aria-dropeffect aria-flowto aria-grabbed
syn keyword  htmlArg contained aria-haspopup aria-hidden aria-invalid aria-label
syn keyword  htmlArg contained aria-labelledby aria-live aria-owns aria-relevant

" Widget Attributes
syn keyword  htmlArg contained aria-autocomplete aria-checked aria-disabled aria-expanded
syn keyword  htmlArg contained aria-haspopup aria-hidden aria-invalid aria-label
syn keyword  htmlArg contained aria-level aria-multiline aria-multiselectable aria-orientation
syn keyword  htmlArg contained aria-pressed aria-readonly aria-required aria-selected
syn keyword  htmlArg contained aria-sort aria-valuemax aria-valuemin aria-valuenow aria-valuetext

" Live Region Attributes
syn keyword  htmlArg contained aria-atomic aria-busy aria-live aria-relevant

" Drag-and-Drop attributes
syn keyword  htmlArg contained aria-dropeffect aria-grabbed

" Relationship Attributes
syn keyword  htmlArg contained aria-activedescendant aria-controls aria-describedby aria-flowto
syn keyword  htmlArg contained aria-labelledby aria-owns aria-posinset aria-setsize

