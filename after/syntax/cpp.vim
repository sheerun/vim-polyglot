if polyglot#init#is_disabled(expand('<sfile>:p'), 'cpp-modern', 'after/syntax/cpp.vim')
  finish
endif

" ==============================================================================
" Vim syntax file
" Language:        C++ (Standard library including C++11/14/17/20)
" Original Author: Jon Haggblad <https://github.com/octol>
" Maintainer:      bfrg <https://github.com/bfrg>
" Website:         https://github.com/bfrg/vim-cpp-modern
" Last Change:     Sep 15, 2022
"
" This syntax file is based on:
" https://github.com/octol/vim-cpp-enhanced-highlight
" ==============================================================================

" C++ attributes {{{1
if get(g:, 'cpp_attributes_highlight', 0)
    syntax region cppAttribute matchgroup=cppAttributeBrackets start='\[\[' end=']]' contains=cString
    hi def link cppAttribute         Macro
    hi def link cppAttributeBrackets Identifier
endif


" Standard library {{{1
syntax keyword cppSTLdefine
        \ MB_CUR_MAX MB_LEN_MAX WCHAR_MAX WCHAR_MIN WEOF __STDC_UTF_16__ __STDC_UTF_32__

syntax keyword cppSTLnamespace
        \ std experimental rel_ops

syntax keyword cppSTLconstant
        \ badbit digits digits10 eofbit failbit goodbit has_denorm has_denorm_loss has_infinity has_quiet_NaN has_signaling_NaN is_bounded is_exact is_iec559 is_integer is_modulo is_signed is_specialized max_exponent max_exponent10 min_exponent min_exponent10 npos radix round_style tinyness_before traps

syntax keyword cppSTLvariable
        \ cerr cin clog cout wcerr wcin wclog wcout nothrow

syntax keyword cppSTLexception
        \ bad_alloc bad_exception bad_typeid bad_cast domain_error exception failure invalid_argument length_error logic_error out_of_range overflow_error range_error runtime_error underflow_error

syntax keyword cppSTLios
        \ endl ends flush resetiosflags setbase setfill setiosflags setprecision setw ws

syntax keyword cppSTLios
        \ boolalpha dec defaultfloat fixed hex hexfloat internal left noboolalpha noshowbase noshowpoint noshowpos noskipws nounitbuf nouppercase oct right scientific showbase showpoint showpos skipws unitbuf uppercase

syntax keyword cppSTLtype
        \ fmtflags iostate openmode Init allocator auto_ptr basic_filebuf basic_fstream basic_ifstream basic_ios basic_iostream basic_istream basic_istringstream basic_ofstream basic_ostream basic_ostringstream basic_streambuf basic_string basic_stringbuf basic_stringstream binary_compose binder1st binder2nd bitset char_traits char_type const_mem_fun1_t const_mem_fun_ref1_t const_mem_fun_ref_t const_mem_fun_t const_pointer const_reference container_type deque difference_type div_t event_callback filebuf first_type float_denorm_style float_round_style fpos fstream gslice_array ifstream imaxdiv_t indirect_array int_type ios ios_base iostream istream istringstream istrstream iterator_category iterator_traits key_compare key_type ldiv_t list lldiv_t map mapped_type mask_array mbstate_t mem_fun1_t mem_fun_ref1_t mem_fun_ref_t mem_fun_t multimap multiset nothrow_t numeric_limits off_type ofstream ostream ostringstream ostrstream pair pointer pointer_to_binary_function pointer_to_unary_function pos_type priority_queue queue reference second_type seekdir sequence_buffer set size_type slice_array stack state_type stream streambuf streamoff streampos streamsize string stringbuf stringstream strstream strstreambuf temporary_buffer test_type tm traits_type type_info u16string u32string unary_compose unary_negate valarray value_compare value_type vector wfilebuf wfstream wifstream wios wiostream wistream wistringstream wofstream wostream wostringstream wstreambuf wstreampos wstring wstringbuf wstringstream codecvt codecvt_base codecvt_byname collate collate_byname ctype ctype_base ctype_byname locale messages messages_base messages_byname money_base money_get money_put moneypunct moneypunct_byname num_get num_put numpunct numpunct_byname time_base time_get time_get_byname time_put time_put_byname binary_function binary_negate bit_and bit_not bit_or divides equal_to greater greater_equal less less_equal logical_and logical_not logical_or minus modulus multiplies negate not_equal_to plus unary_function unary_negate bidirectional_iterator_tag forward_iterator_tag input_iterator_tag output_iterator_tag random_access_iterator_tag

