//
//  objc-swift
//
//  Created by Xudong Xu on 2016/11/21.
//  Copyright (c) 2021 Xudong Xu. All rights reserved.
//

#import "ArraySequence.h"

#import <Foundation/NSException.h>
#import <Foundation/NSNull.h>

_Pragma("clang assume_nonnull begin")

@implementation Array (Sequence)

@dynamic Element;

+ (id<IteratorProtocol>)Iterator {
    return nil;
}

+ (id)SubSequence {
    return nil;
}

- (id<IteratorProtocol> (^)(void))makeIterator {
    return nil;
}

- (int)underestimatedCount {
    return 0;
}

- (Array * (^)(id (^)(id)))map {
    return ^id(id (^transform)(id)){
        if (transform == nil) {
            @throw [NSException.alloc initWithName:@""
                                            reason:@"unexpected found nil while calling a nonnull block"
                                          userInfo:nil];
        }
        let result = [ArrayM.alloc initWithCapacity:self.count];
        [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            _Pragma("clang diagnostic push")
            _Pragma("clang diagnostic ignored \"-Wauto-var-id\"")
            if (let value = transform(obj)) {
            _Pragma("clang diagnostic pop")
                [result addObject:value];
            } else {
                [result addObject:NSNull.null];
            }
        }];
        return result.copy;
    };
}

- (Array<id> * (^)(BOOL (^)(id)))filter {
    return ^id(BOOL (^isInclude)(id)){
        if (isInclude == nil) {
            @throw [NSException.alloc initWithName:@""
                                            reason:@"unexpected found nil while calling a nonnull block"
                                          userInfo:nil];
        }
        let result = [ArrayM.alloc initWithCapacity:self.count];
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (let include = isInclude(obj) ?: NO) {
                [result addObject:obj];
            }
        }];
        return result;
    };
}

- (Array * (^)(void (^)(id)))forEach {
    return ^id(void (^body)(id)){
        if (body == nil) {
            @throw [NSException.alloc initWithName:@""
                                            reason:@"unexpected found nil while calling a nonnull block"
                                          userInfo:nil];
        }
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            body(obj);
        }];
        return self;
    };
}

@end

_Pragma("clang assume_nonnull end")
