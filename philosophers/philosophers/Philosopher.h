//
//  Philosopher.h
//  philosophers
//
//  Created by iOS-School-1 on 13.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Stick;

@interface Philosopher : NSThread
@property(nonatomic, strong) Stick *leftStick;
@property(nonatomic, strong) Stick *rightStick;

@end
