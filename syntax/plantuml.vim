if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'plantuml') == -1
  
" Vim syntax file
" Language:     PlantUML
" Maintainer:   Anders Thøgersen <first name at bladre dot dk>
if exists('b:current_syntax')
  finish
endif

scriptencoding utf-8

if v:version < 600
  syntax clear
endif

let s:cpo_orig=&cpo
set cpo&vim

let b:current_syntax = 'plantuml'

syntax sync minlines=100

syntax match plantumlPreProc /\%(^@startuml\|^@enduml\)\|!\%(define|definelong|else|enddefinelong|endif|if|ifdef|ifndef|include|pragma|undef\)\s*.*/ contains=plantumlDir
syntax region plantumlDir start=/\s\+/ms=s+1 end=/$/ contained

syntax keyword plantumlTypeKeyword abstract actor agent archimate artifact boundary card cloud component control
syntax keyword plantumlTypeKeyword database entity enum file folder frame node object package participant
syntax keyword plantumlTypeKeyword queue rectangle stack state storage usecase

syntax keyword plantumlClassKeyword class interface

syntax keyword plantumlKeyword activate again also alt as autonumber bottom box break caption center create
syntax keyword plantumlKeyword critical deactivate destroy down else elseif end endif endwhile footbox footer
syntax keyword plantumlKeyword fork group header hide hnote if is kill left legend link loop namespace newpage
syntax keyword plantumlKeyword note of on opt over package page par partition ref repeat return right rnote
syntax keyword plantumlKeyword rotate show skin skinparam start stop title top up while
" Not in 'java - jar plantuml.jar - language' output
syntax keyword plantumlKeyword then detach sprite

syntax keyword plantumlCommentTODO XXX TODO FIXME NOTE contained
syntax match plantumlColor /#[0-9A-Fa-f]\{6\}\>/
syntax keyword plantumlColor APPLICATION AliceBlue AntiqueWhite Aqua Aquamarine Azure BUSINESS Beige Bisque
syntax keyword plantumlColor Black BlanchedAlmond Blue BlueViolet Brown BurlyWood CadetBlue Chartreuse
syntax keyword plantumlColor Chocolate Coral CornflowerBlue Cornsilk Crimson Cyan DarkBlue DarkCyan
syntax keyword plantumlColor DarkGoldenRod DarkGray DarkGreen DarkGrey DarkKhaki DarkMagenta DarkOliveGreen
syntax keyword plantumlColor DarkOrchid DarkRed DarkSalmon DarkSeaGreen DarkSlateBlue DarkSlateGray
syntax keyword plantumlColor DarkSlateGrey DarkTurquoise DarkViolet Darkorange DeepPink DeepSkyBlue DimGray
syntax keyword plantumlColor DimGrey DodgerBlue FireBrick FloralWhite ForestGreen Fuchsia Gainsboro
syntax keyword plantumlColor GhostWhite Gold GoldenRod Gray Green GreenYellow Grey HoneyDew HotPink
syntax keyword plantumlColor IMPLEMENTATION IndianRed Indigo Ivory Khaki Lavender LavenderBlush LawnGreen
syntax keyword plantumlColor LemonChiffon LightBlue LightCoral LightCyan LightGoldenRodYellow LightGray
syntax keyword plantumlColor LightGreen LightGrey LightPink LightSalmon LightSeaGreen LightSkyBlue
syntax keyword plantumlColor LightSlateGray LightSlateGrey LightSteelBlue LightYellow Lime LimeGreen Linen
syntax keyword plantumlColor MOTIVATION Magenta Maroon MediumAquaMarine MediumBlue MediumOrchid MediumPurple
syntax keyword plantumlColor MediumSeaGreen MediumSlateBlue MediumSpringGreen MediumTurquoise MediumVioletRed
syntax keyword plantumlColor MidnightBlue MintCream MistyRose Moccasin NavajoWhite Navy OldLace Olive
syntax keyword plantumlColor OliveDrab Orange OrangeRed Orchid PHYSICAL PaleGoldenRod PaleGreen PaleTurquoise
syntax keyword plantumlColor PaleVioletRed PapayaWhip PeachPuff Peru Pink Plum PowderBlue Purple Red
syntax keyword plantumlColor RosyBrown RoyalBlue STRATEGY SaddleBrown Salmon SandyBrown SeaGreen SeaShell
syntax keyword plantumlColor Sienna Silver SkyBlue SlateBlue SlateGray SlateGrey Snow SpringGreen SteelBlue
syntax keyword plantumlColor TECHNOLOGY Tan Teal Thistle Tomato Turquoise Violet Wheat White WhiteSmoke
syntax keyword plantumlColor Yellow YellowGreen

