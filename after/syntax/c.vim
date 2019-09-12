if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'c++11') == -1

" Vim syntax file
" Language: C Additions
" Maintainer: Jon Haggblad <jon@haeggblad.com>
" Contributor: Mikhail Wolfson <mywolfson@gmail.com>
" URL: http://www.haeggblad.com
" Last Change: 6 Sep 2014
" Version: 0.3
" Changelog:
"   0.3 - integration of aftersyntaxc.vim
"   0.2 - Cleanup
"   0.1 - initial version.
"
" Syntax highlighting for functions in C.
"
" Based on:
"   http://stackoverflow.com/questions/736701/class-function-names-highlighting-in-vim

" -----------------------------------------------------------------------------
"  Highlight function names.
" -----------------------------------------------------------------------------
if !exists('g:cpp_no_function_highlight')
    syn match    cCustomParen    transparent "(" contains=cParen contains=cCppParen
    syn match    cCustomFunc     "\w\+\s*(\@=" contains=cCustomParen
    hi def link cCustomFunc  Function
endif

" -----------------------------------------------------------------------------
"  Highlight member variable names.
" -----------------------------------------------------------------------------
if exists('g:cpp_member_variable_highlight') && g:cpp_member_variable_highlight
    syn match   cCustomDot    "\." contained
    syn match   cCustomPtr    "->" contained
    syn match   cCustomMemVar "\(\.\|->\)\h\w*" contains=cCustomDot,cCustomPtr
    hi def link cCustomMemVar Function
endif

" -----------------------------------------------------------------------------
"  Source: aftersyntaxc.vim
" -----------------------------------------------------------------------------

