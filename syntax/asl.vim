if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'acpiasl') == -1

" Vim syntax file
" Language: ACPI ASL files
" Maintainer: Martin L Roth <gaumless@gmail.com>
" Version: 0.1

" Currently supporting ACPI 5.0 and IASL preprocessor
" http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf
" https://acpica.org/sites/acpica/files/aslcompiler_8.pdf

if exists("b:current_syntax")
  finish
endif

let b:current_syntax = "asl"

syn case ignore

syn region  aslBlock            start="{" end="}" transparent fold

syn keyword aslTodo             contained TODO FIXME XXX NOTE

syn region  aslComment          display start="//" skip="\\$" end="$" keepend contains=aslTodo
syn region  aslComment          start="/\*" end="\*\/" contains=aslTodo

syn region  aslString           start=/"/ skip=/\\"/ end=/"/

" Keywords
syn keyword aslPrimaryKeyword   AccessAs Acquire Add Alias And Arg0 Arg1 Arg2 Arg3 Arg4 Arg6 Arg6
syn keyword aslPrimaryKeyword   BankField BreakPoint Break Buffer
syn keyword aslPrimaryKeyword   Case ConcatenateResTemplate Concatenate Connection CondRefOf Continue CopyObject CreateBitField CreateByteField CreateDWordField CreateField CreateQWordField CreateWordField
syn keyword aslPrimaryKeyword   DataTableRegion Debug Decrement Default DefinitionBlock DerefOf Device Divide
syn keyword aslPrimaryKeyword   EISAID EisaId ElseIf Else Event External
syn keyword aslPrimaryKeyword   Fatal Field FindSetLeftBit FindSetRightBit FromBCD Function
syn keyword aslPrimaryKeyword   If Include Increment IndexField Index
syn keyword aslPrimaryKeyword   LAnd LEqual LGreaterEqual LGreater LLessEqual LLess LNotEqual LNot LoadTable Load Local0 Local1 Local2 Local3 Local4 Local5 Local6 Local7 LOr
syn keyword aslPrimaryKeyword   Match Method Mid Mod Multiply Mutex
syn keyword aslPrimaryKeyword   Name NAnd NoOp NOr Notify Not
syn keyword aslPrimaryKeyword   ObjectType Offset OperationRegion Or
syn keyword aslPrimaryKeyword   Package PowerResource Processor
syn keyword aslPrimaryKeyword   RawDataBuffer RefOf Release Reset ResourceTemplate Return
syn keyword aslPrimaryKeyword   Scope ShiftLeft ShiftRight Signal SizeOf Sleep Stall Store Subtract Switch
syn keyword aslPrimaryKeyword   ThermalZone Timer ToBCD ToBuffer ToDecimalString ToHexString ToInteger ToString ToUUID
syn keyword aslPrimaryKeyword   Unicode Unload
syn keyword aslPrimaryKeyword   Wait While
syn keyword aslPrimaryKeyword   XOr

syn keyword aslParameterKeyword ActiveBoth ActiveHigh ActiveHigh ActiveLow ActiveLow AddressingMode10Bit AddressingMode7Bit AddressRangeACPI AddressRangeMemory AddressRangeNVS AddressRangeReserved AnyAcc AttribBlock AttribBlockProcessCall AttribByte AttribBytes AttribBytes AttribProcessCall AttribQuick AttribRawBytes AttribRawBytes AttribRawProcessBytes AttribRawProcessBytes AttribSendReceive AttribWord
syn keyword aslParameterKeyword BigEndianing BufferAcc BuffFieldObj BuffObj BusMaster ByteAcc
syn keyword aslParameterKeyword Cacheable ClockPhaseFirst ClockPhaseSecond ClockPolarityHigh ClockPolarityLow Compatibility ControllerInitiated
syn keyword aslParameterKeyword DataBitsEight DataBitsFive DataBitsNine DataBitsSeven DataBitsSix DDBHandleObj Decode10 Decode16 DenseTranslation DeviceInitiated DeviceObj DWordAcc
syn keyword aslParameterKeyword Edge EmbeddedControl EntireRange EventObj Exclusive ExclusiveAndWake
syn keyword aslParameterKeyword FFixedHW FieldUnitObj FlowControlHardware FlowControlNone FlowControlXon FourWireMode
syn keyword aslParameterKeyword GeneralPurposeIO GenericSerialBus
syn keyword aslParameterKeyword IntObj IoRestrictionInputOnly IoRestrictionNone IoRestrictionNoneAndPreserve IoRestrictionOutputOnly IPMI ISAOnlyRanges
syn keyword aslParameterKeyword Level LittleEndian Lock
syn keyword aslParameterKeyword MaxFixed MaxNotFixed MEQ MethodObj MGE MGT MinFixed MinNotFixed MLE MLT MTR MutexObj
syn keyword aslParameterKeyword NoLock NonCacheable NonISAOnlyRanges NotBusMaster NotSerialized
syn keyword aslParameterKeyword OpRegionObj
syn keyword aslParameterKeyword ParityTypeEven ParityTypeMark ParityTypeNone ParityTypeOdd ParityTypeSpace PCC PciBarTarget PCI_Config PkgObj PolarityHigh PolarityLow PosDecode PowerResObj Prefetchable Preserve ProcessorObj PullDefault PullDown PullNone PullUp
syn keyword aslParameterKeyword QWordAcc
syn keyword aslParameterKeyword ReadOnly ReadWrite RegionSpaceKeyword ResourceConsumer ResourceProducer
syn keyword aslParameterKeyword Serialized Shared SharedAndWake SMBus SparseTranslation StopBitsOne StopBitsOnePlusHalf StopBitsTwo StopBitsZero StrObj SubDecode SystemCMOS SystemIO SystemMemory
syn keyword aslParameterKeyword ThermalZoneObj ThreeWireMode Transfer16 Transfer8 Transfer8_16 TypeA TypeB TypeF TypeStatic TypeTranslation
syn keyword aslParameterKeyword UnknownObj UserDefRegionSpace
syn keyword aslParameterKeyword Width128Bit Width16Bit Width256Bit Width32Bit Width64Bit Width8Bit WordAcc WriteAsOnes WriteAsZeros WriteCombining

