//
//  RavenAdapter.m
//  TestingPatterns2
//
//  Created by iOS-School-1 on 20.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "RavenAdapter.h"
#import "Raven.h"

@interface RavenAdapter ()

@property (nonatomic, strong) Raven *raven;

@end

@implementation RavenAdapter

- (instancetype)initWithRaven:(Raven *)raven {
    self = [super init];
    if (self) {
        _raven = raven;
    }
    return self;
}

- (void)fly {
    [_raven flySeekAndDestroy];
}

- (void)sing {
    [_raven voice];
}

@end
