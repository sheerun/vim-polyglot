if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'opencl') == -1

" Vim syntax file
" Language:	OpenCL (Open Computing Language)
" Maintainer:	Terence Ou (rivan_@msn.com)
" Last Change:	19-July-2010

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Read the C syntax to start with
if version < 600
  source <sfile>:p:h/c.vim
else
  runtime! syntax/c.vim
endif

" address space qualifiers
syn keyword clStorageClass	global __global local __local constant __constant private __private
" function qualifiers
syn keyword clStorageClass      kernel __kernel  __attribute__
syn keyword clStorageClass      read_only __read_only write_only __write_only
syn keyword clStorageClass      complex imaginary

" scalar types
syn keyword clType              bool uchar ushort uint ulong half quad

" vector types
syn keyword clType		char2 char3 char4 char8 char16
syn keyword clType		uchar2 uchar3 uchar4 uchar8 uchar16
syn keyword clType		short2 short3 short4 short8 short16
syn keyword clType		ushort2 ushort3 ushort4 ushort8 ushort16
syn keyword clType		int2 int3 int4 int8 int16
syn keyword clType		uint2 uint3 uint4 uint8 uint16
syn keyword clType		long2 long3 long4 long8 long16
syn keyword clType		ulong2 ulong3 ulong4 ulong8 ulong16
syn keyword clType		float2 float3 float4 float8 float16
syn keyword clType		double2 double3 double4 double8 double16
syn keyword clType              half2 half3 half4 half8 half16

" other types
syn keyword clType              ptrdiff_t intptr_t uintptr_t
syn keyword clType		image2d_t image3d_t sampler_t event_t

" reserved types
syn keyword clType              bool2 bool3 bool4 bool8 bool16
syn keyword clType              quad2 quad3 quad4 quad8 quad16
syn match clType                "\(float\|double\)\(2\|3\|4\|8\|16\)x\(2\|3\|4\|8\|16\)"

" abstract data types
syn keyword clType              _cl_platform_id _cl_device_id _cl_context _cl_command_queue _cl_mem _cl_program _cl_kernel _cl_event _cl_sampler

" image format descriptor structure
syn keyword clType              cl_image_format

syn keyword clCast              vec_type_hint work_group_size_hint aligned packed endian

syn match clCast                "as_\(uchar\|char\|ushort\|short\|uint\|int\|ulong\|long\|float\|double\)"

syn match clCast                "as_\(uchar\|char\|ushort\|short\|uint\|int\|ulong\|long\|float\|double\)\(2\|3\|4\|8\|16\)"

syn match clCast                "convert_\(uchar\|char\|ushort\|short\|uint\|int\|ulong\|long\|float\|double\))\(2\|3\|4\|8\|16\)"

syn match clCast                "convert_\(uchar\|char\|ushort\|short\|uint\|int\|ulong\|long\|float\|double\))\(2\|3\|4\|8\|16\)_sat"

syn match clCast                "convert_\(uchar\|char\|ushort\|short\|uint\|int\|ulong\|long\|float\|double\))\(2\|3\|4\|8\|16\)_sat_\(rte\|rtz\|rtp\|rtn\)"

" work item functions
syn keyword clFunction          get_work_dim get_global_size get_global_id get_local_size get_local_id get_num_groups get_group_id get_global_offset

" math functions
syn keyword clFunction          cos cosh cospi acos acosh acospi
syn keyword clFunction          sin sincos sinh sinpi asin asinh asinpi
syn keyword clFunction          tan tanh tanpi atan atan2 atanh atanpi atan2pi
syn keyword clFunction          cbrt ceil copysign
syn keyword clFunction          erfc erf
syn keyword clFunction          exp exp2 exp10 expm1
syn keyword clFunction          fabs fdim floor fma fmax fmin
syn keyword clFunction          fract frexp hypot ilogb
syn keyword clFunction          ldexp ldexp lgamma lgamma_r
syn keyword clFunction          log log2 log10 log1p logb
syn keyword clFunction          mad modf
syn keyword clFunction          nan nextafter
syn keyword clFunction          pow pown powr
syn keyword clFunction          remainder remquo rint rootn round rsqrt sqrt
syn keyword clFunction          tgamma trunc
syn keyword clFunction          half_cos half_divide half_exp half_exp2 half_exp10 half_log half_log2 half_log10 half_powr half_recip half_rsqrt half_sin half_sqrt half_tan
syn keyword clFunction          native_cos native_divide native_exp native_exp2 native_exp10 native_log native_log2 native_log10 native_powr native_recip native_rsqrt native_sin native_sqrt native_tan

" integer functions
syn keyword clFunction          abs abs_diff add_sat hadd rhadd clz mad_hi mad_sat max min mul_hi rotate sub_sat upsample mad24 mul24

" common functions
syn keyword clFunction          clamp degrees max min mix radians step smoothstep sign

" geometric functions
syn keyword clFunction          cross dot distance length normalize fast_distance fast_length fast_normalize

