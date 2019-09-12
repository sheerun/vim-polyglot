if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'haxe') == -1

" Vim syntax file
" Language:     haxe
" Derived from:
"   http://tech.motion-twin.com/zip/haxe.vim
"   and http://www.cactusflower.org/haxe.vim
" Please check :help haxe.vim for comments on some of the options available.

set errorformat=%f\:%l\:\ characters\ %c-%*[^\ ]\ %m,%f\:%l\:\ %m

" Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax='haxe'
endif

if version < 508
  command! -nargs=+ HaxeHiLink hi link <args>
else
  command! -nargs=+ HaxeHiLink hi def link <args>
endif

" some characters that cannot be in a haxe program (outside a string)
syn match     haxeError        "[\\@`]"
syn match     haxeError        "<<<\|=>\|<>\|||=\|&&=\|\*\/"

" use separate name so that it can be deleted in haxecc.vim
syn match     haxeError2       "#\|=<"
HaxeHiLink    haxeError2       haxeError

syn keyword   haxeExternal     import extern using
syn keyword   haxeDefine       package
syn keyword   haxeConditional  if else switch
syn keyword   haxeRepeat       while for do in
syn keyword   haxeBoolean      true false
syn keyword   haxeConstant     null
syn keyword   haxeTypedef      this super
syn keyword   haxeOperator     new cast 
syn keyword   haxeCoreType     Void Bool Int Float Dynamic
syn keyword   haxeStatement    return

syn keyword   haxeTypedef1     typedef
syn keyword   haxeStructure    var enum
syn keyword   haxeScopeDecl    private public
syn keyword   haxeScopeDecl2   static override final dynamic
syn keyword   haxeFunctionDef  function

syn keyword   haxeExceptions   throw try catch finally untyped
syn keyword   haxeAssert       assert
syn keyword   haxeMethodDecl   synchronized throws
syn keyword   haxeClassDecl    extends implements interface
syn match     haxeDelimiter    "[;:=\.]"
syn match     haxeOperator     "\(\.\.\.\|\*\|+\|-\|<<\|>>\|\/\|!\|||\|&&\|%\)"
syn match     haxeComparison   "\(==\|<=\|>=\|<\|>\|!=\)"
syn match     haxeOptionalVars contained "?[a-zA-Z_]\+"

syn match     haxeFunctionRef  "[_$a-zA-Z][_$a-zA-Z0-9_]*("me=e-1

" We use a match here to differentiate the keyword class from MyClass.class 
syn match     haxeTypedef      "\.\s*\<class\>"ms=s+1
syn match     haxeClassDecl    "^class\>"
syn match     haxeClassDecl    "[^.]\s*\<class\>"ms=s+1
syn keyword   haxeBranch       break continue nextgroup=haxeUserLabelRef skipwhite
syn match     haxeUserLabelRef "\k\+" contained
syn match     haxeClassDef     "\(^\s*class\s*\)\@<=[_$a-zA-Z][_$a-zA-Z0-9_]*" contains=haxeTypedef,haxeClassDecl

syn match     haxeLangClass    "\<System\>"
syn keyword   haxeLangClass    Array ArrayAccess Class Date DateTools EReg Enum
syn keyword   haxeLangClass    Hash IntHash IntIter Iterable Iterator Lambda
syn keyword   haxeLangClass    List Math Null Reflect Std String StringBug
syn keyword   haxeLangClass    StringTools Type UInt ValueType Xml XmlType

