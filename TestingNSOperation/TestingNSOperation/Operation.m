//
//  Operation.m
//  TestingNSOperation
//
//  Created by iOS-School-1 on 20.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "Operation.h"

@implementation Operation

- (void)start {
    
//    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
//    [self main];
    
}

- (void)main {
    
    sleep(1);
    NSLog(@"\n %@", self.str);
    //
    
    //
    
    //
    
    if (self.isCancelled) {
        //
    }
    
//    NSLog(@"\n - %@", [NSThread currentThread]);
}

@end
