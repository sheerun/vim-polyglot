if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'qml') != -1
  finish
endif

" Vim syntax file
" Language:     QML
" Maintainer:   Peter Hoeg <peter@hoeg.com>
" Updaters:     Refer to CONTRIBUTORS.md
" URL:          https://github.com/peterhoeg/vim-qml
" Changes:      `git log` is your friend
" Last Change:  2017-11-11
"
" This file is bassed on the original work done by Warwick Allison
" <warwick.allison@nokia.com> whose did about 99% of the work here.

" Based on javascript syntax (as is QML)

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'qml'
endif

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("qml_fold")
  unlet qml_fold
endif

syn case ignore

syn cluster qmlExpr              contains=qmlStringD,qmlString,SqmlCharacter,qmlNumber,qmlObjectLiteralType,qmlBoolean,qmlType,qmlJsType,qmlNull,qmlGlobal,qmlFunction
syn keyword qmlCommentTodo       TODO FIXME XXX TBD contained
syn match   qmlLineComment       "\/\/.*" contains=@Spell,qmlCommentTodo
syn match   qmlCommentSkip       "^[ \t]*\*\($\|[ \t]\+\)"
syn region  qmlComment           start="/\*"  end="\*/" contains=@Spell,qmlCommentTodo fold
syn match   qmlSpecial           "\\\d\d\d\|\\."
syn region  qmlStringD           start=+"+  skip=+\\\\\|\\"\|\\$+  end=+"+  keepend  contains=qmlSpecial,@htmlPreproc,@Spell
syn region  qmlStringS           start=+'+  skip=+\\\\\|\\'\|\\$+  end=+'+  keepend  contains=qmlSpecial,@htmlPreproc,@Spell

syn match   qmlCharacter         "'\\.'"
syn match   qmlNumber            "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn region  qmlRegexpString      start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gi]\{0,2\}\s*$+ end=+/[gi]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline
syn match   qmlObjectLiteralType "[A-Za-z][_A-Za-z0-9]*\s*\({\)\@="
syn region  qmlTernaryColon   start="?" end=":" contains=@qmlExpr,qmlBraces,qmlParens
syn match   qmlBindingProperty   "\<[A-Za-z][_A-Za-z.0-9]*\s*:"

syn keyword qmlConditional       if else switch
syn keyword qmlRepeat            while for do in
syn keyword qmlBranch            break continue
syn keyword qmlOperator          new delete instanceof typeof
syn keyword qmlJsType            Array Boolean Date Function Number Object String RegExp
syn keyword qmlType              action alias bool color date double enumeration font int list point real rect size string time url variant vector3d coordinate geocircle geopath geopolygon georectangle geoshape matrix4x4 palette quaternion vector3d vector4d
syn keyword qmlStatement         return with
syn keyword qmlBoolean           true false
syn keyword qmlNull              null undefined
syn keyword qmlIdentifier        arguments this var let const
syn keyword qmlLabel             case default
syn keyword qmlException         try catch finally throw
syn keyword qmlMessage           alert confirm prompt status
syn keyword qmlGlobal            self
syn keyword qmlDeclaration       property signal readonly
syn keyword qmlReserved          abstract boolean byte char class debugger enum export extends final float goto implements import interface long native package pragma private protected public short static super synchronized throws transient volatile

" List extracted in alphabatical order from: https://doc.qt.io/qt-5/qmltypes.html
" Qt v5.13.0

syn case match

syn keyword qmlObjectLiteralType Abstract3DSeries
syn keyword qmlObjectLiteralType AbstractActionInput
syn keyword qmlObjectLiteralType AbstractAnimation
syn keyword qmlObjectLiteralType AbstractAxis
syn keyword qmlObjectLiteralType AbstractAxis3D
syn keyword qmlObjectLiteralType AbstractAxisInput
syn keyword qmlObjectLiteralType AbstractBarSeries
syn keyword qmlObjectLiteralType AbstractButton
syn keyword qmlObjectLiteralType AbstractClipAnimator
syn keyword qmlObjectLiteralType AbstractClipBlendNode
syn keyword qmlObjectLiteralType AbstractDataProxy
syn keyword qmlObjectLiteralType AbstractGraph3D
syn keyword qmlObjectLiteralType AbstractInputHandler3D
syn keyword qmlObjectLiteralType AbstractPhysicalDevice
syn keyword qmlObjectLiteralType AbstractRayCaster
syn keyword qmlObjectLiteralType AbstractSeries
syn keyword qmlObjectLiteralType AbstractSkeleton
syn keyword qmlObjectLiteralType AbstractTextureImage
syn keyword qmlObjectLiteralType Accelerometer
syn keyword qmlObjectLiteralType AccelerometerReading
syn keyword qmlObjectLiteralType Accessible
syn keyword qmlObjectLiteralType Action
syn keyword qmlObjectLiteralType QtQuickControls
syn keyword qmlObjectLiteralType Qt3D
syn keyword qmlObjectLiteralType QtQuickControls1
syn keyword qmlObjectLiteralType ActionGroup
syn keyword qmlObjectLiteralType ActionInput
syn keyword qmlObjectLiteralType AdditiveClipBlend
syn keyword qmlObjectLiteralType Address
syn keyword qmlObjectLiteralType Affector
syn keyword qmlObjectLiteralType Age
syn keyword qmlObjectLiteralType AlphaCoverage
syn keyword qmlObjectLiteralType AlphaTest
syn keyword qmlObjectLiteralType Altimeter
syn keyword qmlObjectLiteralType AltimeterReading
syn keyword qmlObjectLiteralType AmbientLightReading
syn keyword qmlObjectLiteralType AmbientLightSensor
syn keyword qmlObjectLiteralType AmbientTemperatureReading
syn keyword qmlObjectLiteralType AmbientTemperatureSensor
syn keyword qmlObjectLiteralType AnalogAxisInput
syn keyword qmlObjectLiteralType AnchorAnimation
syn keyword qmlObjectLiteralType AnchorChanges
syn keyword qmlObjectLiteralType AngleDirection
syn keyword qmlObjectLiteralType AnimatedImage
syn keyword qmlObjectLiteralType AnimatedSprite
syn keyword qmlObjectLiteralType Animation
syn keyword qmlObjectLiteralType AnimationController
syn keyword qmlObjectLiteralType QtQuick
syn keyword qmlObjectLiteralType AnimationController
syn keyword qmlObjectLiteralType Qt3D
syn keyword qmlObjectLiteralType AnimationGroup
syn keyword qmlObjectLiteralType Animator
syn keyword qmlObjectLiteralType ApplicationWindow
syn keyword qmlObjectLiteralType QtQuickControls
syn keyword qmlObjectLiteralType ApplicationWindow
syn keyword qmlObjectLiteralType QtQuickControls1
syn keyword qmlObjectLiteralType ApplicationWindowStyle
syn keyword qmlObjectLiteralType AreaSeries
syn keyword qmlObjectLiteralType Armature
syn keyword qmlObjectLiteralType AttenuationModelInverse
syn keyword qmlObjectLiteralType AttenuationModelLinear
syn keyword qmlObjectLiteralType Attractor
syn keyword qmlObjectLiteralType Attribute
syn keyword qmlObjectLiteralType Audio
syn keyword qmlObjectLiteralType AudioCategory
syn keyword qmlObjectLiteralType AudioEngine
syn keyword qmlObjectLiteralType AudioListener
syn keyword qmlObjectLiteralType AudioSample
syn keyword qmlObjectLiteralType AuthenticationDialogRequest
syn keyword qmlObjectLiteralType Axis
syn keyword qmlObjectLiteralType AxisAccumulator
syn keyword qmlObjectLiteralType AxisSetting

