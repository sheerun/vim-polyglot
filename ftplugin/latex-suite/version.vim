" Tex_Version: returns a string which gives the current version number of latex-suite
" Description: 
" 	Each time a bug fix/addition is done in any source file in latex-suite,
" 	not just this file, the number below has to be incremented by the author.
" 	This will ensure that there is a single 'global' version number for all of
" 	latex-suite.
"
" 	If a change is done in the doc/ directory, i.e an addition/change in the
" 	documentation, then this number should NOT be incremented.
"
" 	Latex-suite will follow a 3-tier system of versioning just as Vim. A
" 	version number will be of the form:
"		
"		X.Y.ZZ
"
"	'X' 	will only be incremented for a major over-haul or feature addition.
"	'Y' 	will be incremented for significant changes which do not qualify
"			as major.
"	'ZZ' 	will be incremented for bug-fixes and very trivial additions such
"			as adding an option etc. Once ZZ reaches 50, then Y will be
"			incremented and ZZ will be reset to 01. Each time we have a
"			version number of the form X.Y.01, then we'll make a release on
"			vim.sf.net and also create a cvs tag at that point. We'll try to
"			"stabilize" that version by releasing a few pre-releases and then
"			keep that as a stable point.
function! Tex_Version()
	return "Latex-Suite: version 1.8.23"
endfunction 

com! -nargs=0 TVersion echo Tex_Version()
