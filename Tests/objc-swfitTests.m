//
//  objc-evolution
//
//  Created by Xudong Xu on 2017/1/1.
//  Copyright (c) 2021 Xudong Xu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "objc-evolution.h"

@interface objcswiftTests : XCTestCase

@end

@implementation objcswiftTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExtension {
    // stub enumeratedType
    (void)Array.Element;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
