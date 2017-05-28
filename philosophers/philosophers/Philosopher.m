//
//  Philosopher.m
//  philosophers
//
//  Created by iOS-School-1 on 13.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "Philosopher.h"
#import "Stick.h"

@implementation Philosopher

- (void)main {
    @autoreleasepool {
        NSLog(@"%@ is thinking", self.name);
        [self.leftStick takeStick];
        [self.rightStick takeStick];
        NSLog(@"%@ is eating", self.name);
        sleep(1);
        [self.leftStick putDownStick];
        [self.rightStick putDownStick];
        NSLog(@"%@ has eaten", self.name);
    }
}

@end
