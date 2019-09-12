if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'c++11') == -1

" Vim syntax file
" Language: C++ Additions
" Maintainer: Jon Haggblad <jon@haeggblad.com>
" URL: http://www.haeggblad.com
" Last Change: 29 Jun 2019
" Version: 0.6
" Changelog:
"   0.1 - initial version.
"   0.2 - C++14
"   0.3 - Incorporate lastest changes from Mizuchi/STL-Syntax
"   0.4 - Add template function highlight
"   0.5 - Redo template function highlight to be more robust. Add options.
"   0.6 - more C++14, C++17, library concepts
"
" Additional Vim syntax highlighting for C++ (including C++11/14/17)
"
" This file contains additional syntax highlighting that I use for C++11/14
" development in Vim. Compared to the standard syntax highlighting for C++ it
" adds highlighting of (user defined) functions and the containers and types
" in the standard library / boost.
"
" Based on:
"   http://stackoverflow.com/q/736701
"   http://www.vim.org/scripts/script.php?script_id=4293
"   http://www.vim.org/scripts/script.php?script_id=2224
"   http://www.vim.org/scripts/script.php?script_id=1640
"   http://www.vim.org/scripts/script.php?script_id=3064


" -----------------------------------------------------------------------------
"  Highlight Class and Function names.
"
" Based on the discussion in: http://stackoverflow.com/q/736701
" -----------------------------------------------------------------------------

" Functions
if !exists('g:cpp_no_function_highlight')
    syn match   cCustomParen    transparent "(" contains=cParen contains=cCppParen
    syn match   cCustomFunc     "\w\+\s*(\@="
    hi def link cCustomFunc  Function
endif

" Class and namespace scope
if exists('g:cpp_class_scope_highlight') && g:cpp_class_scope_highlight
    syn match   cCustomScope    "::"
    syn match   cCustomClass    "\w\+\s*::"
                \ contains=cCustomScope
    hi def link cCustomClass Function
endif

" Clear cppStructure and replace "class" and/or "template" with matches
" based on user configuration
let s:needs_cppstructure_match = 0
if exists('g:cpp_class_decl_highlight') && g:cpp_class_decl_highlight
	let s:needs_cppstructure_match += 1
endif
if exists('g:cpp_experimental_template_highlight') && g:cpp_experimental_template_highlight
	let s:needs_cppstructure_match += 2
endif

syn clear cppStructure
if s:needs_cppstructure_match == 0
	syn keyword cppStructure typename namespace template class
elseif s:needs_cppstructure_match == 1
	syn keyword cppStructure typename namespace template
elseif s:needs_cppstructure_match == 2
	syn keyword cppStructure typename namespace class
elseif s:needs_cppstructure_match == 3
	syn keyword cppStructure typename namespace
endif
unlet s:needs_cppstructure_match


" Class name declaration
if exists('g:cpp_class_decl_highlight') && g:cpp_class_decl_highlight
	syn match cCustomClassKey "\<class\>"
	hi def link cCustomClassKey cppStructure

	" Clear cppAccess entirely and redefine as matches
	syn clear cppAccess
	syn match cCustomAccessKey "\<private\>"
	syn match cCustomAccessKey "\<public\>"
	syn match cCustomAccessKey "\<protected\>"
	hi def link cCustomAccessKey cppAccess

	" Match the parts of a class declaration
	syn match cCustomClassName "\<class\_s\+\w\+\>"
				\ contains=cCustomClassKey
	syn match cCustomClassName "\<private\_s\+\w\+\>"
				\ contains=cCustomAccessKey
	syn match cCustomClassName "\<public\_s\+\w\+\>"
				\ contains=cCustomAccessKey
	syn match cCustomClassName "\<protected\_s\+\w\+\>"
				\ contains=cCustomAccessKey
	hi def link cCustomClassName Function
endif
" Template functions.
" Naive implementation that sorta works in most cases. Should correctly
" highlight everything in test/color2.cpp
if exists('g:cpp_experimental_simple_template_highlight') && g:cpp_experimental_simple_template_highlight
    syn region  cCustomAngleBrackets matchgroup=AngleBracketContents start="\v%(<operator\_s*)@<!%(%(\_i|template\_s*)@<=\<[<=]@!|\<@<!\<[[:space:]<=]@!)" end='>' contains=@cppSTLgroup,cppStructure,cType,cCustomClass,cCustomAngleBrackets,cNumbers
    syn match   cCustomBrack    "<\|>" contains=cCustomAngleBrackets
    syn match   cCustomTemplateFunc "\w\+\s*<.*>(\@=" contains=cCustomBrack,cCustomAngleBrackets
    hi def link cCustomTemplateFunc  Function

" Template functions (alternative faster parsing).
" More sophisticated implementation that should be faster but doesn't always
" correctly highlight inside template arguments. Should correctly
" highlight everything in test/color.cpp
elseif exists('g:cpp_experimental_template_highlight') && g:cpp_experimental_template_highlight

    syn match   cCustomAngleBracketStart "<\_[^;()]\{-}>" contained
                \ contains=cCustomAngleBracketStart,cCustomAngleBracketEnd
    hi def link cCustomAngleBracketStart  cCustomAngleBracketContent

    syn match   cCustomAngleBracketEnd ">\_[^<>;()]\{-}>" contained
                \ contains=cCustomAngleBracketEnd
    hi def link cCustomAngleBracketEnd  cCustomAngleBracketContent

    syn match cCustomTemplateFunc "\<\l\w*\s*<\_[^;()]\{-}>(\@="hs=s,he=e-1
                \ contains=cCustomAngleBracketStart
    hi def link cCustomTemplateFunc  cCustomFunc

    syn match    cCustomTemplateClass    "\<\w\+\s*<\_[^;()]\{-}>"
                \ contains=cCustomAngleBracketStart,cCustomTemplateFunc
    hi def link cCustomTemplateClass cCustomClass

    syn match   cCustomTemplate "\<template\>"
    hi def link cCustomTemplate  cppStructure
    syn match   cTemplateDeclare "\<template\_s*<\_[^;()]\{-}>"
                \ contains=cppStructure,cCustomTemplate,cCustomClassKey,cCustomAngleBracketStart

    " Remove 'operator' from cppOperator and use a custom match
    syn clear cppOperator
    syn keyword cppOperator typeid
    syn keyword cppOperator and bitor or xor compl bitand and_eq or_eq xor_eq not not_eq

    syn match   cCustomOperator "\<operator\>"
    hi def link cCustomOperator  cppStructure
    syn match   cTemplateOperatorDeclare "\<operator\_s*<\_[^;()]\{-}>[<>]=\?"
                \ contains=cppOperator,cCustomOperator,cCustomAngleBracketStart
endif