syn keyword qmlObjectLiteralType BackspaceKey
syn keyword qmlObjectLiteralType Bar3DSeries
syn keyword qmlObjectLiteralType BarCategoryAxis
syn keyword qmlObjectLiteralType BarDataProxy
syn keyword qmlObjectLiteralType Bars3D
syn keyword qmlObjectLiteralType BarSeries
syn keyword qmlObjectLiteralType BarSet
syn keyword qmlObjectLiteralType BaseKey
syn keyword qmlObjectLiteralType Behavior
syn keyword qmlObjectLiteralType Binding
syn keyword qmlObjectLiteralType Blend
syn keyword qmlObjectLiteralType BlendedClipAnimator
syn keyword qmlObjectLiteralType BlendEquation
syn keyword qmlObjectLiteralType BlendEquationArguments
syn keyword qmlObjectLiteralType BlitFramebuffer
syn keyword qmlObjectLiteralType BluetoothDiscoveryModel
syn keyword qmlObjectLiteralType BluetoothService
syn keyword qmlObjectLiteralType BluetoothSocket
syn keyword qmlObjectLiteralType BorderImage
syn keyword qmlObjectLiteralType BorderImageMesh
syn keyword qmlObjectLiteralType BoxPlotSeries
syn keyword qmlObjectLiteralType BoxSet
syn keyword qmlObjectLiteralType BrightnessContrast
syn keyword qmlObjectLiteralType Buffer
syn keyword qmlObjectLiteralType BusyIndicator
syn keyword qmlObjectLiteralType BusyIndicatorStyle
syn keyword qmlObjectLiteralType Button
syn keyword qmlObjectLiteralType ButtonAxisInput
syn keyword qmlObjectLiteralType ButtonGroup
syn keyword qmlObjectLiteralType ButtonStyle


syn keyword qmlObjectLiteralType Calendar
syn keyword qmlObjectLiteralType CalendarStyle
syn keyword qmlObjectLiteralType Camera
syn keyword qmlObjectLiteralType Camera3D
syn keyword qmlObjectLiteralType CameraCapabilities
syn keyword qmlObjectLiteralType CameraCapture
syn keyword qmlObjectLiteralType CameraExposure
syn keyword qmlObjectLiteralType CameraFlash
syn keyword qmlObjectLiteralType CameraFocus
syn keyword qmlObjectLiteralType CameraImageProcessing
syn keyword qmlObjectLiteralType CameraLens
syn keyword qmlObjectLiteralType CameraRecorder
syn keyword qmlObjectLiteralType CameraSelector
syn keyword qmlObjectLiteralType CandlestickSeries
syn keyword qmlObjectLiteralType CandlestickSet
syn keyword qmlObjectLiteralType Canvas
syn keyword qmlObjectLiteralType CanvasGradient
syn keyword qmlObjectLiteralType CanvasImageData
syn keyword qmlObjectLiteralType CanvasPixelArray
syn keyword qmlObjectLiteralType Category
syn keyword qmlObjectLiteralType CategoryAxis
syn keyword qmlObjectLiteralType CategoryAxis3D
syn keyword qmlObjectLiteralType CategoryModel
syn keyword qmlObjectLiteralType CategoryRange
syn keyword qmlObjectLiteralType ChangeLanguageKey
syn keyword qmlObjectLiteralType ChartView
syn keyword qmlObjectLiteralType CheckBox
syn keyword qmlObjectLiteralType CheckBoxStyle
syn keyword qmlObjectLiteralType CheckDelegate
syn keyword qmlObjectLiteralType CircularGauge
syn keyword qmlObjectLiteralType CircularGaugeStyle
syn keyword qmlObjectLiteralType ClearBuffers
syn keyword qmlObjectLiteralType ClipAnimator
syn keyword qmlObjectLiteralType ClipPlane
syn keyword qmlObjectLiteralType CloseEvent
syn keyword qmlObjectLiteralType ColorAnimation
syn keyword qmlObjectLiteralType ColorDialog
syn keyword qmlObjectLiteralType ColorDialogRequest
syn keyword qmlObjectLiteralType ColorGradient
syn keyword qmlObjectLiteralType ColorGradientStop
syn keyword qmlObjectLiteralType Colorize
syn keyword qmlObjectLiteralType ColorMask
syn keyword qmlObjectLiteralType ColorOverlay
syn keyword qmlObjectLiteralType Column
syn keyword qmlObjectLiteralType ColumnLayout
syn keyword qmlObjectLiteralType ComboBoxComboBoxStyle
syn keyword qmlObjectLiteralType Compass
syn keyword qmlObjectLiteralType CompassReading
syn keyword qmlObjectLiteralType Component
syn keyword qmlObjectLiteralType Component3D
syn keyword qmlObjectLiteralType ComputeCommand
syn keyword qmlObjectLiteralType ConeGeometry
syn keyword qmlObjectLiteralType ConeMesh
syn keyword qmlObjectLiteralType ConicalGradient
syn keyword qmlObjectLiteralType Connections
syn keyword qmlObjectLiteralType ContactDetail
syn keyword qmlObjectLiteralType ContactDetails
syn keyword qmlObjectLiteralType Container
syn keyword qmlObjectLiteralType Context2D
syn keyword qmlObjectLiteralType ContextMenuRequest
syn keyword qmlObjectLiteralType Control
syn keyword qmlObjectLiteralType CoordinateAnimation
syn keyword qmlObjectLiteralType CuboidGeometry
syn keyword qmlObjectLiteralType CuboidMesh
syn keyword qmlObjectLiteralType CullFace
syn keyword qmlObjectLiteralType CumulativeDirection
syn keyword qmlObjectLiteralType Custom3DItem
syn keyword qmlObjectLiteralType Custom3DLabel
syn keyword qmlObjectLiteralType Custom3DVolume
syn keyword qmlObjectLiteralType CustomParticle
syn keyword qmlObjectLiteralType CylinderGeometry
syn keyword qmlObjectLiteralType CylinderMesh