" Common ANSI-standard functions
syn keyword cAnsiFunction	MULU_ DIVU_ MODU_ MUL_ DIV_ MOD_
syn keyword cAnsiFunction	main typeof
syn keyword cAnsiFunction	open close read write lseek dup dup2
syn keyword cAnsiFunction	fcntl ioctl
syn keyword cAnsiFunction	wctrans towctrans towupper
syn keyword cAnsiFunction	towlower wctype iswctype
syn keyword cAnsiFunction	iswxdigit iswupper iswspace
syn keyword cAnsiFunction	iswpunct iswprint iswlower
syn keyword cAnsiFunction	iswgraph iswdigit iswcntrl
syn keyword cAnsiFunction	iswalpha iswalnum wcsrtombs
syn keyword cAnsiFunction	mbsrtowcs wcrtomb mbrtowc
syn keyword cAnsiFunction	mbrlen mbsinit wctob
syn keyword cAnsiFunction	btowc wcsfxtime wcsftime
syn keyword cAnsiFunction	wmemset wmemmove wmemcpy
syn keyword cAnsiFunction	wmemcmp wmemchr wcstok
syn keyword cAnsiFunction	wcsstr wcsspn wcsrchr
syn keyword cAnsiFunction	wcspbrk wcslen wcscspn
syn keyword cAnsiFunction	wcschr wcsxfrm wcsncmp
syn keyword cAnsiFunction	wcscoll wcscmp wcsncat
syn keyword cAnsiFunction	wcscat wcsncpy wcscpy
syn keyword cAnsiFunction	wcstoull wcstoul wcstoll
syn keyword cAnsiFunction	wcstol wcstold wcstof
syn keyword cAnsiFunction	wcstod ungetwc putwchar
syn keyword cAnsiFunction	putwc getwchar getwc
syn keyword cAnsiFunction	fwide fputws fputwc
syn keyword cAnsiFunction	fgetws fgetwc wscanf
syn keyword cAnsiFunction	wprintf vwscanf vwprintf
syn keyword cAnsiFunction	vswscanf vswprintf vfwscanf
syn keyword cAnsiFunction	vfwprintf swscanf swprintf
syn keyword cAnsiFunction	fwscanf fwprintf zonetime
syn keyword cAnsiFunction	strfxtime strftime localtime
syn keyword cAnsiFunction	gmtime ctime asctime
syn keyword cAnsiFunction	time mkxtime mktime
syn keyword cAnsiFunction	difftime clock strlen
syn keyword cAnsiFunction	strerror memset strtok
syn keyword cAnsiFunction	strstr strspn strrchr
syn keyword cAnsiFunction	strpbrk strcspn strchr
syn keyword cAnsiFunction	memchr strxfrm strncmp
syn keyword cAnsiFunction	strcoll strcmp memcmp
syn keyword cAnsiFunction	strncat strcat strncpy
syn keyword cAnsiFunction	strcpy memmove memcpy
syn keyword cAnsiFunction	wcstombs mbstowcs wctomb
syn keyword cAnsiFunction	mbtowc mblen lldiv
syn keyword cAnsiFunction	ldiv div llabs
syn keyword cAnsiFunction	labs abs qsort
"syn keyword cAnsiFunction	bsearch system getenv
syn keyword cAnsiFunction	bsearch getenv
syn keyword cAnsiFunction	exit atexit abort
syn keyword cAnsiFunction	realloc malloc free
syn keyword cAnsiFunction	calloc srand rand
syn keyword cAnsiFunction	strtoull strtoul strtoll
syn keyword cAnsiFunction	strtol strtold strtof
syn keyword cAnsiFunction	strtod atoll atol
syn keyword cAnsiFunction	atoi atof perror
syn keyword cAnsiFunction	ferror feof clearerr
syn keyword cAnsiFunction	rewind ftell fsetpos
syn keyword cAnsiFunction	fseek fgetpos fwrite
syn keyword cAnsiFunction	fread ungetc puts
syn keyword cAnsiFunction	putchar putc gets
syn keyword cAnsiFunction	getchar getc fputs
syn keyword cAnsiFunction	fputc fgets fgetc
syn keyword cAnsiFunction	vsscanf vsprintf vsnprintf
syn keyword cAnsiFunction	vscanf vprintf vfscanf
syn keyword cAnsiFunction	vfprintf sscanf sprintf
syn keyword cAnsiFunction	snprintf scanf printf
syn keyword cAnsiFunction	fscanf fprintf setvbuf
syn keyword cAnsiFunction	setbuf freopen fopen
syn keyword cAnsiFunction	fflush fclose tmpnam
syn keyword cAnsiFunction	tmpfile rename remove
syn keyword cAnsiFunction	offsetof va_start va_end
syn keyword cAnsiFunction	va_copy va_arg raise signal
syn keyword cAnsiFunction	longjmp setjmp isunordered
syn keyword cAnsiFunction	islessgreater islessequal isless
syn keyword cAnsiFunction	isgreaterequal isgreater fmal
syn keyword cAnsiFunction	fmaf fma fminl
syn keyword cAnsiFunction	fminf fmin fmaxl
syn keyword cAnsiFunction	fmaxf fmax fdiml
syn keyword cAnsiFunction	fdimf fdim nextafterxl
syn keyword cAnsiFunction	nextafterxf nextafterx nextafterl
syn keyword cAnsiFunction	nextafterf nextafter nanl
syn keyword cAnsiFunction	nanf nan copysignl
syn keyword cAnsiFunction	copysignf copysign remquol
syn keyword cAnsiFunction	remquof remquo remainderl
syn keyword cAnsiFunction	remainderf remainder fmodl
syn keyword cAnsiFunction	fmodf fmod truncl
syn keyword cAnsiFunction	truncf trunc llroundl
syn keyword cAnsiFunction	llroundf llround lroundl
syn keyword cAnsiFunction	lroundf lround roundl
syn keyword cAnsiFunction	roundf round llrintl
syn keyword cAnsiFunction	llrintf llrint lrintl
syn keyword cAnsiFunction	lrintf lrint rintl
syn keyword cAnsiFunction	rintf rint nearbyintl
syn keyword cAnsiFunction	nearbyintf nearbyint floorl
syn keyword cAnsiFunction	floorf floor ceill
syn keyword cAnsiFunction	ceilf ceil tgammal
syn keyword cAnsiFunction	tgammaf tgamma lgammal
syn keyword cAnsiFunction	lgammaf lgamma erfcl
syn keyword cAnsiFunction	erfcf erfc erfl
syn keyword cAnsiFunction	erff erf sqrtl
syn keyword cAnsiFunction	sqrtf sqrt powl
syn keyword cAnsiFunction	powf pow hypotl
syn keyword cAnsiFunction	hypotf hypot fabsl
syn keyword cAnsiFunction	fabsf fabs cbrtl
syn keyword cAnsiFunction	cbrtf cbrt scalblnl
syn keyword cAnsiFunction	scalblnf scalbln scalbnl
syn keyword cAnsiFunction	scalbnf scalbn modfl
syn keyword cAnsiFunction	modff modf logbl
syn keyword cAnsiFunction	logbf logb log2l
syn keyword cAnsiFunction	log2f log2 log1pl
syn keyword cAnsiFunction	log1pf log1p log10l
syn keyword cAnsiFunction	log10f log10 logl
syn keyword cAnsiFunction	logf log ldexpl
syn keyword cAnsiFunction	ldexpf ldexp ilogbl
syn keyword cAnsiFunction	ilogbf ilogb frexpl
syn keyword cAnsiFunction	frexpf frexp expm1l
syn keyword cAnsiFunction	expm1f expm1 exp2l
syn keyword cAnsiFunction	exp2f exp2 expl
syn keyword cAnsiFunction	expf exp tanhl
syn keyword cAnsiFunction	tanhf tanh sinhl
syn keyword cAnsiFunction	sinhf sinh coshl
syn keyword cAnsiFunction	coshf cosh atanhl
syn keyword cAnsiFunction	atanhf atanh asinhl
syn keyword cAnsiFunction	asinhf asinh acoshl
syn keyword cAnsiFunction	acoshf acosh tanl
syn keyword cAnsiFunction	tanf tan sinl
syn keyword cAnsiFunction	sinf sin cosl
syn keyword cAnsiFunction	cosf cos atan2l
syn keyword cAnsiFunction	atan2f atan2 atanl
syn keyword cAnsiFunction	atanf atan asinl
syn keyword cAnsiFunction	asinf asin acosl
syn keyword cAnsiFunction	acosf acos signbit
syn keyword cAnsiFunction	isnormal isnan isinf
syn keyword cAnsiFunction	isfinite fpclassify localeconv
syn keyword cAnsiFunction	setlocale wcstoumax wcstoimax
syn keyword cAnsiFunction	strtoumax strtoimax feupdateenv
syn keyword cAnsiFunction	fesetenv feholdexcept fegetenv
syn keyword cAnsiFunction	fesetround fegetround fetestexcept
syn keyword cAnsiFunction	fesetexceptflag feraiseexcept fegetexceptflag
syn keyword cAnsiFunction	feclearexcept toupper tolower
syn keyword cAnsiFunction	isxdigit isupper isspace
syn keyword cAnsiFunction	ispunct isprint islower
syn keyword cAnsiFunction	isgraph isdigit iscntrl
syn keyword cAnsiFunction	isalpha isalnum creall
syn keyword cAnsiFunction	crealf creal cprojl
syn keyword cAnsiFunction	cprojf cproj conjl
syn keyword cAnsiFunction	conjf conj cimagl
syn keyword cAnsiFunction	cimagf cimag cargl
syn keyword cAnsiFunction	cargf carg csqrtl
syn keyword cAnsiFunction	csqrtf csqrt cpowl
syn keyword cAnsiFunction	cpowf cpow cabsl
syn keyword cAnsiFunction	cabsf cabs clogl
syn keyword cAnsiFunction	clogf clog cexpl
syn keyword cAnsiFunction	cexpf cexp ctanhl
syn keyword cAnsiFunction	ctanhf ctanh csinhl
syn keyword cAnsiFunction	csinhf csinh ccoshl
syn keyword cAnsiFunction	ccoshf ccosh catanhl
syn keyword cAnsiFunction	catanhf catanh casinhl
syn keyword cAnsiFunction	casinhf casinh cacoshl
syn keyword cAnsiFunction	cacoshf cacosh ctanl
syn keyword cAnsiFunction	ctanf ctan csinl
syn keyword cAnsiFunction	csinf csin ccosl
syn keyword cAnsiFunction	ccosf ccos catanl
syn keyword cAnsiFunction	catanf catan casinl
syn keyword cAnsiFunction	casinf casin cacosl
syn keyword cAnsiFunction	cacosf cacos assert
syn keyword cAnsiFunction	UINTMAX_C INTMAX_C UINT64_C
syn keyword cAnsiFunction	UINT32_C UINT16_C UINT8_C
syn keyword cAnsiFunction	INT64_C INT32_C INT16_C INT8_C