" Alternative syntax that is used in:
"  http://www.vim.org/scripts/script.php?script_id=3064
"syn match cUserFunction "\<\h\w*\>\(\s\|\n\)*("me=e-1 contains=cType,cDelimiter,cDefine
"hi def link cCustomFunc  Function

" Cluster for all the stdlib functions defined below
syn cluster cppSTLgroup     contains=cppSTLfunction,cppSTLfunctional,cppSTLconstant,cppSTLnamespace,cppSTLtype,cppSTLexception,cppSTLiterator,cppSTLiterator_tag,cppSTLenum,cppSTLios,cppSTLcast


" -----------------------------------------------------------------------------
"  Standard library types and functions.
"
" Mainly based on the excellent STL Syntax vim script by
" Mizuchi <ytj000@gmail.com>
"   http://www.vim.org/scripts/script.php?script_id=4293
" which in turn is based on the scripts
"   http://www.vim.org/scripts/script.php?script_id=2224
"   http://www.vim.org/scripts/script.php?script_id=1640
" -----------------------------------------------------------------------------

syntax keyword cppSTLconstant badbit
syntax keyword cppSTLconstant cerr
syntax keyword cppSTLconstant cin
syntax keyword cppSTLconstant clog
syntax keyword cppSTLconstant cout
syntax keyword cppSTLconstant digits
syntax keyword cppSTLconstant digits10
syntax keyword cppSTLconstant eofbit
syntax keyword cppSTLconstant failbit
syntax keyword cppSTLconstant goodbit
syntax keyword cppSTLconstant has_denorm
syntax keyword cppSTLconstant has_denorm_loss
syntax keyword cppSTLconstant has_infinity
syntax keyword cppSTLconstant has_quiet_NaN
syntax keyword cppSTLconstant has_signaling_NaN
syntax keyword cppSTLconstant is_bounded
syntax keyword cppSTLconstant is_exact
syntax keyword cppSTLconstant is_iec559
syntax keyword cppSTLconstant is_integer
syntax keyword cppSTLconstant is_modulo
syntax keyword cppSTLconstant is_signed
syntax keyword cppSTLconstant is_specialized
syntax keyword cppSTLconstant max_digits10
syntax keyword cppSTLconstant max_exponent
syntax keyword cppSTLconstant max_exponent10
syntax keyword cppSTLconstant min_exponent
syntax keyword cppSTLconstant min_exponent10
syntax keyword cppSTLconstant nothrow
syntax keyword cppSTLconstant npos
syntax keyword cppSTLconstant radix
syntax keyword cppSTLconstant round_style
syntax keyword cppSTLconstant tinyness_before
syntax keyword cppSTLconstant traps
syntax keyword cppSTLconstant wcerr
syntax keyword cppSTLconstant wcin
syntax keyword cppSTLconstant wclog
syntax keyword cppSTLconstant wcout
syntax keyword cppSTLexception bad_alloc
syntax keyword cppSTLexception bad_array_new_length
syntax keyword cppSTLexception bad_exception
syntax keyword cppSTLexception bad_typeid bad_cast
syntax keyword cppSTLexception domain_error
syntax keyword cppSTLexception exception
syntax keyword cppSTLexception invalid_argument
syntax keyword cppSTLexception length_error
syntax keyword cppSTLexception logic_error
syntax keyword cppSTLexception out_of_range
syntax keyword cppSTLexception overflow_error
syntax keyword cppSTLexception range_error
syntax keyword cppSTLexception runtime_error
syntax keyword cppSTLexception underflow_error
syntax keyword cppSTLfunction abort
syntax keyword cppSTLfunction abs
syntax keyword cppSTLfunction accumulate
syntax keyword cppSTLfunction acos
syntax keyword cppSTLfunction adjacent_difference
syntax keyword cppSTLfunction adjacent_find
syntax keyword cppSTLfunction adjacent_find_if
syntax keyword cppSTLfunction advance
syntax keyword cppSTLfunctional binary_function
syntax keyword cppSTLfunctional binary_negate
syntax keyword cppSTLfunctional bit_and
syntax keyword cppSTLfunctional bit_not
syntax keyword cppSTLfunctional bit_or
syntax keyword cppSTLfunctional bit_xor
syntax keyword cppSTLfunctional divides
syntax keyword cppSTLfunctional equal_to
syntax keyword cppSTLfunctional greater
syntax keyword cppSTLfunctional greater_equal
syntax keyword cppSTLfunctional less
syntax keyword cppSTLfunctional less_equal
syntax keyword cppSTLfunctional logical_and
syntax keyword cppSTLfunctional logical_not
syntax keyword cppSTLfunctional logical_or
syntax keyword cppSTLfunctional minus
syntax keyword cppSTLfunctional modulus
syntax keyword cppSTLfunctional multiplies
syntax keyword cppSTLfunctional negate
syntax keyword cppSTLfunctional not_equal_to
syntax keyword cppSTLfunctional plus
syntax keyword cppSTLfunctional unary_function
syntax keyword cppSTLfunctional unary_negate
"syntax keyword cppSTLfunction any
syntax keyword cppSTLfunction append
syntax keyword cppSTLfunction arg
syntax keyword cppSTLfunction asctime
syntax keyword cppSTLfunction asin
syntax keyword cppSTLfunction assert
syntax keyword cppSTLfunction assign
syntax keyword cppSTLfunction at
syntax keyword cppSTLfunction atan
syntax keyword cppSTLfunction atan2
syntax keyword cppSTLfunction atexit
syntax keyword cppSTLfunction atof
syntax keyword cppSTLfunction atoi
syntax keyword cppSTLfunction atol
syntax keyword cppSTLfunction atoll
syntax keyword cppSTLfunction back
syntax keyword cppSTLfunction back_inserter
syntax keyword cppSTLfunction bad
syntax keyword cppSTLfunction beg
"syntax keyword cppSTLfunction begin
syntax keyword cppSTLfunction binary_compose
syntax keyword cppSTLfunction binary_negate
syntax keyword cppSTLfunction binary_search
syntax keyword cppSTLfunction bind1st
syntax keyword cppSTLfunction bind2nd
syntax keyword cppSTLfunction binder1st
syntax keyword cppSTLfunction binder2nd
syntax keyword cppSTLfunction bsearch
syntax keyword cppSTLfunction calloc
syntax keyword cppSTLfunction capacity
syntax keyword cppSTLfunction ceil
syntax keyword cppSTLfunction clear
syntax keyword cppSTLfunction clearerr
syntax keyword cppSTLfunction clock
syntax keyword cppSTLfunction close
syntax keyword cppSTLfunction compare
syntax keyword cppSTLfunction conj
syntax keyword cppSTLfunction construct
syntax keyword cppSTLfunction copy
syntax keyword cppSTLfunction copy_backward
syntax keyword cppSTLfunction cos
syntax keyword cppSTLfunction cosh
syntax keyword cppSTLfunction count
syntax keyword cppSTLfunction count_if
syntax keyword cppSTLfunction c_str
syntax keyword cppSTLfunction ctime
"syntax keyword cppSTLfunction data
syntax keyword cppSTLfunction denorm_min
syntax keyword cppSTLfunction destroy
syntax keyword cppSTLfunction difftime
syntax keyword cppSTLfunction distance
syntax keyword cppSTLfunction div
syntax keyword cppSTLfunction empty
"syntax keyword cppSTLfunction end
syntax keyword cppSTLfunction eof
syntax keyword cppSTLfunction epsilon
syntax keyword cppSTLfunction equal
syntax keyword cppSTLfunction equal_range
syntax keyword cppSTLfunction erase
syntax keyword cppSTLfunction exit
syntax keyword cppSTLfunction exp
syntax keyword cppSTLfunction fabs
syntax keyword cppSTLfunction fail
syntax keyword cppSTLfunction failure
syntax keyword cppSTLfunction fclose
syntax keyword cppSTLfunction feof
syntax keyword cppSTLfunction ferror
syntax keyword cppSTLfunction fflush
syntax keyword cppSTLfunction fgetc
syntax keyword cppSTLfunction fgetpos
syntax keyword cppSTLfunction fgets
syntax keyword cppSTLfunction fill
syntax keyword cppSTLfunction fill_n
syntax keyword cppSTLfunction find
syntax keyword cppSTLfunction find_end
syntax keyword cppSTLfunction find_first_not_of
syntax keyword cppSTLfunction find_first_of
syntax keyword cppSTLfunction find_if
syntax keyword cppSTLfunction find_last_not_of
syntax keyword cppSTLfunction find_last_of
syntax keyword cppSTLfunction first
syntax keyword cppSTLfunction flags
syntax keyword cppSTLfunction flip
syntax keyword cppSTLfunction floor
syntax keyword cppSTLfunction flush
syntax keyword cppSTLfunction fmod
syntax keyword cppSTLfunction fopen
syntax keyword cppSTLfunction for_each
syntax keyword cppSTLfunction fprintf
syntax keyword cppSTLfunction fputc
syntax keyword cppSTLfunction fputs
syntax keyword cppSTLfunction fread
syntax keyword cppSTLfunction free
syntax keyword cppSTLfunction freopen
syntax keyword cppSTLfunction frexp
syntax keyword cppSTLfunction front
syntax keyword cppSTLfunction fscanf
syntax keyword cppSTLfunction fseek
syntax keyword cppSTLfunction fsetpos
syntax keyword cppSTLfunction ftell
syntax keyword cppSTLfunction fwide
syntax keyword cppSTLfunction fwprintf
syntax keyword cppSTLfunction fwrite
syntax keyword cppSTLfunction fwscanf
syntax keyword cppSTLfunction gcount
syntax keyword cppSTLfunction generate
syntax keyword cppSTLfunction generate_n
syntax keyword cppSTLfunction get
syntax keyword cppSTLfunction get_allocator
syntax keyword cppSTLfunction getc
syntax keyword cppSTLfunction getchar
syntax keyword cppSTLfunction getenv
syntax keyword cppSTLfunction getline
syntax keyword cppSTLfunction gets
syntax keyword cppSTLfunction get_temporary_buffer
syntax keyword cppSTLfunction gmtime
syntax keyword cppSTLfunction good
syntax keyword cppSTLfunction ignore
syntax keyword cppSTLfunction imag
syntax keyword cppSTLfunction in
syntax keyword cppSTLfunction includes
syntax keyword cppSTLfunction infinity
syntax keyword cppSTLfunction inner_product
syntax keyword cppSTLfunction inplace_merge
syntax keyword cppSTLfunction insert
syntax keyword cppSTLfunction inserter
syntax keyword cppSTLfunction ios
syntax keyword cppSTLfunction ios_base
syntax keyword cppSTLfunction iostate
syntax keyword cppSTLfunction iota
syntax keyword cppSTLfunction isalnum
syntax keyword cppSTLfunction isalpha
syntax keyword cppSTLfunction iscntrl
syntax keyword cppSTLfunction isdigit
syntax keyword cppSTLfunction isgraph
syntax keyword cppSTLfunction is_heap
syntax keyword cppSTLfunction islower
syntax keyword cppSTLfunction is_open
syntax keyword cppSTLfunction isprint
syntax keyword cppSTLfunction ispunct
syntax keyword cppSTLfunction isspace
syntax keyword cppSTLfunction isupper
syntax keyword cppSTLfunction isxdigit
syntax keyword cppSTLfunction iterator_category
syntax keyword cppSTLfunction iter_swap
syntax keyword cppSTLfunction jmp_buf
syntax keyword cppSTLfunction key_comp
syntax keyword cppSTLfunction labs
syntax keyword cppSTLfunction ldexp
syntax keyword cppSTLfunction ldiv
syntax keyword cppSTLfunction length
syntax keyword cppSTLfunction lexicographical_compare
syntax keyword cppSTLfunction lexicographical_compare_3way
syntax keyword cppSTLfunction llabs
syntax keyword cppSTLfunction lldiv
syntax keyword cppSTLfunction localtime
syntax keyword cppSTLfunction log
syntax keyword cppSTLfunction log10
syntax keyword cppSTLfunction longjmp
syntax keyword cppSTLfunction lower_bound
syntax keyword cppSTLfunction make_heap
syntax keyword cppSTLfunction make_pair
syntax keyword cppSTLfunction malloc
syntax keyword cppSTLfunction max
syntax keyword cppSTLfunction max_element
syntax keyword cppSTLfunction max_size
syntax keyword cppSTLfunction memchr
syntax keyword cppSTLfunction memcpy
syntax keyword cppSTLfunction mem_fun
syntax keyword cppSTLfunction mem_fun_ref
syntax keyword cppSTLfunction memmove
syntax keyword cppSTLfunction memset
syntax keyword cppSTLfunction merge
syntax keyword cppSTLfunction min
syntax keyword cppSTLfunction min_element
syntax keyword cppSTLfunction mismatch
syntax keyword cppSTLfunction mktime
syntax keyword cppSTLfunction modf
syntax keyword cppSTLfunction next_permutation
syntax keyword cppSTLfunction none
syntax keyword cppSTLfunction norm
syntax keyword cppSTLfunction not1
syntax keyword cppSTLfunction not2
syntax keyword cppSTLfunction nth_element
syntax keyword cppSTLtype numeric_limits
syntax keyword cppSTLfunction open
syntax keyword cppSTLfunction partial_sort
syntax keyword cppSTLfunction partial_sort_copy
syntax keyword cppSTLfunction partial_sum
syntax keyword cppSTLfunction partition
syntax keyword cppSTLfunction peek
syntax keyword cppSTLfunction perror
syntax keyword cppSTLfunction polar
syntax keyword cppSTLfunction pop
syntax keyword cppSTLfunction pop_back
syntax keyword cppSTLfunction pop_front
syntax keyword cppSTLfunction pop_heap
syntax keyword cppSTLfunction pow
syntax keyword cppSTLfunction power
syntax keyword cppSTLfunction precision
syntax keyword cppSTLfunction prev_permutation
syntax keyword cppSTLfunction printf
syntax keyword cppSTLfunction ptr_fun
syntax keyword cppSTLfunction push
syntax keyword cppSTLfunction push_back
syntax keyword cppSTLfunction push_front
syntax keyword cppSTLfunction push_heap
syntax keyword cppSTLfunction put
syntax keyword cppSTLfunction putback
syntax keyword cppSTLfunction putc
syntax keyword cppSTLfunction putchar
syntax keyword cppSTLfunction puts
syntax keyword cppSTLfunction qsort
syntax keyword cppSTLfunction quiet_NaN
syntax keyword cppSTLfunction raise
syntax keyword cppSTLfunction rand
syntax keyword cppSTLfunction random_sample
syntax keyword cppSTLfunction random_sample_n
syntax keyword cppSTLfunction random_shuffle
syntax keyword cppSTLfunction rbegin
syntax keyword cppSTLfunction rdbuf
syntax keyword cppSTLfunction rdstate
syntax keyword cppSTLfunction read
syntax keyword cppSTLfunction real
syntax keyword cppSTLfunction realloc
syntax keyword cppSTLfunction remove
syntax keyword cppSTLfunction remove_copy
syntax keyword cppSTLfunction remove_copy_if
syntax keyword cppSTLfunction remove_if
syntax keyword cppSTLfunction rename
syntax keyword cppSTLfunction rend
syntax keyword cppSTLfunction replace
syntax keyword cppSTLfunction replace_copy
syntax keyword cppSTLfunction replace_copy_if
syntax keyword cppSTLfunction replace_if
syntax keyword cppSTLfunction reserve
syntax keyword cppSTLfunction reset
syntax keyword cppSTLfunction resize
syntax keyword cppSTLfunction return_temporary_buffer
syntax keyword cppSTLfunction reverse
syntax keyword cppSTLfunction reverse_copy
syntax keyword cppSTLfunction rewind
syntax keyword cppSTLfunction rfind
syntax keyword cppSTLfunction rotate
syntax keyword cppSTLfunction rotate_copy
syntax keyword cppSTLfunction round_error
syntax keyword cppSTLfunction scanf
syntax keyword cppSTLfunction search
syntax keyword cppSTLfunction search_n
syntax keyword cppSTLfunction second
syntax keyword cppSTLfunction seekg
syntax keyword cppSTLfunction seekp
syntax keyword cppSTLfunction setbuf
syntax keyword cppSTLfunction set_difference
syntax keyword cppSTLfunction setf
syntax keyword cppSTLfunction set_intersection
syntax keyword cppSTLfunction setjmp
syntax keyword cppSTLfunction setlocale
syntax keyword cppSTLfunction set_new_handler
syntax keyword cppSTLfunction set_symmetric_difference
syntax keyword cppSTLfunction set_union
syntax keyword cppSTLfunction setvbuf
syntax keyword cppSTLfunction signal
syntax keyword cppSTLfunction signaling_NaN
syntax keyword cppSTLfunction sin
syntax keyword cppSTLfunction sinh
"syntax keyword cppSTLfunction size
syntax keyword cppSTLfunction sort
syntax keyword cppSTLfunction sort_heap
syntax keyword cppSTLfunction splice
syntax keyword cppSTLfunction sprintf
syntax keyword cppSTLfunction sqrt
syntax keyword cppSTLfunction srand
syntax keyword cppSTLfunction sscanf
syntax keyword cppSTLfunction stable_partition
syntax keyword cppSTLfunction stable_sort
syntax keyword cppSTLfunction str
syntax keyword cppSTLfunction strcat
syntax keyword cppSTLfunction strchr
syntax keyword cppSTLfunction strcmp
syntax keyword cppSTLfunction strcoll
syntax keyword cppSTLfunction strcpy
syntax keyword cppSTLfunction strcspn
syntax keyword cppSTLfunction strerror
syntax keyword cppSTLfunction strftime
syntax keyword cppSTLfunction string
syntax keyword cppSTLfunction strlen
syntax keyword cppSTLfunction strncat
syntax keyword cppSTLfunction strncmp
syntax keyword cppSTLfunction strncpy
syntax keyword cppSTLfunction strpbrk
syntax keyword cppSTLfunction strrchr
syntax keyword cppSTLfunction strspn
syntax keyword cppSTLfunction strstr
syntax keyword cppSTLfunction strtod
syntax keyword cppSTLfunction strtof
syntax keyword cppSTLfunction strtok
syntax keyword cppSTLfunction strtol
syntax keyword cppSTLfunction strtold
syntax keyword cppSTLfunction strtoll
syntax keyword cppSTLfunction strtoul
syntax keyword cppSTLfunction strxfrm
syntax keyword cppSTLfunction substr
syntax keyword cppSTLfunction swap
syntax keyword cppSTLfunction swap_ranges
syntax keyword cppSTLfunction swprintf
syntax keyword cppSTLfunction swscanf
syntax keyword cppSTLfunction sync_with_stdio
"syntax keyword cppSTLfunction system
syntax keyword cppSTLfunction tan
syntax keyword cppSTLfunction tanh
syntax keyword cppSTLfunction tellg
syntax keyword cppSTLfunction tellp
"syntax keyword cppSTLfunction test
"syntax keyword cppSTLfunction time
syntax keyword cppSTLfunction tmpfile
syntax keyword cppSTLfunction tmpnam
syntax keyword cppSTLfunction tolower
syntax keyword cppSTLfunction top
syntax keyword cppSTLfunction to_string
syntax keyword cppSTLfunction to_ulong
syntax keyword cppSTLfunction toupper
syntax keyword cppSTLfunction to_wstring
syntax keyword cppSTLfunction transform
syntax keyword cppSTLfunction unary_compose
syntax keyword cppSTLfunction unget
syntax keyword cppSTLfunction ungetc
syntax keyword cppSTLfunction uninitialized_copy
syntax keyword cppSTLfunction uninitialized_copy_n
syntax keyword cppSTLfunction uninitialized_fill
syntax keyword cppSTLfunction uninitialized_fill_n
syntax keyword cppSTLfunction unique
syntax keyword cppSTLfunction unique_copy
syntax keyword cppSTLfunction unsetf
syntax keyword cppSTLfunction upper_bound
syntax keyword cppSTLfunction va_arg
syntax keyword cppSTLfunction va_copy
syntax keyword cppSTLfunction va_end
syntax keyword cppSTLfunction value_comp
syntax keyword cppSTLfunction va_start
syntax keyword cppSTLfunction vfprintf
syntax keyword cppSTLfunction vfwprintf
syntax keyword cppSTLfunction vprintf
syntax keyword cppSTLfunction vsprintf
syntax keyword cppSTLfunction vswprintf
syntax keyword cppSTLfunction vwprintf
syntax keyword cppSTLfunction width
syntax keyword cppSTLfunction wprintf
syntax keyword cppSTLfunction write
syntax keyword cppSTLfunction wscanf
syntax keyword cppSTLios boolalpha
syntax keyword cppSTLios dec
syntax keyword cppSTLios defaultfloat
syntax keyword cppSTLios endl
syntax keyword cppSTLios ends
syntax keyword cppSTLios fixed
syntax keyword cppSTLios floatfield
syntax keyword cppSTLios flush
syntax keyword cppSTLios get_money
syntax keyword cppSTLios get_time
syntax keyword cppSTLios hex
syntax keyword cppSTLios hexfloat
syntax keyword cppSTLios internal
syntax keyword cppSTLios noboolalpha
syntax keyword cppSTLios noshowbase
syntax keyword cppSTLios noshowpoint
syntax keyword cppSTLios noshowpos
syntax keyword cppSTLios noskipws
syntax keyword cppSTLios nounitbuf
syntax keyword cppSTLios nouppercase
syntax keyword cppSTLios oct
syntax keyword cppSTLios put_money
syntax keyword cppSTLios put_time
syntax keyword cppSTLios resetiosflags
syntax keyword cppSTLios scientific
syntax keyword cppSTLios setbase
syntax keyword cppSTLios setfill
syntax keyword cppSTLios setiosflags
syntax keyword cppSTLios setprecision
syntax keyword cppSTLios setw
syntax keyword cppSTLios showbase
syntax keyword cppSTLios showpoint
syntax keyword cppSTLios showpos
syntax keyword cppSTLios skipws
syntax keyword cppSTLios unitbuf
syntax keyword cppSTLios uppercase
"syntax keyword cppSTLios ws
syntax keyword cppSTLiterator back_insert_iterator
syntax keyword cppSTLiterator bidirectional_iterator
syntax keyword cppSTLiterator const_iterator
syntax keyword cppSTLiterator const_reverse_iterator
syntax keyword cppSTLiterator forward_iterator
syntax keyword cppSTLiterator front_insert_iterator
syntax keyword cppSTLiterator input_iterator
syntax keyword cppSTLiterator insert_iterator
syntax keyword cppSTLiterator istreambuf_iterator
syntax keyword cppSTLiterator istream_iterator
syntax keyword cppSTLiterator iterator
syntax keyword cppSTLiterator ostream_iterator
syntax keyword cppSTLiterator output_iterator
syntax keyword cppSTLiterator random_access_iterator
syntax keyword cppSTLiterator raw_storage_iterator
syntax keyword cppSTLiterator reverse_bidirectional_iterator
syntax keyword cppSTLiterator reverse_iterator
syntax keyword cppSTLiterator_tag bidirectional_iterator_tag
syntax keyword cppSTLiterator_tag forward_iterator_tag
syntax keyword cppSTLiterator_tag input_iterator_tag
syntax keyword cppSTLiterator_tag output_iterator_tag
syntax keyword cppSTLiterator_tag random_access_iterator_tag
syntax keyword cppSTLnamespace rel_ops
syntax keyword cppSTLnamespace std
syntax keyword cppSTLnamespace experimental
syntax keyword cppSTLtype allocator
syntax keyword cppSTLtype auto_ptr
syntax keyword cppSTLtype basic_filebuf
syntax keyword cppSTLtype basic_fstream
syntax keyword cppSTLtype basic_ifstream
syntax keyword cppSTLtype basic_iostream
syntax keyword cppSTLtype basic_istream
syntax keyword cppSTLtype basic_istringstream
syntax keyword cppSTLtype basic_ofstream
syntax keyword cppSTLtype basic_ostream
syntax keyword cppSTLtype basic_ostringstream
syntax keyword cppSTLtype basic_streambuf
syntax keyword cppSTLtype basic_string
syntax keyword cppSTLtype basic_stringbuf
syntax keyword cppSTLtype basic_stringstream
syntax keyword cppSTLtype binary_compose
syntax keyword cppSTLtype binder1st
syntax keyword cppSTLtype binder2nd
syntax keyword cppSTLtype bitset
syntax keyword cppSTLtype char_traits
syntax keyword cppSTLtype char_type
syntax keyword cppSTLtype const_mem_fun1_t
syntax keyword cppSTLtype const_mem_fun_ref1_t
syntax keyword cppSTLtype const_mem_fun_ref_t
syntax keyword cppSTLtype const_mem_fun_t
syntax keyword cppSTLtype const_pointer
syntax keyword cppSTLtype const_reference
syntax keyword cppSTLtype container_type
syntax keyword cppSTLtype deque
syntax keyword cppSTLtype difference_type
syntax keyword cppSTLtype div_t
syntax keyword cppSTLtype double_t
syntax keyword cppSTLtype filebuf
syntax keyword cppSTLtype first_type
syntax keyword cppSTLtype float_denorm_style
syntax keyword cppSTLtype float_round_style
syntax keyword cppSTLtype float_t
syntax keyword cppSTLtype fstream
syntax keyword cppSTLtype gslice_array
syntax keyword cppSTLtype ifstream
syntax keyword cppSTLtype imaxdiv_t
syntax keyword cppSTLtype indirect_array
syntax keyword cppSTLtype int_type
syntax keyword cppSTLtype ios_base
syntax keyword cppSTLtype iostream
syntax keyword cppSTLtype istream
syntax keyword cppSTLtype istringstream
syntax keyword cppSTLtype istrstream
syntax keyword cppSTLtype iterator_traits
syntax keyword cppSTLtype key_compare
syntax keyword cppSTLtype key_type
syntax keyword cppSTLtype ldiv_t
syntax keyword cppSTLtype list
syntax keyword cppSTLtype lldiv_t
syntax keyword cppSTLtype map
syntax keyword cppSTLtype mapped_type
syntax keyword cppSTLtype mask_array
syntax keyword cppSTLtype mem_fun1_t
syntax keyword cppSTLtype mem_fun_ref1_t
syntax keyword cppSTLtype mem_fun_ref_t
syntax keyword cppSTLtype mem_fun_t
syntax keyword cppSTLtype multimap
syntax keyword cppSTLtype multiset
syntax keyword cppSTLtype nothrow_t
syntax keyword cppSTLtype off_type
syntax keyword cppSTLtype ofstream
syntax keyword cppSTLtype ostream
syntax keyword cppSTLtype ostringstream
syntax keyword cppSTLtype ostrstream
syntax keyword cppSTLtype pair
syntax keyword cppSTLtype pointer
syntax keyword cppSTLtype pointer_to_binary_function
syntax keyword cppSTLtype pointer_to_unary_function
syntax keyword cppSTLtype pos_type
syntax keyword cppSTLtype priority_queue
syntax keyword cppSTLtype queue
syntax keyword cppSTLtype reference
syntax keyword cppSTLtype second_type
syntax keyword cppSTLtype sequence_buffer
syntax keyword cppSTLtype set
syntax keyword cppSTLtype sig_atomic_t
syntax keyword cppSTLtype size_type
syntax keyword cppSTLtype slice_array
syntax keyword cppSTLtype stack
syntax keyword cppSTLtype stream
syntax keyword cppSTLtype streambuf
syntax keyword cppSTLtype streamsize
syntax keyword cppSTLtype string
syntax keyword cppSTLtype stringbuf
syntax keyword cppSTLtype stringstream
syntax keyword cppSTLtype strstream
syntax keyword cppSTLtype strstreambuf
syntax keyword cppSTLtype temporary_buffer
syntax keyword cppSTLtype test_type
syntax keyword cppSTLtype time_t
syntax keyword cppSTLtype tm
syntax keyword cppSTLtype traits_type
syntax keyword cppSTLtype type_info
syntax keyword cppSTLtype u16string
syntax keyword cppSTLtype u32string
syntax keyword cppSTLtype unary_compose
syntax keyword cppSTLtype unary_negate
syntax keyword cppSTLtype valarray
syntax keyword cppSTLtype value_compare
syntax keyword cppSTLtype value_type
syntax keyword cppSTLtype vector
syntax keyword cppSTLtype wfilebuf
syntax keyword cppSTLtype wfstream
syntax keyword cppSTLtype wifstream
syntax keyword cppSTLtype wiostream
syntax keyword cppSTLtype wistream
syntax keyword cppSTLtype wistringstream
syntax keyword cppSTLtype wofstream
syntax keyword cppSTLtype wostream
syntax keyword cppSTLtype wostringstream
syntax keyword cppSTLtype wstreambuf
syntax keyword cppSTLtype wstring
syntax keyword cppSTLtype wstringbuf
syntax keyword cppSTLtype wstringstream

syntax keyword cppSTLfunction mblen
syntax keyword cppSTLfunction mbtowc
syntax keyword cppSTLfunction wctomb
syntax keyword cppSTLfunction mbstowcs
syntax keyword cppSTLfunction wcstombs
syntax keyword cppSTLfunction mbsinit
syntax keyword cppSTLfunction btowc
syntax keyword cppSTLfunction wctob
syntax keyword cppSTLfunction mbrlen
syntax keyword cppSTLfunction mbrtowc
syntax keyword cppSTLfunction wcrtomb
syntax keyword cppSTLfunction mbsrtowcs
syntax keyword cppSTLfunction wcsrtombs

syntax keyword cppSTLtype mbstate_t

syntax keyword cppSTLconstant MB_LEN_MAX
syntax keyword cppSTLconstant MB_CUR_MAX
syntax keyword cppSTLconstant __STDC_UTF_16__
syntax keyword cppSTLconstant __STDC_UTF_32__

syntax keyword cppSTLfunction iswalnum
syntax keyword cppSTLfunction iswalpha
syntax keyword cppSTLfunction iswlower
syntax keyword cppSTLfunction iswupper
syntax keyword cppSTLfunction iswdigit
syntax keyword cppSTLfunction iswxdigit
syntax keyword cppSTLfunction iswcntrl
syntax keyword cppSTLfunction iswgraph
syntax keyword cppSTLfunction iswspace
syntax keyword cppSTLfunction iswprint
syntax keyword cppSTLfunction iswpunct
syntax keyword cppSTLfunction iswctype
syntax keyword cppSTLfunction wctype

syntax keyword cppSTLfunction towlower
syntax keyword cppSTLfunction towupper
syntax keyword cppSTLfunction towctrans
syntax keyword cppSTLfunction wctrans

syntax keyword cppSTLfunction wcstol
syntax keyword cppSTLfunction wcstoll
syntax keyword cppSTLfunction wcstoul
syntax keyword cppSTLfunction wcstoull
syntax keyword cppSTLfunction wcstof
syntax keyword cppSTLfunction wcstod
syntax keyword cppSTLfunction wcstold

syntax keyword cppSTLfunction wcscpy
syntax keyword cppSTLfunction wcsncpy
syntax keyword cppSTLfunction wcscat
syntax keyword cppSTLfunction wcsncat
syntax keyword cppSTLfunction wcsxfrm
syntax keyword cppSTLfunction wcslen
syntax keyword cppSTLfunction wcscmp
syntax keyword cppSTLfunction wcsncmp
syntax keyword cppSTLfunction wcscoll
syntax keyword cppSTLfunction wcschr
syntax keyword cppSTLfunction wcsrchr
syntax keyword cppSTLfunction wcsspn
syntax keyword cppSTLfunction wcscspn
syntax keyword cppSTLfunction wcspbrk
syntax keyword cppSTLfunction wcsstr
syntax keyword cppSTLfunction wcstok
syntax keyword cppSTLfunction wmemcpy
syntax keyword cppSTLfunction wmemmove
syntax keyword cppSTLfunction wmemcmp
syntax keyword cppSTLfunction wmemchr
syntax keyword cppSTLfunction wmemset

syntax keyword cppSTLtype wctrans_t
syntax keyword cppSTLtype wctype_t
syntax keyword cppSTLtype wint_t

syntax keyword cppSTLconstant WEOF
syntax keyword cppSTLconstant WCHAR_MIN
syntax keyword cppSTLconstant WCHAR_MAX

" locale
syntax keyword cppSTLtype locale
syntax keyword cppSTLtype ctype_base
syntax keyword cppSTLtype codecvt_base
syntax keyword cppSTLtype messages_base
syntax keyword cppSTLtype time_base
syntax keyword cppSTLtype money_base
syntax keyword cppSTLtype ctype
syntax keyword cppSTLtype codecvt
syntax keyword cppSTLtype collate
syntax keyword cppSTLtype messages
syntax keyword cppSTLtype time_get
syntax keyword cppSTLtype time_put
syntax keyword cppSTLtype num_get
syntax keyword cppSTLtype num_put
syntax keyword cppSTLtype numpunct
syntax keyword cppSTLtype money_get
syntax keyword cppSTLtype money_put
syntax keyword cppSTLtype moneypunct
syntax keyword cppSTLtype ctype_byname
syntax keyword cppSTLtype codecvt_byname
syntax keyword cppSTLtype messages_byname
syntax keyword cppSTLtype collate_byname
syntax keyword cppSTLtype time_get_byname
syntax keyword cppSTLtype time_put_byname
syntax keyword cppSTLtype numpunct_byname
syntax keyword cppSTLtype moneypunct_byname
syntax keyword cppSTLfunction use_facet
syntax keyword cppSTLfunction has_facet
syntax keyword cppSTLfunction isspace isblank iscntrl isupper islower isalpha
syntax keyword cppSTLfunction isdigit ispunct isxdigit isalnum isprint isgraph

if !exists("cpp_no_cpp11")
    syntax keyword cppSTLconstant nullptr

    " containers (array, vector, list, *map, *set, ...)
    syntax keyword cppSTLtype array
    syntax keyword cppSTLfunction cbegin cend
    syntax keyword cppSTLfunction crbegin crend
    syntax keyword cppSTLfunction shrink_to_fit
    syntax keyword cppSTLfunction emplace
    syntax keyword cppSTLfunction emplace_back
    syntax keyword cppSTLfunction emplace_front
    syntax keyword cppSTLfunction emplace_hint

    " algorithm
    syntax keyword cppSTLfunction all_of any_of none_of
    syntax keyword cppSTLfunction find_if_not
    syntax keyword cppSTLfunction copy_if
    syntax keyword cppSTLfunction copy_n
    syntax keyword cppSTLfunction move
    syntax keyword cppSTLfunction move_backward
    syntax keyword cppSTLfunction shuffle
    syntax keyword cppSTLfunction is_partitioned
    syntax keyword cppSTLfunction partition_copy
    syntax keyword cppSTLfunction partition_point
    syntax keyword cppSTLfunction is_sorted
    syntax keyword cppSTLfunction is_sorted_until
    syntax keyword cppSTLfunction is_heap
    syntax keyword cppSTLfunction is_heap_until
    syntax keyword cppSTLfunction minmax
    syntax keyword cppSTLfunction minmax_element
    syntax keyword cppSTLfunction is_permutation
    syntax keyword cppSTLfunction itoa

    " atomic
    syntax keyword cppSTLtype atomic
    syntax keyword cppSTLtype atomic_flag
    syntax keyword cppSTLtype atomic_bool
    syntax keyword cppSTLtype atomic_char
    syntax keyword cppSTLtype atomic_schar
    syntax keyword cppSTLtype atomic_uchar
    syntax keyword cppSTLtype atomic_short
    syntax keyword cppSTLtype atomic_ushort
    syntax keyword cppSTLtype atomic_int
    syntax keyword cppSTLtype atomic_uint
    syntax keyword cppSTLtype atomic_long
    syntax keyword cppSTLtype atomic_ulong
    syntax keyword cppSTLtype atomic_llong
    syntax keyword cppSTLtype atomic_ullong
    syntax keyword cppSTLtype atomic_char16_t
    syntax keyword cppSTLtype atomic_char32_t
    syntax keyword cppSTLtype atomic_wchar_t
    syntax keyword cppSTLtype atomic_int_least8_t
    syntax keyword cppSTLtype atomic_uint_least8_t
    syntax keyword cppSTLtype atomic_int_least16_t
    syntax keyword cppSTLtype atomic_uint_least16_t
    syntax keyword cppSTLtype atomic_int_least32_t
    syntax keyword cppSTLtype atomic_uint_least32_t
    syntax keyword cppSTLtype atomic_int_least64_t
    syntax keyword cppSTLtype atomic_uint_least64_t
    syntax keyword cppSTLtype atomic_int_fast8_t
    syntax keyword cppSTLtype atomic_uint_fast8_t
    syntax keyword cppSTLtype atomic_int_fast16_t
    syntax keyword cppSTLtype atomic_uint_fast16_t
    syntax keyword cppSTLtype atomic_int_fast32_t
    syntax keyword cppSTLtype atomic_uint_fast32_t
    syntax keyword cppSTLtype atomic_int_fast64_t
    syntax keyword cppSTLtype atomic_uint_fast64_t
    syntax keyword cppSTLtype atomic_intptr_t
    syntax keyword cppSTLtype atomic_uintptr_t
    syntax keyword cppSTLtype atomic_size_t
    syntax keyword cppSTLtype atomic_ptrdiff_t
    syntax keyword cppSTLtype atomic_intmax_t
    syntax keyword cppSTLtype atomic_uintmax_t
    syntax keyword cppSTLconstant ATOMIC_FLAG_INIT
    syntax keyword cppSTLenum memory_order
    syntax keyword cppSTLtype memory_order_relaxed
    syntax keyword cppSTLtype memory_order_consume
    syntax keyword cppSTLtype memory_order_acquire
    syntax keyword cppSTLtype memory_order_release
    syntax keyword cppSTLtype memory_order_acq_rel
    syntax keyword cppSTLtype memory_order_seq_cst
    syntax keyword cppSTLfunction is_lock_free
    syntax keyword cppSTLfunction compare_exchange_weak
    syntax keyword cppSTLfunction compare_exchange_strong
    syntax keyword cppSTLfunction fetch_add
    syntax keyword cppSTLfunction fetch_sub
    syntax keyword cppSTLfunction fetch_and
    syntax keyword cppSTLfunction fetch_or
    syntax keyword cppSTLfunction fetch_xor
    syntax keyword cppSTLfunction atomic_is_lock_free
    syntax keyword cppSTLfunction atomic_store
    syntax keyword cppSTLfunction atomic_store_explicit
    syntax keyword cppSTLfunction atomic_load
    syntax keyword cppSTLfunction atomic_load_explicit
    syntax keyword cppSTLfunction atomic_exchange
    syntax keyword cppSTLfunction atomic_exchange_explicit
    syntax keyword cppSTLfunction atomic_compare_exchange_weak
    syntax keyword cppSTLfunction atomic_compare_exchange_weak_explicit
    syntax keyword cppSTLfunction atomic_compare_exchange_strong
    syntax keyword cppSTLfunction atomic_compare_exchange_strong_explicit
    syntax keyword cppSTLfunction atomic_fetch_add
    syntax keyword cppSTLfunction atomic_fetch_add_explicit
    syntax keyword cppSTLfunction atomic_fetch_sub
    syntax keyword cppSTLfunction atomic_fetch_sub_explicit
    syntax keyword cppSTLfunction atomic_fetch_and
    syntax keyword cppSTLfunction atomic_fetch_and_explicit
    syntax keyword cppSTLfunction atomic_fetch_or
    syntax keyword cppSTLfunction atomic_fetch_or_explicit
    syntax keyword cppSTLfunction atomic_fetch_xor
    syntax keyword cppSTLfunction atomic_fetch_xor_explicit
    syntax keyword cppSTLfunction atomic_flag_test_and_set
    syntax keyword cppSTLfunction atomic_flag_test_and_set_explicit
    syntax keyword cppSTLfunction atomic_flag_clear
    syntax keyword cppSTLfunction atomic_flag_clear_explicit
    syntax keyword cppSTLfunction atomic_init
    syntax keyword cppSTLfunction ATOMIC_VAR_INIT
    syntax keyword cppSTLfunction kill_dependency
    syntax keyword cppSTLfunction atomic_thread_fence
    syntax keyword cppSTLfunction atomic_signal_fence
    syntax keyword cppSTLfunction exchange
    " syntax keyword cppSTLfunction store
    " syntax keyword cppSTLfunction load

    " bitset
    syntax keyword cppSTLfunction to_ullong
    " syntax keyword cppSTLfunction all

    " cinttypes
    syntax keyword cppSTLfunction strtoimax
    syntax keyword cppSTLfunction strtoumax
    syntax keyword cppSTLfunction wcstoimax
    syntax keyword cppSTLfunction wcstoumax

    " chrono
    syntax keyword cppSTLnamespace chrono
    syntax keyword cppSTLcast duration_cast
    syntax keyword cppSTLcast time_point_cast
    syntax keyword cppSTLtype duration
    syntax keyword cppSTLtype system_clock
    syntax keyword cppSTLtype steady_clock
    syntax keyword cppSTLtype high_resolution_clock
    syntax keyword cppSTLtype time_point
    syntax keyword cppSTLtype nanoseconds
    syntax keyword cppSTLtype microseconds
    syntax keyword cppSTLtype milliseconds
    syntax keyword cppSTLtype seconds
    syntax keyword cppSTLtype minutes
    syntax keyword cppSTLtype hours
    syntax keyword cppSTLtype treat_as_floating_point
    syntax keyword cppSTLtype duration_values
    " syntax keyword cppSTLtype rep period
    syntax keyword cppSTLfunction time_since_epoch
    syntax keyword cppSTLfunction to_time_t
    syntax keyword cppSTLfunction from_time_t
    " syntax keyword cppSTLfunction zero
    " syntax keyword cppSTLfunction now

    " complex
    " syntax keyword cppSTLfunction proj

    " condition_variable
    syntax keyword cppSTLtype condition_variable
    syntax keyword cppSTLfunction notify_all
    syntax keyword cppSTLfunction notify_one

    " cstddef
    syntax keyword cppSTLtype nullptr_t max_align_t

    " cstdlib
    syntax keyword cppSTLfunction quick_exit
    syntax keyword cppSTLfunction _Exit
    syntax keyword cppSTLfunction at_quick_exit

    " cuchar
    syntax keyword cppSTLfunction mbrtoc16
    syntax keyword cppSTLfunction c16rtomb
    syntax keyword cppSTLfunction mbrtoc32
    syntax keyword cppSTLfunction c32rtomb

    " exception
    syntax keyword cppSTLtype exception_ptr
    syntax keyword cppSTLtype nested_exception
    syntax keyword cppSTLfunction get_terminate
    syntax keyword cppSTLfunction make_exception_ptr
    syntax keyword cppSTLfunction current_exception
    syntax keyword cppSTLfunction rethrow_exception
    syntax keyword cppSTLfunction throw_with_nested
    syntax keyword cppSTLfunction rethrow_if_nested
    syntax keyword cppSTLfunction rethrow_nested

    " forward_list
    syntax keyword cppSTLtype forward_list
    syntax keyword cppSTLfunction before_begin
    syntax keyword cppSTLfunction cbefore_begin
    syntax keyword cppSTLfunction insert_after
    syntax keyword cppSTLfunction emplace_after
    syntax keyword cppSTLfunction erase_after
    syntax keyword cppSTLfunction splice_after

    " functional
    syntax keyword cppSTLexception bad_function_call
    syntax keyword cppSTLfunctional function
    syntax keyword cppSTLconstant _1 _2 _3 _4 _5 _6 _7 _8 _9
    syntax keyword cppSTLtype hash
    syntax keyword cppSTLtype is_bind_expression
    syntax keyword cppSTLtype is_placeholder
    syntax keyword cppSTLtype reference_wrapper
    syntax keyword cppSTLfunction bind
    syntax keyword cppSTLfunction mem_fn
    syntax keyword cppSTLfunction ref cref

    " future
    syntax keyword cppSTLtype future
    syntax keyword cppSTLtype packaged_task
    syntax keyword cppSTLtype promise
    syntax keyword cppSTLtype shared_future
    syntax keyword cppSTLenum future_status
    syntax keyword cppSTLenum future_errc
    syntax keyword cppSTLenum launch
    syntax keyword cppSTLexception future_error
    syntax keyword cppSTLfunction get_future
    syntax keyword cppSTLfunction set_value
    syntax keyword cppSTLfunction set_value_at_thread_exit
    syntax keyword cppSTLfunction set_exception
    syntax keyword cppSTLfunction set_exception_at_thread_exit
    syntax keyword cppSTLfunction wait_for
    syntax keyword cppSTLfunction wait_until
    syntax keyword cppSTLfunction future_category
    syntax keyword cppSTLfunction make_error_code
    syntax keyword cppSTLfunction make_error_condition
    syntax keyword cppSTLfunction make_ready_at_thread_exit
    " syntax keyword cppSTLfunction async
    " syntax keyword cppSTLfunction share
    " syntax keyword cppSTLfunction valid
    " syntax keyword cppSTLfunction wait

    " initializer_list
    syntax keyword cppSTLtype initializer_list

    " io
    syntax keyword cppSTLenum io_errc
    syntax keyword cppSTLfunction iostream_category
    syntax keyword cppSTLfunction vscanf vfscanf vsscanf
    syntax keyword cppSTLfunction snprintf vsnprintf
    syntax keyword cppSTLfunction vwscanf vfwscanf vswscanf

    " iterator
    syntax keyword cppSTLiterator move_iterator
    syntax keyword cppSTLfunction make_move_iterator
    syntax keyword cppSTLfunction next prev

    " limits
    syntax keyword cppSTLconstant max_digits10
    syntax keyword cppSTLfunction lowest

    " locale
    syntax keyword cppSTLtype wstring_convert
    syntax keyword cppSTLtype wbuffer_convert
    syntax keyword cppSTLtype codecvt_utf8
    syntax keyword cppSTLtype codecvt_utf16
    syntax keyword cppSTLtype codecvt_utf8_utf16
    syntax keyword cppSTLtype codecvt_mode
    syntax keyword cppSTLfunction isblank
    syntax keyword cppSTLfunction iswblank

    " memory
    syntax keyword cppSTLtype unique_ptr
    syntax keyword cppSTLtype shared_ptr
    syntax keyword cppSTLtype weak_ptr
    syntax keyword cppSTLtype owner_less
    syntax keyword cppSTLtype enable_shared_from_this
    syntax keyword cppSTLtype default_delete
    syntax keyword cppSTLtype allocator_traits
    syntax keyword cppSTLtype allocator_type
    syntax keyword cppSTLtype allocator_arg_t
    syntax keyword cppSTLtype uses_allocator
    syntax keyword cppSTLtype scoped_allocator_adaptor
    syntax keyword cppSTLtype pointer_safety
    syntax keyword cppSTLtype pointer_traits
    syntax keyword cppSTLconstant allocator_arg
    syntax keyword cppSTLexception bad_weak_ptr
    syntax keyword cppSTLcast static_pointer_cast
    syntax keyword cppSTLcast dynamic_pointer_cast
    syntax keyword cppSTLcast const_pointer_cast
    syntax keyword cppSTLfunction make_shared
    syntax keyword cppSTLfunction declare_reachable
    syntax keyword cppSTLfunction undeclare_reachable
    syntax keyword cppSTLfunction declare_no_pointers
    syntax keyword cppSTLfunction undeclare_no_pointers
    syntax keyword cppSTLfunction get_pointer_safety
    syntax keyword cppSTLfunction addressof
    syntax keyword cppSTLfunction allocate_shared
    syntax keyword cppSTLfunction get_deleter
    " syntax keyword cppSTLfunction align

    " mutex
    syntax keyword cppSTLtype mutex
    syntax keyword cppSTLtype timed_mutex
    syntax keyword cppSTLtype recursive_mutex
    syntax keyword cppSTLtype recursive_timed_mutex
    syntax keyword cppSTLtype lock_guard
    syntax keyword cppSTLtype unique_lock
    syntax keyword cppSTLtype defer_lock_t
    syntax keyword cppSTLtype try_to_lock_t
    syntax keyword cppSTLtype adopt_lock_t
    syntax keyword cppSTLtype once_flag
    syntax keyword cppSTLtype condition_variable_any
    syntax keyword cppSTLenum cv_status
    syntax keyword cppSTLconstant defer_lock try_to_lock adopt_lock
    syntax keyword cppSTLfunction try_lock lock unlock try_lock_for try_lock_until
    syntax keyword cppSTLfunction call_once
    syntax keyword cppSTLfunction owns_lock
    syntax keyword cppSTLfunction notify_all_at_thread_exit
    syntax keyword cppSTLfunction release
    " Note: unique_lock has method 'mutex()', but already set as cppSTLtype
    " syntax keyword cppSTLfunction mutex

    " new
    syntax keyword cppSTLexception bad_array_new_length
    syntax keyword cppSTLfunction get_new_handler

    " numerics, cmath
    syntax keyword cppSTLconstant HUGE_VALF
    syntax keyword cppSTLconstant HUGE_VALL
    syntax keyword cppSTLconstant INFINITY
    syntax keyword cppSTLconstant NAN
    syntax keyword cppSTLconstant math_errhandling
    syntax keyword cppSTLconstant MATH_ERRNO
    syntax keyword cppSTLconstant MATH_ERREXCEPT
    syntax keyword cppSTLconstant FP_NORMAL
    syntax keyword cppSTLconstant FP_SUBNORMAL
    syntax keyword cppSTLconstant FP_ZERO
    syntax keyword cppSTLconstant FP_INFINITY
    syntax keyword cppSTLconstant FP_NAN
    syntax keyword cppSTLconstant FLT_EVAL_METHOD
    syntax keyword cppSTLfunction imaxabs
    syntax keyword cppSTLfunction imaxdiv
    syntax keyword cppSTLfunction remainder
    syntax keyword cppSTLfunction remquo
    syntax keyword cppSTLfunction fma
    syntax keyword cppSTLfunction fmax
    syntax keyword cppSTLfunction fmin
    syntax keyword cppSTLfunction fdim
    syntax keyword cppSTLfunction nan
    syntax keyword cppSTLfunction nanf
    syntax keyword cppSTLfunction nanl
    syntax keyword cppSTLfunction exp2
    syntax keyword cppSTLfunction expm1
    syntax keyword cppSTLfunction log1p
    syntax keyword cppSTLfunction log2
    syntax keyword cppSTLfunction cbrt
    syntax keyword cppSTLfunction hypot
    syntax keyword cppSTLfunction asinh
    syntax keyword cppSTLfunction acosh
    syntax keyword cppSTLfunction atanh
    syntax keyword cppSTLfunction erf
    syntax keyword cppSTLfunction erfc
    syntax keyword cppSTLfunction lgamma
    syntax keyword cppSTLfunction tgamma
    syntax keyword cppSTLfunction trunc
    syntax keyword cppSTLfunction round
    syntax keyword cppSTLfunction lround
    syntax keyword cppSTLfunction llround
    syntax keyword cppSTLfunction nearbyint
    syntax keyword cppSTLfunction rint
    syntax keyword cppSTLfunction lrint
    syntax keyword cppSTLfunction llrint
    syntax keyword cppSTLfunction scalbn
    syntax keyword cppSTLfunction scalbln
    syntax keyword cppSTLfunction ilogb
    syntax keyword cppSTLfunction logb
    syntax keyword cppSTLfunction nextafter
    syntax keyword cppSTLfunction nexttoward
    syntax keyword cppSTLfunction copysign
    syntax keyword cppSTLfunction fpclassify
    syntax keyword cppSTLfunction isfinite
    syntax keyword cppSTLfunction isinf
    syntax keyword cppSTLfunction isnan
    syntax keyword cppSTLfunction isnormal
    syntax keyword cppSTLfunction signbit

    " random
    syntax keyword cppSTLtype linear_congruential_engine
    syntax keyword cppSTLtype mersenne_twister_engine
    syntax keyword cppSTLtype subtract_with_carry_engine
    syntax keyword cppSTLtype discard_block_engine
    syntax keyword cppSTLtype independent_bits_engine
    syntax keyword cppSTLtype shuffle_order_engine
    syntax keyword cppSTLtype random_device
    syntax keyword cppSTLtype default_random_engine
    syntax keyword cppSTLtype minstd_rand0
    syntax keyword cppSTLtype minstd_rand
    syntax keyword cppSTLtype mt19937
    syntax keyword cppSTLtype mt19937_64
    syntax keyword cppSTLtype ranlux24_base
    syntax keyword cppSTLtype ranlux48_base
    syntax keyword cppSTLtype ranlux24
    syntax keyword cppSTLtype ranlux48
    syntax keyword cppSTLtype knuth_b
    syntax keyword cppSTLtype uniform_int_distribution
    syntax keyword cppSTLtype uniform_real_distribution
    syntax keyword cppSTLtype bernoulli_distribution
    syntax keyword cppSTLtype binomial_distribution
    syntax keyword cppSTLtype negative_binomial_distribution
    syntax keyword cppSTLtype geometric_distribution
    syntax keyword cppSTLtype poisson_distribution
    syntax keyword cppSTLtype exponential_distribution
    syntax keyword cppSTLtype gamma_distribution
    syntax keyword cppSTLtype weibull_distribution
    syntax keyword cppSTLtype extreme_value_distribution
    syntax keyword cppSTLtype normal_distribution
    syntax keyword cppSTLtype lognormal_distribution
    syntax keyword cppSTLtype chi_squared_distribution
    syntax keyword cppSTLtype cauchy_distribution
    syntax keyword cppSTLtype fisher_f_distribution
    syntax keyword cppSTLtype student_t_distribution
    syntax keyword cppSTLtype discrete_distribution
    syntax keyword cppSTLtype piecewise_constant_distribution
    syntax keyword cppSTLtype piecewise_linear_distribution
    syntax keyword cppSTLtype seed_seq
    syntax keyword cppSTLfunction generate_canonical

    " ratio
    syntax keyword cppSTLtype ratio
    syntax keyword cppSTLtype yocto
    syntax keyword cppSTLtype zepto
    syntax keyword cppSTLtype atto
    syntax keyword cppSTLtype femto
    syntax keyword cppSTLtype pico
    syntax keyword cppSTLtype nano
    syntax keyword cppSTLtype micro
    syntax keyword cppSTLtype milli
    syntax keyword cppSTLtype centi
    syntax keyword cppSTLtype deci
    syntax keyword cppSTLtype deca
    syntax keyword cppSTLtype hecto
    syntax keyword cppSTLtype kilo
    syntax keyword cppSTLtype mega
    syntax keyword cppSTLtype giga
    syntax keyword cppSTLtype tera
    syntax keyword cppSTLtype peta
    syntax keyword cppSTLtype exa
    syntax keyword cppSTLtype zetta
    syntax keyword cppSTLtype yotta
    syntax keyword cppSTLtype ratio_add
    syntax keyword cppSTLtype ratio_subtract
    syntax keyword cppSTLtype ratio_multiply
    syntax keyword cppSTLtype ratio_divide
    syntax keyword cppSTLtype ratio_equal
    syntax keyword cppSTLtype ratio_not_equal
    syntax keyword cppSTLtype ratio_less
    syntax keyword cppSTLtype ratio_less_equal
    syntax keyword cppSTLtype ratio_greater
    syntax keyword cppSTLtype ratio_greater_equal

    " regex
    syntax keyword cppSTLtype basic_regex
    syntax keyword cppSTLtype sub_match
    syntax keyword cppSTLtype match_results
    syntax keyword cppSTLtype regex_traits
    syntax keyword cppSTLtype regex_match regex_search regex_replace
    syntax keyword cppSTLiterator regex_iterator
    syntax keyword cppSTLiterator regex_token_iterator
    syntax keyword cppSTLexception regex_error
    syntax keyword cppSTLtype syntax_option_type match_flag_type error_type

    " string
    syntax keyword cppSTLfunction stoi
    syntax keyword cppSTLfunction stol
    syntax keyword cppSTLfunction stoll
    syntax keyword cppSTLfunction stoul
    syntax keyword cppSTLfunction stoull
    syntax keyword cppSTLfunction stof
    syntax keyword cppSTLfunction stod
    syntax keyword cppSTLfunction stold

    " system_error
    syntax keyword cppSTLenum errc
    syntax keyword cppSTLtype system_error
    syntax keyword cppSTLtype error_code
    syntax keyword cppSTLtype error_condition
    syntax keyword cppSTLtype error_category
    syntax keyword cppSTLtype is_error_code_enum
    syntax keyword cppSTLtype is_error_condition_enum
    " syntax keyword cppSTLfunction default_error_condition
    " syntax keyword cppSTLfunction generic_category
    " syntax keyword cppSTLfunction system_category
    " syntax keyword cppSTLfunction code
    " syntax keyword cppSTLfunction category
    " syntax keyword cppSTLfunction message
    " syntax keyword cppSTLfunction equivalent

    " thread
    syntax keyword cppSTLnamespace this_thread
    syntax keyword cppSTLtype thread
    syntax keyword cppSTLfunction get_id
    syntax keyword cppSTLfunction sleep_for
    syntax keyword cppSTLfunction sleep_until
    syntax keyword cppSTLfunction joinable
    syntax keyword cppSTLfunction native_handle
    syntax keyword cppSTLfunction hardware_concurrency
    " syntax keyword cppSTLfunction yield
    " syntax keyword cppSTLfunction join
    " syntax keyword cppSTLfunction detach

    " tuple
    syntax keyword cppSTLtype tuple
    syntax keyword cppSTLtype tuple_size
    syntax keyword cppSTLtype tuple_element
    syntax keyword cppSTLfunction make_tuple
    syntax keyword cppSTLfunction tie
    syntax keyword cppSTLfunction forward_as_tuple
    syntax keyword cppSTLfunction tuple_cat
    " Note: 'ignore' is already set as cppSTLfunction
    " syntax keyword cppSTLconstant ignore

    " typeindex
    syntax keyword cppSTLtype type_index

    " type_traits
    syntax keyword cppSTLtype is_void
    syntax keyword cppSTLtype is_integral
    syntax keyword cppSTLtype is_floating_point
    syntax keyword cppSTLtype is_array
    syntax keyword cppSTLtype is_enum
    syntax keyword cppSTLtype is_union
    syntax keyword cppSTLtype is_class
    syntax keyword cppSTLtype is_function
    syntax keyword cppSTLtype is_pointer
    syntax keyword cppSTLtype is_lvalue_reference
    syntax keyword cppSTLtype is_rvalue_reference
    syntax keyword cppSTLtype is_member_object_pointer
    syntax keyword cppSTLtype is_member_function_pointer
    syntax keyword cppSTLtype is_fundamental
    syntax keyword cppSTLtype is_arithmetic
    syntax keyword cppSTLtype is_scalar
    syntax keyword cppSTLtype is_object
    syntax keyword cppSTLtype is_compound
    syntax keyword cppSTLtype is_reference
    syntax keyword cppSTLtype is_member_pointer
    syntax keyword cppSTLtype is_const
    syntax keyword cppSTLtype is_volatile
    syntax keyword cppSTLtype is_trivial
    syntax keyword cppSTLtype is_trivially_copyable
    syntax keyword cppSTLtype is_standard_layout
    syntax keyword cppSTLtype is_pod
    syntax keyword cppSTLtype is_literal_type
    syntax keyword cppSTLtype is_empty
    syntax keyword cppSTLtype is_polymorphic
    syntax keyword cppSTLtype is_abstract
    syntax keyword cppSTLtype is_signed
    syntax keyword cppSTLtype is_unsigned
    syntax keyword cppSTLtype is_constructible
    syntax keyword cppSTLtype is_trivially_constructible
    syntax keyword cppSTLtype is_nothrow_constructible
    syntax keyword cppSTLtype is_default_constructible
    syntax keyword cppSTLtype is_trivially_default_constructible
    syntax keyword cppSTLtype is_nothrow_default_constructible
    syntax keyword cppSTLtype is_copy_constructible
    syntax keyword cppSTLtype is_trivially_copy_constructible
    syntax keyword cppSTLtype is_nothrow_copy_constructible
    syntax keyword cppSTLtype is_move_constructible
    syntax keyword cppSTLtype is_trivially_move_constructible
    syntax keyword cppSTLtype is_nothrow_move_constructible
    syntax keyword cppSTLtype is_assignable
    syntax keyword cppSTLtype is_trivially_assignable
    syntax keyword cppSTLtype is_nothrow_assignable
    syntax keyword cppSTLtype is_copy_assignable
    syntax keyword cppSTLtype is_trivially_copy_assignable
    syntax keyword cppSTLtype is_nothrow_copy_assignable
    syntax keyword cppSTLtype is_move_assignable
    syntax keyword cppSTLtype is_trivially_move_assignable
    syntax keyword cppSTLtype is_nothrow_move_assignable
    syntax keyword cppSTLtype is_destructible
    syntax keyword cppSTLtype is_trivially_destructible
    syntax keyword cppSTLtype is_nothrow_destructible
    syntax keyword cppSTLtype has_virtual_destructor
    syntax keyword cppSTLtype alignment_of
    syntax keyword cppSTLtype rank
    syntax keyword cppSTLtype extent
    syntax keyword cppSTLtype is_same
    syntax keyword cppSTLtype is_base_of
    syntax keyword cppSTLtype is_convertible
    syntax keyword cppSTLtype remove_cv
    syntax keyword cppSTLtype remove_const
    syntax keyword cppSTLtype remove_volatile
    syntax keyword cppSTLtype add_cv
    syntax keyword cppSTLtype add_const
    syntax keyword cppSTLtype add_volatile
    syntax keyword cppSTLtype remove_reference
    syntax keyword cppSTLtype add_lvalue_reference
    syntax keyword cppSTLtype add_rvalue_reference
    syntax keyword cppSTLtype remove_pointer
    syntax keyword cppSTLtype add_pointer
    syntax keyword cppSTLtype make_signed
    syntax keyword cppSTLtype make_unsigned
    syntax keyword cppSTLtype remove_extent
    syntax keyword cppSTLtype remove_all_extents
    syntax keyword cppSTLtype aligned_storage
    syntax keyword cppSTLtype aligned_union
    syntax keyword cppSTLtype decay
    syntax keyword cppSTLtype enable_if
    syntax keyword cppSTLtype conditional
    syntax keyword cppSTLtype common_type
    syntax keyword cppSTLtype underlying_type
    syntax keyword cppSTLtype result_of
    syntax keyword cppSTLtype integral_constant
    syntax keyword cppSTLtype true_type
    syntax keyword cppSTLtype false_type

    " unordered_map, unordered_set, unordered_multimap, unordered_multiset
    syntax keyword cppSTLtype unordered_map
    syntax keyword cppSTLtype unordered_set
    syntax keyword cppSTLtype unordered_multimap
    syntax keyword cppSTLtype unordered_multiset
    syntax keyword cppSTLtype hasher
    syntax keyword cppSTLtype key_equal
    syntax keyword cppSTLiterator local_iterator
    syntax keyword cppSTLiterator const_local_iterator
    syntax keyword cppSTLfunction bucket_count
    syntax keyword cppSTLfunction max_bucket_count
    syntax keyword cppSTLfunction bucket_size
    syntax keyword cppSTLfunction bucket
    syntax keyword cppSTLfunction load_factor
    syntax keyword cppSTLfunction max_load_factor
    syntax keyword cppSTLfunction rehash
    syntax keyword cppSTLfunction reserve
    syntax keyword cppSTLfunction hash_function
    syntax keyword cppSTLfunction key_eq

    " utility
    syntax keyword cppSTLtype piecewise_construct_t
    syntax keyword cppSTLconstant piecewise_construct
    syntax keyword cppSTLfunction declval
    syntax keyword cppSTLfunction forward
    syntax keyword cppSTLfunction move_if_noexcept

    " raw string literals
    syntax region cppRawString matchgroup=cppRawDelimiter start=@\%(u8\|[uLU]\)\=R"\z([[:alnum:]_{}[\]#<>%:;.?*\+\-/\^&|~!=,"']\{,16}\)(@ end=/)\z1"/ contains=@Spell

    syn match cNumber "0b[01]\+"
endif " C++11


if !exists("cpp_no_cpp14")
    " chrono
    syntax keyword cppSTLnamespace literals
    syntax keyword cppSTLnamespace chrono_literals

    " iterator
    syntax keyword cppSTLfunction make_reverse_iterator

    " memory
    syntax keyword cppSTLfunction make_unique

    " utility
    syntax keyword cppSTLtype integer_sequence
    syntax keyword cppSTLtype index_sequence
    syntax keyword cppSTLtype make_integer_sequence
    syntax keyword cppSTLtype make_index_sequence
    syntax keyword cppSTLtype index_sequence_for

    " shared_mutex
    syntax keyword cppSTLtype shared_timed_mutex
    syntax keyword cppSTLtype shared_lock
    syntax keyword cppSTLfunction lock_shared
    syntax keyword cppSTLfunction unlock_shared
    syntax keyword cppSTLfunction try_lock_shared
    syntax keyword cppSTLfunction try_lock_shared_for
    syntax keyword cppSTLfunction try_lock_shared_until

    " string
    syntax keyword cppSTLnamespace string_literals

    " tuple
    syntax keyword cppSTLtype tuple_element_t

    " type_traits
    syntax keyword cppSTLtype is_null_pointer
    syntax keyword cppSTLtype remove_cv_t
    syntax keyword cppSTLtype remove_const_t
    syntax keyword cppSTLtype remove_volatile_t
    syntax keyword cppSTLtype add_cv_t
    syntax keyword cppSTLtype add_const_t
    syntax keyword cppSTLtype add_volatile_t
    syntax keyword cppSTLtype remove_reference_t
    syntax keyword cppSTLtype add_lvalue_reference_t
    syntax keyword cppSTLtype add_rvalue_reference_t
    syntax keyword cppSTLtype remove_pointer_t
    syntax keyword cppSTLtype add_pointer_t
    syntax keyword cppSTLtype make_signed_t
    syntax keyword cppSTLtype make_unsigned_t
    syntax keyword cppSTLtype remove_extent_t
    syntax keyword cppSTLtype remove_all_extents_t
    syntax keyword cppSTLtype aligned_storage_t
    syntax keyword cppSTLtype aligned_union_t
    syntax keyword cppSTLtype decay_t
    syntax keyword cppSTLtype enable_if_t
    syntax keyword cppSTLtype conditional_t
    syntax keyword cppSTLtype common_type_t
    syntax keyword cppSTLtype underlying_type_t
    syntax keyword cppSTLtype result_of_t
endif " C++14


if !exists("cpp_no_cpp17")
    " algorithm
    syntax keyword cppSTLfunction clamp
    syntax keyword cppSTLfunction for_each_n

    " any
    syntax keyword cppSTLtype any
    syntax keyword cppSTLexception bad_any_cast
    syntax keyword cppSTLcast any_cast
    syntax keyword cppSTLfunction make_any

    " array
    syntax keyword cppSTLfunction to_array
    syntax keyword cppSTLfunction make_array

    " atomic
    syntax keyword cppSTLconstant is_always_lock_free

    " chrono
    syntax keyword cppSTLbool treat_as_floating_point_v

    " cmath
    syntax keyword cppSTLfunction assoc_laguerre assoc_laguerref assoc_laguerrel
    syntax keyword cppSTLfunction assoc_legendre assoc_legendref assoc_legendrel
    syntax keyword cppSTLfunction beta betaf betal
    syntax keyword cppSTLfunction comp_ellint_1 comp_ellint_1f comp_ellint_1l
    syntax keyword cppSTLfunction comp_ellint_2 comp_ellint_2f comp_ellint_2l
    syntax keyword cppSTLfunction comp_ellint_3 comp_ellint_3f comp_ellint_3l
    syntax keyword cppSTLfunction cyl_bessel_i cyl_bessel_if cyl_bessel_il
    syntax keyword cppSTLfunction cyl_bessel_j cyl_bessel_jf cyl_bessel_jl
    syntax keyword cppSTLfunction cyl_bessel_k cyl_bessel_kf cyl_bessel_kl
    syntax keyword cppSTLfunction cyl_neumann cyl_neumannf cyl_neumannl
    syntax keyword cppSTLfunction ellint_1 ellint_1f ellint_1l
    syntax keyword cppSTLfunction ellint_2 ellint_2f ellint_2l
    syntax keyword cppSTLfunction ellint_3 ellint_3f ellint_3l
    syntax keyword cppSTLfunction expint expintf expintl
    syntax keyword cppSTLfunction hermite hermitef hermitel
    syntax keyword cppSTLfunction legendre legendrefl egendrel
    syntax keyword cppSTLfunction laguerre laguerref laguerrel
    syntax keyword cppSTLfunction riemann_zeta riemann_zetaf riemann_zetal
    syntax keyword cppSTLfunction sph_bessel sph_besself sph_bessell
    syntax keyword cppSTLfunction sph_legendre sph_legendref sph_legendrel
    syntax keyword cppSTLfunction sph_neumann sph_neumannf sph_neumannl

    " cstdlib
    syntax keyword cppSTLfunction aligned_alloc

    " exception
    syntax keyword cppSTLfunction uncaught_exceptions

    " execution
    syntax keyword cppSTLnamespace execution
    syntax keyword cppSTLconstant seq par par_unseq
    syntax keyword cppSTLbool is_execution_policy_v
    syntax keyword cppSTLtype sequenced_policy
    syntax keyword cppSTLtype parallel_policy
    syntax keyword cppSTLtype parallel_unsequenced_policy
    syntax keyword cppSTLtype is_execution_policy

    " filesystem
    syntax keyword cppSTLnamespace filesystem
    syntax keyword cppSTLexception filesystem_error
    syntax keyword cppSTLtype path
    syntax keyword cppSTLtype directory_entry
    syntax keyword cppSTLtype directory_iterator
    syntax keyword cppSTLtype recursive_directory_iterator
    syntax keyword cppSTLtype file_status
    syntax keyword cppSTLtype space_info
    syntax keyword cppSTLtype file_time_type
    syntax keyword cppSTLenum file_type
    syntax keyword cppSTLenum perms
    syntax keyword cppSTLenum copy_options
    syntax keyword cppSTLenum directory_options
    syntax keyword cppSTLConstant preferred_separator
    syntax keyword cppSTLconstant available
    " Note: 'capacity' and 'free' are already set as cppSTLfunction
    " syntax keyword cppSTLconstant capacity
    " syntax keyword cppSTLconstant free
    syntax keyword cppSTLfunction concat
    syntax keyword cppSTLfunction make_preferred
    syntax keyword cppSTLfunction remove_filename
    syntax keyword cppSTLfunction replace_filename
    syntax keyword cppSTLfunction replace_extension
    syntax keyword cppSTLfunction native
    syntax keyword cppSTLfunction string_type
    " Note: wstring, u8string, u16string, u32string already set as cppSTLtype
    " syntax keyword cppSTLfunction wstring
    " syntax keyword cppSTLfunction u8string
    " syntax keyword cppSTLfunction u16string
    " syntax keyword cppSTLfunction u32string
    syntax keyword cppSTLfunction generic_string
    syntax keyword cppSTLfunction generic_wstring
    syntax keyword cppSTLfunction generic_u8string
    syntax keyword cppSTLfunction generic_u16string
    syntax keyword cppSTLfunction generic_u32string
    syntax keyword cppSTLfunction lexically_normal
    syntax keyword cppSTLfunction lexically_relative
    syntax keyword cppSTLfunction lexically_proximate
    syntax keyword cppSTLfunction root_name
    syntax keyword cppSTLfunction root_directory
    syntax keyword cppSTLfunction root_path
    syntax keyword cppSTLfunction relative_path
    syntax keyword cppSTLfunction parent_path
    " syntax keyword cppSTLfunction filename
    syntax keyword cppSTLfunction stem
    syntax keyword cppSTLfunction extension
    syntax keyword cppSTLfunction has_root_name
    syntax keyword cppSTLfunction has_root_directory
    syntax keyword cppSTLfunction has_root_path
    syntax keyword cppSTLfunction has_relative_path
    syntax keyword cppSTLfunction has_parent_path
    syntax keyword cppSTLfunction has_filename
    syntax keyword cppSTLfunction has_stem
    syntax keyword cppSTLfunction has_extension
    syntax keyword cppSTLfunction is_absolute
    syntax keyword cppSTLfunction is_relative
    syntax keyword cppSTLfunction hash_value
    syntax keyword cppSTLfunction u8path
    syntax keyword cppSTLfunction path1
    syntax keyword cppSTLfunction path2
    " syntax keyword cppSTLfunction path
    syntax keyword cppSTLfunction status
    syntax keyword cppSTLfunction symlink_status
    syntax keyword cppSTLfunction options
    " syntax keyword cppSTLfunction depth
    syntax keyword cppSTLfunction recursive_pending
    syntax keyword cppSTLfunction disable_recursive_pending
    " syntax keyword cppSTLfunction type
    syntax keyword cppSTLfunction permissions
    syntax keyword cppSTLfunction absolute
    syntax keyword cppSTLfunction system_complete
    syntax keyword cppSTLfunction canonical
    syntax keyword cppSTLfunction weakly_canonical
    syntax keyword cppSTLfunction relative
    syntax keyword cppSTLfunction proximate
    syntax keyword cppSTLfunction copy_file
    syntax keyword cppSTLfunction copy_symlink
    syntax keyword cppSTLfunction create_directory
    syntax keyword cppSTLfunction create_directories
    syntax keyword cppSTLfunction create_hard_link
    syntax keyword cppSTLfunction create_symlink
    syntax keyword cppSTLfunction create_directory_symlink
    syntax keyword cppSTLfunction current_path
    " syntax keyword cppSTLfunction exists
    syntax keyword cppSTLfunction file_size
    syntax keyword cppSTLfunction hard_link_count
    syntax keyword cppSTLfunction last_write_time
    syntax keyword cppSTLfunction read_symlink
    syntax keyword cppSTLfunction remove_all
    syntax keyword cppSTLfunction resize_file
    syntax keyword cppSTLfunction space
    syntax keyword cppSTLfunction temp_directory_path
    syntax keyword cppSTLfunction is_block_file
    syntax keyword cppSTLfunction is_character_file
    syntax keyword cppSTLfunction is_directory
    syntax keyword cppSTLfunction is_fifo
    syntax keyword cppSTLfunction is_other
    syntax keyword cppSTLfunction is_regular_file
    syntax keyword cppSTLfunction is_socket
    syntax keyword cppSTLfunction is_symlink
    syntax keyword cppSTLfunction status_known
    " Note: 'is_empty' already set as cppSTLtype
    " syntax keyword cppSTLfunction is_empty

    " functional
    syntax keyword cppSTLtype default_order
    syntax keyword cppSTLtype default_order_t
    syntax keyword cppSTLtype default_searcher
    syntax keyword cppSTLtype boyer_moore_searcher
    syntax keyword cppSTLtype boyer_moore_horspool_searcher
    syntax keyword cppSTLbool is_bind_expression_v
    syntax keyword cppSTLbool is_placeholder_v
    syntax keyword cppSTLfunction not_fn
    syntax keyword cppSTLfunction make_default_searcher
    syntax keyword cppSTLfunction make_boyer_moore_searcher
    syntax keyword cppSTLfunction make_boyer_moore_horspool_searcher
    " syntax keyword cppSTLfunction invoke

    " memory
    syntax keyword cppSTLcast reinterpret_pointer_cast
    syntax keyword cppSTLfunction uninitialized_move
    syntax keyword cppSTLfunction uninitialized_move_n
    syntax keyword cppSTLfunction uninitialized_default_construct
    syntax keyword cppSTLfunction uninitialized_default_construct_n
    syntax keyword cppSTLfunction uninitialized_value_construct
    syntax keyword cppSTLfunction uninitialized_value_construct_n
    syntax keyword cppSTLfunction destroy_at
    syntax keyword cppSTLfunction destroy_n

    " memory_resource
    syntax keyword cppSTLtype polymorphic_allocator
    syntax keyword cppSTLtype memory_resource
    syntax keyword cppSTLtype synchronized_pool_resource
    syntax keyword cppSTLtype unsynchronized_pool_resource
    syntax keyword cppSTLtype pool_options
    syntax keyword cppSTLtype monotonic_buffer_resource
    syntax keyword cppSTLfunction upstream_resource
    syntax keyword cppSTLfunction get_default_resource
    syntax keyword cppSTLfunction new_default_resource
    syntax keyword cppSTLfunction set_default_resource
    syntax keyword cppSTLfunction null_memory_resource
    syntax keyword cppSTLfunction allocate
    syntax keyword cppSTLfunction deallocate
    syntax keyword cppSTLfunction construct
    syntax keyword cppSTLfunction destruct
    syntax keyword cppSTLfunction resource
    syntax keyword cppSTLfunction select_on_container_copy_construction
    syntax keyword cppSTLfunction do_allocate
    syntax keyword cppSTLfunction do_deallocate
    syntax keyword cppSTLfunction do_is_equal

    " mutex
    syntax keyword cppSTLtype scoped_lock

    " new
    syntax keyword cppSTLconstant hardware_destructive_interference_size
    syntax keyword cppSTLconstant hardware_constructive_interference_size
    syntax keyword cppSTLfunction launder

    " numeric
    syntax keyword cppSTLfunction gcd
    syntax keyword cppSTLfunction lcm
    syntax keyword cppSTLfunction exclusive_scan
    syntax keyword cppSTLfunction inclusive_scan
    syntax keyword cppSTLfunction transform_reduce
    syntax keyword cppSTLfunction transform_exclusive_scan
    syntax keyword cppSTLfunction transform_inclusive_scan
    " syntax keyword cppSTLfunction reduce

    " optional
    syntax keyword cppSTLtype optional
    syntax keyword cppSTLtype nullopt_t
    syntax keyword cppSTLexception bad_optional_access
    syntax keyword cppSTLconstant nullopt
    syntax keyword cppSTLfunction make_optional
    syntax keyword cppSTLfunction value_or
    syntax keyword cppSTLfunction has_value
    " syntax keyword cppSTLfunction value

    " string_view
    syntax keyword cppSTLtype basic_string_view
    syntax keyword cppSTLtype string_view
    syntax keyword cppSTLtype wstring_view
    syntax keyword cppSTLtype u16string_view
    syntax keyword cppSTLtype u32string_view
    syntax keyword cppSTLfunction remove_prefix
    syntax keyword cppSTLfunction remove_suffix

    " system_error
    syntax keyword cppSTLbool is_error_code_enum_v
    syntax keyword cppSTLbool is_error_condition_enum_v

    " shared_mutex
    syntax keyword cppSTLtype shared_mutex

    " tuple
    syntax keyword cppSTLconstant tuple_size_v
    syntax keyword cppSTLfunction make_from_tuple
    " syntax keyword cppSTLfunction apply

    " type_traits
    syntax keyword cppSTLbool is_void_v
    syntax keyword cppSTLbool is_null_pointer_v
    syntax keyword cppSTLbool is_integral_v
    syntax keyword cppSTLbool is_floating_point_v
    syntax keyword cppSTLbool is_array_v
    syntax keyword cppSTLbool is_enum_v
    syntax keyword cppSTLbool is_union_v
    syntax keyword cppSTLbool is_class_v
    syntax keyword cppSTLbool is_function_v
    syntax keyword cppSTLbool is_pointer_v
    syntax keyword cppSTLbool is_lvalue_reference_v
    syntax keyword cppSTLbool is_rvalue_reference_v
    syntax keyword cppSTLbool is_member_object_pointer_v
    syntax keyword cppSTLbool is_member_function_pointer_v
    syntax keyword cppSTLbool is_fundamental_v
    syntax keyword cppSTLbool is_arithmetic_v
    syntax keyword cppSTLbool is_scalar_v
    syntax keyword cppSTLbool is_object_v
    syntax keyword cppSTLbool is_compound_v
    syntax keyword cppSTLbool is_reference_v
    syntax keyword cppSTLbool is_member_pointer_v
    syntax keyword cppSTLbool is_const_v
    syntax keyword cppSTLbool is_volatile_v
    syntax keyword cppSTLbool is_trivial_v
    syntax keyword cppSTLbool is_trivially_copyable_v
    syntax keyword cppSTLbool is_standard_layout_v
    syntax keyword cppSTLbool is_pod_v
    syntax keyword cppSTLbool is_literal_type_v
    syntax keyword cppSTLbool is_empty_v
    syntax keyword cppSTLbool is_polymorphic_v
    syntax keyword cppSTLbool is_abstract_v
    syntax keyword cppSTLbool is_signed_v
    syntax keyword cppSTLbool is_unsigned_v
    syntax keyword cppSTLbool is_constructible_v
    syntax keyword cppSTLbool is_trivially_constructible_v
    syntax keyword cppSTLbool is_nothrow_constructible_v
    syntax keyword cppSTLbool is_default_constructible_v
    syntax keyword cppSTLbool is_trivially_default_constructible_v
    syntax keyword cppSTLbool is_nothrow_default_constructible_v
    syntax keyword cppSTLbool is_copy_constructible_v
    syntax keyword cppSTLbool is_trivially_copy_constructible_v
    syntax keyword cppSTLbool is_nothrow_copy_constructible_v
    syntax keyword cppSTLbool is_move_constructible_v
    syntax keyword cppSTLbool is_trivially_move_constructible_v
    syntax keyword cppSTLbool is_nothrow_move_constructible_v
    syntax keyword cppSTLbool is_assignable_v
    syntax keyword cppSTLbool is_trivially_assignable_v
    syntax keyword cppSTLbool is_nothrow_assignable_v
    syntax keyword cppSTLbool is_copy_assignable_v
    syntax keyword cppSTLbool is_trivially_copy_assignable_v
    syntax keyword cppSTLbool is_nothrow_copy_assignable_v
    syntax keyword cppSTLbool is_move_assignable_v
    syntax keyword cppSTLbool is_trivially_move_assignable_v
    syntax keyword cppSTLbool is_nothrow_move_assignable_v
    syntax keyword cppSTLbool is_destructible_v
    syntax keyword cppSTLbool is_trivially_destructible_v
    syntax keyword cppSTLbool is_nothrow_destructible_v
    syntax keyword cppSTLbool has_virtual_destructor_v
    syntax keyword cppSTLbool is_same_v
    syntax keyword cppSTLbool is_base_of_v
    syntax keyword cppSTLbool is_convertible_v
    syntax keyword cppSTLbool is_callable_v
    syntax keyword cppSTLbool is_nowthrow_callable_v
    syntax keyword cppSTLbool conjunction_v
    syntax keyword cppSTLbool disjunction_v
    syntax keyword cppSTLbool negation_v
    syntax keyword cppSTLbool has_unique_object_representations_v
    syntax keyword cppSTLbool is_swappable_v
    syntax keyword cppSTLbool is_swappable_with_v
    syntax keyword cppSTLbool is_nothrow_swappable_v
    syntax keyword cppSTLbool is_nothrow_swappable_with_v
    syntax keyword cppSTLbool is_invocable_v
    syntax keyword cppSTLbool is_invocable_r_v
    syntax keyword cppSTLbool is_nothrow_invocable_v
    syntax keyword cppSTLbool is_nothrow_invocable_r_v
    syntax keyword cppSTLbool is_aggregate_v
    syntax keyword cppSTLconstant alignment_of_v
    syntax keyword cppSTLconstant rank_v
    syntax keyword cppSTLconstant extent_v
    syntax keyword cppSTLtype bool_constant
    syntax keyword cppSTLtype is_callable
    syntax keyword cppSTLtype is_nowthrow_callable
    syntax keyword cppSTLtype conjunction
    syntax keyword cppSTLtype disjunction
    syntax keyword cppSTLtype negation
    syntax keyword cppSTLtype void_t
    syntax keyword cppSTLtype has_unique_object_representations
    syntax keyword cppSTLtype is_swappable
    syntax keyword cppSTLtype is_swappable_with
    syntax keyword cppSTLtype is_nothrow_swappable
    syntax keyword cppSTLtype is_nothrow_swappable_with
    syntax keyword cppSTLtype is_invocable
    syntax keyword cppSTLtype is_invocable_r
    syntax keyword cppSTLtype is_nothrow_invocable
    syntax keyword cppSTLtype is_nothrow_invocable_r
    syntax keyword cppSTLtype invoke_result
    syntax keyword cppSTLtype invoke_result_t
    syntax keyword cppSTLtype is_aggregate

    " unordered_map, unordered_set, unordered_multimap, unordered_multiset
    syntax keyword cppSTLtype node_type
    syntax keyword cppSTLtype insert_return_type
    syntax keyword cppSTLfunction try_emplace
    syntax keyword cppSTLfunction insert_or_assign
    syntax keyword cppSTLfunction extract

    " utility
    syntax keyword cppSTLtype in_place_tag
    syntax keyword cppSTLtype in_place_t
    syntax keyword cppSTLtype in_place_type_t
    syntax keyword cppSTLtype in_place_index_t
    syntax keyword cppSTLfunction in_place
    syntax keyword cppSTLfunction as_const

    " variant
    syntax keyword cppSTLtype variant
    syntax keyword cppSTLtype monostate
    syntax keyword cppSTLtype variant_size
    syntax keyword cppSTLtype variant_alternative
    syntax keyword cppSTLtype variant_alternative_t
    syntax keyword cppSTLconstant variant_size_v
    syntax keyword cppSTLconstant variant_npos
    syntax keyword cppSTLexception bad_variant_access
    syntax keyword cppSTLfunction valueless_by_exception
    syntax keyword cppSTLfunction holds_alternative
    syntax keyword cppSTLfunction get_if
    syntax keyword cppSTLfunction visit
    " syntax keyword cppSTLfunction index
endif " C++17


if !exists("cpp_no_cpp20")
    " type_traits
    syntax keyword cppSTLtype remove_cvref remove_cvref_t
    syntax keyword cppType char8_t
    syntax keyword cppStatement co_yield co_return co_await
    syntax keyword cppStorageClass consteval
endif


if exists('g:cpp_concepts_highlight') && g:cpp_concepts_highlight
    syntax keyword cppStatement concept
    syntax keyword cppStorageClass requires
    syntax keyword cppSTLtype DefaultConstructible
    syntax keyword cppSTLtype MoveConstructible
    syntax keyword cppSTLtype CopyConstructible
    syntax keyword cppSTLtype MoveAssignable
    syntax keyword cppSTLtype CopyAssignable
    syntax keyword cppSTLtype Destructible
    syntax keyword cppSTLtype TriviallyCopyable
    syntax keyword cppSTLtype TrivialType
    syntax keyword cppSTLtype StandardLayoutType
    syntax keyword cppSTLtype PODType
    syntax keyword cppSTLtype EqualityComparable
    syntax keyword cppSTLtype LessThanComparable
    syntax keyword cppSTLtype Swappable
    syntax keyword cppSTLtype ValueSwappable
    syntax keyword cppSTLtype NullablePointer
    syntax keyword cppSTLtype Hash
    syntax keyword cppSTLtype Allocator
    syntax keyword cppSTLtype FunctionObject
    syntax keyword cppSTLtype Callable
    syntax keyword cppSTLtype Predicate
    syntax keyword cppSTLtype BinaryPredicate
    syntax keyword cppSTLtype Compare
    syntax keyword cppSTLtype Container
    syntax keyword cppSTLtype ReversibleContainer
    syntax keyword cppSTLtype AllocatorAwareContainer
    syntax keyword cppSTLtype SequenceContainer
    syntax keyword cppSTLtype ContiguousContainer
    syntax keyword cppSTLtype AssociativeContainer
    syntax keyword cppSTLtype UnorderedAssociativeContainer
    syntax keyword cppSTLtype DefaultInsertable
    syntax keyword cppSTLtype CopyInsertable
    syntax keyword cppSTLtype CopyInsertable
    syntax keyword cppSTLtype MoveInsertable
    syntax keyword cppSTLtype EmplaceConstructible
    syntax keyword cppSTLtype Erasable
    syntax keyword cppSTLtype Iterator
    syntax keyword cppSTLtype InputIterator
    syntax keyword cppSTLtype OutputIterator
    syntax keyword cppSTLtype ForwardIterator
    syntax keyword cppSTLtype BidirectionalIterator
    syntax keyword cppSTLtype RandomAccessIterator
    syntax keyword cppSTLtype ContiguousIterator
    syntax keyword cppSTLtype UnformattedInputFunction
    syntax keyword cppSTLtype FormattedInputFunction
    syntax keyword cppSTLtype UnformattedOutputFunction
    syntax keyword cppSTLtype FormattedOutputFunction
    syntax keyword cppSTLtype SeedSequence
    syntax keyword cppSTLtype UniformRandomBitGenerator
    syntax keyword cppSTLtype RandomNumberEngine
    syntax keyword cppSTLtype RandomNumberEngineAdaptor
    syntax keyword cppSTLtype RandomNumberDistribution
    syntax keyword cppSTLtype BasicLockable
    syntax keyword cppSTLtype Lockable
    syntax keyword cppSTLtype TimedLockable
    syntax keyword cppSTLtype Mutex
    syntax keyword cppSTLtype TimedMutex
    syntax keyword cppSTLtype SharedMutex
    syntax keyword cppSTLtype SharedTimedMutex
    syntax keyword cppSTLtype UnaryTypeTrait
    syntax keyword cppSTLtype BinaryTypeTrait
    syntax keyword cppSTLtype TransformationTrait
    syntax keyword cppSTLtype Clock
    syntax keyword cppSTLtype TrivialClock
    syntax keyword cppSTLtype CharTraits
    syntax keyword cppSTLtype pos_type
    syntax keyword cppSTLtype off_type
    syntax keyword cppSTLtype BitmaskType
    syntax keyword cppSTLtype NumericType
    syntax keyword cppSTLtype RegexTraits
    syntax keyword cppSTLtype LiteralType
endif " C++ concepts


if !exists("cpp_no_boost")
    syntax keyword cppSTLnamespace boost
    syntax keyword cppSTLcast lexical_cast
endif " boost


" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
  if version < 508
    let did_cpp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink cppSTLbool         Boolean
  HiLink cppStorageClass    StorageClass
  HiLink cppStatement       Statement
  HiLink cppSTLfunction     Function
  HiLink cppSTLfunctional   Typedef
  HiLink cppSTLconstant     Constant
  HiLink cppSTLnamespace    Constant
  HiLink cppSTLtype         Typedef
  HiLink cppSTLexception    Exception
  HiLink cppSTLiterator     Typedef
  HiLink cppSTLiterator_tag Typedef
  HiLink cppSTLenum         Typedef
  HiLink cppSTLios          Function
  HiLink cppSTLcast         Statement " be consistent with official syntax
  HiLink cppRawString       String
  HiLink cppRawDelimiter    Delimiter
  delcommand HiLink
endif

endif