" Arrows - Differentiate between horizontal and vertical arrows
syntax match plantumlHorizontalArrow /\%([-\.]\%(|>\|>\|\*\|o\>\|\\\\\|\\\|\/\/\|\/\|\.\|-\)\|\%(<|\|<\|\*\|\<o\|\\\\\|\\\|\/\/\|\/\)[\.-]\)\%(\[[^\]]*\]\)\?/ contains=plantumlLabel
syntax match plantumlDirectedOrVerticalArrowLR /[-\.]\%(le\?f\?t\?\|ri\?g\?h\?t\?\|up\?\|do\?w\?n\?\)\?[-\.]\%(|>\|>>\|>\|\*\|o\>\|\\\\\|\\\|\/\/\|\/\|\.\|-\)\%(\[[^\]]*\]\)\?/ contains=plantumlLabel
syntax match plantumlDirectedOrVerticalArrowRL /\%(<|\|<<\|<\|\*\|\<o\|\\\\\|\\\|\/\/\|\/\)[-\.]\%(le\?f\?t\?\|ri\?g\?h\?t\?\|up\?\|do\?w\?n\?\)\?[-\.]\%(\[[^\]]*\]\)\?/ contains=plantumlLabel
syntax region plantumlLabel start=/\[/ms=s+1 end=/\]/me=s-1 contained contains=plantumlText
syntax match plantumlText /\%([0-9A-Za-z\0xc0-\0xff]\|\s\|[\.,;_-]\)\+/ contained