syntax keyword cppSTLtypedef
        \ time_t sig_atomic_t wctrans_t wctype_t wint_t

syntax keyword cppSTLiterator
        \ back_insert_iterator bidirectional_iterator const_iterator const_reverse_iterator forward_iterator front_insert_iterator input_iterator insert_iterator istream_iterator istreambuf_iterator iterator ostream_iterator ostreambuf_iterator output_iterator random_access_iterator raw_storage_iterator reverse_bidirectional_iterator reverse_iterator

" Function templates that are called with template parameters
syntax keyword cppSTLfunction
        \ use_facet has_facet get

" Some of these keywords can be highlighted as cppSTLios or cppSTLconstant
" syntax keyword cppSTLconstant
"         \ adjustfield app ate basefield binary floatfield in out trunc boolalpha dec fixed hex internal left oct right scientific showbase showpoint showpos skipws unitbuf uppercase


" C++11 extensions {{{1
if !exists('cpp_no_cpp11')
    syntax keyword cppStatement nullptr
    syntax keyword cppType char16_t char32_t

    syntax keyword cppSTLnamespace chrono this_thread

    syntax keyword cppSTLtype
            \ array atomic atomic_bool atomic_char atomic_flag atomic_int atomic_llong atomic_long atomic_schar atomic_short atomic_uchar atomic_uint atomic_ullong atomic_ulong atomic_ushort duration duration_values high_resolution_clock hours microseconds milliseconds minutes nanoseconds seconds steady_clock system_clock time_point treat_as_floating_point condition_variable exception_ptr nested_exception hash is_bind_expression is_placeholder reference_wrapper forward_list future packaged_task promise shared_future initializer_list codecvt_mode codecvt_utf16 codecvt_utf8 codecvt_utf8_utf16 wbuffer_convert wstring_convert allocator_traits allocator_type default_delete enable_shared_from_this is_always_equal owner_less pointer_safety pointer_traits propagate_on_container_copy_assignment propagate_on_container_move_assignment propagate_on_container_swap rebind_alloc rebind_traits shared_ptr unique_ptr uses_allocator void_pointer const_void_pointer weak_ptr condition_variable_any lock_guard mutex once_flag recursive_mutex recursive_timed_mutex timed_mutex unique_lock bernoulli_distribution binomial_distribution cauchy_distribution chi_squared_distribution default_random_engine discard_block_engine discrete_distribution exponential_distribution extreme_value_distribution fisher_f_distribution gamma_distribution geometric_distribution independent_bits_engine knuth_b linear_congruential_engine lognormal_distribution mersenne_twister_engine minstd_rand minstd_rand0 mt19937 mt19937_64 negative_binomial_distribution normal_distribution piecewise_constant_distribution piecewise_linear_distribution poisson_distribution random_device ranlux24 ranlux24_base ranlux48 ranlux48_base seed_seq shuffle_order_engine student_t_distribution subtract_with_carry_engine uniform_int_distribution uniform_real_distribution weibull_distribution atto centi deca deci exa femto giga hecto kilo mega micro milli nano peta pico ratio ratio_add ratio_divide ratio_equal ratio_greater ratio_greater_equal ratio_less ratio_less_equal ratio_multiply ratio_not_equal ratio_subtract tera yocto yotta zepto zetta basic_regex regex wregex match_results regex_traits sub_match syntax_option_type match_flag_type error_type scoped_allocator_adaptor outer_allocator_type inner_allocator_type error_code error_condition error_category is_error_code_enum is_error_condition_enum thread tuple tuple_size tuple_element type_index add_const add_cv add_lvalue_reference add_pointer add_rvalue_reference add_volatile aligned_storage aligned_union alignment_of common_type conditional decay enable_if extent false_type has_virtual_destructor integral_constant is_abstract is_arithmetic is_array is_assignable is_base_of is_class is_compound is_const is_constructible is_convertible is_copy_assignable is_copy_constructible is_default_constructible is_destructible is_empty is_enum is_floating_point is_function is_fundamental is_integral is_literal_type is_lvalue_reference is_member_function_pointer is_member_object_pointer is_member_pointer is_move_assignable is_move_constructible is_nothrow_assignable is_nothrow_constructible is_nothrow_copy_assignable is_nothrow_copy_constructible is_nothrow_default_constructible is_nothrow_destructible is_nothrow_move_assignable is_nothrow_move_constructible is_object is_pod is_pointer is_polymorphic is_reference is_rvalue_reference is_same is_scalar is_signed is_standard_layout is_trivial is_trivially_assignable is_trivially_constructible is_trivially_copy_assignable is_trivially_copy_constructible is_trivially_copyable is_trivially_default_constructible is_trivially_destructible is_trivially_move_assignable is_trivially_move_constructible is_union is_unsigned is_void is_volatile make_signed make_unsigned rank remove_all_extents remove_const remove_cv remove_extent remove_pointer remove_reference remove_volatile result_of true_type underlying_type hasher key_equal unordered_map unordered_multimap unordered_multiset unordered_set function

    syntax keyword cppSTLtypedef
            \ atomic_char16_t atomic_char32_t atomic_int_fast16_t atomic_int_fast32_t atomic_int_fast64_t atomic_int_fast8_t atomic_int_least16_t atomic_int_least32_t atomic_int_least64_t atomic_int_least8_t atomic_intmax_t atomic_intptr_t atomic_ptrdiff_t atomic_size_t atomic_uint_fast16_t atomic_uint_fast32_t atomic_uint_fast64_t atomic_uint_fast8_t atomic_uint_least16_t atomic_uint_least32_t atomic_uint_least64_t atomic_uint_least8_t atomic_uintmax_t atomic_uintptr_t atomic_wchar_t nullptr_t max_align_t allocator_arg_t adopt_lock_t defer_lock_t try_to_lock_t piecewise_construct_t

    syntax keyword cppSTLconstant max_digits10

    syntax keyword cppSTLvariable
            \ _1 _2 _3 _4 _5 _6 _7 _8 _9 defer_lock try_to_lock adopt_lock allocator_arg

    syntax keyword cppSTLdefine
            \ math_errhandling FLT_EVAL_METHOD FP_INFINITE FP_NAN FP_NORMAL FP_SUBNORMAL FP_ZERO HUGE_VALF HUGE_VALL INFINITY MATH_ERREXCEPT MATH_ERRNO NAN

    syntax keyword cppSTLenum
            \ memory_order future_status future_errc launch io_errc cv_status errc

    syntax keyword cppSTLfunction
            \ duration_cast time_point_cast mem_fn const_pointer_cast dynamic_pointer_cast static_pointer_cast allocate_shared make_shared isblank generate_canonical forward_as_tuple make_tuple tie tuple_cat declval forward move move_if_noexcept

    syntax keyword cppSTLexception
            \ bad_function_call future_error regex_error system_error bad_weak_ptr bad_array_new_length

    syntax keyword cppSTLiterator
            \ move_iterator regex_iterator regex_token_iterator const_local_iterator local_iterator

    " Note: ignore is also a function
    syntax match cppSTLvariable "\<ignore\>(\@!"
