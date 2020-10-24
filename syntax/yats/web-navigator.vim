let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/yats/web-navigator.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptBOMNavigatorProp contained battery buildID connection cookieEnabled
syntax keyword typescriptBOMNavigatorProp contained doNotTrack maxTouchPoints oscpu
syntax keyword typescriptBOMNavigatorProp contained productSub push serviceWorker
syntax keyword typescriptBOMNavigatorProp contained vendor vendorSub
syntax cluster props add=typescriptBOMNavigatorProp
if exists("did_typescript_hilink") | HiLink typescriptBOMNavigatorProp Keyword
endif
syntax keyword typescriptBOMNavigatorMethod contained addIdleObserver geolocation nextgroup=typescriptFuncCallArg
syntax keyword typescriptBOMNavigatorMethod contained getDeviceStorage getDeviceStorages nextgroup=typescriptFuncCallArg
syntax keyword typescriptBOMNavigatorMethod contained getGamepads getUserMedia registerContentHandler nextgroup=typescriptFuncCallArg
syntax keyword typescriptBOMNavigatorMethod contained removeIdleObserver requestWakeLock nextgroup=typescriptFuncCallArg
syntax keyword typescriptBOMNavigatorMethod contained share vibrate watch registerProtocolHandler nextgroup=typescriptFuncCallArg
syntax keyword typescriptBOMNavigatorMethod contained sendBeacon nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptBOMNavigatorMethod
if exists("did_typescript_hilink") | HiLink typescriptBOMNavigatorMethod Keyword
endif
syntax keyword typescriptServiceWorkerMethod contained register nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptServiceWorkerMethod
if exists("did_typescript_hilink") | HiLink typescriptServiceWorkerMethod Keyword
endif

endif
