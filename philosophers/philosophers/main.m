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

void takeStick(NSUInteger num);
void putStick(NSUInteger num);
void eat(NSString *name);

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
        NSMutableDictionary *sticks = [NSMutableDictionary new];
        for (int i = 0; i < 9; i++) {
            Stick *stick = [[Stick alloc] init];
            stick.number = [[NSString alloc] initWithFormat:@"%i", i];
            sticks[stick.number] = stick;
        }
        for (int j = 0; j < 10; j++) {
            NSString *l = [NSString stringWithFormat:@"%i", (j - 1) % 10];
            NSString *r = [NSString stringWithFormat:@"%i", (j + 1) % 10];

            Stick *left = [sticks objectForKey:l];
            Stick *right = [sticks objectForKey:r];
            
            Philosopher *phi = [[Philosopher alloc] init];
            phi.name = philosophers[j];
            phi.leftStick = left;
            phi.rightStick = right;
            phi.threadPriority = (j + 1) / 10;
            [phi start];
        }
        
        sleep(10);
        
//        NSLog(@"\n\n Pause");
//        
//        for (int i = 0; i < 10; i++) {
//            __block NSThread *philosopher = [[NSThread alloc] initWithBlock:^{
//                takeStick((i - 1) % 10);
//                takeStick((i + 1) % 10);
////                NSLog(@"%@ is eating", philosopher.name);
//                eat(philosopher.name);
//                putStick((i - 1) % 10);
//                putStick((i + 1) % 10);
//            }];
//            philosopher.name = philosophers[i];
//            philosopher.threadPriority = (i + 1) / 10;
//            [philosopher start];
//        }
//        sleep(10);
    }
    return 0;
}

void takeStick(NSUInteger num) {
    NSLog(@"Take stick Number %lu", num);
}

void putStick(NSUInteger num) {
    NSLog(@"Put down stick Number %lu", num);
}

void eat(NSString *name) {
    NSLog(@"%@ is eating", name);
}
