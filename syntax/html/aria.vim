" Vim syntax file
" Language:	    WAI-ARIA
" Maintainer:  	othree <othree@gmail.com>
" URL:		      http://github.com/othree/html5-syntax.vim
" Last Change:  2014-05-02
" License:      MIT
" Changes:      Add match rules 
"               update to Draft 16 September 2010

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


" Use match: https://github.com/othree/html5.vim/issues/39

" Global States and Properties
syn match    htmlArg contained "\<aria-\%(\|atomic\|busy\|controls\|describedby\)\>"
syn match    htmlArg contained "\<aria-\%(\|disabled\|dropeffect\|flowto\|grabbed\)\>"
syn match    htmlArg contained "\<aria-\%(\|haspopup\|hidden\|invalid\|label\)\>"
syn match    htmlArg contained "\<aria-\%(\|labelledby\|live\|owns\|relevant\)\>"

" Widget Attributes
syn match    htmlArg contained "\<aria-\%(\|autocomplete\|checked\|disabled\|expanded\)\>"
syn match    htmlArg contained "\<aria-\%(\|haspopup\|hidden\|invalid\|label\)\>"
syn match    htmlArg contained "\<aria-\%(\|level\|multiline\|multiselectable\|orientation\)\>"
syn match    htmlArg contained "\<aria-\%(\|pressed\|readonly\|required\|selected\)\>"
syn match    htmlArg contained "\<aria-\%(\|sort\|valuemax\|valuemin\|valuenow\|valuetext\)\>"

" Live Region Attributes
syn match    htmlArg contained "\<aria-\%(\|atomic\|busy\|live\|relevant\)\>"

" Drag-and-Drop attributes
syn match    htmlArg contained "\<aria-\%(\|dropeffect\|grabbed\)\>"

" Relationship Attributes
syn match    htmlArg contained "\<aria-\%(\|activedescendant\|controls\|describedby\|flowto\)\>"
syn match    htmlArg contained "\<aria-\%(\|labelledby\|owns\|posinset\|setsize\)\>"