endif


" C++14 extensions {{{1
if !exists('cpp_no_cpp14')
    syntax keyword cppSTLnamespace literals chrono_literals string_literals complex_literals

    syntax keyword cppSTLfunction make_unique

    syntax keyword cppSTLtype
            \ index_sequence index_sequence_for integer_sequence make_index_sequence make_integer_sequence shared_lock shared_timed_mutex is_null_pointer

    syntax keyword cppSTLtypedef
            \ tuple_element_t add_const_t add_cv_t add_lvalue_reference_t add_pointer_t add_rvalue_reference_t add_volatile_t aligned_storage_t aligned_union_t common_type_t conditional_t decay_t enable_if_t make_signed_t make_unsigned_t remove_all_extents_t remove_const_t remove_cv_t remove_extent_t remove_pointer_t remove_reference_t remove_volatile_t result_of_t underlying_type_t
endif


" C++17 extensions {{{1
if !exists('cpp_no_cpp17')
    syntax keyword cppSTLnamespace filesystem execution string_view_literals

    syntax keyword cppSTLtype
            \ any byte is_execution_policy parallel_policy parallel_unsequenced_policy sequenced_policy directory_entry directory_iterator file_status file_time_type path recursive_directory_iterator space_info default_order default_searcher boyer_moore_searcher boyer_moore_horspool_searcher memory_resource monotonic_buffer_resource polymorphic_allocator pool_options synchronized_pool_resource unsynchronized_pool_resource scoped_lock optional shared_mutex basic_string_view string_view u16string_view u32string_view wstring_view bool_constant conjunction disjunction has_unique_object_representations invoke_result is_aggregate is_callable is_invocable is_invocable_r is_nothrow_invocable is_nothrow_invocable_r is_nothrow_swappable is_nothrow_swappable_with is_nowthrow_callable is_swappable is_swappable_with negation node_type insert_return_type in_place_tag monostate variant variant_size variant_alternative from_chars_result to_chars_result chars_format

    syntax keyword cppSTLtypedef
            \ invoke_result_t default_order_t nullopt_t void_t in_place_t in_place_type_t in_place_index_t variant_alternative_t

    syntax keyword cppSTLexception
            \ bad_any_cast filesystem_error bad_optional_access bad_variant_access

    syntax keyword cppSTLconstant
            \ is_always_lock_free seq par par_unseq copy_symlinks auto_format create_hard_links create_symlinks directories_only follow_directory_symlink generic_format group_all group_exec group_read group_write native_format others_all others_exec others_read others_write overwrite_existing owner_all owner_exec owner_read owner_write preferred_separator recursive set_gid set_uid skip_existing skip_permission_denied skip_symlinks sticky_bit update_existing hardware_destructive_interference_size hardware_constructive_interference_size tuple_size_v nullopt alignment_of_v rank_v extent_v variant_npos variant_size_v

    syntax keyword cppSTLbool
            \ treat_as_floating_point_v is_execution_policy_v is_bind_expression_v is_placeholder_v is_error_code_enum_v is_error_condition_enum_v uses_allocator_v conjunction_v disjunction_v has_unique_object_representations_v has_virtual_destructor_v is_abstract_v is_aggregate_v is_arithmetic_v is_array_v is_assignable_v is_base_of_v is_callable_v is_class_v is_compound_v is_const_v is_constructible_v is_convertible_v is_copy_assignable_v is_copy_constructible_v is_default_constructible_v is_destructible_v is_empty_v is_enum_v is_floating_point_v is_function_v is_fundamental_v is_integral_v is_invocable_r_v is_invocable_v is_literal_type_v is_lvalue_reference_v is_member_function_pointer_v is_member_object_pointer_v is_member_pointer_v is_move_assignable_v is_move_constructible_v is_nothrow_assignable_v is_nothrow_constructible_v is_nothrow_copy_assignable_v is_nothrow_copy_constructible_v is_nothrow_default_constructible_v is_nothrow_destructible_v is_nothrow_invocable_r_v is_nothrow_invocable_v is_nothrow_move_assignable_v is_nothrow_move_constructible_v is_nothrow_swappable_v is_nothrow_swappable_with_v is_nowthrow_callable_v is_null_pointer_v is_object_v is_pod_v is_pointer_v is_polymorphic_v is_reference_v is_rvalue_reference_v is_same_v is_scalar_v is_signed_v is_standard_layout_v is_swappable_v is_swappable_with_v is_trivial_v is_trivially_assignable_v is_trivially_constructible_v is_trivially_copy_assignable_v is_trivially_copy_constructible_v is_trivially_copyable_v is_trivially_default_constructible_v is_trivially_destructible_v is_trivially_move_assignable_v is_trivially_move_constructible_v is_union_v is_unsigned_v is_void_v is_volatile_v negation_v

    syntax keyword cppSTLfunction
            \ reinterpret_pointer_cast make_from_tuple make_optional any_cast

    syntax keyword cppSTLenum
            \ copy_options directory_options file_type perm_options perms

    " Note: There is std::filesystem::path::format and std::format() in <format>
    syntax match cppSTLenum "\<format\>(\@!"

    " Note: these can be both member objects and methods
    syntax match cppSTLvariable "\<\%(capacity\|free\|available\)\>(\@!"

    " Note: these keywords are very likely to coincide with user-defined variables
    " syntax keyword cppSTLconstant
    "         \ all mask unknown replace add remove nofollow none not_found regular directory symlink block character fifo socket unknown