syn keyword   haxeFlashTop     flash
syn keyword   haxeFlashInner   accessibility deskdop display errors events
syn keyword   haxeFlashInner   external filters geom media net printing sampler
syn keyword   haxeFlashInner   system text ui utils xml display engine
syn keyword   haxeFlashFinal   BitmapData ExternalInterface BevelFilter
syn keyword   haxeFlashFinal   BitmapFilter BlurFilter ColorMatrixFilter ConvolutionFilter
syn keyword   haxeFlashFinal   DisplacementMapFilter DropShadowFilter GlowFilter GradientBevelFilter
syn keyword   haxeFlashFinal   GradientGlowFilter ColorTransform Matrix Point Rectangle Transform
syn keyword   haxeFlashFinal   FileReference FileReferenceList Capabilities IME Security StyleSheet
syn keyword   haxeFlashFinal   TextRenderer Accessibility Boot Button Camera Color ContextMenu
syn keyword   haxeFlashFinal   ContextMenuItem ExtendedKey Key Lib LoadVars
syn keyword   haxeFlashFinal   LocalConnection Microphone Mouse MovieClip
syn keyword   haxeFlashFinal   MovieClipLoader NetConnection NetStream PrintJob
syn keyword   haxeFlashFinal   Selection SelectionListener SharedObject Sound
syn keyword   haxeFlashFinal   Stage System TextField TextFormat TextSnapshot
syn keyword   haxeFlashFinal   Video XMLRequest XMLSocket
syn keyword   haxeFlash9Final  Accessibility AccessibilityImplementation
syn keyword   haxeFlash9Final  AccessibilityProperties Clipboard
syn keyword   haxeFlash9Final  ClipboardFormats ClipboardTransferMode AVM1Movie
syn keyword   haxeFlash9Final  ActionScriptVersion Bitmap BitmapData
syn keyword   haxeFlash9Final  BitmapDataChannel BlendMode CapsStyle
syn keyword   haxeFlash9Final  DisplayObject DisplayObjectContainer FrameLabel
syn keyword   haxeFlash9Final  GradientType Graphics GraphicsBitmapFill
syn keyword   haxeFlash9Final  GraphicsEndFill GraphicsGradientFill GraphicsPath
syn keyword   haxeFlash9Final  GraphicsPathCommand GraphicsPathWinding
syn keyword   haxeFlash9Final  GraphicsShaderFill GraphicsSolidFill
syn keyword   haxeFlash9Final  GraphicsStroke GraphicsTrianglePath
syn keyword   haxeFlash9Final  IBitmapDrawable IGraphicsData IGraphicsFill
syn keyword   haxeFlash9Final  IGraphicsPath IGraphicsStroke InteractiveObject
syn keyword   haxeFlash9Final  InterpolationMethod JointStyle
syn keyword   haxeFlash9Final  LineScaleMode Loader LoaderInfo MorphShape
syn keyword   haxeFlash9Final  MovieClip PixelSnapping SWFVersion
syn keyword   haxeFlash9Final  Scene Shader ShaderData ShaderInput ShaderJob ShaderParameter
syn keyword   haxeFlash9Final  ShaderParameterType ShaderPrecision Shape
syn keyword   haxeFlash9Final  SimpleButton SpreadMethod Sprite
syn keyword   haxeFlash9Final  Stage StageAlign StageDisplayState StageQuality
syn keyword   haxeFlash9Final  StageScaleMode TriangleCulling
syn keyword   haxeFlash9Final  EOFError Error IOError Illegal OperationError
syn keyword   haxeFlash9Final  InvalidSWFError MemoryError ScriptTimeoutError
syn keyword   haxeFlash9Final  StackOverflowError ActivityEventAsyncErrorEvent
syn keyword   haxeFlash9Final  ContextMenuEvent DataEvent ErrorEvent Event
syn keyword   haxeFlash9Final  EventDispatcher EventPhase FocusEvent
syn keyword   haxeFlash9Final  FullScreenEvent HTTPStatusEvent IEventDispatcher IMEEvent
syn keyword   haxeFlash9Final  IOErrorEvent KeyboardEvent MouseEvent
syn keyword   haxeFlash9Final  NetFilterEvent NetStatusEvent ProgressEvent
syn keyword   haxeFlash9Final  SampleDataEvent SecurityErrorEvent ShaderEvent StatusEvent
syn keyword   haxeFlash9Final  SyncEvent TextEvent TimerEvent WeakFunctionClosure WeakMethodClosure
syn keyword   haxeFlash9Final  ExternalInterface BevelFilter BitmapFilter
syn keyword   haxeFlash9Final  BitmapFilterQuality BitmapFilterType
syn keyword   haxeFlash9Final  BlurFilter ColorMatrixFilter ConvolutionFilter DisplacementMapFilter
syn keyword   haxeFlash9Final  DisplacementMapFilterMode DropShadowFilter
syn keyword   haxeFlash9Final  GlowFilter GradientBevelFilter
syn keyword   haxeFlash9Final  GradientGlowFilter ShaderFilter ColorTransform
syn keyword   haxeFlash9Final  Matrix Matrix3D Orientation3D
syn keyword   haxeFlash9Final  PerspectiveProjection Point Rectangle Transform
syn keyword   haxeFlash9Final  Utils3D Vector3D Camera ID3Info
syn keyword   haxeFlash9Final  Microphone Sound SoundChannel SoundCodec SoundLoaderContext SoundMixer
syn keyword   haxeFlash9Final  SoundTransform Video DynamicPropertyOutput FileFilter FileReference
syn keyword   haxeFlash9Final  FileReferenceList IDynamicPropertyOutput
syn keyword   haxeFlash9Final  IDynamicPropertyWriter LocalConnection
syn keyword   haxeFlash9Final  NetConnection NetStream NetStreamInfo NetSTreamPlayOptions
syn keyword   haxeFlash9Final  NetSTreamPlayTransitions ObjectEncoding Responder SharedObject
syn keyword   haxeFlash9Final  SharedObjectFlushStatus Socket URLLoader URLLoaderDataFormat URLRequest
syn keyword   haxeFlash9Final  URLRequestHeader URLRequestMethod URLStream
syn keyword   haxeFlash9Final  URLVariables XMLSocket PrintJob
syn keyword   haxeFlash9Final  PrintJobOptions PrintJobOrientation Api
syn keyword   haxeFlash9Final  DeleteObjectSample NewObjectSample
syn keyword   haxeFlash9Final  Sample StackFrame ApplicationDomain Capabilities FSCommand IME
syn keyword   haxeFlash9Final  IMEConversionMode JPEGLoaderContext
syn keyword   haxeFlash9Final  LoaderContext Security SecurityDomain
syn keyword   haxeFlash9Final  SecurityPanel System
syn keyword   haxeFlash9Final  BreakOpportunity CFFHinting ContentElement
syn keyword   haxeFlash9Final  DigitCase DigitWidth EastAsianJustifier ElementFormat FontDescription
syn keyword   haxeFlash9Final  FontLookup FontMetrics FontPosture FontWeight
syn keyword   haxeFlash9Final  GraphicElement GroupElement
syn keyword   haxeFlash9Final  JustificationStyle Kerning LIgatureLevel
syn keyword   haxeFlash9Final  LineJustification RenderingMode
syn keyword   haxeFlash9Final  SpaceJustifier TabAlignment TabStop TextBaseline TextBlock TextElement
syn keyword   haxeFlash9Final  TextJustifier TextLine TextLineCreationResult TextLineMirrorRegion
syn keyword   haxeFlash9Final  TextLineValidity TextRotation TypographicCase
syn keyword   haxeFlash9Final  AntiAliasType CSMSettings Font
syn keyword   haxeFlash9Final  FontStyle FontType GridFitType StaticText StyleSheet TextColorType
syn keyword   haxeFlash9Final  TextDisplayMode TextExtent TextField
syn keyword   haxeFlash9Final  TextFieldAutoSize TextFieldType TextFormat
syn keyword   haxeFlash9Final  TextFormatAlign TextFormatDisplay TextLineMetrics TextRenderer TextRun
syn keyword   haxeFlash9Final  TextSnapshot Trace ContextMenu ContextMenuBuiltInItems
syn keyword   haxeFlash9Final  ContextMenuClipboardItems ContextMenuItem KeyLocation Keyboard Mouse
syn keyword   haxeFlash9Final  MouseCursor ByteArray Dictionary Endian
syn keyword   haxeFlash9Final  IDataInput IDataOutput IExternalizable
syn keyword   haxeFlash9Final  Namespace ObjectInput ObjectOutput Proxy QName SetIntervalTimer Timer
syn keyword   haxeFlash9Final  TypedDictionary XML XMLDocument XMLList XMLNode
syn keyword   haxeFlash9Final  XMLNodeType XMLParser XMLTag
syn keyword   haxeFlash9Final  Boot Lib Memory Vector

