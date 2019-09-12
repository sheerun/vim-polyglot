if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'arduino') == -1

" Vim syntax file
" Language:    Arduino
" Maintainer:  Sudar <sudar@sudarmuthu.com>
" Original Author:  Johannes Hoff <johannes@johanneshoff.com>
" Last Change: 27 April 2015
" License:     VIM license (:help license, replace vim by arduino.vim)

" Syntax highlighting like in the Arduino IDE

" Thanks to original author Johannes Hoff and Rik, Erik Nomitch, Adam Obeng and Graeme Cross for helpful feedback!
" Thanks to Rafi Khan for Arduino 1.5.x support

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Read the C syntax to start with
if version < 600
  so <sfile>:p:h/cpp.vim
else
  runtime! syntax/cpp.vim
endif

"C:/Program Files (x86)/Arduino\hardware\arduino\avr\libraries\EEPROM\keywords.txt{{{
	syn keyword arduinoConstant EEPROM
"}}}
"C:/Program Files (x86)/Arduino\hardware\arduino\avr\libraries\SoftwareSerial\keywords.txt{{{
	syn keyword arduinoFunc SoftwareSerial begin end read write available isListening overflow flush listen
	syn keyword arduinoFunc peek
"}}}
"C:/Program Files (x86)/Arduino\hardware\arduino\avr\libraries\SPI\keywords.txt{{{
	syn keyword arduinoConstant SPI SPI_CLOCK_DIV4 SPI_CLOCK_DIV16 SPI_CLOCK_DIV64 SPI_CLOCK_DIV128 SPI_CLOCK_DIV2 SPI_CLOCK_DIV8 SPI_CLOCK_DIV32 SPI_CLOCK_DIV64 SPI_MODE0
	syn keyword arduinoConstant SPI_MODE1 SPI_MODE2 SPI_MODE3
	syn keyword arduinoFunc begin end transfer setBitOrder setDataMode setClockDivider
"}}}
"C:/Program Files (x86)/Arduino\hardware\arduino\avr\libraries\Wire\keywords.txt{{{
	syn keyword arduinoFunc begin setClock beginTransmission endTransmission requestFrom send receive onReceive onRequest Wire
"}}}
"C:/Program Files (x86)/Arduino\hardware\arduino\sam\libraries\SPI\keywords.txt{{{
	syn keyword arduinoConstant SPI SPI_MODE0 SPI_MODE1 SPI_MODE2 SPI_MODE3 SPI_CONTINUE SPI_LAST
	syn keyword arduinoFunc begin end transfer setDataMode setClockDivider
"}}}
"C:/Program Files (x86)/Arduino\hardware\arduino\sam\libraries\Wire\keywords.txt{{{
	syn keyword arduinoFunc begin setClock beginTransmission endTransmission requestFrom send receive onReceive onRequest Wire
	syn keyword arduinoFunc Wire1
"}}}
"C:/Program Files (x86)/Arduino\lib\keywords.txt{{{
	syn keyword arduinoConstant HIGH LOW INPUT INPUT_PULLUP OUTPUT DEC BIN HEX OCT PI
	syn keyword arduinoConstant HALF_PI TWO_PI LSBFIRST MSBFIRST CHANGE FALLING RISING DEFAULT EXTERNAL INTERNAL
	syn keyword arduinoConstant INTERNAL1V1 INTERNAL2V56
	syn keyword arduinoType boolean break byte case char class const continue default do
	syn keyword arduinoType double else false float for if int long new null
	syn keyword arduinoType private protected public register return short signed static String switch
	syn keyword arduinoType this throw try true unsigned void while word boolean byte
	syn keyword arduinoType char float int long word
	syn keyword arduinoFunc abs acos asin atan atan2 ceil constrain cos degrees exp
	syn keyword arduinoFunc floor log map max min radians random randomSeed round sin
	syn keyword arduinoFunc sq sqrt tan pow bitRead bitWrite bitSet bitClear bit highByte
	syn keyword arduinoFunc lowByte analogReference analogRead analogWrite attachInterrupt detachInterrupt delay delayMicroseconds digitalWrite digitalRead
	syn keyword arduinoFunc interrupts millis micros noInterrupts noTone pinMode pulseIn shiftIn shiftOut tone
	syn keyword arduinoFunc yield
	syn keyword arduinoIdentifier Serial Serial1 Serial2 Serial3
	syn keyword arduinoFunc SerialUSB begin end peek read
	syn keyword arduinoFunc print println available availableForWrite flush setTimeout find findUntil parseInt parseFloat
	syn keyword arduinoFunc readBytes readBytesUntil readString readStringUntil trim toUpperCase toLowerCase charAt compareTo concat
	syn keyword arduinoFunc endsWith startsWith equals equalsIgnoreCase getBytes indexOf lastIndexOf length replace setCharAt
	syn keyword arduinoFunc substring toCharArray toInt Keyboard Mouse press release releaseAll accept click
	syn keyword arduinoFunc move isPressed setup loop