endif


" C++20 extensions {{{1
if !exists('cpp_no_cpp20')
    syntax keyword cppSTLnamespace ranges views
    syntax keyword cppSTLconstant dynamic_extent
    syntax keyword cppSTLvariable default_sentinel unreachable_sentinel
    syntax keyword cppSTLexception format_error

    syntax keyword cppSTLtype
            \ atomic_ref endian weak_ordering strong_ordering partial_ordering weak_equality strong_equality common_comparison_category contract_violation coroutine_traits coroutine_handle noop_coroutine_handle noop_coroutine_promise suspend_never suspend_always remove_cvref is_bounded_array is_layout_compatible is_unbounded_array is_nothrow_convertible has_strong_structural_equality is_pointer_interconvertible_base_of unwrap_reference unwrap_ref_decay basic_common_reference common_reference dangling ref_view filter_view transform_view iota_view join_view empty_view single_view split_view common_view reverse_view view_interface span basic_syncbuf basic_osyncstream syncbuf wsyncbuf osyncstream wosyncstream jthread latch barrier stop_token stop_source stop_callback counting_semaphore binary_semaphore source_location compare_three_way_result contiguous_iterator_tag incrementable_traits indirectly_readable_traits move_sentinel common_iterator counted_iterator projected type_identity formatter basic_format_context basic_format_args basic_format_string basic_format_parse_context

    syntax keyword cppSTLtypedef
            \ common_comparison_category_t remove_cvref_t unwrap_reference_t unwrap_ref_decay_t common_reference_t iterator_t sentinel_t safe_iterator_t safe_subrange_t compare_three_way_result_t iter_value_t iter_reference_t iter_difference_t iter_rvalue_reference_t iter_common_reference_t default_sentinel_t unreachable_sentinel_t indirect_result_t type_identity_t format_context wformat_context format_args wformat_args format_string wformat_string format_parse_context wformat_parse_context

    syntax keyword cppSTLfunction
            \ make_unique_default_init make_shared_default_init allocate_shared_default_init uses_allocator_construction_args make_obj_using_allocator is_corresponding_member subspan in_range is_pointer_interconvertible_with_class

    syntax keyword cppSTLbool
            \ is_bounded_array_v is_layout_compatible_v is_unbounded_array_v is_nothrow_convertible_v has_strong_structural_equality_v is_pointer_interconvertible_base_of_v disable_sized_sentinel_for disable_sized_range enable_borrowed_range enable_view

    syntax keyword cppSTLconcept
            \ assignable_from boolean common_reference_with common_with constructible_from convertible_to copy_constructible copyable default_constructible derived_from destructible equality_comparable equality_comparable_with equivalence_relation floating_point integral invocable movable move_constructible predicate regular regular_invocable relation same_as semiregular signed_integral strict_weak_order swappable swappable_with totally_ordered totally_ordered_with unsigned_integral default_initializable range sized_range view input_range output_range forward_range bidirectional_range random_access_range contiguous_range common_range viewable_range three_way_comparable three_way_comparable_with indirectly_readable indirectly_writable weakly_incrementable incrementable input_or_output_iterator sentinel_for sized_sentinel_for input_iterator output_iterator forward_iterator bidirectional_iterator random_access_iterator contiguous_iterator indirectly_unary_invocable indirectly_regular_unary_invocable indirect_unary_predicate indirect_binary_predicate indirect_equivalence_relation indirect_strict_weak_order indirectly_movable indirectly_movable_storable indirectly_copyable indirectly_copyable_storable indirectly_swappable indirectly_comparable permutable mergeable sortable
