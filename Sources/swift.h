//
//  Created by Xudong Xu on 2016/12/2.
//  Copyright (c) 2021 Xudong Xu. All rights reserved.
//

_Pragma("once")

#ifdef __cplusplus
extern "C" {
#endif
    
// Introduce Swift let
#ifdef __cplusplus
    #define let const auto
#else
    #define let const __auto_type
#endif

// Introduce Swift var
#ifdef __cplusplus
    #define var auto
#else
    #define var __auto_type
#endif

// Introduce Swift defer
typedef void (^defer_t)(void);

_Pragma("clang diagnostic push")
_Pragma("clang diagnostic ignored \"-Wunused-function\"")
static inline void cleanup(__strong defer_t *block) {
    (*block)();
}
_Pragma("clang diagnostic pop")

#define defer_($Token) \
    __defer__ ## $Token ## __

#define defer_at_line($Line) defer_($Line)

#define defer \
    __strong defer_t defer_at_line(__LINE__) \
        __attribute__((cleanup(cleanup), unused)) = ^

#ifdef __cplusplus
}
#endif
