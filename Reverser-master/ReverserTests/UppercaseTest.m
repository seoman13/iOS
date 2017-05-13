//
//  UppercaseTest.m
//  Reverser
//
//  Created by iOS-School-1 on 13.04.17.
//  Copyright © 2017 Alexey Ulenkov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SBDUppercase.h"

@interface UppercaseTest : XCTestCase

@end

@implementation UppercaseTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testUppercaseNormal {
    NSString *sourceString = @"Hello world!";
    NSString *resultString = @"HELLO WORLD!";
    XCTAssertTrue([[SBDUppercase uppercaseB:sourceString] isEqualToString:resultString], @"Test uppercaser in normal case.");
}

- (void)testUppercaseEmpty {
    NSString *sourceString = @"";
    NSString *resultString = @"";
    XCTAssertTrue([[SBDUppercase uppercaseB:sourceString] isEqualToString:resultString], @"Test uppercaser with normal string.");
}

- (void)testUppercaseNil {
    NSString *sourceString = nil;
    XCTAssertTrue([SBDUppercase uppercaseB:sourceString] == nil, @"Test uppercaser with nil.");
}
@end