endif


" C++23 extensions {{{1
if !exists('cpp_no_cpp23')
    syntax keyword cppSTLtype basic_stacktrace stacktrace_entry is_scoped_enum
    syntax keyword cppSTLtypedef stacktrace
    syntax keyword cppSTLbool is_scoped_enum_v
    syntax keyword cppSTLfunction invoke_r
    syntax keyword cppSTLtype expected unexpected unexpect_t bad_expected_access
    syntax keyword cppSTLvariable unexpect
endif


" Boost {{{1
if !exists('cpp_no_boost')
    syntax keyword cppSTLnamespace boost
    syntax keyword cppSTLfunction lexical_cast
endif
" }}}


" Default highlighting
hi def link cppSTLbool         Boolean
hi def link cppStatement       Statement
hi def link cppSTLfunction     Function
hi def link cppSTLdefine       Constant
hi def link cppSTLconstant     Constant
hi def link cppSTLnamespace    Constant
hi def link cppSTLexception    Type
hi def link cppSTLiterator     Type
hi def link cppSTLtype         Type
hi def link cppSTLtypedef      Typedef
hi def link cppSTLenum         Typedef
hi def link cppSTLios          Function
hi def link cppSTLconcept      Typedef
hi def link cppSTLvariable     Identifier

" The keywords {inline, virtual, explicit, export, override, final} are
" standard C++ keywords and NOT types!
hi! def link cppModifier Statement


" Highlight all standard C++ keywords as Statement
if get(g:, 'cpp_simple_highlight', 0)
    hi! def link cppStructure    Statement
    hi! def link cppExceptions   Statement
    hi! def link cppStorageClass Statement
endif
