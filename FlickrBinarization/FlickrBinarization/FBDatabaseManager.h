//
//  FBDatabaseManager.h
//  FlickrBinarization
//
//  Created by Admin on 21.06.17.
//  Copyright © 2017 Admin. All rights reserved.
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