HaxeHiLink    haxeLangObject   haxeConstant
syn cluster   haxeTop          add=haxeLangObject,haxeLangClass
syn cluster   haxeClasses      add=haxeLangClass,haxeFlashClass

if filereadable(expand("<sfile>:p:h")."/haxeid.vim")
  source <sfile>:p:h/haxeid.vim
endif

if !exists("haxe_no_trail_space_error")
  syn match   haxeSpaceError   "\s\+$"
endif
if !exists("haxe_no_tab_space_error")
  syn match   haxeSpaceError   " \+\t"me=e-1
endif

syn region    haxeLabelRegion  transparent matchgroup=haxeLabel start="\<case\>"
                               \ matchgroup=NONE end=":"
                               \ contains=haxeNumber,haxeChr,haxeNumber2
syn match     haxeUserLabel    "\({\s*\|^\s*\|,\s*\)\@<=[_$a-zA-Z][_$a-zA-Z0-9_]*:\s"he=e-1 contains=haxeDelimiter
                               \ contains=haxeLabel
syn keyword   haxeLabel        default never

" Everything - used in parenthases checking or something
syn cluster   haxeTop          add=haxeExternal,haxeError,haxeError,haxeBranch,
                               \ haxeLabelRegion,haxeLabel,haxeConditional,
                               \ haxeRepeat,haxeBoolean,haxeConstant,
                               \ haxeTypedef,haxeOperator,haxeType,haxeCoreType,
                               \ haxeStatement,haxeStorageClass,haxeAssert,
                               \ haxeExceptions,haxeMethodDecl,haxeClassDecl,
                               \ haxeClassDecl,haxeClassDecl,haxeScopeDecl,
                               \ haxeError,haxeError2,haxeUserLabel,
                               \ haxeLangObject,haxeFlashTop,haxeFlashInner,
                               \ haxeFlashFinal,haxeFlash9Final,haxeFunctionRef,
                               \ haxeComparison,haxeOptionalVars