"}}}
"C:/Program Files (x86)/Arduino\libraries\Audio\keywords.txt{{{
	syn keyword arduinoFunc Audio prepare write
"}}}
"C:/Program Files (x86)/Arduino\libraries\Bridge\keywords.txt{{{
	syn keyword arduinoConstant FILE_READ FILE_WRITE FILE_APPEND
	syn keyword arduinoFunc Bridge FileIO FileSystem Console Process Mailbox HttpClient YunServer YunClient begin
	syn keyword arduinoFunc end available read peek write flush bool transfer put get
	syn keyword arduinoFunc buffer noBuffer connected File seek position size close name isDirectory
	syn keyword arduinoFunc openNextFile rewindDirectory addParameter runAsynchronously run running exitValue runShellCommand runShellCommandAsynchronously readMessage
	syn keyword arduinoFunc writeMessage writeJSON message Available getAsynchronously ready getResult accept stop connect connected
"}}}
"C:/Program Files (x86)/Arduino\libraries\Esplora\keywords.txt{{{
	syn keyword arduinoConstant JOYSTICK_BASE MAX_CHANNELS CH_SWITCH_1 CH_SWITCH_2 CH_SWITCH_3 CH_SWITCH_4 CH_SLIDER CH_LIGHT CH_TEMPERATURE CH_MIC
	syn keyword arduinoConstant CH_JOYSTICK_SW CH_JOYSTICK_X CH_JOYSTICK_Y SWITCH_1 SWITCH_2 SWITCH_3 SWITCH_4 SWITCH_DOWN SWITCH_LEFT SWITCH_UP
	syn keyword arduinoConstant SWITCH_RIGHT JOYSTICK_DOWN JOYSTICK_LEFT JOYSTICK_UP PRESSED RELEASED DEGREES_C DEGREES_F X_AXIS Y_AXIS
	syn keyword arduinoConstant Z_AXIS
	syn keyword arduinoFunc Esplora begin readSlider readLightSensor readTemperature readMicrophone readJoystickSwitch readJoystickButton readJoystickX readJoystickY
	syn keyword arduinoFunc readAccelerometer readButton writeRGB writeRed writeGreen writeBlue readRed readGreen readBlue readBlue
	syn keyword arduinoFunc readBlue readBlue tone noTone
"}}}
"C:/Program Files (x86)/Arduino\libraries\Ethernet\keywords.txt{{{
	syn keyword arduinoFunc Ethernet EthernetClient EthernetServer IPAddress status connect write available read peek
	syn keyword arduinoFunc flush stop connected begin beginPacket endPacket parsePacket remoteIP remotePort
"}}}
"C:/Program Files (x86)/Arduino\libraries\Firmata\keywords.txt{{{
	syn keyword arduinoConstant MAX_DATA_BYTES DIGITAL_MESSAGE ANALOG_MESSAGE REPORT_ANALOG REPORT_DIGITAL REPORT_VERSION SET_PIN_MODE SYSTEM_RESET START_SYSEX END_SYSEX
	syn keyword arduinoConstant PWM TOTAL_ANALOG_PINS TOTAL_DIGITAL_PINS TOTAL_PORTS ANALOG_PORT
	syn keyword arduinoFunc Firmata callbackFunction systemResetCallbackFunction stringCallbackFunction sysexCallbackFunction begin begin printVersion blinkVersion printFirmwareVersion
	syn keyword arduinoFunc setFirmwareVersion setFirmwareNameAndVersion available processInput sendAnalog sendDigital sendDigitalPortPair sendDigitalPort sendString sendString
	syn keyword arduinoFunc sendSysex attach detach flush
"}}}
"C:/Program Files (x86)/Arduino\libraries\GSM\keywords.txt{{{
	syn keyword arduinoConstant GSM GSM_SMS GPRS GSMPIN GSMPIN ERROR IDLE CONNECTING GSM_READY GPRS_READY
	syn keyword arduinoConstant TRANSPARENT_CONNECTED IDLE_CALL CALLING RECEIVINGCALL TALKING GSM_MODE_UNDEFINED GSM_MODE_EGSM GSM_MODE_DCS GSM_MODE_PCS GSM_MODE_EGSM_DCS
	syn keyword arduinoConstant GSM_MODE_GSM850_PCS GSM_MODE_GSM850_EGSM_DCS_PCS
	syn keyword arduinoFunc GSMVoiceCall GSMClient GSMServer GSMModem GSMScanner begin shutdown gatVoiceCallStatus ready voiceCall
	syn keyword arduinoFunc answerCall hangCall retrieveCallingNumber beginSMS endSMS remoteNumber attachGPRS begnWrite endWrite getIMEI
	syn keyword arduinoFunc getCurrentCarrier getSignalStrength readNetworks isPIN checkPIN checkPUK changePIN switchPIN checkReg getPINUsed
	syn keyword arduinoFunc setPINUsed getBand setBand getvoiceCallStatus
