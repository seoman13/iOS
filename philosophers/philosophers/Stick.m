//
//  Stick.m
//  philosophers
//
//  Created by iOS-School-1 on 13.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "Stick.h"
@interface Stick()
@property(nonatomic) NSLock *stickLock;
@end

@implementation Stick
-(instancetype) init{
    self = [super init];
    if (self) {
        self.stickLock = [NSLock new];
    }
    return self;
}

-(void)takeStick{
    [self.stickLock lock];
}

-(void)putDownStick{
    [self.stickLock unlock];
}

@end
