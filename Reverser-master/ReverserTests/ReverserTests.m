//
//  ReverserTests.m
//  ReverserTests
//
//  Created by Alexey Ulenkov on 25.02.17.
//  Copyright © 2017 Alexey Ulenkov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SBDReverser.h"

@interface ReverserTests : XCTestCase

@end

@implementation ReverserTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testReverseNormal {
    NSString *sourceString = @"Hello world!";
    NSString *resultString = @"!dlrow olleH";
    XCTAssertTrue([[SBDReverser reverseString: sourceString] isEqualToString:resultString], @"Test reverser in normal case.");
}

- (void)testReverseEmpty {
    NSString *sourceString = @"";
    NSString *resultString = @"";
    XCTAssertTrue([[SBDReverser reverseString: sourceString] isEqualToString:resultString], @"Test reverser with empty string.");
}

- (void)testReverseNil {
    NSString *sourceString = nil;
    XCTAssertTrue([SBDReverser reverseString: sourceString] == nil, @"Test reverser with nil.");
}

@end
