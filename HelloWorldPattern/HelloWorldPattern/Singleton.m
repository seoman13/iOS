//
//  Singleton.m
//  HelloWorldPattern
//
//  Created by iOS-School-1 on 17.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "Singleton.h"
static NSString *const title = @"Hello World!";

@implementation Singleton

+ (instancetype)sharedInstance {
    static Singleton *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

@end
