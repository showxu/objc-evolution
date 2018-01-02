//
//  CocoaSwift
//
//  Created by 0xxd0 on 2017/1/1.
//  Copyright © 2017年 0xxd0. All rights reserved.
//

#import "Extension"
#import "Comparable"

@extension(Comparable)

/// Returns a Boolean value indicating whether the value of the first argument
/// is greater than that of the second argument.
///
/// This is the default implementation of the greater-than operator (`>`) for
/// any type that conforms to `Comparable`.
///
/// - Parameters:
///   - lhs: A value to compare.
///   - rhs: Another value to compare.
+ (BOOL (^)(id, id))greaterThan {
    return ^BOOL(id lhs, id rhs){
        return self.lessThan(rhs, lhs);
    };
}

/// Returns a Boolean value indicating whether the value of the first argument
/// is less than or equal to that of the second argument.
///
/// This is the default implementation of the less-than-or-equal-to
/// operator (`<=`) for any type that conforms to `Comparable`.
///
/// - Parameters:
///   - lhs: A value to compare.
///   - rhs: Another value to compare.
+ (BOOL (^)(id, id))lessThanOrEqualTo {
    return ^BOOL(id lhs, id rhs){
        return !self.lessThan(rhs, lhs);
    };
}

/// Returns a Boolean value indicating whether the value of the first argument
/// is greater than or equal to that of the second argument.
///
/// This is the default implementation of the greater-than-or-equal-to operator
/// (`>=`) for any type that conforms to `Comparable`.
///
/// - Parameters:
///   - lhs: A value to compare.
///   - rhs: Another value to compare.
/// - Returns: `true` if `lhs` is greater than or equal to `rhs`; otherwise,
///   `false`.
+ (BOOL (^)(id, id))greaterThanOrEqualTo {
    return ^BOOL(id lhs, id rhs){
        return self.lessThan(rhs, lhs);
    };
}
    
@end
