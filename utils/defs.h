#ifndef DEFS_H
#define DEFS_H
#include <stdint.h>
#include <limits.h>
#include <float.h>

#ifndef __cplusplus
#  include <stdbool.h>
#  include <iso646.h>
#endif

typedef int8_t    int8;
typedef int16_t   int16;
typedef int32_t   int32;
typedef int64_t   int64;

typedef int8_t    i8;
typedef int16_t   i16;
typedef int32_t   i32;
typedef int64_t   i64;

typedef int8_t    s8;
typedef int16_t   s16;
typedef int32_t   s32;
typedef int64_t   s64;

typedef uint8_t   u_int8;
typedef uint16_t  u_int16;
typedef uint32_t  u_int32;
typedef uint64_t  u_int64;

typedef uint8_t   uint8;
typedef uint16_t  uint16;
typedef uint32_t  uint32;
typedef uint64_t  uint64;

typedef uint8_t   u8;
typedef uint16_t  u16;
typedef uint32_t  u32;
typedef uint64_t  u64;

typedef unsigned char u_char;

typedef unsigned char uchar;

#if defined(__FLT16_MANT_DIG__)
#  if defined(__GNUC__) || defined(__clang__)
__extension__ typedef _Float16 float16;
#  else
   typedef _Float16 float16;
#  endif
#elif defined(__cplusplus) && __cplusplus >= 202302L && defined(__has_include)
#  if __has_include(<stdfloat>)
#    include <stdfloat>
#    if defined(__STDCPP_FLOAT16_T__)
       typedef std::float16_t float16;
#    else
#      error "defs.h: native 16-bit floats are unavailable on this target"
#    endif
#  else
#    error "defs.h: native 16-bit floats are unavailable on this target"
#  endif
#else
#  error "defs.h: native 16-bit floats are unavailable on this target"
#endif

typedef float  float32;
typedef double float64;

typedef float  f32;
typedef double f64;

/** MUST FIND A WAY TO MAKE THEM - MAYBE MAKE MY OWN P.L **/
typedef uint16_t u_float16;
typedef uint32_t u_float32;
typedef uint64_t u_float64;

#if defined(__cplusplus)
#  define DEFS_ASSERT(condition, reason) static_assert((condition), reason)
#else
#  define DEFS_ASSERT(condition, reason) _Static_assert((condition), reason)
#endif
DEFS_ASSERT(CHAR_BIT == 8, "defs.h needs 8-bit bytes");
DEFS_ASSERT(sizeof(float16) == 2, "float16 must be 16 bits");
#if defined(__FLT16_MANT_DIG__)
DEFS_ASSERT(__FLT16_MANT_DIG__ == 11, "float16 must have IEEE binary16 precision");
#endif
DEFS_ASSERT(sizeof(float32) == 4 && FLT_RADIX == 2 && FLT_MANT_DIG == 24,
            "float32 must be IEEE binary32");
DEFS_ASSERT(sizeof(float64) == 8 && FLT_RADIX == 2 && DBL_MANT_DIG == 53,
            "float64 must be IEEE binary64");
#undef DEFS_ASSERT

#define band &
#define bor  |
#define bxor ^
#define bnot ~

#define b_and &
#define b_or  |
#define b_xor ^
#define b_not ~

#define and_b &
#define or_b  |
#define xor_b ^
#define not_b ~

#define lsh <<
#define rsh >>

#define shl <<
#define shr >>

#define sl <<
#define sr >>

#define ls <<
#define rs >>

#endif /* DEFS_H */
