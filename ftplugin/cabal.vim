if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'haskell') == -1
  
if exists("g:loaded_haskellvim_cabal")
  finish
endif

let g:loaded_haskellvim_cabal = 1

function! s:makeSection(content)
  return "\n" . join(a:content, "\n")
endfunction

function! s:exeTmpl(name, src)
  let l:exetmpl = [ 'executable ' . a:name,
                  \ '-- ghc-options:',
                  \ 'main-is:             ' . a:src,
                  \ '-- other-modules:',
                  \ '-- other-extensions:',
                  \ 'build-depends:       base',
                  \ '-- hs-source-dirs:',
                  \ 'default-language:    Haskell2010'
                  \ ]

  return s:makeSection(l:exetmpl)
endfunction

function! s:libTmpl()
  let l:libtmpl = [ 'library',
                  \ '-- ghc-options:',
                  \ '-- other-modules:',
                  \ '-- other-extensions:',
                  \ 'build-depends:       base',
                  \ '-- hs-source-dirs:',
                  \ 'default-language:    Haskell2010'
                  \ ]

  return s:makeSection(l:libtmpl)
endfunction

function! s:flagTmpl(name)
  let l:flagtmpl = [ 'flag ' . a:name,
                   \ 'description:',
                   \ 'default:      False',
                   \ 'manual:       True',
                   \ ]

  return s:makeSection(l:flagtmpl)
endfunction

function! cabal#addExecutable()
  let l:name = input("Enter executable name: ")
  let l:src  = input("Enter source file: ")
  exe "normal Go" . s:exeTmpl(l:name, l:src)
endfunction

function! cabal#addLibrary()
  exe "normal Go" . s:libTmpl()
endfunction

function! cabal#addFlag()
  let l:name = input("Enter flag name: ")
  exe "normal Go" . s:flagTmpl(l:name)
endfunction

command! -buffer CabalAddExecutable call cabal#addExecutable()
command! -buffer CabalAddLibrary call cabal#addLibrary()
command! -buffer CabalAddFlag call cabal#addFlag()

endif
