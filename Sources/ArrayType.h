//
//  objc-swift
//
//  Created by Xudong Xu on 2016/12/31.
//  Copyright (c) 2021 Xudong Xu. All rights reserved.
//

_Pragma("once")

#ifdef __OBJC__

#import <Foundation/NSArray.h>

@class NSArray;
@compatibility_alias Array NSArray;

@class NSMutableArray;
@compatibility_alias ArrayM NSMutableArray;

@interface Array<T>()

- (Array<T> *)copy __attribute__((objc_requires_super));

- (ArrayM<T> *)mutableCopy __attribute__((objc_requires_super));

@end

#endif
