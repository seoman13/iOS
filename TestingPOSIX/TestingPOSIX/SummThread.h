//
//  SummThread.h
//  TestingPOSIX
//
//  Created by iOS-School-1 on 27.05.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SummThread : NSThread

@property (nonatomic, strong) NSArray *collection;
@property (nonatomic, assign) NSUInteger maxThreadCount;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) NSUInteger nsThreadResult;
@property (nonatomic, assign) NSLock *condition;
@property (nonatomic) NSUInteger *nsThreadResultAddress;

@end