" Common ANSI-standard Names
syn keyword	cAnsiName	PRId8 PRIi16 PRIo32 PRIu64
syn keyword	cAnsiName	PRId16 PRIi32 PRIo64 PRIuLEAST8
syn keyword	cAnsiName	PRId32 PRIi64 PRIoLEAST8 PRIuLEAST16
syn keyword	cAnsiName	PRId64 PRIiLEAST8 PRIoLEAST16 PRIuLEAST32
syn keyword	cAnsiName	PRIdLEAST8 PRIiLEAST16 PRIoLEAST32 PRIuLEAST64
syn keyword	cAnsiName	PRIdLEAST16 PRIiLEAST32 PRIoLEAST64 PRIuFAST8
syn keyword	cAnsiName	PRIdLEAST32 PRIiLEAST64 PRIoFAST8 PRIuFAST16
syn keyword	cAnsiName	PRIdLEAST64 PRIiFAST8 PRIoFAST16 PRIuFAST32
syn keyword	cAnsiName	PRIdFAST8 PRIiFAST16 PRIoFAST32 PRIuFAST64
syn keyword	cAnsiName	PRIdFAST16 PRIiFAST32 PRIoFAST64 PRIuMAX
syn keyword	cAnsiName	PRIdFAST32 PRIiFAST64 PRIoMAX PRIuPTR
syn keyword	cAnsiName	PRIdFAST64 PRIiMAX PRIoPTR PRIx8
syn keyword	cAnsiName	PRIdMAX PRIiPTR PRIu8 PRIx16
syn keyword	cAnsiName	PRIdPTR PRIo8 PRIu16 PRIx32
syn keyword	cAnsiName	PRIi8 PRIo16 PRIu32 PRIx64