" Comments
syn keyword   haxeTodo         contained TODO FIXME XXX
if exists("haxe_comment_strings")
  syn region  haxeCmString     contained start=+"+ end=+"+ end=+$+
                               \ end=+\*/+me=s-1,he=s-1
                               \ contains=haxeSpecial,haxeCmStar,haxeSpecChr,@Spell
  syn region  haxeCm2String    contained start=+"+ end=+$\|"+
                               \ contains=haxeSpecial,haxeSpecChr,@Spell
  syn match   haxeCmCharacter  contained "'\\[^']\{1,6\}'" contains=haxeSpecChr
  syn match   haxeCmCharacter  contained "'\\''" contains=haxeSpecChr
  syn match   haxeCmCharacter  contained "'[^\\]'"
  syn cluster haxeCmSpecial    add=haxeCmString,haxeCmCharacter,haxeNumber,haxeNumber2
  syn cluster haxeCmSpecial2   add=haxeCm2String,haxeCmCharacter,haxeNumber,haxeNumber2
endif
syn region    haxeCm           start="/\*" end="\*/"
                               \ contains=@haxeCmSpecial,haxeTodo,@Spell
syn match     haxeCmStar       contained "^\s*\*[^/]"me=e-1
syn match     haxeCmStar       contained "^\s*\*$"
syn match     haxeLineCm       "//.*" contains=@haxeCmSpecial2,haxeTodo,@Spell
HaxeHiLink    haxeCmString     haxeDocTags
HaxeHiLink    haxeCm2String    haxeString
HaxeHiLink    haxeCmCharacter  haxeChr
syn cluster   haxeTop          add=haxeCm,haxeLineCm
if exists("haxe_haxedoc") || main_syntax == 'jsp'
  syntax case ignore
  " syntax coloring for haxedoc comments (HTML)
  " syntax include @haxeHtml <sfile>:p:h/html.vim
  " unlet b:current_syntax
  syn region  haxeDocCm        start="/\*\*" end="\*/" keepend
                               \ contains=haxeCmTitle,@haxeHtml,haxeDocTags,haxeTodo,@Spell,haxeProposedTags
  syn region  haxeCmTitle      contained matchgroup=haxeDocCm start="/\*\*"
                               \ matchgroup=haxeCmTitle keepend end="\.$"
                               \ end="\.[ \t\r<]"me=e-1
                               \ end="[^{]@"me=s-2,he=s-1 end="\*/"me=s-1,he=s-1
                               \ contains=@haxeHtml,haxeCmStar,haxeTodo,@Spell,haxeDocTags,haxeProposedTags
  syn region  haxeDocTags      contained start="{@\(link\|linkplain\|inherit[Dd]oc\|doc[rR]oot\|value\)" 
                               \ end="}"
  syn match   haxeDocTags      contained "@\(see\|param\|exception\|throws\|since\)\s\+\S\+"
                               \ contains=haxeDocParam
  syn match   haxeDocParam     contained "\s\S\+"
  syn match   haxeDocTags      contained "@\(version\|author\|return\|deprecated\|serial\|serialField\|serialData\)\>"
  syn match   haxeProposedTags contained "@\(category\|example\|tutorial\|index\|exclude\|todo\|internal\|obsolete\)\>"
  syntax case match
