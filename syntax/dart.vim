if has_key(g:polyglot_is_disabled, 'dart')
  finish
endif

" Vim syntax file " Language: Dart
" Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
" for details. All rights reserved. Use of this source code is governed by a
" BSD-style license that can be found in the LICENSE file.

if !exists('g:main_syntax')
  if v:version < 600
    syntax clear
  elseif exists('b:current_syntax')
    finish
  endif
  let g:main_syntax = 'dart'
  syntax region dartFold start='{' end='}' transparent fold
endif

" Ensure long multiline strings are highlighted.
syntax sync fromstart

syntax case match

" keyword definitions
syntax keyword dartConditional    if else switch
syntax keyword dartRepeat         do while for
syntax keyword dartBoolean        true false
syntax keyword dartConstant       null
syntax keyword dartTypedef        this super class typedef enum mixin extension
syntax keyword dartOperator       new is as in
syntax match   dartOperator       "+=\=\|-=\=\|*=\=\|/=\=\|%=\=\|\~/=\=\|<<=\=\|>>=\=\|[<>]=\=\|===\=\|\!==\=\|&=\=\|\^=\=\||=\=\|||\|&&\|\[\]=\=\|=>\|!\|\~\|?\|:"
syntax keyword dartCoreType       void var dynamic
syntax keyword dartStatement      return
syntax keyword dartStorageClass   static abstract final const factory late
syntax keyword dartExceptions     throw rethrow try on catch finally
syntax keyword dartAssert         assert
syntax keyword dartClassDecl      extends with implements
syntax keyword dartBranch         break continue nextgroup=dartUserLabelRef skipwhite
syntax keyword dartKeyword        get set operator call external async await
    \ yield sync native covariant required
syntax match   dartUserLabelRef   "\k\+" contained

syntax region  dartLabelRegion   transparent matchgroup=dartLabel start="\<case\>" matchgroup=NONE end=":"
syntax keyword dartLabel         default

syntax match   dartLibrary       "^\(import\|export\)\>" nextgroup=dartUri skipwhite skipnl
syntax region  dartUri           contained start=+r\=\z(["']\)+ end=+\z1+ nextgroup=dartCombinators skipwhite skipnl
syntax region  dartCombinators   contained start="" end=";" contains=dartCombinator,dartComment,dartLineComment
syntax keyword dartCombinator    contained show hide deferred as
syntax match   dartLibrary       "^\(library\|part of\|part\)\>"

syntax match   dartMetadata      "@\([_$a-zA-Z][_$a-zA-Z0-9]*\.\)*[_$a-zA-Z][_$a-zA-Z0-9]*\>"

" Numbers
syntax match   dartNumber        "\<\d\+\(\.\d\+\)\=\>"

" User Types
syntax match   dartUserType      "\<[_$]*\u[a-zA-Z0-9_$]*\>"

" Function highlighting
syntax match   dartFunction      "\zs\<\([_$]*[a-z][a-zA-Z0-9_$]*\)\ze\(<\|(\|\s\+=>\)"

" SDK libraries
syntax keyword dartSdkClass     BidirectionalIterator Comparable DateTime
    \ Duration Expando Function Invocation Iterable Iterator List Map Match
    \ Object Pattern RegExp RuneIterator Runes Set StackTrace Stopwatch String
    \ StringBuffer StringSink Symbol Type bool int double num
syntax keyword dartSdkTypedef   Comparator
syntax keyword dartSdkException AbstractClassInstantiationError
    \ ArgumentError AssertionError CastError ConcurrentModificationError
    \ Error Exception FallThroughError FormatException
    \ IntegerDivisionByZeroException NoSuchMethodError NullThrownError
    \ OutOfMemoryError RangeError RuntimeError StackOverflowError StateError
    \ TypeError UnimplementedError UnsupportedError

" Comments
syntax keyword dartTodo          contained TODO FIXME XXX
syntax region  dartComment       start="/\*"  end="\*/" contains=dartComment,dartTodo,dartDocLink,@Spell
syntax match   dartLineComment   "//.*" contains=dartTodo,@Spell
syntax match   dartLineDocComment "///.*" contains=dartTodo,dartDocLink,@Spell
syntax match   dartShebangLine   /^\%1l#!.*/
syntax region  dartDocLink       oneline contained start=+\[+ end=+\]+

" Strings
syntax cluster dartRawStringContains contains=@Spell
if exists('dart_html_in_strings') && dart_html_in_strings
  syntax include @HTML syntax/html.vim
  syntax cluster dartRawStringContains add=@HTML
endif
syntax cluster dartStringContains contains=@dartRawStringContains,dartInterpolation,dartSpecialChar
syntax region  dartString         oneline start=+\z(["']\)+ end=+\z1+ contains=@dartStringContains keepend
syntax region  dartRawString      oneline start=+r\z(["']\)+ end=+\z1+ contains=@dartRawStringContains keepend
syntax region  dartMultilineString     start=+\z("\{3\}\|'\{3\}\)+ end=+\z1+ contains=@dartStringContains keepend
syntax region  dartRawMultilineString     start=+r\z("\{3\}\|'\{3\}\)+ end=+\z1+ contains=@dartSRawtringContains keepend
syntax match   dartInterpolation contained "\$\(\w\+\|{[^}]\+}\)" extend
syntax match   dartSpecialChar   contained "\\\(u\x\{4\}\|u{\x\+}\|x\x\x\|x{\x\+}\|.\)" extend

" The default highlighting.
highlight default link dartBranch          Conditional
highlight default link dartUserLabelRef    dartUserLabel
highlight default link dartLabel           Label
highlight default link dartUserLabel       Label
highlight default link dartConditional     Conditional
highlight default link dartRepeat          Repeat
highlight default link dartExceptions      Exception
highlight default link dartAssert          Statement
highlight default link dartStorageClass    StorageClass
highlight default link dartClassDecl       dartStorageClass
highlight default link dartBoolean         Boolean
highlight default link dartString          String
highlight default link dartRawString       String
highlight default link dartMultilineString String
highlight default link dartRawMultilineString String
highlight default link dartNumber          Number
highlight default link dartStatement       Statement
highlight default link dartOperator        Operator
highlight default link dartComment         Comment
highlight default link dartLineComment     Comment
highlight default link dartLineDocComment  Comment
highlight default link dartShebangLine     Comment
highlight default link dartConstant        Constant
highlight default link dartTodo            Todo
highlight default link dartKeyword         Keyword
highlight default link dartInterpolation   PreProc
highlight default link dartDocLink         SpecialComment
highlight default link dartSpecialChar     SpecialChar
highlight default link dartLibrary         Include
highlight default link dartUri             String
highlight default link dartCombinator      Keyword
highlight default link dartMetadata        PreProc
highlight default link dartSdkTypedef      Typedef
highlight default link dartTypedef         Typedef
highlight default link dartSdkException    Exception
highlight default link dartSdkClass        dartType
highlight default link dartCoreType        dartType
highlight default link dartUserType        dartType
highlight default link dartType            Type
highlight default link dartFunction        Function

let b:current_syntax = 'dart'
let b:spell_options = 'contained'

if g:main_syntax is# 'dart'
  unlet g:main_syntax
endif