syn keyword qmlObjectLiteralType Date
syn keyword qmlObjectLiteralType DateTimeAxis
syn keyword qmlObjectLiteralType DelayButton
syn keyword qmlObjectLiteralType DelayButtonStyle
syn keyword qmlObjectLiteralType DelegateChoice
syn keyword qmlObjectLiteralType DelegateChooser
syn keyword qmlObjectLiteralType DelegateModel
syn keyword qmlObjectLiteralType DelegateModelGroup
syn keyword qmlObjectLiteralType DepthTest
syn keyword qmlObjectLiteralType Desaturate
syn keyword qmlObjectLiteralType Dial
syn keyword qmlObjectLiteralType Dialog
syn keyword qmlObjectLiteralType DialogButtonBox
syn keyword qmlObjectLiteralType DialStyle
syn keyword qmlObjectLiteralType DiffuseMapMaterial
syn keyword qmlObjectLiteralType DiffuseSpecularMapMaterial
syn keyword qmlObjectLiteralType DiffuseSpecularMaterial
syn keyword qmlObjectLiteralType Direction
syn keyword qmlObjectLiteralType DirectionalBlur
syn keyword qmlObjectLiteralType DirectionalLight
syn keyword qmlObjectLiteralType DispatchCompute
syn keyword qmlObjectLiteralType Displace
syn keyword qmlObjectLiteralType DistanceReading
syn keyword qmlObjectLiteralType DistanceSensor
syn keyword qmlObjectLiteralType Dithering
syn keyword qmlObjectLiteralType DoubleValidator
syn keyword qmlObjectLiteralType Drag
syn keyword qmlObjectLiteralType DragEvent
syn keyword qmlObjectLiteralType DragHandler
syn keyword qmlObjectLiteralType Drawer
syn keyword qmlObjectLiteralType DropArea
syn keyword qmlObjectLiteralType DropShadow
syn keyword qmlObjectLiteralType DwmFeatures
syn keyword qmlObjectLiteralType DynamicParameter

syn keyword qmlObjectLiteralType EditorialModel
syn keyword qmlObjectLiteralType Effect
syn keyword qmlObjectLiteralType EllipseShape
syn keyword qmlObjectLiteralType Emitter
syn keyword qmlObjectLiteralType EnterKey
syn keyword qmlObjectLiteralType EnterKeyAction
syn keyword qmlObjectLiteralType Entity
syn keyword qmlObjectLiteralType EntityLoader
syn keyword qmlObjectLiteralType EnvironmentLight
syn keyword qmlObjectLiteralType EventConnection
syn keyword qmlObjectLiteralType EventPoint
syn keyword qmlObjectLiteralType EventTouchPoint
syn keyword qmlObjectLiteralType ExclusiveGroup
syn keyword qmlObjectLiteralType ExtendedAttributes
syn keyword qmlObjectLiteralType ExtrudedTextGeometry
syn keyword qmlObjectLiteralType ExtrudedTextMesh

syn keyword qmlObjectLiteralType FastBlur
syn keyword qmlObjectLiteralType FileDialog
syn keyword qmlObjectLiteralType FileDialogRequest
syn keyword qmlObjectLiteralType FillerKey
syn keyword qmlObjectLiteralType FilterKey
syn keyword qmlObjectLiteralType FinalState
syn keyword qmlObjectLiteralType FirstPersonCameraController
syn keyword qmlObjectLiteralType Flickable
syn keyword qmlObjectLiteralType Flipable
syn keyword qmlObjectLiteralType Flow
syn keyword qmlObjectLiteralType FocusScope
syn keyword qmlObjectLiteralType FolderListModel
syn keyword qmlObjectLiteralType FontDialog
syn keyword qmlObjectLiteralType FontLoader
syn keyword qmlObjectLiteralType FontMetrics
syn keyword qmlObjectLiteralType FormValidationMessageRequest
syn keyword qmlObjectLiteralType ForwardRenderer
syn keyword qmlObjectLiteralType Frame
syn keyword qmlObjectLiteralType FrameAction
syn keyword qmlObjectLiteralType FrameGraphNode
syn keyword qmlObjectLiteralType Friction
syn keyword qmlObjectLiteralType FrontFace
syn keyword qmlObjectLiteralType FrustumCulling
syn keyword qmlObjectLiteralType FullScreenRequest

syn keyword qmlObjectLiteralType Gamepad
syn keyword qmlObjectLiteralType GamepadManager
syn keyword qmlObjectLiteralType GammaAdjust
syn keyword qmlObjectLiteralType Gauge
syn keyword qmlObjectLiteralType GaugeStyle
syn keyword qmlObjectLiteralType GaussianBlur
syn keyword qmlObjectLiteralType GeocodeModel
syn keyword qmlObjectLiteralType Geometry
syn keyword qmlObjectLiteralType GeometryRenderer
syn keyword qmlObjectLiteralType GestureEvent
syn keyword qmlObjectLiteralType Glow
syn keyword qmlObjectLiteralType GoochMaterial
syn keyword qmlObjectLiteralType Gradient
syn keyword qmlObjectLiteralType GradientStop
syn keyword qmlObjectLiteralType GraphicsApiFilter
syn keyword qmlObjectLiteralType GraphicsInfo
syn keyword qmlObjectLiteralType Gravity
syn keyword qmlObjectLiteralType Grid
syn keyword qmlObjectLiteralType GridLayout
syn keyword qmlObjectLiteralType GridMesh
syn keyword qmlObjectLiteralType GridView
syn keyword qmlObjectLiteralType GroupBox
syn keyword qmlObjectLiteralType GroupGoal
syn keyword qmlObjectLiteralType Gyroscope
syn keyword qmlObjectLiteralType GyroscopeReading

syn keyword qmlObjectLiteralType HandlerPoint
syn keyword qmlObjectLiteralType HandwritingInputPanel
syn keyword qmlObjectLiteralType HandwritingModeKey
syn keyword qmlObjectLiteralType HBarModelMapper
syn keyword qmlObjectLiteralType HBoxPlotModelMapper
syn keyword qmlObjectLiteralType HCandlestickModelMapper
syn keyword qmlObjectLiteralType HeightMapSurfaceDataProxy
syn keyword qmlObjectLiteralType HideKeyboardKey
syn keyword qmlObjectLiteralType HistoryState
syn keyword qmlObjectLiteralType HolsterReading
syn keyword qmlObjectLiteralType HolsterSensor
syn keyword qmlObjectLiteralType HorizontalBarSeries
syn keyword qmlObjectLiteralType HorizontalPercentBarSeries
syn keyword qmlObjectLiteralType HorizontalStackedBarSeries
syn keyword qmlObjectLiteralType HoverHandler
syn keyword qmlObjectLiteralType HPieModelMapper
syn keyword qmlObjectLiteralType HueSaturation
syn keyword qmlObjectLiteralType HumidityReading
syn keyword qmlObjectLiteralType HumiditySensor
syn keyword qmlObjectLiteralType HXYModelMapper