" miscellaneous vector functions
syn keyword clFunction          vec_step shuffle shuffle2

" relational functions
syn keyword clFunction          isequal isnotequal isgreater isgreaterequal isless islessequal islessgreater isfinite isinf isnan isnormal isordered isunordered signbit any all bitselect select

" vector data load and store functions
syn keyword clFunction          vload_half vstore_half
syn match clFunction            "vload\(2\|3\|4\|8\|16\)"
syn match clFunction            "vload_half\(2\|3\|4\|8\|16\)"
syn match clFunction            "vloada_half\(2\|3\|4\|8\|16\)"
syn match clFunction            "vloada_half\(2\|3\|4\|8\|16\)_\(rte\|rtz\|rtp\)"
syn match clFunction            "vstore\(2\|3\|4\|8\|16\)"
syn match clFunction            "vstore\(rte\|rtz\|rtp\|rtn\)"
syn match clFunction            "vstore_half\(2\|3\|4\|8\|16\)"
syn match clFunction            "vstore_half_\(rte\|rtz\|rtp\|rtn\)"
syn match clFunction            "vstore_half\(2\|3\|4\|8\|16\)_\(rte\|rtz\|rtp\|rtn\)"
syn match clFunction            "vstorea_half\(2\|3\|4\|8\|16\)"
syn match clFunction            "vstorea_half\(2\|3\|4\|8\|16\)_\(rte\|rtz\|rtp\|rtn\)"

" image read and write functions
syn match clFunction            "read_image\(f\|i\|ui\|h\)"
syn match clFunction            "write_image\(f\|i\|ui\|h\)"
syn keyword clFunction          get_image_width get_image_height get_image_depth get_image_channel_data_type get_image_channel_order get_image_dim

" explicit memory fence functions
syn keyword clFunction          barrier mem_fence read_mem_fence write_mem_fence

" async copies from global to local mem to and fro and prefetch
syn keyword clFunction          async_work_group_copy async_work_group__strided_copy wait_group_events prefetch

" atomic functions
syn match clFunction            "atom_\(add\|sub\|xchg\|inc\|dec\|cmpxchg\|min\|max\|and\|or\|xor\)"

syn keyword clConstant          MAXFLOAT HUGE_VALF INFINITY NAN
syn keyword clConstant          FLT_DIG FLT_MANT_DIG FLT_MAX_10_EXP FLT_MAX_EXP FLT_MIN_10_EXP FLT_MIN_EXP FLT_RADIX FLT_MAX FLT_MIN FLT_EPSILON
syn keyword clConstant          CHAR_BIT CHAR_MAX CHAR_MIN INT_MIN INT_MAX LONG_MAX LONG_MIN SCHAR_MAX SCHAR_MIN SHRT_MAX SHRT_MIN UCHAR_MAX UCHAR_MIN UINT_MAX ULONG_MAX
syn keyword clConstant          DBL_DIG DBL_MANT_DIG DBL_MAX_10_EXP DBL_MIN_10_EXP DBL_MIN_EXP DBL_MAX DBL_MIN DBL_EPSILON
syn keyword clConstant          M_E M_LOG2E M_LOG10E M_LN2 M_LN10 M_PI M_PI2 M_PI4 M_1_PI M_2_PI M_2_SQRTPI M_SQRT2 M_SQRT1_2
syn keyword clConstant          CLK_NORMALIZED_COORDS_TRUE CLK_NORMALIZED_COORDS_FALSE
syn keyword clConstant          CLK_ADDRESS_REPEAT CLK_ADDRESS_CLAMP_TO_EDGE CLK_ADDRESS_CLAMP
syn keyword clConstant          CL_INTENSITY CL_RA CL_ARGB CL_BGRA CL_RGBA CL_R CL_RG CL_RGB CL_RGx CL_RGBx CL_Rx CL_A CL_LUMINANCE
syn keyword clConstant          CL_SNORM_INT8 CL_SNORM_INT16 CL_UNORM_INT8 CL_UNORM_INT16 CL_UNORM_SHORT_565 CL_UNORM_SHORT_555 CL_UNORM_INT_101010 CL_SIGNED_INT8 CL_SIGNED_INT16 CL_SIGNED_INT32 CL_UNSIGNED_INT8 CL_UNSIGNED_INT16 CL_UNSIGNED_INT32 CL_HALF_FLOAT CL_FLOAT
syn keyword clConstant          CLK_ADDRESS_NONE CLK_FILTER_NEAREST CLK_FILTER_LINEAR
syn keyword clConstant          CLK_GLOBAL_MEM_FENCE CLK_LOCAL_MEM_FENCE

hi def link clStorageClass	StorageClass
hi def link clStructure         Structure
hi def link clType		Type
hi def link clVariable	        Identifier
hi def link clConstant	        Constant
hi def link clCast              Operator
hi def link clFunction          Function
hi def link clStatement         Statement

let b:current_syntax = "opencl"

" vim: ts=8

endif
