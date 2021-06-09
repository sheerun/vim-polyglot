if polyglot#init#is_disabled(expand('<sfile>:p'), 'openscad', 'ftplugin/openscad.vim')
  finish
endif

" Blatantly stolen from vim74\ftplugin\c.vim

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql

" Set 'comments' to format dashed lists in comments.
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://

" Win32 can filter files in the browse dialog
if (has("gui_win32") || has("gui_gtk")) && !exists("b:browsefilter")
    let b:browsefilter = "OpenSCAD Source Files (*.scad)\t*.scad\n" .
	  \ "All Files (*.*)\t*.*\n"
endif
