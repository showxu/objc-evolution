# Feature name

* Proposal: [OE-0001](0001-swift-var-and-let.md)
* Authors: [Xudong Xu](https://github.com/0xxd0)
* Status: Implemented

## Introduction

Swift `var`, `let` are important keywords for Swift variable, describing whether particular variable can be mutated. Introduce these keywords to Objective-C allowing better expression of mutation for variables. 

## Motivation

In Objective-C, a type should be specified for a variable:

```objc
NSMutableArray<NSString *> *elements = NSMutableArray.array;
```

However, it is automatically infered by type inference in Swift:

```swift
var elements = [String]();
```

## Proposed solution

Allow the use of `let` `var` except inout, var. This only affects the grammar in variable declaration.

```objc
let elements = NSMutableArray<NSString *>.array;
```

## Source compatibility

This functionality is strictly additive, and does not break any existing code: it only makes some previously ill-formed code well-formed, and does not change the behavior of any well-formed code.

## Effect on API resilience

API resilience describes the changes one can make to a public API
without breaking its ABI. Does this proposal introduce features that
would become part of a public API? If so, what kinds of changes can be
made without breaking ABI? Can this feature be added/removed without
breaking ABI? For more information about the resilience model, see the
[library evolution
document](https://github.com/apple/swift/blob/master/docs/LibraryEvolution.rst)
in the Swift repository.

## Alternatives considered

The primary alternative here is to do nothing: objc variable will continue to specific types for variables.
