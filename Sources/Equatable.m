//
//  objc-swift
//
//  Created by Alchemist on 2017/1/1.
//  Copyright (c) 2021 Xudong Xu. All rights reserved.
//

@import ObjectiveC.NSObject;

#import "Extension.h"
#import "Equatable.h"

@extension(Equatable)

- (BOOL (^)(id))isEqual {
    return ^BOOL(id rhs) {
        return !self.class.isEqual(self, rhs);
    };
}

+ (BOOL (^)(id, id))isNotEqual {
    return ^BOOL(id lhs, id rhs) {
        return !self.isEqual(lhs, rhs);
    };
}

- (BOOL (^)(id))isNotEqual {
    return ^BOOL(id rhs) {
        return !self.isEqual(rhs);
    };
}

@end
