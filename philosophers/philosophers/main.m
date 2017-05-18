//
//  main.m
//  philosophers
//
//  Created by iOS-School-1 on 13.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stick.h"
#import "Philosopher.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray <NSString *> *philosophers = @[@"Socrates",
                                               @"Plato",
                                               @"Aristotel",
                                               @"Herodotus",
                                               @"Spinoza",
                                               @"Kant",
                                               @"Hedon",
                                               @"Jacky",
                                               @"Norman",
                                               @"Leo"];
//        NSMutableDictionary *sticks = [NSMutableDictionary new];
//        for(int i = 0; i < 9; i++){
//            Stick *stick = [[Stick alloc] init];
//            stick.number = [[NSString alloc] initWithFormat:@"%i", i];
//            sticks[stick.number] = stick;
//        }
//        for(int j = 0; j < 10; j++){
//            NSString *l = [NSString stringWithFormat:@"%i", (j - 1) % 10];
//            NSString *r = [NSString stringWithFormat:@"%i", (j + 1) % 10];
//
//            Stick *left = [sticks objectForKey:l];
//            Stick *right = [sticks objectForKey:r];
//            
//            Philosopher *phi = [[Philosopher alloc] init];
//            phi.name = philosophers[j];
//            phi.leftStick = left;
//            phi.rightStick = right;
//            [phi start];
//        }
//        sleep(1000);
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        size_t iterations = [philosophers count];
        
        dispatch_apply(iterations, <#dispatch_queue_t  _Nonnull queue#>, <#^(size_t)block#>)
    }
    return 0;
}
