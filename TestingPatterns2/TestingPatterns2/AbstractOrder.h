//
//  AbstractOrder.h
//  TestingPatterns2
//
//  Created by iOS-School-1 on 20.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Address;

@interface AbstractOrder : NSObject

- (void)chooseItem;
- (void)choosePayment;
- (void)addAddress:(Address *)address;
- (void)confirmOrder;

- (instancetype)init NS_UNAVAILABLE;

@end
