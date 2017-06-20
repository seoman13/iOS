//
//  main.m
//  TestingPatterns2
//
//  Created by iOS-School-1 on 20.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringPrinter.h"
#import "PlainPrinter.h"
#import "PrinterDecorator.h"

@interface Report : NSObject

- (void)startPrinter:(id<StringPrinter>)printer;

@end

@implementation Report

- (void)startPrinter:(id<StringPrinter>)printer {
    [printer printString];
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Report *report = [Report new];
        PlainPrinter *printer = [PlainPrinter new];
        printer.string = @"Report";
        [report startPrinter:printer];
        [report startPrinter:[[PrinterDecorator alloc] initWith:printer]];
    }
    return 0;
}
