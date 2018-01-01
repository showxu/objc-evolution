//
//  CocoaSwift
//
//  Created by Alchemist on 2017/1/1.
//  Copyright © 2018年 alchemistxxd. All rights reserved.
//

@import ObjectiveC.NSObject;

#import "Equatable"
#import "Extension"

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

