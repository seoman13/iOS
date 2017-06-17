//
//  Singleton.m
//  TestingPatterns
//
//  Created by iOS-School-1 on 17.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

// If using multithreading it will create few instances, @synchronized will make it safe or dispatch_once
+ (instancetype)sharedInstance {
    static Singleton *sharedInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            sharedInstance = [[self alloc] init];
    });
    
    //    @synchronized (self) {
    //        if (sharedInstance == nil) {
    //            sharedInstance = [[self alloc] init];
    //        }
    //    }
    
    
    //    if (sharedInstance == nil) {
    //            sharedInstance = [[self alloc] init];
    //        }
    
    return sharedInstance;
}

@end
