if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Blob BlobBuilder
syntax keyword typescriptGlobal containedin=typescriptIdentifierName File FileReader
syntax keyword typescriptGlobal containedin=typescriptIdentifierName FileReaderSync
syntax keyword typescriptGlobal containedin=typescriptIdentifierName URL nextgroup=typescriptGlobalURLDot,typescriptFuncCallArg
syntax match   typescriptGlobalURLDot /\./ contained nextgroup=typescriptURLStaticMethod,typescriptProp
syntax keyword typescriptGlobal containedin=typescriptIdentifierName URLUtils
syntax keyword typescriptFileMethod contained readAsArrayBuffer readAsBinaryString nextgroup=typescriptFuncCallArg
syntax keyword typescriptFileMethod contained readAsDataURL readAsText nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptFileMethod
if exists("did_typescript_hilink") | HiLink typescriptFileMethod Keyword
endif
syntax keyword typescriptFileReaderProp contained error readyState result
syntax cluster props add=typescriptFileReaderProp
if exists("did_typescript_hilink") | HiLink typescriptFileReaderProp Keyword
endif
syntax keyword typescriptFileReaderMethod contained abort readAsArrayBuffer readAsBinaryString nextgroup=typescriptFuncCallArg
syntax keyword typescriptFileReaderMethod contained readAsDataURL readAsText nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptFileReaderMethod
if exists("did_typescript_hilink") | HiLink typescriptFileReaderMethod Keyword
endif
syntax keyword typescriptFileListMethod contained item nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptFileListMethod
if exists("did_typescript_hilink") | HiLink typescriptFileListMethod Keyword
endif
syntax keyword typescriptBlobMethod contained append getBlob getFile nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptBlobMethod
if exists("did_typescript_hilink") | HiLink typescriptBlobMethod Keyword
endif
syntax keyword typescriptURLUtilsProp contained hash host hostname href origin password
syntax keyword typescriptURLUtilsProp contained pathname port protocol search searchParams
syntax keyword typescriptURLUtilsProp contained username
syntax cluster props add=typescriptURLUtilsProp
if exists("did_typescript_hilink") | HiLink typescriptURLUtilsProp Keyword
endif
syntax keyword typescriptURLStaticMethod contained createObjectURL revokeObjectURL nextgroup=typescriptFuncCallArg
if exists("did_typescript_hilink") | HiLink typescriptURLStaticMethod Keyword
endif

endif