syn keyword aslResourceKeyword  DMA DWordIO DWordMemory DWordSpace
syn keyword aslResourceKeyword  EndDependentFn ExtendedIO ExtendedMemory ExtendedSpace
syn keyword aslResourceKeyword  FixedDMA FixedIO
syn keyword aslResourceKeyword  GpioInt GpioIO
syn keyword aslResourceKeyword  I2CSerialBus Interrupt IO IRQNoFlags IRQ
syn keyword aslResourceKeyword  Memory24 Memory32Fixed Memory32
syn keyword aslResourceKeyword  QWordIO QWordMemory QWordSpace
syn keyword aslResourceKeyword  RawDataBuffer Register
syn keyword aslResourceKeyword  SPISerialBus StartDependentFnNoPri StartDependentFn
syn keyword aslResourceKeyword  UARTSerialBus
syn keyword aslResourceKeyword  VendorLong VendorShort
syn keyword aslResourceKeyword  WordBusNumber WordIO WordSpace

" Pre-defined object names
syn keyword aslObjects          _AC0 _AC1 _AC2 _AC3 _AC4 _AC5 _AC6 _AC7 _AC8 _AC9 _ADR _ALC _ALI _ALN _APL _ALR _ALT _AL0 _AL1 _AL2 _AL3 _AL4 _AL5 _AL6 _AL7 _AL8 _AL9 _ART _ASI _ASZ _ATT _BAS _BBN _BCL _BCM _BCT _BDN _BFS _BIF _BIX _BLT _BM _BMA _BMC _BMD _MBS _BQC _BST _BTM _BTP _CBA _CDM _CID _CRS _CRT _CSD _CST _CWS _DBT _DCK _DCS _DDC _DDN _DEC _DGS _DIS _DLM _DMA _DOD _DOS _DPL _DRS _DSM _DSS _DSW _DTI _EC _EDL _EJD _END _EVT _FDE _FDI _FDM _FIF _FIX _FLC _FPS _FSL _FST _GAI _GCP _GHL _GL _GLK _GPD _GPE _GRA _GRT _GSB _GTF _GTM _GTS _GWS _HE _HID _HOT _HPP _HPX _HRV _IFT _INI _INT _IOR _IRC _LCK _LEN _LID _LIN _LL _MAF _MAT _MAX _MBM _MEM _MIF _MIN _MLS _MOD _MSG _MSM _MTP _NTT _OFF _ON _OS _OSC _OSI _OST _PAI _PAR _PCL _PCT _PDC _PDL _PHA _PIC _PIF _PIN _PLD _PMC _PMD _PMM _POL _PPC _PPE _PPI _PR _PR0 _PR1 _PR2 _PR3 _PRE _PRL _PRS _PRT _PRW _PS0 _PS1 _PS2 _PS3 _PSC _PSD _PSE _PSL _PSR _PSS _PSV _PSW _PTC _PTP _PTS _PUR _PXM _RBO _RBW _REG _REV _RMV _RNG _ROM _RT _RTV _RW _RXL _S0 _S1 _S2 _S3 _S4 _S4 _S1D _S2D _S3D _S4D _S0W _S1W _S2W _S3W _S4W _SB _SBS _SCP _SDD _SEG _SHL _SHR _SI _SIZ _SLI _SLV _SPD _SPE _SRS _SRT _SRV _SST _STA _STB _STM _STP _STR _STV _SUN _SWS _TC2 _TC2 _TDL _TIP _TIV _TMP _TPC _TPT _TRA _TRS _TRT _TSD _TSF _TSP _TSS _TST _TTP _TXL _TTS _TYP _TZ _TZD _TZM _TZP _UID _UPC _UPD _UPP _VPO _VEN _WAK

" IASL Preprocessor: #define #elif #else #endif #error #if #ifdef #ifndef #include #line #undef
syn region  aslPreProc          start="^\s*\(%:\|#\)\s*\(include\)\>" skip="\\$" end="$" keepend
syn region  aslPreProc          start="^\s*\(%:\|#\)\s*\(error\|line\|define\|undef\|if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" keepend contains=ALL
syn match   aslPreProcMatch     display "^\s*\(%:\|#\)\s*\(else\|endif\)\>"

" Numeric values and Zero / One keywords
syn keyword aslZeroOne          Zero One
syn match   aslNumber           display "\<\d\+"
syn match   aslNumber           display "0x\x\+"

" Set the default colors
hi def link aslTodo              Todo
hi def link aslComment           Comment
hi def link aslString            String
hi def link aslPrimaryKeyword    Keyword
hi def link aslParameterKeyword  Macro
hi def link aslResourceKeyword   Type
hi def link aslObjects           Identifier
hi def link aslPreProc           PreProc
hi def link aslPreProcMatch      PreProc
hi def link aslZeroOne           Number
hi def link aslNumber            Number

let b:current_syntax = "asl"
syn sync minlines=200


endif