endif
syn match     haxeCm           "/\*\*/"  " Edge case


" Strings and constants
syn match     haxeSpecError    contained "\\."
"syn match     haxeSpecChrError contained "[^']"
syn match     haxeSpecChr      contained "\\\([4-9]\d\|[0-3]\d\d\|[\"\\'ntbrf]\|u\x\{4\}\)"
syn match     haxeEregEscape   contained "\(\\\\\|\\/\)"
syn region    haxeEreg         start=+\~\/+ end=+\/[gims]*+ contains=haxeEregEscape

syn region    haxeString       start=+"+ end=+"+ contains=haxeSpecChr,haxeSpecError,@Spell
syn region    haxeSingleString start=+'+ end=+'+ 
syn match     haxeChr          "'[^']*'" contains=haxeSpecChr,haxeSpecChrError
syn match     haxeChr          "'\\''" contains=haxeSpecChr
syn match     haxeChr          "'[^\\]'"
syn match     haxeNumber       "\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lL]\=\>" contains=haxeSpecNum
"syn match     haxeNumber       "\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syn match     haxeNumber2      "\(\<\d\+\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\=" contains=haxeSpecNum
syn match     haxeNumber2      "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>" contains=haxeSpecNum
syn match     haxeNumber2      "\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>" contains=haxeSpecNum
syn match     haxeSpecNum      contained "\(0[xX]\|[\.+-]\)"

syn region    haxeCondIf       start="#if \+!\?" end="\(\W\|$\)" skip="([A-Za-z0-9_ |&!]\+)"
syn region    haxeCondElseIf   start="#elseif \+!\?" end="\(\W\|$\)" skip="([A-Za-z0-9_ |&!]\+)"
syn match     haxeCondElse     "#else\s*$"
syn match     haxeCondEnd      "#end"
syn match     haxeCondError    "#else .*$"

" unicode characters
syn match     haxeSpecial      "\\u\d\{4\}"

syn match     haxeType         ":[a-zA-Z_\.]\+"
                               \ contains=haxeDelimiter,haxeCoreType,haxeFlashTop,haxeFlashInner,haxeFlashFinal,haxeFlash9Final

syn cluster   haxeTop          add=haxeString,haxeChr,haxeNumber,haxeNumber2
syn cluster   haxeTop          add=haxeSpecial,haxeStringError,haxeDelimiter,haxeType

syn keyword   haxeTraceFun     trace contained
syn region    haxeTrace        start=+\(^\s*\)\@<=trace(+ end=+);+ contains=haxeTraceFun

if exists("haxe_highlight_functions")
 if haxe_highlight_functions == "indent"
  syn match   haxeFuncDef      "^\(\t\| \{4\}\)[_$a-zA-Z][_$a-zA-Z0-9_. \[\]]*([^-+*/()]*)"
                               \ contains=haxeType,haxeStorageClass,@haxeClasses
  syn region  haxeFuncDef      start=+^\(\t\| \{4\}\)[$_a-zA-Z][$_a-zA-Z0-9_. \[\]]*([^-+*/()]*,\s*+
                               \ end=+)+ contains=haxeType,haxeStorageClass,@haxeClasses
  syn match   haxeFuncDef      "^  [$_a-zA-Z][$_a-zA-Z0-9_. \[\]]*([^-+*/()]*)"
                               \ contains=haxeType,haxeStorageClass,@haxeClasses
  syn region  haxeFuncDef      start=+^  [$_a-zA-Z][$_a-zA-Z0-9_. \[\]]*([^-+*/()]*,\s*+
                               \ end=+)+
                               \ contains=haxeType,haxeStorageClass,@haxeClasses
 else
  " This line catches method declarations at any indentation>0, but it assumes
  " two things:
  "   1. class names are always capitalized (ie: Button)
  "   2. method names are never capitalized (except constructors, of course)
  syn region  haxeFuncDef      start=+\s\+\(\(void\|boolean\|char\|byte\|short\|int\|long\|float\|double\|\([A-Za-z_][A-Za-z0-9_$]*\.\)*[A-Z][A-Za-z0-9_$]*\)\(\[\]\)*\s\+[a-z][A-Za-z0-9_$]*\|[A-Z][A-Za-z0-9_$]*\)\s*(+
                               \ end=+)+
                               \ contains=haxeType,haxeStorageClass,haxeCm,haxeLineCm,@haxeClasses
 endif
 syn match    haxeBraces       "[{}]"
 syn cluster  haxeTop          add=haxeFuncDef,haxeBraces
endif

if exists("haxe_mark_braces_in_parens_as_errors")
  syn match   haxeInParen      contained "[{}]"
  HaxeHiLink  haxeInParen      haxeError
  syn cluster haxeTop          add=haxeInParen
endif

" catch errors caused by wrong parenthesis
syn region    haxeParenT       transparent matchgroup=haxeParen start="("
                               \ end=")" contains=@haxeTop,haxeParenT1
syn region    haxeParenT1      transparent matchgroup=haxeParen1 start="("
                               \ end=")" contains=@haxeTop,haxeParenT2 contained
syn region    haxeParenT2      transparent matchgroup=haxeParen2 start="("
                               \ end=")" contains=@haxeTop,haxeParenT  contained
syn match     haxeParenError   ")"
HaxeHiLink    haxeParenError   haxeError


if !exists("haxe_minlines")
  let haxe_minlines = 5000
endif
exec "syn sync ccomment haxeCm minlines=" . haxe_minlines
syn sync linebreaks=30

" The default highlighting.
if version >= 508 || !exists("did_haxe_syn_inits")
  if version < 508
    let did_haxe_syn_inits = 1
  endif

  HaxeHiLink  haxeFunctionDef  Identifier
  HaxeHiLink  haxeFuncDef      Identifier
  HaxeHiLink  haxeFunctionRef  Function
  HaxeHiLink  haxeBraces       Function
  HaxeHiLink  haxeBranch       Conditional
  HaxeHiLink  haxeUserLabelRef haxeUserLabel
  HaxeHiLink  haxeLabel        Label
  HaxeHiLink  haxeUserLabel    Label
  HaxeHiLink  haxeConditional  Conditional
  HaxeHiLink  haxeRepeat       Repeat
  HaxeHiLink  haxeExceptions   Exception
  HaxeHiLink  haxeAssert       Statement

  HaxeHiLink  haxeClassDef     Underlined
  HaxeHiLink  haxeStructure    Structure
  HaxeHiLink  haxeMethodDecl   haxeStorageClass
  HaxeHiLink  haxeClassDecl    Structure
  HaxeHiLink  haxeScopeDecl    StorageClass
  HaxeHiLink  haxeScopeDecl2   Tag
  HaxeHiLink  haxeBoolean      Boolean
  HaxeHiLink  haxeSpecial      Special
  HaxeHiLink  haxeSpecError    Error
  HaxeHiLink  haxeSpecChrError Error
  HaxeHiLink  haxeString       String
  HaxeHiLink  haxeSingleString Character

  HaxeHiLink  haxeEreg         Number
  HaxeHiLink  haxeEregEscape   Debug
  HaxeHiLink  haxeChr          Character
  HaxeHiLink  haxeSpecChr      SpecialChar
  HaxeHiLink  haxeNumber       Number
  HaxeHiLink  haxeNumber2      Float
  HaxeHiLink  haxeSpecNum      Boolean
  HaxeHiLink  haxeError        Error
  HaxeHiLink  haxeStringError  Debug
  HaxeHiLink  haxeStatement    Statement
  HaxeHiLink  haxeOperator     Operator
  HaxeHiLink  haxeComparison   Repeat
  HaxeHiLink  haxeTraceFun     SpecialComment
  HaxeHiLink  haxeTrace        Comment
  HaxeHiLink  haxeDelimiter    Delimiter

  HaxeHiLink  haxeCm           Comment
  HaxeHiLink  haxeDocCm        Comment
  HaxeHiLink  haxeLineCm       Comment
  HaxeHiLink  haxeConstant     Constant
  HaxeHiLink  haxeTypedef      Typedef
  HaxeHiLink  haxeTypedef1     Typedef
  HaxeHiLink  haxeTodo         Todo
  HaxeHiLink  haxeLangClass    Special
  HaxeHiLink  haxeFlashClass   Keyword
  HaxeHiLink  haxeFunction     Function
  HaxeHiLink  haxeCmTitle      Special
  HaxeHiLink  haxeDocTags      SpecialComment
  HaxeHiLink  haxeProposedTags SpecialComment
  HaxeHiLink  haxeCmStar       Comment

  HaxeHiLink  haxeDocParam     Function
  HaxeHiLink  haxeCoreType     Keyword
  HaxeHiLink  haxeType         Type
  HaxeHiLink  haxeExternal     Include
  HaxeHiLink  haxeDefine       Define
  HaxeHiLink  htmlComment      Special
  HaxeHiLink  htmlCommentPart  Special
  HaxeHiLink  haxeSpaceError   Error
  HaxeHiLink  haxeCondIf       PreCondit
  HaxeHiLink  haxeCondElseIf   PreCondit
  HaxeHiLink  haxeCondElse     PreProc
  HaxeHiLink  haxeCondEnd      PreProc

  HaxeHiLink  haxeCondError    Error

  HaxeHiLink  haxeFlashTop     PreProc
  HaxeHiLink  haxeFlashInner   Macro
  HaxeHiLink  haxeFlashFinal   Define
  HaxeHiLink  haxeFlash9Final  Define

  HaxeHiLink  haxeOptionalVars Identifier
endif

delcommand HaxeHiLink
let b:current_syntax = "haxe"
if main_syntax == 'haxe'
  unlet main_syntax
endif
let b:spell_options="contained"

endif