" Note
syntax region plantumlNoteMultiLine start=/\%(^\s*[rh]\?note\)\@<=\s\%([^:"]\+$\)\@=/ end=/^\%(\s*end \?[rh]\?note$\)\@=/ contains=plantumlSpecialString,plantumlNoteMultiLineStart
syntax match plantumlNoteMultiLineStart /\%(^\s*[rh]\?note\)\@<=\s\%([^:]\+$\)/ contained contains=plantumlKeyword,plantumlColor,plantumlString

" Class
syntax region plantumlClass start=/\%(\%(class\|interface\|object\)\s[^{]\+\)\@<=\zs{/ end=/^\s*}/ contains=plantumlClassArrows,
\                                                                                  plantumlClassKeyword,
\                                                                                  @plantumlClassOp,
\                                                                                  plantumlClassSeparator,
\                                                                                  plantumlComment

syntax match plantumlClassPublic      /^\s*+\s*\w\+/ contained
syntax match plantumlClassPrivate     /^\s*-\s*\w\+/ contained
syntax match plantumlClassProtected   /^\s*#\s*\w\+/ contained
syntax match plantumlClassPackPrivate /^\s*\~\s*\w\+/ contained
syntax match plantumlClassSeparator   /__\%(.\+__\)\?\|==\%(.\+==\)\?\|--\%(.\+--\)\?\|\.\.\%(.\+\.\.\)\?/ contained

syntax cluster plantumlClassOp contains=plantumlClassPublic,
\                                       plantumlClassPrivate,
\                                       plantumlClassProtected,
\                                       plantumlClassPackPrivate

" Strings
syntax match plantumlSpecialString /\\n/ contained
syntax region plantumlString start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=plantumlSpecialString
syntax region plantumlString start=/'/ skip=/\\\\\|\\'/ end=/'/ contains=plantumlSpecialString
syntax match plantumlComment /'.*$/ contains=plantumlCommentTODO
syntax region plantumlMultilineComment start=/\/'/ end=/'\// contains=plantumlCommentTODO

" Labels with a colon
syntax match plantumlColonLine /\S\@<=\s*\zs:.\+$/ contains=plantumlSpecialString

" Stereotypes
syntax match plantumlStereotype /<<.\{-1,}>>/ contains=plantumlSpecialString

" Activity diagram
syntax match plantumlActivityThing /([^)]*)/
syntax match plantumlActivitySynch /===[^=]\+===/
syntax match plantumlActivityLabel /\%(^\%(#\S\+\)\?\)\@<=:\_[^;|<>/\]}]\+[;|<>/\]}]$/ contains=plantumlSpecialString

" Sequence diagram
syntax match plantumlSequenceDivider /^\s*==[^=]\+==\s*$/
syntax match plantumlSequenceSpace /^\s*|||\+\s*$/
syntax match plantumlSequenceSpace /^\s*||\d\+||\+\s*$/

" Usecase diagram
syntax match plantumlUsecaseActor /:.\{-1,}:/ contains=plantumlSpecialString

" Skinparam keywords
syntax case ignore
syntax keyword plantumlSkinparamKeyword ActivityBackgroundColor ActivityBarColor ActivityBorderColor
syntax keyword plantumlSkinparamKeyword ActivityBorderThickness ActivityDiamondBackgroundColor
syntax keyword plantumlSkinparamKeyword ActivityDiamondBorderColor ActivityDiamondFontColor ActivityDiamondFontName
syntax keyword plantumlSkinparamKeyword ActivityDiamondFontSize ActivityDiamondFontStyle ActivityEndColor
syntax keyword plantumlSkinparamKeyword ActivityFontColor ActivityFontName ActivityFontSize ActivityFontStyle
syntax keyword plantumlSkinparamKeyword ActivityStartColor ActorBackgroundColor ActorBorderColor ActorFontColor
syntax keyword plantumlSkinparamKeyword ActorFontName ActorFontSize ActorFontStyle ActorStereotypeFontColor
syntax keyword plantumlSkinparamKeyword ActorStereotypeFontName ActorStereotypeFontSize ActorStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword AgentBackgroundColor AgentBorderColor AgentFontColor AgentFontName AgentFontSize
syntax keyword plantumlSkinparamKeyword AgentFontStyle AgentStereotypeFontColor AgentStereotypeFontName
syntax keyword plantumlSkinparamKeyword AgentStereotypeFontSize AgentStereotypeFontStyle ArrowColor ArrowFontColor
syntax keyword plantumlSkinparamKeyword ArrowFontName ArrowFontSize ArrowFontStyle ArtifactBackgroundColor
syntax keyword plantumlSkinparamKeyword ArtifactBorderColor ArtifactFontColor ArtifactFontName ArtifactFontSize
syntax keyword plantumlSkinparamKeyword ArtifactFontStyle ArtifactStereotypeFontColor ArtifactStereotypeFontName
syntax keyword plantumlSkinparamKeyword ArtifactStereotypeFontSize ArtifactStereotypeFontStyle BackgroundColor
syntax keyword plantumlSkinparamKeyword BoundaryBackgroundColor BoundaryBorderColor BoundaryFontColor BoundaryFontName
syntax keyword plantumlSkinparamKeyword BoundaryFontSize BoundaryFontStyle BoundaryStereotypeFontColor
syntax keyword plantumlSkinparamKeyword BoundaryStereotypeFontName BoundaryStereotypeFontSize
syntax keyword plantumlSkinparamKeyword BoundaryStereotypeFontStyle CaptionFontColor CaptionFontName CaptionFontSize
syntax keyword plantumlSkinparamKeyword CaptionFontStyle CircledCharacterFontColor CircledCharacterFontName
syntax keyword plantumlSkinparamKeyword CircledCharacterFontSize CircledCharacterFontStyle CircledCharacterRadius
syntax keyword plantumlSkinparamKeyword ClassAttributeFontColor ClassAttributeFontName ClassAttributeFontSize
syntax keyword plantumlSkinparamKeyword ClassAttributeFontStyle ClassAttributeIconSize ClassBackgroundColor
syntax keyword plantumlSkinparamKeyword ClassBorderColor ClassBorderThickness ClassFontColor ClassFontName ClassFontSize
syntax keyword plantumlSkinparamKeyword ClassFontStyle ClassHeaderBackgroundColor ClassStereotypeFontColor
syntax keyword plantumlSkinparamKeyword ClassStereotypeFontName ClassStereotypeFontSize ClassStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword CloudBackgroundColor CloudBorderColor CloudFontColor CloudFontName CloudFontSize
syntax keyword plantumlSkinparamKeyword CloudFontStyle CloudStereotypeFontColor CloudStereotypeFontName
syntax keyword plantumlSkinparamKeyword CloudStereotypeFontSize CloudStereotypeFontStyle CollectionsBackgroundColor
syntax keyword plantumlSkinparamKeyword CollectionsBorderColor ColorArrowSeparationSpace ComponentBackgroundColor
syntax keyword plantumlSkinparamKeyword ComponentBorderColor ComponentFontColor ComponentFontName ComponentFontSize
syntax keyword plantumlSkinparamKeyword ComponentFontStyle ComponentStereotypeFontColor ComponentStereotypeFontName
syntax keyword plantumlSkinparamKeyword ComponentStereotypeFontSize ComponentStereotypeFontStyle ComponentStyle
syntax keyword plantumlSkinparamKeyword ConditionStyle ControlBackgroundColor ControlBorderColor ControlFontColor
syntax keyword plantumlSkinparamKeyword ControlFontName ControlFontSize ControlFontStyle ControlStereotypeFontColor
syntax keyword plantumlSkinparamKeyword ControlStereotypeFontName ControlStereotypeFontSize ControlStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword DatabaseBackgroundColor DatabaseBorderColor DatabaseFontColor DatabaseFontName
syntax keyword plantumlSkinparamKeyword DatabaseFontSize DatabaseFontStyle DatabaseStereotypeFontColor
syntax keyword plantumlSkinparamKeyword DatabaseStereotypeFontName DatabaseStereotypeFontSize
syntax keyword plantumlSkinparamKeyword DatabaseStereotypeFontStyle DefaultFontColor DefaultFontName DefaultFontSize
syntax keyword plantumlSkinparamKeyword DefaultFontStyle DefaultMonospacedFontName DefaultTextAlignment
syntax keyword plantumlSkinparamKeyword DiagramBorderColor DiagramBorderThickness Dpi EntityBackgroundColor
syntax keyword plantumlSkinparamKeyword EntityBorderColor EntityFontColor EntityFontName EntityFontSize EntityFontStyle
syntax keyword plantumlSkinparamKeyword EntityStereotypeFontColor EntityStereotypeFontName EntityStereotypeFontSize
syntax keyword plantumlSkinparamKeyword EntityStereotypeFontStyle FileBackgroundColor FileBorderColor FileFontColor
syntax keyword plantumlSkinparamKeyword FileFontName FileFontSize FileFontStyle FileStereotypeFontColor
syntax keyword plantumlSkinparamKeyword FileStereotypeFontName FileStereotypeFontSize FileStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword FolderBackgroundColor FolderBorderColor FolderFontColor FolderFontName
syntax keyword plantumlSkinparamKeyword FolderFontSize FolderFontStyle FolderStereotypeFontColor
syntax keyword plantumlSkinparamKeyword FolderStereotypeFontName FolderStereotypeFontSize FolderStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword FooterFontColor FooterFontName FooterFontSize FooterFontStyle
syntax keyword plantumlSkinparamKeyword FrameBackgroundColor FrameBorderColor FrameFontColor FrameFontName FrameFontSize
syntax keyword plantumlSkinparamKeyword FrameFontStyle FrameStereotypeFontColor FrameStereotypeFontName
syntax keyword plantumlSkinparamKeyword FrameStereotypeFontSize FrameStereotypeFontStyle Guillemet Handwritten
syntax keyword plantumlSkinparamKeyword HeaderFontColor HeaderFontName HeaderFontSize HeaderFontStyle HyperlinkColor
syntax keyword plantumlSkinparamKeyword HyperlinkUnderline IconIEMandatoryColor IconPackageBackgroundColor
syntax keyword plantumlSkinparamKeyword IconPackageColor IconPrivateBackgroundColor IconPrivateColor
syntax keyword plantumlSkinparamKeyword IconProtectedBackgroundColor IconProtectedColor IconPublicBackgroundColor
syntax keyword plantumlSkinparamKeyword IconPublicColor InterfaceBackgroundColor InterfaceBorderColor InterfaceFontColor
syntax keyword plantumlSkinparamKeyword InterfaceFontName InterfaceFontSize InterfaceFontStyle
syntax keyword plantumlSkinparamKeyword InterfaceStereotypeFontColor InterfaceStereotypeFontName
syntax keyword plantumlSkinparamKeyword InterfaceStereotypeFontSize InterfaceStereotypeFontStyle LegendBackgroundColor
syntax keyword plantumlSkinparamKeyword LegendBorderColor LegendBorderThickness LegendFontColor LegendFontName
syntax keyword plantumlSkinparamKeyword LegendFontSize LegendFontStyle Linetype MaxAsciiMessageLength MaxMessageSize
syntax keyword plantumlSkinparamKeyword MinClassWidth Monochrome NodeBackgroundColor NodeBorderColor NodeFontColor
syntax keyword plantumlSkinparamKeyword NodeFontName NodeFontSize NodeFontStyle NodeStereotypeFontColor
syntax keyword plantumlSkinparamKeyword NodeStereotypeFontName NodeStereotypeFontSize NodeStereotypeFontStyle Nodesep
syntax keyword plantumlSkinparamKeyword NoteBackgroundColor NoteBorderColor NoteBorderThickness NoteFontColor
syntax keyword plantumlSkinparamKeyword NoteFontName NoteFontSize NoteFontStyle NoteShadowing ObjectAttributeFontColor
syntax keyword plantumlSkinparamKeyword ObjectAttributeFontName ObjectAttributeFontSize ObjectAttributeFontStyle
syntax keyword plantumlSkinparamKeyword ObjectBackgroundColor ObjectBorderColor ObjectBorderThickness ObjectFontColor
syntax keyword plantumlSkinparamKeyword ObjectFontName ObjectFontSize ObjectFontStyle ObjectStereotypeFontColor
syntax keyword plantumlSkinparamKeyword ObjectStereotypeFontName ObjectStereotypeFontSize ObjectStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword PackageBackgroundColor PackageBorderColor PackageBorderThickness
syntax keyword plantumlSkinparamKeyword PackageFontColor PackageFontName PackageFontSize PackageFontStyle
syntax keyword plantumlSkinparamKeyword PackageStereotypeFontColor PackageStereotypeFontName PackageStereotypeFontSize
syntax keyword plantumlSkinparamKeyword PackageStereotypeFontStyle PackageStyle Padding ParticipantBackgroundColor
syntax keyword plantumlSkinparamKeyword ParticipantBorderColor ParticipantFontColor ParticipantFontName
syntax keyword plantumlSkinparamKeyword ParticipantFontSize ParticipantFontStyle PartitionBackgroundColor
syntax keyword plantumlSkinparamKeyword PartitionBorderColor PartitionBorderThickness PartitionFontColor
syntax keyword plantumlSkinparamKeyword PartitionFontName PartitionFontSize PartitionFontStyle QueueBackgroundColor
syntax keyword plantumlSkinparamKeyword QueueBorderColor QueueFontColor QueueFontName QueueFontSize QueueFontStyle
syntax keyword plantumlSkinparamKeyword QueueStereotypeFontColor QueueStereotypeFontName QueueStereotypeFontSize
syntax keyword plantumlSkinparamKeyword QueueStereotypeFontStyle Ranksep RectangleBackgroundColor RectangleBorderColor
syntax keyword plantumlSkinparamKeyword RectangleBorderThickness RectangleFontColor RectangleFontName RectangleFontSize
syntax keyword plantumlSkinparamKeyword RectangleFontStyle RectangleStereotypeFontColor RectangleStereotypeFontName
syntax keyword plantumlSkinparamKeyword RectangleStereotypeFontSize RectangleStereotypeFontStyle RoundCorner
syntax keyword plantumlSkinparamKeyword SameClassWidth SequenceActorBorderThickness SequenceArrowThickness
syntax keyword plantumlSkinparamKeyword SequenceBoxBackgroundColor SequenceBoxBorderColor SequenceBoxFontColor
syntax keyword plantumlSkinparamKeyword SequenceBoxFontName SequenceBoxFontSize SequenceBoxFontStyle
syntax keyword plantumlSkinparamKeyword SequenceDelayFontColor SequenceDelayFontName SequenceDelayFontSize
syntax keyword plantumlSkinparamKeyword SequenceDelayFontStyle SequenceDividerBackgroundColor SequenceDividerBorderColor
syntax keyword plantumlSkinparamKeyword SequenceDividerBorderThickness SequenceDividerFontColor SequenceDividerFontName
syntax keyword plantumlSkinparamKeyword SequenceDividerFontSize SequenceDividerFontStyle SequenceGroupBackgroundColor
syntax keyword plantumlSkinparamKeyword SequenceGroupBodyBackgroundColor SequenceGroupBorderColor
syntax keyword plantumlSkinparamKeyword SequenceGroupBorderThickness SequenceGroupFontColor SequenceGroupFontName
syntax keyword plantumlSkinparamKeyword SequenceGroupFontSize SequenceGroupFontStyle SequenceGroupHeaderFontColor
syntax keyword plantumlSkinparamKeyword SequenceGroupHeaderFontName SequenceGroupHeaderFontSize
syntax keyword plantumlSkinparamKeyword SequenceGroupHeaderFontStyle SequenceLifeLineBackgroundColor
syntax keyword plantumlSkinparamKeyword SequenceLifeLineBorderColor SequenceLifeLineBorderThickness
syntax keyword plantumlSkinparamKeyword SequenceNewpageSeparatorColor SequenceParticipant
syntax keyword plantumlSkinparamKeyword SequenceParticipantBorderThickness SequenceReferenceBackgroundColor
syntax keyword plantumlSkinparamKeyword SequenceReferenceBorderColor SequenceReferenceBorderThickness
syntax keyword plantumlSkinparamKeyword SequenceReferenceFontColor SequenceReferenceFontName SequenceReferenceFontSize
syntax keyword plantumlSkinparamKeyword SequenceReferenceFontStyle SequenceReferenceHeaderBackgroundColor
syntax keyword plantumlSkinparamKeyword SequenceStereotypeFontColor SequenceStereotypeFontName
syntax keyword plantumlSkinparamKeyword SequenceStereotypeFontSize SequenceStereotypeFontStyle SequenceTitleFontColor
syntax keyword plantumlSkinparamKeyword SequenceTitleFontName SequenceTitleFontSize SequenceTitleFontStyle Shadowing
syntax keyword plantumlSkinparamKeyword StackBackgroundColor StackBorderColor StackFontColor StackFontName StackFontSize
syntax keyword plantumlSkinparamKeyword StackFontStyle StackStereotypeFontColor StackStereotypeFontName
syntax keyword plantumlSkinparamKeyword StackStereotypeFontSize StackStereotypeFontStyle StateAttributeFontColor
syntax keyword plantumlSkinparamKeyword StateAttributeFontName StateAttributeFontSize StateAttributeFontStyle
syntax keyword plantumlSkinparamKeyword StateBackgroundColor StateBorderColor StateEndColor StateFontColor StateFontName
syntax keyword plantumlSkinparamKeyword StateFontSize StateFontStyle StateStartColor StereotypeABackgroundColor
syntax keyword plantumlSkinparamKeyword StereotypeCBackgroundColor StereotypeEBackgroundColor StereotypeIBackgroundColor
syntax keyword plantumlSkinparamKeyword StereotypeNBackgroundColor StereotypePosition StorageBackgroundColor
syntax keyword plantumlSkinparamKeyword StorageBorderColor StorageFontColor StorageFontName StorageFontSize
syntax keyword plantumlSkinparamKeyword StorageFontStyle StorageStereotypeFontColor StorageStereotypeFontName
syntax keyword plantumlSkinparamKeyword StorageStereotypeFontSize StorageStereotypeFontStyle Style SvglinkTarget
syntax keyword plantumlSkinparamKeyword SwimlaneBorderColor SwimlaneBorderThickness SwimlaneTitleFontColor
syntax keyword plantumlSkinparamKeyword SwimlaneTitleFontName SwimlaneTitleFontSize SwimlaneTitleFontStyle TabSize
syntax keyword plantumlSkinparamKeyword TitleBackgroundColor TitleBorderColor TitleBorderRoundCorner
syntax keyword plantumlSkinparamKeyword TitleBorderThickness TitleFontColor TitleFontName TitleFontSize TitleFontStyle
syntax keyword plantumlSkinparamKeyword UsecaseBackgroundColor UsecaseBorderColor UsecaseBorderThickness UsecaseFontColor
syntax keyword plantumlSkinparamKeyword UsecaseFontName UsecaseFontSize UsecaseFontStyle UsecaseStereotypeFontColor
syntax keyword plantumlSkinparamKeyword UsecaseStereotypeFontName UsecaseStereotypeFontSize UsecaseStereotypeFontStyle
" Not in 'java - jar plantuml.jar - language' output
syntax keyword plantumlSkinparamKeyword activityArrowColor activityArrowFontColor activityArrowFontName
syntax keyword plantumlSkinparamKeyword activityArrowFontSize activityArrowFontStyle BarColor BorderColor BoxPadding
syntax keyword plantumlSkinparamKeyword CharacterFontColor CharacterFontName CharacterFontSize CharacterFontStyle
syntax keyword plantumlSkinparamKeyword CharacterRadius classArrowColor classArrowFontColor classArrowFontName
syntax keyword plantumlSkinparamKeyword classArrowFontSize classArrowFontStyle Color componentArrowColor
syntax keyword plantumlSkinparamKeyword componentArrowFontColor componentArrowFontName componentArrowFontSize
syntax keyword plantumlSkinparamKeyword componentArrowFontStyle componentInterfaceBackgroundColor
syntax keyword plantumlSkinparamKeyword componentInterfaceBorderColor DividerBackgroundColor DividerFontColor
syntax keyword plantumlSkinparamKeyword DividerFontName DividerFontSize DividerFontStyle EndColor FontColor FontName
syntax keyword plantumlSkinparamKeyword FontSize FontStyle GroupBackgroundColor GroupingFontColor GroupingFontName
syntax keyword plantumlSkinparamKeyword GroupingFontSize GroupingFontStyle GroupingHeaderFontColor
syntax keyword plantumlSkinparamKeyword GroupingHeaderFontName GroupingHeaderFontSize GroupingHeaderFontStyle
syntax keyword plantumlSkinparamKeyword LifeLineBackgroundColor LifeLineBorderColor ParticipantPadding
syntax keyword plantumlSkinparamKeyword sequenceActorBackgroundColor sequenceActorBorderColor sequenceActorFontColor
syntax keyword plantumlSkinparamKeyword sequenceActorFontName sequenceActorFontSize sequenceActorFontStyle
syntax keyword plantumlSkinparamKeyword sequenceArrowColor sequenceArrowFontColor sequenceArrowFontName
syntax keyword plantumlSkinparamKeyword sequenceArrowFontSize sequenceArrowFontStyle sequenceGroupingFontColor
syntax keyword plantumlSkinparamKeyword sequenceGroupingFontName sequenceGroupingFontSize sequenceGroupingFontStyle
syntax keyword plantumlSkinparamKeyword sequenceGroupingHeaderFontColor sequenceGroupingHeaderFontName
syntax keyword plantumlSkinparamKeyword sequenceGroupingHeaderFontSize sequenceGroupingHeaderFontStyle
syntax keyword plantumlSkinparamKeyword sequenceParticipantBackgroundColor sequenceParticipantBorderColor
syntax keyword plantumlSkinparamKeyword sequenceParticipantFontColor sequenceParticipantFontName
syntax keyword plantumlSkinparamKeyword sequenceParticipantFontSize sequenceParticipantFontStyle StartColor
syntax keyword plantumlSkinparamKeyword stateArrowColor stateArrowFontColor stateArrowFontName stateArrowFontSize
syntax keyword plantumlSkinparamKeyword stateArrowFontStyle StereotypeFontColor StereotypeFontName StereotypeFontSize
syntax keyword plantumlSkinparamKeyword StereotypeFontStyle usecaseActorBackgroundColor usecaseActorBorderColor
syntax keyword plantumlSkinparamKeyword usecaseActorFontColor usecaseActorFontName usecaseActorFontSize
syntax keyword plantumlSkinparamKeyword usecaseActorFontStyle usecaseActorStereotypeFontColor
syntax keyword plantumlSkinparamKeyword usecaseActorStereotypeFontName usecaseActorStereotypeFontSize
syntax keyword plantumlSkinparamKeyword usecaseActorStereotypeFontStyle usecaseArrowColor usecaseArrowFontColor
syntax keyword plantumlSkinparamKeyword usecaseArrowFontName usecaseArrowFontSize usecaseArrowFontStyle
syntax case match

" Highlight
highlight default link plantumlCommentTODO Todo
highlight default link plantumlKeyword Keyword
highlight default link plantumlClassKeyword Keyword
highlight default link plantumlTypeKeyword Type
highlight default link plantumlPreProc PreProc
highlight default link plantumlDir Constant
highlight default link plantumlColor Constant
highlight default link plantumlHorizontalArrow Identifier
highlight default link plantumlDirectedOrVerticalArrowLR Identifier
highlight default link plantumlDirectedOrVerticalArrowRL Identifier
highlight default link plantumlLabel Special
highlight default link plantumlText Label
highlight default link plantumlClass Type
highlight default link plantumlClassPublic Structure
highlight default link plantumlClassPrivate Macro
highlight default link plantumlClassProtected Statement
highlight default link plantumlClassPackPrivate Function
highlight default link plantumlClassSeparator Comment
highlight default link plantumlSequenceDivider Comment
highlight default link plantumlSequenceSpace Comment
highlight default link plantumlSpecialString Special
highlight default link plantumlString String
highlight default link plantumlComment Comment
highlight default link plantumlMultilineComment Comment
highlight default link plantumlColonLine Comment
highlight default link plantumlActivityThing Type
highlight default link plantumlActivitySynch Type
highlight default link plantumlActivityLabel String
highlight default link plantumlSkinparamKeyword Identifier
highlight default link plantumlNoteMultiLine String
highlight default link plantumlUsecaseActor String
highlight default link plantumlStereotype Type

let &cpo=s:cpo_orig
unlet s:cpo_orig

endif
