//
//  objc-evolution
//
//  Created by Xudong Xu on 2016/11/21.
//  Copyright (c) 2021 Xudong Xu. All rights reserved.
//

_Pragma("once")

#ifdef __OBJC__

#import "Array.h"
#import "Sequence.h"

_Pragma("clang assume_nonnull begin")

@interface Array<T>(Sequence) <Sequence>

@property (class, nonatomic, nonnull, readonly) T Element;

@property (class, nonatomic, nonnull, readonly) id<IteratorProtocol> Iterator;

@property (class, nonatomic, nonnull, readonly) id SubSequence;

- (id<IteratorProtocol> (^)(void))makeIterator;

@property (nonatomic, readonly) int underestimatedCount;

- (__nullable T (^)(BOOL (^by)(T x, T y)))min;

- (__nullable T (^)(BOOL (^by)(T x, T y)))max;

- (Array *(^)(id (^traform)(T value)))map;

- (Array<T> *(^)(BOOL (^isIncluded)(T value)))filter;

- (Array *(^)(void (^)(T)))forEach;

@end

_Pragma("clang assume_nonnull end")

#endif

