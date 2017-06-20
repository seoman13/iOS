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
#import "Raven.h"
#import "RavenAdapter.h"
#import "BirdProtocol.h"
#import "Strategy.h"
#import "Context.h"
#import "StrategyAdd.h"
#import "StrategySubtract.h"
#import "StrategyMultiply.h"

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
        // DECORATOR PATTERN
        Report *report = [Report new];
        PlainPrinter *printer = [PlainPrinter new];
        printer.string = @"Report";
        [report startPrinter:printer];
        [report startPrinter:[[PrinterDecorator alloc] initWith:printer]];
        
        // ADAPTER PATTERN
        Raven *raven = [[Raven alloc] init];
        RavenAdapter *ravenAdapter = [[RavenAdapter alloc] initWithRaven:raven];
        [raven flySeekAndDestroy];
        [ravenAdapter fly];
        [raven voice];
        [ravenAdapter sing];
        
        // STRATEGY PATTERN
        Context *context = [Context new];
        context.strategy = [StrategyAdd new];
        NSLog(@"%i", [context.strategy executeWithA:2 B:3]);
        context.strategy = [StrategySubtract new];
        NSLog(@"%i", [context.strategy executeWithA:20 B:5]);
        context.strategy = [StrategyMultiply new];
        NSLog(@"%i", [context.strategy executeWithA:3 B:4]);
    }
    return 0;
}