syn keyword qmlObjectLiteralType Icon
syn keyword qmlObjectLiteralType Image
syn keyword qmlObjectLiteralType ImageModel
syn keyword qmlObjectLiteralType ImageParticle
syn keyword qmlObjectLiteralType InnerShadow
syn keyword qmlObjectLiteralType InputChord
syn keyword qmlObjectLiteralType InputContext
syn keyword qmlObjectLiteralType InputEngine
syn keyword qmlObjectLiteralType InputHandler3D
syn keyword qmlObjectLiteralType InputMethod
syn keyword qmlObjectLiteralType InputModeKey
syn keyword qmlObjectLiteralType InputPanel
syn keyword qmlObjectLiteralType InputSequence
syn keyword qmlObjectLiteralType InputSettings
syn keyword qmlObjectLiteralType Instantiator
syn keyword qmlObjectLiteralType IntValidator
syn keyword qmlObjectLiteralType InvokedServices
syn keyword qmlObjectLiteralType IRProximityReading
syn keyword qmlObjectLiteralType IRProximitySensor
syn keyword qmlObjectLiteralType Item
syn keyword qmlObjectLiteralType ItemDelegate
syn keyword qmlObjectLiteralType ItemGrabResult
syn keyword qmlObjectLiteralType ItemModelBarDataProxy
syn keyword qmlObjectLiteralType ItemModelScatterDataProxy
syn keyword qmlObjectLiteralType ItemModelSurfaceDataProxy
syn keyword qmlObjectLiteralType ItemParticle
syn keyword qmlObjectLiteralType ItemSelectionModel
syn keyword qmlObjectLiteralType IviApplication
syn keyword qmlObjectLiteralType IviSurface


syn keyword qmlObjectLiteralType JavaScriptDialogRequest
syn keyword qmlObjectLiteralType Joint
syn keyword qmlObjectLiteralType JumpList
syn keyword qmlObjectLiteralType JumpListCategory
syn keyword qmlObjectLiteralType JumpListDestination
syn keyword qmlObjectLiteralType JumpListLink
syn keyword qmlObjectLiteralType JumpListSeparator

syn keyword qmlObjectLiteralType Key
syn keyword qmlObjectLiteralType KeyboardColumn
syn keyword qmlObjectLiteralType KeyboardDevice
syn keyword qmlObjectLiteralType KeyboardHandler
syn keyword qmlObjectLiteralType KeyboardLayout
syn keyword qmlObjectLiteralType KeyboardLayoutLoader
syn keyword qmlObjectLiteralType KeyboardRow
syn keyword qmlObjectLiteralType KeyboardStyle
syn keyword qmlObjectLiteralType KeyEvent
syn keyword qmlObjectLiteralType KeyframeAnimation
syn keyword qmlObjectLiteralType KeyIcon
syn keyword qmlObjectLiteralType KeyNavigation
syn keyword qmlObjectLiteralType KeyPanel
syn keyword qmlObjectLiteralType Keys

syn keyword qmlObjectLiteralType Label
syn keyword qmlObjectLiteralType Layer
syn keyword qmlObjectLiteralType LayerFilter
syn keyword qmlObjectLiteralType Layout
syn keyword qmlObjectLiteralType LayoutMirroring
syn keyword qmlObjectLiteralType Legend
syn keyword qmlObjectLiteralType LerpBlend
syn keyword qmlObjectLiteralType LevelAdjust
syn keyword qmlObjectLiteralType LevelOfDetail
syn keyword qmlObjectLiteralType LevelOfDetailBoundingSphere
syn keyword qmlObjectLiteralType LevelOfDetailLoader
syn keyword qmlObjectLiteralType LevelOfDetailSwitch
syn keyword qmlObjectLiteralType LidReading
syn keyword qmlObjectLiteralType LidSensor
syn keyword qmlObjectLiteralType Light
syn keyword qmlObjectLiteralType Light3D
syn keyword qmlObjectLiteralType LightReading
syn keyword qmlObjectLiteralType LightSensor
syn keyword qmlObjectLiteralType LinearGradient
syn keyword qmlObjectLiteralType LineSeries
syn keyword qmlObjectLiteralType LineShape
syn keyword qmlObjectLiteralType LineWidth
syn keyword qmlObjectLiteralType ListElement
syn keyword qmlObjectLiteralType ListModel
syn keyword qmlObjectLiteralType ListView
syn keyword qmlObjectLiteralType Loader
syn keyword qmlObjectLiteralType Locale
syn keyword qmlObjectLiteralType Location
syn keyword qmlObjectLiteralType LoggingCategory
syn keyword qmlObjectLiteralType LogicalDevice
syn keyword qmlObjectLiteralType LogValueAxis
syn keyword qmlObjectLiteralType LogValueAxis3DFormatter
syn keyword qmlObjectLiteralType LottieAnimation

