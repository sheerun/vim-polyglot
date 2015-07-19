if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  
syntax keyword javascriptGlobal Function Boolean Error EvalError InternalError RangeError
syntax keyword javascriptGlobal ReferenceError StopIteration SyntaxError TypeError
syntax keyword javascriptGlobal URIError Date Float32Array Float64Array Int16Array
syntax keyword javascriptGlobal Int32Array Int8Array Uint16Array Uint32Array Uint8Array
syntax keyword javascriptGlobal Uint8ClampedArray ParallelArray ArrayBuffer DataView
syntax keyword javascriptGlobal Iterator Generator Reflect Proxy arguments
if exists("did_javascript_hilink") | HiLink javascriptGlobal Structure
endif
syntax keyword javascriptGlobalMethod eval uneval isFinite isNaN parseFloat parseInt nextgroup=javascriptFuncCallArg
syntax keyword javascriptGlobalMethod decodeURI decodeURIComponent encodeURI encodeURIComponent nextgroup=javascriptFuncCallArg
syntax cluster props add=javascriptGlobalMethod
if exists("did_javascript_hilink") | HiLink javascriptGlobalMethod Structure
endif

endif
