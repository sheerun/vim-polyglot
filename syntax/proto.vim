if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vim') == -1
  
" syntax file for Protocol Buffers - Google's data interchange format
"
" Copyright 2008 Google Inc.  All rights reserved.
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.
"
" http://code.google.com/p/protobuf/

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case match

syn keyword protoTodo       contained TODO FIXME XXX
syn cluster protoCommentGrp contains=protoTodo

syn keyword protoSyntax     syntax import option
syn keyword protoStructure  package message group
syn keyword protoRepeat     optional required repeated
syn keyword protoDefault    default
syn keyword protoExtend     extend extensions to max
syn keyword protoRPC        service rpc returns

syn keyword protoType      int32 int64 uint32 uint64 sint32 sint64
syn keyword protoType      fixed32 fixed64 sfixed32 sfixed64
syn keyword protoType      float double bool string bytes
syn keyword protoTypedef   enum
syn keyword protoBool      true false

syn match   protoInt     /-\?\<\d\+\>/
syn match   protoInt     /\<0[xX]\x+\>/
syn match   protoFloat   /\<-\?\d*\(\.\d*\)\?/
syn region  protoComment start="\/\*" end="\*\/" contains=@protoCommentGrp
syn region  protoComment start="//" skip="\\$" end="$" keepend contains=@protoCommentGrp
syn region  protoString  start=/"/ skip=/\\./ end=/"/
syn region  protoString  start=/'/ skip=/\\./ end=/'/

hi def link protoTodo         Todo

hi def link protoSyntax       Include
hi def link protoStructure    Structure
hi def link protoRepeat       Repeat
hi def link protoDefault      Keyword
hi def link protoExtend       Keyword
hi def link protoRPC          Keyword
hi def link protoType         Type
hi def link protoTypedef      Typedef
hi def link protoBool         Boolean

hi def link protoInt          Number
hi def link protoFloat        Float
hi def link protoComment      Comment
hi def link protoString       String

let b:current_syntax = "proto"

endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'protobuf') == -1
  
" Protocol Buffers - Google's data interchange format
" Copyright 2008 Google Inc.  All rights reserved.
" https://developers.google.com/protocol-buffers/
"
" Redistribution and use in source and binary forms, with or without
" modification, are permitted provided that the following conditions are
" met:
"
"     * Redistributions of source code must retain the above copyright
" notice, this list of conditions and the following disclaimer.
"     * Redistributions in binary form must reproduce the above
" copyright notice, this list of conditions and the following disclaimer
" in the documentation and/or other materials provided with the
" distribution.
"     * Neither the name of Google Inc. nor the names of its
" contributors may be used to endorse or promote products derived from
" this software without specific prior written permission.
"
" THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
" "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
" LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
" A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
" OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
" SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
" LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
" DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
" THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
" (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
" OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

" This is the Vim syntax file for Google Protocol Buffers.
"
" Usage:
"
" 1. cp proto.vim ~/.vim/syntax/
" 2. Add the following to ~/.vimrc:
"
" augroup filetype
"   au! BufRead,BufNewFile *.proto setfiletype proto
" augroup end
"
" Or just create a new file called ~/.vim/ftdetect/proto.vim with the
" previous lines on it.

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case match

syn keyword pbTodo       contained TODO FIXME XXX
syn cluster pbCommentGrp contains=pbTodo

syn keyword pbSyntax     syntax import option
syn keyword pbStructure  package message group oneof
syn keyword pbRepeat     optional required repeated
syn keyword pbDefault    default
syn keyword pbExtend     extend extensions to max reserved
syn keyword pbRPC        service rpc returns

syn keyword pbType      int32 int64 uint32 uint64 sint32 sint64
syn keyword pbType      fixed32 fixed64 sfixed32 sfixed64
syn keyword pbType      float double bool string bytes
syn keyword pbTypedef   enum
syn keyword pbBool      true false

syn match   pbInt     /-\?\<\d\+\>/
syn match   pbInt     /\<0[xX]\x+\>/
syn match   pbFloat   /\<-\?\d*\(\.\d*\)\?/
syn region  pbComment start="\/\*" end="\*\/" contains=@pbCommentGrp
syn region  pbComment start="//" skip="\\$" end="$" keepend contains=@pbCommentGrp
syn region  pbString  start=/"/ skip=/\\./ end=/"/
syn region  pbString  start=/'/ skip=/\\./ end=/'/

if version >= 508 || !exists("did_proto_syn_inits")
  if version < 508
    let did_proto_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink pbTodo         Todo

  HiLink pbSyntax       Include
  HiLink pbStructure    Structure
  HiLink pbRepeat       Repeat
  HiLink pbDefault      Keyword
  HiLink pbExtend       Keyword
  HiLink pbRPC          Keyword
  HiLink pbType         Type
  HiLink pbTypedef      Typedef
  HiLink pbBool         Boolean

  HiLink pbInt          Number
  HiLink pbFloat        Float
  HiLink pbComment      Comment
  HiLink pbString       String

  delcommand HiLink
endif

let b:current_syntax = "proto"

endif
