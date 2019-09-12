if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptAnimationEvent contained animationend animationiteration
syntax keyword typescriptAnimationEvent contained animationstart beginEvent endEvent
syntax keyword typescriptAnimationEvent contained repeatEvent
syntax cluster events add=typescriptAnimationEvent
if exists("did_typescript_hilink") | HiLink typescriptAnimationEvent Title
endif
syntax keyword typescriptCSSEvent contained CssRuleViewRefreshed CssRuleViewChanged
syntax keyword typescriptCSSEvent contained CssRuleViewCSSLinkClicked transitionend
syntax cluster events add=typescriptCSSEvent
if exists("did_typescript_hilink") | HiLink typescriptCSSEvent Title
endif
syntax keyword typescriptDatabaseEvent contained blocked complete error success upgradeneeded
syntax keyword typescriptDatabaseEvent contained versionchange
syntax cluster events add=typescriptDatabaseEvent
if exists("did_typescript_hilink") | HiLink typescriptDatabaseEvent Title
endif
syntax keyword typescriptDocumentEvent contained DOMLinkAdded DOMLinkRemoved DOMMetaAdded
syntax keyword typescriptDocumentEvent contained DOMMetaRemoved DOMWillOpenModalDialog
syntax keyword typescriptDocumentEvent contained DOMModalDialogClosed unload
syntax cluster events add=typescriptDocumentEvent
if exists("did_typescript_hilink") | HiLink typescriptDocumentEvent Title
endif
syntax keyword typescriptDOMMutationEvent contained DOMAttributeNameChanged DOMAttrModified
syntax keyword typescriptDOMMutationEvent contained DOMCharacterDataModified DOMContentLoaded
syntax keyword typescriptDOMMutationEvent contained DOMElementNameChanged DOMNodeInserted
syntax keyword typescriptDOMMutationEvent contained DOMNodeInsertedIntoDocument DOMNodeRemoved
syntax keyword typescriptDOMMutationEvent contained DOMNodeRemovedFromDocument DOMSubtreeModified
syntax cluster events add=typescriptDOMMutationEvent
if exists("did_typescript_hilink") | HiLink typescriptDOMMutationEvent Title
endif
syntax keyword typescriptDragEvent contained drag dragdrop dragend dragenter dragexit
syntax keyword typescriptDragEvent contained draggesture dragleave dragover dragstart
syntax keyword typescriptDragEvent contained drop
syntax cluster events add=typescriptDragEvent
if exists("did_typescript_hilink") | HiLink typescriptDragEvent Title
endif
syntax keyword typescriptElementEvent contained invalid overflow underflow DOMAutoComplete
syntax keyword typescriptElementEvent contained command commandupdate
syntax cluster events add=typescriptElementEvent
if exists("did_typescript_hilink") | HiLink typescriptElementEvent Title
endif
syntax keyword typescriptFocusEvent contained blur change DOMFocusIn DOMFocusOut focus
syntax keyword typescriptFocusEvent contained focusin focusout
syntax cluster events add=typescriptFocusEvent
if exists("did_typescript_hilink") | HiLink typescriptFocusEvent Title
endif
syntax keyword typescriptFormEvent contained reset submit
syntax cluster events add=typescriptFormEvent
if exists("did_typescript_hilink") | HiLink typescriptFormEvent Title
endif
syntax keyword typescriptFrameEvent contained DOMFrameContentLoaded
syntax cluster events add=typescriptFrameEvent
if exists("did_typescript_hilink") | HiLink typescriptFrameEvent Title
endif
syntax keyword typescriptInputDeviceEvent contained click contextmenu DOMMouseScroll
syntax keyword typescriptInputDeviceEvent contained dblclick gamepadconnected gamepaddisconnected
syntax keyword typescriptInputDeviceEvent contained keydown keypress keyup MozGamepadButtonDown
syntax keyword typescriptInputDeviceEvent contained MozGamepadButtonUp mousedown mouseenter
syntax keyword typescriptInputDeviceEvent contained mouseleave mousemove mouseout
syntax keyword typescriptInputDeviceEvent contained mouseover mouseup mousewheel MozMousePixelScroll
syntax keyword typescriptInputDeviceEvent contained pointerlockchange pointerlockerror
syntax keyword typescriptInputDeviceEvent contained wheel
syntax cluster events add=typescriptInputDeviceEvent
if exists("did_typescript_hilink") | HiLink typescriptInputDeviceEvent Title
endif
syntax keyword typescriptMediaEvent contained audioprocess canplay canplaythrough
syntax keyword typescriptMediaEvent contained durationchange emptied ended ended loadeddata
syntax keyword typescriptMediaEvent contained loadedmetadata MozAudioAvailable pause
syntax keyword typescriptMediaEvent contained play playing ratechange seeked seeking
syntax keyword typescriptMediaEvent contained stalled suspend timeupdate volumechange
syntax keyword typescriptMediaEvent contained waiting complete
syntax cluster events add=typescriptMediaEvent
if exists("did_typescript_hilink") | HiLink typescriptMediaEvent Title
endif
syntax keyword typescriptMenuEvent contained DOMMenuItemActive DOMMenuItemInactive
syntax cluster events add=typescriptMenuEvent
if exists("did_typescript_hilink") | HiLink typescriptMenuEvent Title
endif
syntax keyword typescriptNetworkEvent contained datachange dataerror disabled enabled
syntax keyword typescriptNetworkEvent contained offline online statuschange connectionInfoUpdate
syntax cluster events add=typescriptNetworkEvent
if exists("did_typescript_hilink") | HiLink typescriptNetworkEvent Title
endif
syntax keyword typescriptProgressEvent contained abort error load loadend loadstart
syntax keyword typescriptProgressEvent contained progress timeout uploadprogress
syntax cluster events add=typescriptProgressEvent
if exists("did_typescript_hilink") | HiLink typescriptProgressEvent Title
endif
syntax keyword typescriptResourceEvent contained cached error load
syntax cluster events add=typescriptResourceEvent
if exists("did_typescript_hilink") | HiLink typescriptResourceEvent Title
endif
syntax keyword typescriptScriptEvent contained afterscriptexecute beforescriptexecute
syntax cluster events add=typescriptScriptEvent
if exists("did_typescript_hilink") | HiLink typescriptScriptEvent Title
endif
syntax keyword typescriptSensorEvent contained compassneedscalibration devicelight
syntax keyword typescriptSensorEvent contained devicemotion deviceorientation deviceproximity
syntax keyword typescriptSensorEvent contained orientationchange userproximity
syntax cluster events add=typescriptSensorEvent
if exists("did_typescript_hilink") | HiLink typescriptSensorEvent Title
endif
syntax keyword typescriptSessionHistoryEvent contained pagehide pageshow popstate
syntax cluster events add=typescriptSessionHistoryEvent
if exists("did_typescript_hilink") | HiLink typescriptSessionHistoryEvent Title
endif
syntax keyword typescriptStorageEvent contained change storage
syntax cluster events add=typescriptStorageEvent
if exists("did_typescript_hilink") | HiLink typescriptStorageEvent Title
endif
syntax keyword typescriptSVGEvent contained SVGAbort SVGError SVGLoad SVGResize SVGScroll
syntax keyword typescriptSVGEvent contained SVGUnload SVGZoom
syntax cluster events add=typescriptSVGEvent
if exists("did_typescript_hilink") | HiLink typescriptSVGEvent Title
endif
syntax keyword typescriptTabEvent contained visibilitychange
syntax cluster events add=typescriptTabEvent
if exists("did_typescript_hilink") | HiLink typescriptTabEvent Title
endif
syntax keyword typescriptTextEvent contained compositionend compositionstart compositionupdate
syntax keyword typescriptTextEvent contained copy cut paste select text
syntax cluster events add=typescriptTextEvent
if exists("did_typescript_hilink") | HiLink typescriptTextEvent Title
endif
syntax keyword typescriptTouchEvent contained touchcancel touchend touchenter touchleave
syntax keyword typescriptTouchEvent contained touchmove touchstart
syntax cluster events add=typescriptTouchEvent
if exists("did_typescript_hilink") | HiLink typescriptTouchEvent Title
endif
syntax keyword typescriptUpdateEvent contained checking downloading error noupdate
syntax keyword typescriptUpdateEvent contained obsolete updateready
syntax cluster events add=typescriptUpdateEvent
if exists("did_typescript_hilink") | HiLink typescriptUpdateEvent Title
endif
syntax keyword typescriptValueChangeEvent contained hashchange input readystatechange
syntax cluster events add=typescriptValueChangeEvent
if exists("did_typescript_hilink") | HiLink typescriptValueChangeEvent Title
endif
syntax keyword typescriptViewEvent contained fullscreen fullscreenchange fullscreenerror
syntax keyword typescriptViewEvent contained resize scroll
syntax cluster events add=typescriptViewEvent
if exists("did_typescript_hilink") | HiLink typescriptViewEvent Title
endif
syntax keyword typescriptWebsocketEvent contained close error message open
syntax cluster events add=typescriptWebsocketEvent
if exists("did_typescript_hilink") | HiLink typescriptWebsocketEvent Title
endif
syntax keyword typescriptWindowEvent contained DOMWindowCreated DOMWindowClose DOMTitleChanged
syntax cluster events add=typescriptWindowEvent
if exists("did_typescript_hilink") | HiLink typescriptWindowEvent Title
endif
syntax keyword typescriptUncategorizedEvent contained beforeunload message open show
syntax cluster events add=typescriptUncategorizedEvent
if exists("did_typescript_hilink") | HiLink typescriptUncategorizedEvent Title
endif
syntax keyword typescriptServiceWorkerEvent contained install activate fetch
syntax cluster events add=typescriptServiceWorkerEvent
if exists("did_typescript_hilink") | HiLink typescriptServiceWorkerEvent Title
endif

endif
