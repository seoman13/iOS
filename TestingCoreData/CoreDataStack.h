//
//  CoreDataStack.h
//  TestingCoreData
//
//  Created by iOS-School-1 on 30.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface CoreDataStack : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *coreDataContext;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initStack NS_DESIGNATED_INITIALIZER;
+ (instancetype)stack;

- (void)save;

@end