syn keyword qmlObjectLiteralType Magnetometer
syn keyword qmlObjectLiteralType MagnetometerReading
syn keyword qmlObjectLiteralType Map
syn keyword qmlObjectLiteralType MapCircle
syn keyword qmlObjectLiteralType MapCircleObject
syn keyword qmlObjectLiteralType MapCopyrightNotice
syn keyword qmlObjectLiteralType MapGestureArea
syn keyword qmlObjectLiteralType MapIconObject
syn keyword qmlObjectLiteralType MapItemGroup
syn keyword qmlObjectLiteralType MapItemView
syn keyword qmlObjectLiteralType MapObjectView
syn keyword qmlObjectLiteralType MapParameter
syn keyword qmlObjectLiteralType MapPinchEvent
syn keyword qmlObjectLiteralType MapPolygon
syn keyword qmlObjectLiteralType MapPolygonObject
syn keyword qmlObjectLiteralType MapPolyline
syn keyword qmlObjectLiteralType MapPolylineObject
syn keyword qmlObjectLiteralType MapQuickItem
syn keyword qmlObjectLiteralType MapRectangle
syn keyword qmlObjectLiteralType MapRoute
syn keyword qmlObjectLiteralType MapRouteObject
syn keyword qmlObjectLiteralType MapType
syn keyword qmlObjectLiteralType Margins
syn keyword qmlObjectLiteralType MaskedBlur
syn keyword qmlObjectLiteralType MaskShape
syn keyword qmlObjectLiteralType Material
syn keyword qmlObjectLiteralType Matrix4x4
syn keyword qmlObjectLiteralType MediaPlayer
syn keyword qmlObjectLiteralType MemoryBarrier
syn keyword qmlObjectLiteralType Menu
syn keyword qmlObjectLiteralType MenuBar
syn keyword qmlObjectLiteralType MenuBarItem
syn keyword qmlObjectLiteralType MenuBarStyle
syn keyword qmlObjectLiteralType MenuItem
syn keyword qmlObjectLiteralType MenuSeparator
syn keyword qmlObjectLiteralType MenuStyle
syn keyword qmlObjectLiteralType Mesh
syn keyword qmlObjectLiteralType MessageDialog
syn keyword qmlObjectLiteralType ModeKey
syn keyword qmlObjectLiteralType MorphingAnimation
syn keyword qmlObjectLiteralType MorphTarget
syn keyword qmlObjectLiteralType MouseArea
syn keyword qmlObjectLiteralType MouseDevice
syn keyword qmlObjectLiteralType MouseEvent
syn keyword qmlObjectLiteralType MouseHandler
syn keyword qmlObjectLiteralType MultiPointHandler
syn keyword qmlObjectLiteralType MultiPointTouchArea
syn keyword qmlObjectLiteralType MultiSampleAntiAliasing

syn keyword qmlObjectLiteralType Navigator
syn keyword qmlObjectLiteralType NdefFilter
syn keyword qmlObjectLiteralType NdefMimeRecord
syn keyword qmlObjectLiteralType NdefRecord
syn keyword qmlObjectLiteralType NdefTextRecord
syn keyword qmlObjectLiteralType NdefUriRecord
syn keyword qmlObjectLiteralType NearField
syn keyword qmlObjectLiteralType Node
syn keyword qmlObjectLiteralType NodeInstantiator
syn keyword qmlObjectLiteralType NoDepthMask
syn keyword qmlObjectLiteralType NoDraw
syn keyword qmlObjectLiteralType NormalDiffuseMapAlphaMaterial
syn keyword qmlObjectLiteralType NormalDiffuseMapMaterial
syn keyword qmlObjectLiteralType NormalDiffuseSpecularMapMaterial
syn keyword qmlObjectLiteralType Number
syn keyword qmlObjectLiteralType NumberAnimation
syn keyword qmlObjectLiteralType NumberKey

syn keyword qmlObjectLiteralType Object3D
syn keyword qmlObjectLiteralType ObjectModel
syn keyword qmlObjectLiteralType ObjectPicker
syn keyword qmlObjectLiteralType OpacityAnimator
syn keyword qmlObjectLiteralType OpacityMask
syn keyword qmlObjectLiteralType OpenGLInfo
syn keyword qmlObjectLiteralType OrbitCameraController
syn keyword qmlObjectLiteralType OrientationReading
syn keyword qmlObjectLiteralType OrientationSensor
syn keyword qmlObjectLiteralType Overlay

syn keyword qmlObjectLiteralType Package
syn keyword qmlObjectLiteralType Page
syn keyword qmlObjectLiteralType PageIndicator
syn keyword qmlObjectLiteralType Pane
syn keyword qmlObjectLiteralType ParallelAnimation
syn keyword qmlObjectLiteralType Parameter
syn keyword qmlObjectLiteralType ParentAnimation
syn keyword qmlObjectLiteralType ParentChange
syn keyword qmlObjectLiteralType Particle
syn keyword qmlObjectLiteralType ParticleGroup
syn keyword qmlObjectLiteralType ParticlePainter
syn keyword qmlObjectLiteralType ParticleSystem
syn keyword qmlObjectLiteralType Path
syn keyword qmlObjectLiteralType PathAngleArc
syn keyword qmlObjectLiteralType PathAnimation
syn keyword qmlObjectLiteralType PathArc
syn keyword qmlObjectLiteralType PathAttribute
syn keyword qmlObjectLiteralType PathCubic
syn keyword qmlObjectLiteralType PathCurve
syn keyword qmlObjectLiteralType PathElement
syn keyword qmlObjectLiteralType PathInterpolator
syn keyword qmlObjectLiteralType PathLine
syn keyword qmlObjectLiteralType PathMove
syn keyword qmlObjectLiteralType PathPercent
syn keyword qmlObjectLiteralType PathQuad
syn keyword qmlObjectLiteralType PathSvg
syn keyword qmlObjectLiteralType PathView
syn keyword qmlObjectLiteralType PauseAnimation
syn keyword qmlObjectLiteralType PercentBarSeries
syn keyword qmlObjectLiteralType PerVertexColorMaterial
syn keyword qmlObjectLiteralType PhongAlphaMaterial
syn keyword qmlObjectLiteralType PhongMaterial
syn keyword qmlObjectLiteralType PickEvent
syn keyword qmlObjectLiteralType PickingSettings
syn keyword qmlObjectLiteralType PickLineEvent
syn keyword qmlObjectLiteralType PickPointEvent
syn keyword qmlObjectLiteralType PickTriangleEvent
syn keyword qmlObjectLiteralType Picture
syn keyword qmlObjectLiteralType PieMenu
syn keyword qmlObjectLiteralType PieMenuStyle
syn keyword qmlObjectLiteralType PieSeries
syn keyword qmlObjectLiteralType PieSlice
syn keyword qmlObjectLiteralType PinchArea
syn keyword qmlObjectLiteralType PinchEvent
syn keyword qmlObjectLiteralType PinchHandler
syn keyword qmlObjectLiteralType Place
syn keyword qmlObjectLiteralType PlaceAttribute
syn keyword qmlObjectLiteralType PlaceSearchModel
syn keyword qmlObjectLiteralType PlaceSearchSuggestionModel
syn keyword qmlObjectLiteralType PlaneGeometry
syn keyword qmlObjectLiteralType PlaneMesh
syn keyword qmlObjectLiteralType Playlist
syn keyword qmlObjectLiteralType PlaylistItem
syn keyword qmlObjectLiteralType PlayVariation
syn keyword qmlObjectLiteralType Plugin
syn keyword qmlObjectLiteralType PluginParameter
syn keyword qmlObjectLiteralType PointDirection
syn keyword qmlObjectLiteralType PointerDevice
syn keyword qmlObjectLiteralType PointerDeviceHandler
syn keyword qmlObjectLiteralType PointerEvent
syn keyword qmlObjectLiteralType PointerHandler
syn keyword qmlObjectLiteralType PointHandler
syn keyword qmlObjectLiteralType PointLight
syn keyword qmlObjectLiteralType PointSize
syn keyword qmlObjectLiteralType PolarChartView
syn keyword qmlObjectLiteralType PolygonOffset
syn keyword qmlObjectLiteralType Popup
syn keyword qmlObjectLiteralType Position
syn keyword qmlObjectLiteralType Positioner
syn keyword qmlObjectLiteralType PositionSource
syn keyword qmlObjectLiteralType PressureReading
syn keyword qmlObjectLiteralType PressureSensor
syn keyword qmlObjectLiteralType Product
syn keyword qmlObjectLiteralType ProgressBar
syn keyword qmlObjectLiteralType ProgressBarStyle
syn keyword qmlObjectLiteralType PropertyAction
syn keyword qmlObjectLiteralType PropertyAnimation
syn keyword qmlObjectLiteralType PropertyChanges
syn keyword qmlObjectLiteralType ProximityFilter
syn keyword qmlObjectLiteralType ProximityReading
syn keyword qmlObjectLiteralType ProximitySensor

