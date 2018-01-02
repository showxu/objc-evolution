//
//  CocoaSwift
//
//  Created by 0xxd0 on 2016/12/31.
//  Copyright © 2016年 0xxd0. All rights reserved.
//

#import <Foundation/NSEnumerator.h>
#import "Extension"
#import "Sequence"

//===----------------------------------------------------------------------===//
// Default implementations for Sequence
//===----------------------------------------------------------------------===//

// MARK: Fast Enumeration
@extension(Sequence)

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id  _Nullable __unsafe_unretained [])buffer count:(NSUInteger)bufferLength {
    // Keep the iterator alive througth the enumeration
    id<IteratorProtocol> (^getIterator)(void) = ^{
        return (__bridge id<IteratorProtocol>)(void *)state->extra[1];
    };
    void (^setIterator)(id<IteratorProtocol>) = ^(id<IteratorProtocol> iterator) {
        CFBridgingRelease((void *)state->state);
        state->extra[1] = (unsigned long)CFBridgingRetain(iterator);
    };
    void (^complete)(void) = ^{
        // Release any stored iterator.
        setIterator(nil);
        state->state = 0;
    };
body:
    // This is the initialization condition, so we'll do one-time setup here.
    if (state->state == 0) {
        // We are not tracking mutations, so we'll set state->mutationsPtr to point
        // into one of our extra values, since these values are not otherwise used
        // by the protocol.
        // If your class was mutable, you may choose to use an internal variable that
        // is updated when the class is mutated.
        // state->mutationsPtr MUST NOT be NULL and SHOULD NOT be set to self.
        state->mutationsPtr = &state->extra[0];
        setIterator(self.makeIterator());
    }
    
    var countOfItemsAlreadyEnumerated = state->state;
    var count = (NSUInteger)0;
    state->itemsPtr = buffer;
    while (count < bufferLength) {
        id<IteratorProtocol> iterator = getIterator();
        __autoreleasing id element = iterator.next;
        if (element == nil) {
            complete();
            break;
        }
        buffer[countOfItemsAlreadyEnumerated++] = element;
        ++count;
    }
done:
    state->state = countOfItemsAlreadyEnumerated;
    return count;
}

@end

// MARK: Sequence body
@extension(Sequence)

+ (id)Element {
    return nil;
}

+ (id<IteratorProtocol>)Iterator {
    return nil;
}

+ (id<Sequence>)SubSequence {
    return nil;
}

- (int)underestimatedCount {
    return 0;
}

/// Calls the given closure on each element in the sequence in the same order
/// as a `for`-`in` loop.
///
/// The two loops in the following example produce the same output:
///
///     let numberWords = ["one", "two", "three"]
///     for word in numberWords {
///         print(word)
///     }
///     // Prints "one"
///     // Prints "two"
///     // Prints "three"
///
///     numberWords.forEach { word in
///         print(word)
///     }
///     // Same as above
///
/// Using the `forEach` method is distinct from a `for`-`in` loop in two
/// important ways:
///
/// 1. You cannot use a `break` or `continue` statement to exit the current
///    call of the `body` closure or skip subsequent calls.
/// 2. Using the `return` statement in the `body` closure will exit only from
///    the current call to `body`, not from any outer scope, and won't skip
///    subsequent calls.
///
/// - Parameter body: A closure that takes an element of the sequence as a
///   parameter.
- (void (^)(void (^ _Nonnull)(id)))forEach {
    return ^void(void (^body)(id)) {
        forEach(element, self) {
            !body ?({}): body(element);
        };
    };
}

@end
