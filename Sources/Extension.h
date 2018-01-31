//
//  objc-swift
//
//  Created by Xudong Xu on 2016/12/27.
//  Copyright (c) 2021 Xudong Xu. All rights reserved.
//

_Pragma("once")

#import <objc/runtime.h>

#ifdef __OBJC__
#import <objc/NSObject.h>

/**
 Add default implementation to Protocol

 @param $Protocol The Protocol to inspect
 */
#define extension($Protocol)    \
    extension_specific($Protocol, protocol_extension($Protocol))

/**
 Add default implementation to Protocol by using a helper Class

 @param $Protocol The Protocol to inspect
 @param $Class The helper Class
 */
#define extension_specific($Protocol, $Class)   \
    _Pragma("clang diagnostic push")    \
    _Pragma("clang diagnostic ignored \"-Wprotocol\"")  \
    _Pragma("clang diagnostic ignored \"-Wobjc-property-implementation\"")  \
    _Pragma("clang diagnostic ignored \"-Wobjc-protocol-property-synthesis\"")  \
    protocol $Protocol; \
    \
    @interface $Class: NSObject <$Protocol> @end   \
    \
    @implementation $Class  \
	\
    + (void)load {  \
        protocol_load_extention(@protocol($Protocol), self); \
    }   \
    _Pragma("clang diagnostic pop") \

#define protocol_extension($Protocol) \
    protocol_extension_specific($Protocol, __COUNTER__)

#define protocol_extension_specific($Protocol, $Token) \
    protocol_extension_name($Protocol, $Token, __objc_swift__, _Protocol_Container__)

#define protocol_extension_name($Protocol, $Token, $Prefix, $Suffix) \
    $Prefix ## $Protocol ## _ ## $Token ## $Suffix

#endif

/**
 Add extention to existing Protocol
 
 @param p Protocol to inpect
 @param cls The Class which comforms to Protocol p
 */
OBJC_EXPORT
void protocol_load_extention(Protocol *p, Class cls) OBJC_AVAILABLE(10.0, 2.0, 9.0, 1.0, 2.0);