syn keyword qmlObjectLiteralType QAbstractState
syn keyword qmlObjectLiteralType QAbstractTransition
syn keyword qmlObjectLiteralType QmlSensors
syn keyword qmlObjectLiteralType QSignalTransition
syn keyword qmlObjectLiteralType Qt
syn keyword qmlObjectLiteralType QtMultimedia
syn keyword qmlObjectLiteralType QtObject
syn keyword qmlObjectLiteralType QtPositioning
syn keyword qmlObjectLiteralType QuaternionAnimation
syn keyword qmlObjectLiteralType QuotaRequest

syn keyword qmlObjectLiteralType RadialBlur
syn keyword qmlObjectLiteralType RadialGradient
syn keyword qmlObjectLiteralType Radio
syn keyword qmlObjectLiteralType RadioButton
syn keyword qmlObjectLiteralType RadioButtonStyle
syn keyword qmlObjectLiteralType RadioData
syn keyword qmlObjectLiteralType RadioDelegate
syn keyword qmlObjectLiteralType RangeSlider
syn keyword qmlObjectLiteralType Ratings
syn keyword qmlObjectLiteralType RayCaster
syn keyword qmlObjectLiteralType Rectangle
syn keyword qmlObjectLiteralType RectangleShape
syn keyword qmlObjectLiteralType RectangularGlow
syn keyword qmlObjectLiteralType RecursiveBlur
syn keyword qmlObjectLiteralType RegExpValidator
syn keyword qmlObjectLiteralType RegisterProtocolHandlerRequest
syn keyword qmlObjectLiteralType RenderCapture
syn keyword qmlObjectLiteralType RenderCaptureReply
syn keyword qmlObjectLiteralType RenderPass
syn keyword qmlObjectLiteralType RenderPassFilter
syn keyword qmlObjectLiteralType RenderSettings
syn keyword qmlObjectLiteralType RenderState
syn keyword qmlObjectLiteralType RenderStateSet
syn keyword qmlObjectLiteralType RenderSurfaceSelector
syn keyword qmlObjectLiteralType RenderTarget
syn keyword qmlObjectLiteralType RenderTargetOutput
syn keyword qmlObjectLiteralType RenderTargetSelector
syn keyword qmlObjectLiteralType Repeater
syn keyword qmlObjectLiteralType ReviewModel
syn keyword qmlObjectLiteralType Rotation
syn keyword qmlObjectLiteralType RotationAnimation
syn keyword qmlObjectLiteralType RotationAnimator
syn keyword qmlObjectLiteralType RotationReading
syn keyword qmlObjectLiteralType RotationSensor
syn keyword qmlObjectLiteralType RoundButton
syn keyword qmlObjectLiteralType Route
syn keyword qmlObjectLiteralType RouteLeg
syn keyword qmlObjectLiteralType RouteManeuver
syn keyword qmlObjectLiteralType RouteModel
syn keyword qmlObjectLiteralType RouteQuery
syn keyword qmlObjectLiteralType RouteSegment
syn keyword qmlObjectLiteralType Row
syn keyword qmlObjectLiteralType RowLayout

