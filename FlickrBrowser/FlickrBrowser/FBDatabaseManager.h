//
//  FBDatabaseManager.h
//  FlickrBrowser
//
//  Created by Admin on 23.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSManagedObjectContext;

typedef void(^FBDatabaseManagerCompletionHandler)(BOOL succeeded, NSError *error);

@interface FBDatabaseManager : NSObject

@property (strong, nonatomic, readonly) NSManagedObjectContext *mainThreadManagedObjectContext;

- (instancetype)initWithModelName:(NSString *)modelName NS_DESIGNATED_INITIALIZER;

- (void)setupCoreDataStackWithCompletionHandler:(FBDatabaseManagerCompletionHandler)handler;
- (void)saveDataWithCompletionHandler:(FBDatabaseManagerCompletionHandler)handler;

@end
