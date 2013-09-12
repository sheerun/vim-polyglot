" Vim syntax file
" Language: Cabal
" Author: Tristan Ravitch
" Version: 0.0.1

if version < 600
  syntax clear
elseif exists('b:current_syntax')
  finish
endif

syn sync minlines=50 maxlines=200
syn case ignore

" Top-level package keywords
syn match cabalKey '^name:'
syn match cabalKey '^version:'
syn match cabalKey '^cabal-version:'
syn match cabalKey '^build-type:'
syn match cabalKey '^license:'
syn match cabalKey '^license-file:'
syn match cabalKey '^copyright:'
syn match cabalKey '^author:'
syn match cabalKey '^maintainer:'
syn match cabalKey '^stability:'
syn match cabalKey '^homepage:'
syn match cabalKey '^bug-reports:'
syn match cabalKey '^package-url:'
syn match cabalKey '^synopsis:'
syn match cabalKey '^description:'
syn match cabalKey '^category:'
syn match cabalKey '^tested-with:'
syn match cabalKey '^data-files:'
syn match cabalKey '^data-dir:'
syn match cabalKey '^extra-source-files:'
syn match cabalKey '^extra-tmp-files:'

" Other keywords
syn match cabalLit '\(:\s*\)\@<=\(true\|false\)'

" Library-specifics
syn region cabalLibraryR start='^library\(\s\|$\)\@=' end='^\w' transparent keepend contains=cabalLibrayKey,cabalBuildKey,cabalCondition,cabalOperator
syn match cabalLibraryKey '^library\(\s\|$\)\@='
syn match cabalLibraryKey '\(^\s\+\)\@<=exposed-modules:'
syn match cabalLibraryKey '\(^\s\+\)\@<=exposed:'

" Executable-specifics
syn region cabalExeR start='^executable\s\@=' end='^\w' transparent keepend contains=cabalExeKey,cabalBuildKey,cabalCondition,cabalOperator,cabalBuildableName
syn match cabalExeKey '^executable\s\@='
syn match cabalExeKey '\(^\s\+\)\@<=main-is:'

" Test-specifics
syn region cabalTestR start='^test-suite\s\@=' end='^\w' transparent keepend contains=cabalTestKey,cabalBuildKey,cabalCondition,cabalOperator,cabalBuildableName
syn match cabalTestKey '^test-suite\s\@='
syn match cabalTestKey '\(^\s\+\)\@<=type:'
syn match cabalTestKey '\(^\s\+\)\@<=main-is:'
syn match cabalTestKey '\(^\s\+\)\@<=test-module:'

" Benchmark-specifics
syn region cabalBenchR start='^benchmark\s\@=' end='^\w' transparent keepend contains=cabalBenchKey,cabalBuildKey,cabalCondition,cabalOperator,cabalBuildableName
syn match cabalBenchKey '^benchmark\s\@='
syn match cabalBenchKey '\(^\s\+\)\@<=type:'
syn match cabalBenchKey '\(^\s\+\)\@<=main-is:'

syn match cabalBuildableName '\(^\(^benchmark\|test-suite\|executable\)\s\+\)\@<=\w\+'