syn keyword qmlObjectLiteralType Scale
syn keyword qmlObjectLiteralType ScaleAnimator
syn keyword qmlObjectLiteralType Scatter3D
syn keyword qmlObjectLiteralType Scatter3DSeries
syn keyword qmlObjectLiteralType ScatterDataProxy
syn keyword qmlObjectLiteralType ScatterSeries
syn keyword qmlObjectLiteralType Scene2D
syn keyword qmlObjectLiteralType Scene3D
syn keyword qmlObjectLiteralType SceneLoader
syn keyword qmlObjectLiteralType ScissorTest
syn keyword qmlObjectLiteralType Screen
syn keyword qmlObjectLiteralType ScreenRayCaster
syn keyword qmlObjectLiteralType ScriptAction
syn keyword qmlObjectLiteralType ScrollBar
syn keyword qmlObjectLiteralType ScrollIndicator
syn keyword qmlObjectLiteralType ScrollView
syn keyword qmlObjectLiteralType ScrollViewStyle
syn keyword qmlObjectLiteralType ScxmlStateMachine
syn keyword qmlObjectLiteralType SeamlessCubemap
syn keyword qmlObjectLiteralType SelectionListItem
syn keyword qmlObjectLiteralType SelectionListModel
syn keyword qmlObjectLiteralType Sensor
syn keyword qmlObjectLiteralType SensorGesture
syn keyword qmlObjectLiteralType SensorReading
syn keyword qmlObjectLiteralType SequentialAnimation
syn keyword qmlObjectLiteralType Settings
syn keyword qmlObjectLiteralType SettingsStore
syn keyword qmlObjectLiteralType ShaderEffect
syn keyword qmlObjectLiteralType ShaderEffectSource
syn keyword qmlObjectLiteralType ShaderProgram
syn keyword qmlObjectLiteralType ShaderProgramBuilder
syn keyword qmlObjectLiteralType Shape
syn keyword qmlObjectLiteralType ShapeGradient
syn keyword qmlObjectLiteralType ShapePath
syn keyword qmlObjectLiteralType ShellSurface
syn keyword qmlObjectLiteralType ShellSurfaceItem
syn keyword qmlObjectLiteralType ShiftHandler
syn keyword qmlObjectLiteralType ShiftKey
syn keyword qmlObjectLiteralType Shortcut
syn keyword qmlObjectLiteralType SignalSpy
syn keyword qmlObjectLiteralType SignalTransition
syn keyword qmlObjectLiteralType SinglePointHandler
syn keyword qmlObjectLiteralType Skeleton
syn keyword qmlObjectLiteralType SkeletonLoader
syn keyword qmlObjectLiteralType Slider
syn keyword qmlObjectLiteralType SliderStyle
syn keyword qmlObjectLiteralType SmoothedAnimation
syn keyword qmlObjectLiteralType SortPolicy
syn keyword qmlObjectLiteralType Sound
syn keyword qmlObjectLiteralType SoundEffect
syn keyword qmlObjectLiteralType SoundInstance
syn keyword qmlObjectLiteralType SpaceKey
syn keyword qmlObjectLiteralType SphereGeometry
syn keyword qmlObjectLiteralType SphereMesh
syn keyword qmlObjectLiteralType SpinBox
syn keyword qmlObjectLiteralType SpinBoxStyle
syn keyword qmlObjectLiteralType SplineSeries
syn keyword qmlObjectLiteralType SplitHandle
syn keyword qmlObjectLiteralType SplitView
syn keyword qmlObjectLiteralType SpotLight
syn keyword qmlObjectLiteralType SpringAnimation
syn keyword qmlObjectLiteralType Sprite
syn keyword qmlObjectLiteralType SpriteGoal
syn keyword qmlObjectLiteralType SpriteSequence
syn keyword qmlObjectLiteralType Stack
syn keyword qmlObjectLiteralType StackedBarSeries
syn keyword qmlObjectLiteralType StackLayout
syn keyword qmlObjectLiteralType StackView
syn keyword qmlObjectLiteralType StackViewDelegate
syn keyword qmlObjectLiteralType State
syn keyword qmlObjectLiteralType QtQml
syn keyword qmlObjectLiteralType State
syn keyword qmlObjectLiteralType StateChangeScript
syn keyword qmlObjectLiteralType StateGroup
syn keyword qmlObjectLiteralType StateMachine
syn keyword qmlObjectLiteralType StateMachineLoader
syn keyword qmlObjectLiteralType StatusBar
syn keyword qmlObjectLiteralType StatusBarStyle
syn keyword qmlObjectLiteralType StatusIndicator
syn keyword qmlObjectLiteralType StatusIndicatorStyle
syn keyword qmlObjectLiteralType StencilMask
syn keyword qmlObjectLiteralType StencilOperation
syn keyword qmlObjectLiteralType StencilOperationArguments
syn keyword qmlObjectLiteralType StencilTest
syn keyword qmlObjectLiteralType StencilTestArguments
syn keyword qmlObjectLiteralType Store
syn keyword qmlObjectLiteralType String
syn keyword qmlObjectLiteralType Supplier
syn keyword qmlObjectLiteralType Surface3D
syn keyword qmlObjectLiteralType Surface3DSeries
syn keyword qmlObjectLiteralType SurfaceDataProxy
syn keyword qmlObjectLiteralType SwipeDelegate
syn keyword qmlObjectLiteralType SwipeView
syn keyword qmlObjectLiteralType Switch
syn keyword qmlObjectLiteralType SwitchDelegate
syn keyword qmlObjectLiteralType SwitchStyle
syn keyword qmlObjectLiteralType SymbolModeKey
syn keyword qmlObjectLiteralType SystemPalette

syn keyword qmlObjectLiteralType Tab
syn keyword qmlObjectLiteralType TabBar
syn keyword qmlObjectLiteralType TabButton
syn keyword qmlObjectLiteralType TableView
syn keyword qmlObjectLiteralType TableViewColumn
syn keyword qmlObjectLiteralType TableViewStyle
syn keyword qmlObjectLiteralType TabView
syn keyword qmlObjectLiteralType TabViewStyle
syn keyword qmlObjectLiteralType TapHandler
syn keyword qmlObjectLiteralType TapReading
syn keyword qmlObjectLiteralType TapSensor
syn keyword qmlObjectLiteralType TargetDirection
syn keyword qmlObjectLiteralType TaskbarButton
syn keyword qmlObjectLiteralType Technique
syn keyword qmlObjectLiteralType TechniqueFilter
syn keyword qmlObjectLiteralType TestCase
syn keyword qmlObjectLiteralType Text
syn keyword qmlObjectLiteralType Text2DEntity
syn keyword qmlObjectLiteralType TextArea
syn keyword qmlObjectLiteralType TextAreaStyle
syn keyword qmlObjectLiteralType TextEdit
syn keyword qmlObjectLiteralType TextField
syn keyword qmlObjectLiteralType TextFieldStyle
syn keyword qmlObjectLiteralType TextInput
syn keyword qmlObjectLiteralType TextMetrics
syn keyword qmlObjectLiteralType TextureImage
syn keyword qmlObjectLiteralType Theme3D
syn keyword qmlObjectLiteralType ThemeColor
syn keyword qmlObjectLiteralType ThresholdMask
syn keyword qmlObjectLiteralType ThumbnailToolBar
syn keyword qmlObjectLiteralType ThumbnailToolButton
syn keyword qmlObjectLiteralType TiltReading
syn keyword qmlObjectLiteralType TiltSensor
syn keyword qmlObjectLiteralType TimeoutTransition
syn keyword qmlObjectLiteralType Timer
syn keyword qmlObjectLiteralType ToggleButton
syn keyword qmlObjectLiteralType ToggleButtonStyle
syn keyword qmlObjectLiteralType ToolBar
syn keyword qmlObjectLiteralType ToolBarStyle
syn keyword qmlObjectLiteralType ToolButton
syn keyword qmlObjectLiteralType ToolSeparator
syn keyword qmlObjectLiteralType ToolTip
syn keyword qmlObjectLiteralType Torch
syn keyword qmlObjectLiteralType TorusGeometry
syn keyword qmlObjectLiteralType TorusMesh
syn keyword qmlObjectLiteralType TouchEventSequence
syn keyword qmlObjectLiteralType TouchInputHandler3D
syn keyword qmlObjectLiteralType TouchPoint
syn keyword qmlObjectLiteralType Trace
syn keyword qmlObjectLiteralType TraceCanvas
syn keyword qmlObjectLiteralType TraceInputArea
syn keyword qmlObjectLiteralType TraceInputKey
syn keyword qmlObjectLiteralType TraceInputKeyPanel
syn keyword qmlObjectLiteralType TrailEmitter
syn keyword qmlObjectLiteralType Transaction
syn keyword qmlObjectLiteralType Transform
syn keyword qmlObjectLiteralType Transition
syn keyword qmlObjectLiteralType Translate
syn keyword qmlObjectLiteralType TreeView
syn keyword qmlObjectLiteralType TreeViewStyle
syn keyword qmlObjectLiteralType Tumbler
syn keyword qmlObjectLiteralType TumblerColumn
syn keyword qmlObjectLiteralType TumblerStyle
syn keyword qmlObjectLiteralType Turbulence