syn keyword	cAnsiName	PRIxLEAST8 SCNd8 SCNiFAST32 SCNuLEAST32
syn keyword	cAnsiName	PRIxLEAST16 SCNd16 SCNiFAST64 SCNuLEAST64
syn keyword	cAnsiName	PRIxLEAST32 SCNd32 SCNiMAX SCNuFAST8
syn keyword	cAnsiName	PRIxLEAST64 SCNd64 SCNiPTR SCNuFAST16
syn keyword	cAnsiName	PRIxFAST8 SCNdLEAST8 SCNo8 SCNuFAST32
syn keyword	cAnsiName	PRIxFAST16 SCNdLEAST16 SCNo16 SCNuFAST64
syn keyword	cAnsiName	PRIxFAST32 SCNdLEAST32 SCNo32 SCNuMAX
syn keyword	cAnsiName	PRIxFAST64 SCNdLEAST64 SCNo64 SCNuPTR
syn keyword	cAnsiName	PRIxMAX SCNdFAST8 SCNoLEAST8 SCNx8
syn keyword	cAnsiName	PRIxPTR SCNdFAST16 SCNoLEAST16 SCNx16
syn keyword	cAnsiName	PRIX8 SCNdFAST32 SCNoLEAST32 SCNx32
syn keyword	cAnsiName	PRIX16 SCNdFAST64 SCNoLEAST64 SCNx64
syn keyword	cAnsiName	PRIX32 SCNdMAX SCNoFAST8 SCNxLEAST8
syn keyword	cAnsiName	PRIX64 SCNdPTR SCNoFAST16 SCNxLEAST16
syn keyword	cAnsiName	PRIXLEAST8 SCNi8 SCNoFAST32 SCNxLEAST32
syn keyword	cAnsiName	PRIXLEAST16 SCNi16 SCNoFAST64 SCNxLEAST64
syn keyword	cAnsiName	PRIXLEAST32 SCNi32 SCNoMAX SCNxFAST8
syn keyword	cAnsiName	PRIXLEAST64 SCNi64 SCNoPTR SCNxFAST16
syn keyword	cAnsiName	PRIXFAST8 SCNiLEAST8 SCNu8 SCNxFAST32
syn keyword	cAnsiName	PRIXFAST16 SCNiLEAST16 SCNu16 SCNxFAST64
syn keyword	cAnsiName	PRIXFAST32 SCNiLEAST32 SCNu32 SCNxMAX
syn keyword	cAnsiName	PRIXFAST64 SCNiLEAST64 SCNu64 SCNxPTR
syn keyword	cAnsiName	PRIXMAX SCNiFAST8 SCNuLEAST8
syn keyword	cAnsiName	PRIXPTR SCNiFAST16 SCNuLEAST16

