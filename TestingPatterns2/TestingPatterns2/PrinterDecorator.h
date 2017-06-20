//
//  PrinterDecorator.h
//  TestingPatterns2
//
//  Created by iOS-School-1 on 20.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringPrinter.h"

@interface PrinterDecorator : NSObject <StringPrinter>

@property (nonatomic, copy) NSString *string;

- (instancetype)initWith:(id<StringPrinter>)printer;

@end