syn keyword qmlObjectLiteralType UniformAnimator
syn keyword qmlObjectLiteralType User

syn keyword qmlObjectLiteralType ValueAxis
syn keyword qmlObjectLiteralType ValueAxis3D
syn keyword qmlObjectLiteralType ValueAxis3DFormatter
syn keyword qmlObjectLiteralType VBarModelMapper
syn keyword qmlObjectLiteralType VBoxPlotModelMapper
syn keyword qmlObjectLiteralType VCandlestickModelMapper
syn keyword qmlObjectLiteralType Vector3dAnimation
syn keyword qmlObjectLiteralType VertexBlendAnimation
syn keyword qmlObjectLiteralType Video
syn keyword qmlObjectLiteralType VideoOutput
syn keyword qmlObjectLiteralType Viewport
syn keyword qmlObjectLiteralType ViewTransition
syn keyword qmlObjectLiteralType VirtualKeyboardSettings
syn keyword qmlObjectLiteralType VPieModelMapper
syn keyword qmlObjectLiteralType VXYModelMapper

syn keyword qmlObjectLiteralType Wander
syn keyword qmlObjectLiteralType WavefrontMesh
syn keyword qmlObjectLiteralType WaylandClient
syn keyword qmlObjectLiteralType WaylandCompositor
syn keyword qmlObjectLiteralType WaylandHardwareLayer
syn keyword qmlObjectLiteralType WaylandOutput
syn keyword qmlObjectLiteralType WaylandQuickItem
syn keyword qmlObjectLiteralType WaylandSeat
syn keyword qmlObjectLiteralType WaylandSurface
syn keyword qmlObjectLiteralType WaylandView
syn keyword qmlObjectLiteralType Waypoint
syn keyword qmlObjectLiteralType WebChannel
syn keyword qmlObjectLiteralType WebEngine
syn keyword qmlObjectLiteralType WebEngineAction
syn keyword qmlObjectLiteralType WebEngineCertificateError
syn keyword qmlObjectLiteralType WebEngineClientCertificateOption
syn keyword qmlObjectLiteralType WebEngineClientCertificateSelection
syn keyword qmlObjectLiteralType WebEngineDownloadItem
syn keyword qmlObjectLiteralType WebEngineHistory
syn keyword qmlObjectLiteralType WebEngineHistoryListModel
syn keyword qmlObjectLiteralType WebEngineLoadRequest
syn keyword qmlObjectLiteralType WebEngineNavigationRequest
syn keyword qmlObjectLiteralType WebEngineNewViewRequest
syn keyword qmlObjectLiteralType WebEngineProfile
syn keyword qmlObjectLiteralType WebEngineScript
syn keyword qmlObjectLiteralType WebEngineSettings
syn keyword qmlObjectLiteralType WebEngineView
syn keyword qmlObjectLiteralType WebSocket
syn keyword qmlObjectLiteralType WebSocketServer
syn keyword qmlObjectLiteralType WebView
syn keyword qmlObjectLiteralType WebViewLoadRequest
syn keyword qmlObjectLiteralType WheelEvent
syn keyword qmlObjectLiteralType Window
syn keyword qmlObjectLiteralType WlScaler
syn keyword qmlObjectLiteralType WlShell
syn keyword qmlObjectLiteralType WlShellSurface
syn keyword qmlObjectLiteralType WorkerScript

syn keyword qmlObjectLiteralType XAnimator
syn keyword qmlObjectLiteralType XdgDecorationManagerV1
syn keyword qmlObjectLiteralType XdgPopup
syn keyword qmlObjectLiteralType XdgPopupV5
syn keyword qmlObjectLiteralType XdgPopupV6
syn keyword qmlObjectLiteralType XdgShell
syn keyword qmlObjectLiteralType XdgShellV5
syn keyword qmlObjectLiteralType XdgShellV6
syn keyword qmlObjectLiteralType XdgSurface
syn keyword qmlObjectLiteralType XdgSurfaceV5
syn keyword qmlObjectLiteralType XdgSurfaceV6
syn keyword qmlObjectLiteralType XdgToplevel
syn keyword qmlObjectLiteralType XdgToplevelV6
syn keyword qmlObjectLiteralType XmlListModel
syn keyword qmlObjectLiteralType XmlRole
syn keyword qmlObjectLiteralType XYPoint
syn keyword qmlObjectLiteralType XYSeries

syn keyword qmlObjectLiteralType YAnimator

syn keyword qmlObjectLiteralType ZoomBlur


if get(g:, 'qml_fold', 0)
  syn match   qmlFunction      "\<function\>"
  syn region  qmlFunctionFold  start="\<function\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

  syn sync match qmlSync  grouphere qmlFunctionFold "\<function\>"
  syn sync match qmlSync  grouphere NONE "^}"

  setlocal foldmethod=syntax
  setlocal foldtext=getline(v:foldstart)
else
  syn keyword qmlFunction function
  syn match   qmlBraces   "[{}\[\]]"
  syn match   qmlParens   "[()]"
endif

syn sync fromstart
syn sync maxlines=100

if main_syntax == "qml"
  syn sync ccomment qmlComment
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_qml_syn_inits")
  if version < 508
    let did_qml_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink qmlComment           Comment
  HiLink qmlLineComment       Comment
  HiLink qmlCommentTodo       Todo
  HiLink qmlSpecial           Special
  HiLink qmlStringS           String
  HiLink qmlStringD           String
  HiLink qmlCharacter         Character
  HiLink qmlNumber            Number
  HiLink qmlConditional       Conditional
  HiLink qmlRepeat            Repeat
  HiLink qmlBranch            Conditional
  HiLink qmlOperator          Operator
  HiLink qmlJsType            Type
  HiLink qmlType              Type
  HiLink qmlObjectLiteralType Type
  HiLink qmlStatement         Statement
  HiLink qmlFunction          Function
  HiLink qmlBraces            Function
  HiLink qmlError             Error
  HiLink qmlNull              Keyword
  HiLink qmlBoolean           Boolean
  HiLink qmlRegexpString      String

  HiLink qmlIdentifier        Identifier
  HiLink qmlLabel             Label
  HiLink qmlException         Exception
  HiLink qmlMessage           Keyword
  HiLink qmlGlobal            Keyword
  HiLink qmlReserved          Keyword
  HiLink qmlDebug             Debug
  HiLink qmlConstant          Label
  HiLink qmlBindingProperty   Label
  HiLink qmlDeclaration       Function

  delcommand HiLink
endif

let b:current_syntax = "qml"
if main_syntax == 'qml'
  unlet main_syntax
endif
