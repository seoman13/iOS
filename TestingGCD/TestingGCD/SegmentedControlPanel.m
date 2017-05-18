//
//  SegmentedControlPanel.m
//  TestingGCD
//
//  Created by iOS-School-1 on 16.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "SegmentedControlPanel.h"

@implementation SegmentedControlPanel

- (void)configurePanel {
    [self insertSegmentWithTitle:@"Map" atIndex:0 animated:YES];
    [self insertSegmentWithTitle:@"Satellite" atIndex:1 animated:YES];
    [self insertSegmentWithTitle:@"Hybrid" atIndex:2 animated:YES];
    self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo
    }
    
}

@end
