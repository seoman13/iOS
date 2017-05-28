//
//  SummThread.m
//  TestingPOSIX
//
//  Created by iOS-School-1 on 27.05.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "SummThread.h"

@implementation SummThread

- (void)main {
    NSUInteger addition = _collection.count%_maxThreadCount;
    
    NSUInteger length = _collection.count/_maxThreadCount;
    NSUInteger step = _collection.count/_maxThreadCount;
    
    if ( addition!=0 && _index==(_maxThreadCount-1) ) {
        length = length+addition;
    }
    
    NSRange range = NSMakeRange(_index*step, length);
    NSUInteger sum = 0;
    for (NSUInteger i=range.location; i<(range.location+range.length);++i) {
        sum = sum + (NSUInteger)_collection[i];
    }

//    NSLog(@"Thread: %@ number: %lu", self.name, sum);
    [self.condition lock];
    *(_nsThreadResultAddress) = *(_nsThreadResultAddress) + sum;
//    [self.condition signal];
    [self.condition unlock];
}

@end
