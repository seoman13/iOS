//
//  AbstractOrder.m
//  TestingPatterns2
//
//  Created by iOS-School-1 on 20.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AbstractOrder.h"
@class Address;

@implementation AbstractOrder

- (void)chooseItem {
    // in inheriting objects need to overload these methods
}

- (void)choosePayment {
    // in inheriting objects need to overload these methods
}

- (void)addAddress:(Address *)address {
    // no need to overload
}

- (void)confirmOrder {
    // no need to overload
}

@end