"}}}
"C:/Program Files (x86)/Arduino\libraries\LiquidCrystal\keywords.txt{{{
	syn keyword arduinoFunc LiquidCrystal begin clear home print setCursor cursor noCursor blink noBlink
	syn keyword arduinoFunc display noDisplay autoscroll noAutoscroll leftToRight rightToLeft scrollDisplayLeft scrollDisplayRight createChar setRowOffsets
"}}}
"C:/Program Files (x86)/Arduino\libraries\Scheduler\keywords.txt{{{
	syn keyword arduinoFunc Scheduler startLoop
"}}}
"C:/Program Files (x86)/Arduino\libraries\SD\keywords.txt{{{
	syn keyword arduinoConstant SD FILE_READ FILE_WRITE
	syn keyword arduinoFunc File begin exists mkdir remove rmdir open close seek position
	syn keyword arduinoFunc size
"}}}
"C:/Program Files (x86)/Arduino\libraries\Servo\keywords.txt{{{
	syn keyword arduinoFunc Servo attach detach write read attached writeMicroseconds readMicroseconds
"}}}
"C:/Program Files (x86)/Arduino\libraries\SpacebrewYun\keywords.txt{{{
	syn keyword arduinoFunc SpacebrewYun addPublish addSubscribe connect verbose monitor onMessage send onRangeMessage onStringMessage
	syn keyword arduinoFunc onBooleanMessage onCustomMessage onOpen onClose onError
"}}}
"C:/Program Files (x86)/Arduino\libraries\Stepper\keywords.txt{{{
	syn keyword arduinoFunc Stepper step setSpeed version direction speed
"}}}
"C:/Program Files (x86)/Arduino\libraries\Temboo\keywords.txt{{{
	syn keyword arduinoFunc Temboo TembooChoreo begin setAccountName setAppKeyName setAppKey setChoreo setCredential setSavedInputs addInput
	syn keyword arduinoFunc addOutputFilter setSettingsFileToWrite setSettingsFileToRead
"}}}
"C:/Program Files (x86)/Arduino\libraries\TFT\keywords.txt{{{
	syn keyword arduinoConstant TFT
	syn keyword arduinoFunc EsploraTFT
"}}}
"C:/Program Files (x86)/Arduino\libraries\TFT\src\utility\keywords.txt{{{
	syn keyword arduinoFunc Adafruit_GFX Adafruit_ST7735 PImage drawPixel invertDisplay drawLine drawFastVLine drawFastHLine drawRect fillRect
	syn keyword arduinoFunc fillScreen drawCircle drawCircleHelper fillCircle fillCircleHelper drawTriangle fillTriangle drawRoundRect fillRoundRect drawBitmap
	syn keyword arduinoFunc drawChar setCursor setTextColor setTextSize setTextWrap height width setRotation getRotation newColor
	syn keyword arduinoFunc background fill noFill stroke noStroke text textWrap textSize circle point
	syn keyword arduinoFunc quad rect triangle loadImage image draw isValid
"}}}
"C:/Program Files (x86)/Arduino\libraries\USBHost\keywords.txt{{{
	syn keyword arduinoFunc MouseController USBHost KeyboardController Task mouseMoved mouseDragged mousePressed mouseReleased getXChange getYChange
	syn keyword arduinoFunc getButton keyPressed keyReleased getModifiers getKey getOemKey
"}}}
"C:/Program Files (x86)/Arduino\libraries\WiFi\keywords.txt{{{
	syn keyword arduinoConstant SSID BSSID RSSI
	syn keyword arduinoFunc WiFi WiFiUdp Client Server firmwareVersion status connect write available config
	syn keyword arduinoFunc setDNS read flush stop connected begin disconnect macAddress localIP subnetMask
	syn keyword arduinoFunSec gatewayIP encryptionType getResult getSocket WiFiClient WiFiServer WiFiUDP beginPacket endPacket parsePacket
	syn keyword arduinoFunc remoteIP remotePort
"}}}

hi def link arduinoType Type
hi def link arduinoConstant Constant
hi def link arduinoFunc Function
hi def link arduinoIdentifier Identifier

endif