syn keyword	cAnsiName	errno environ

syn keyword	cAnsiName	STDC CX_LIMITED_RANGE
syn keyword	cAnsiName	STDC FENV_ACCESS
syn keyword	cAnsiName	STDC FP_CONTRACT

syn keyword	cAnsiName	and bitor not_eq xor
syn keyword	cAnsiName	and_eq compl or xor_eq
syn keyword	cAnsiName	bitand not or_eq

hi def link cAnsiFunction cFunction
hi def link cAnsiName cIdentifier
hi def link cFunction Function
hi def link cIdentifier Identifier

" Booleans
syn keyword cBoolean true false TRUE FALSE
hi def link cBoolean Boolean

" -----------------------------------------------------------------------------
"  Additional optional highlighting
" -----------------------------------------------------------------------------

" Operators
"syn match cOperator	"\(<<\|>>\|[-+*/%&^|<>!=]\)="
"syn match cOperator	"<<\|>>\|&&\|||\|++\|--\|->"
"syn match cOperator	"[.!~*&%<>^|=,+-]"
"syn match cOperator	"/[^/*=]"me=e-1
"syn match cOperator	"/$"
"syn match cOperator "&&\|||"
"syn match cOperator	"[][]"
"
"" Preprocs
"syn keyword cDefined defined contained containedin=cDefine
"hi def link cDefined cDefine

"" Functions
"syn match cUserFunction "\<\h\w*\>\(\s\|\n\)*("me=e-1 contains=cType,cDelimiter,cDefine
"syn match cUserFunctionPointer "(\s*\*\s*\h\w*\s*)\(\s\|\n\)*(" contains=cDelimiter,cOperator
"
"hi def link cUserFunction cFunction
"hi def link cUserFunctionPointer cFunction
"
"" Delimiters
"syn match cDelimiter    "[();\\]"
"" foldmethod=syntax fix, courtesy of Ivan Freitas
"syn match cBraces display "[{}]"

" Links
"hi def link cDelimiter Delimiter
" foldmethod=syntax fix, courtesy of Ivan Freitas
"hi def link cBraces Delimiter

endif
