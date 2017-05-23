//
//  SWMRTest.m
//  SWMR
//
//  Created by iOS-School-1 on 23.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "SWMRTest.h"

@interface SWMRTest ()

@property dispatch_queue_t queue;

@end

@implementation SWMRTest

@synthesize count = _count;

- (instancetype)init {
    self = [super init];
    if (self) {
//        self.queue = dispatch_queue_create("my.queue", 0);
        _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _count = 0;
    }
    return self;
}

- (NSInteger)count {
    __block NSUInteger localCount;
    dispatch_sync(self.queue, ^{
        localCount = _count;
    });
    return localCount;
}

- (void)setCount:(NSInteger)count {
    dispatch_barrier_async(self.queue, ^{
        _count = count;
    });
}

@end
