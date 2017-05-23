//
//  main.m
//  SWMR
//
//  Created by iOS-School-1 on 23.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWMRTest.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        SWMRTest *test = [[SWMRTest alloc] init];
        dispatch_apply(1000, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t iterations){
            if (iterations%10 == 0) {
                test.count += 1;
            }
            NSLog(@"%lu", test.count);
        });
        
    }
    
    return 0;
}
