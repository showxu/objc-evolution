//
//  CocoaSwiftTests
//
//  Created by 0xxd0 on 2017/1/1.
//  Copyright © 2017年 0xxd0. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CocoaSwift.h"

@interface CocoaSwiftTests : XCTestCase

@end

@implementation CocoaSwiftTests

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
    (void)Array.alloc.init.enumeratedType;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