" General build info
syn match cabalBuildKey '\(^\s\+\)\@<=default-language:'
syn match cabalBuildKey '\(^\s\+\)\@<=build-depends:'
syn match cabalBuildKey '\(^\s\+\)\@<=other-modules:'
syn match cabalBuildKey '\(^\s\+\)\@<=hs-source-dirs:'
syn match cabalBuildKey '\(^\s\+\)\@<=extensions:'
syn match cabalBuildKey '\(^\s\+\)\@<=build-tools:'
syn match cabalBuildKey '\(^\s\+\)\@<=buildable:'
syn match cabalBuildKey '\(^\s\+\)\@<=ghc-options:'
syn match cabalBuildKey '\(^\s\+\)\@<=ghc-prof-options:'
syn match cabalBuildKey '\(^\s\+\)\@<=ghc-shared-options:'
syn match cabalBuildKey '\(^\s\+\)\@<=hugs-options:'
syn match cabalBuildKey '\(^\s\+\)\@<=nch98-options:'
syn match cabalBuildKey '\(^\s\+\)\@<=includes:'
syn match cabalBuildKey '\(^\s\+\)\@<=install-includes:'
syn match cabalBuildKey '\(^\s\+\)\@<=include-dirs:'
syn match cabalBuildKey '\(^\s\+\)\@<=c-sources:'
syn match cabalBuildKey '\(^\s\+\)\@<=extra-libraries:'
syn match cabalBuildKey '\(^\s\+\)\@<=extra-lib-dirs:'
syn match cabalBuildKey '\(^\s\+\)\@<=cc-options:'
syn match cabalBuildKey '\(^\s\+\)\@<=cpp-options:'
syn match cabalBuildKey '\(^\s\+\)\@<=ld-options:'
syn match cabalBuildKey '\(^\s\+\)\@<=pkgconfig-depends:'
syn match cabalBuildKey '\(^\s\+\)\@<=frameworks:'

syn region cabalFlagR start='^flag\s\@=' end='^\w' transparent keepend contains=cabalFlagKey,cabalCondition,cabalFlag
syn match cabalFlagKey '^flag\s\@='
syn match cabalFlagKey '\(^\s\+\)\@<=description:'
syn match cabalFlagKey '\(^\s\+\)\@<=default:'
syn match cabalFlagKey '\(^\s\+\)\@<=manual:'
syn match cabalFlag '\(flag\s\+\)\@<=\w\+'
syn match cabalFlag '\(flag(\)\@<=\w\+)\@='

syn region cabalSourceR start='^source-repository' end='^\w' transparent keepend contains=cabalSourceKey
syn match cabalSourceKey '^source-repository\s\@='
syn match cabalSourceKey '\(^\s\+\)\@<=type:'
syn match cabalSourceKey '\(^\s\+\)\@<=location:'
syn match cabalSourceKey '\(^\s\+\)\@<=module:'
syn match cabalSourceKey '\(^\s\+\)\@<=branch:'
syn match cabalSourceKey '\(^\s\+\)\@<=tag:'
syn match cabalSourceKey '\(^\s\+\)\@<=subdir:'

syn match cabalCondition '\(^\s\+\)\@<=if\((\|\s\)\@='
syn match cabalCondition '\(^\s\+\)\@<=else\($\|\s\)\@='
syn match cabalCondition '\(^\s\+\)\@<=if\((\|\s\)\@='
syn match cabalCondition '\(^\s\+\)\@<=else\($\|\s\)\@='
syn match cabalOperator '\W\@<=os\((.\+)\)\@='
syn match cabalOperator '\W\@<=arch\((.\+)\)\@='
syn match cabalOperator '\W\@<=impl\((.\+)\)\@='
syn match cabalOperator '\W\@<=flag\((.\+)\)\@='
syn match cabalOperator '\(^\s*--.*\)\@<!\(<\|>\|=\|||\|&&\)'

syn match cabalComment '\s\@<=--.*$'

if version >= 508 || !exists('did_cabal_syntax_inits')
  if version < 508
    let did_cabal_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink cabalBuildableName Structure
  HiLink cabalFlag Special
  HiLink cabalComment Comment
  HiLink cabalCondition Conditional
  HiLink cabalSourceKey Keyword
  HiLink cabalOperator Operator
  HiLink cabalKey Keyword
  HiLink cabalLibraryKey Keyword
  HiLink cabalTestKey Keyword
  HiLink cabalExeKey Keyword
  HiLink cabalBenchKey Keyword
  HiLink cabalBuildKey Keyword
  HiLink cabalFlagKey Keyword
  HiLink cabalLit Constant

  delcommand HiLink
endif

let b:current_syntax = 'cabal'
