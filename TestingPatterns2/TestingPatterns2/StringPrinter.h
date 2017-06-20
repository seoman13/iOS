//
//  StringPrinter.h
//  TestingPatterns2
//
//  Created by iOS-School-1 on 20.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@protocol StringPrinter <NSObject>

- (void)printString;
- (void)setString:(NSString *)string;
- (NSString *)string;

@end
