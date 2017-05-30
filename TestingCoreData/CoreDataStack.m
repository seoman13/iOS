//
//  CoreDataStack.m
//  TestingCoreData
//
//  Created by iOS-School-1 on 30.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CoreDataStack.h"
@import CoreData;

@interface CoreDataStack ()

@property (nonatomic, strong, readwrite) NSManagedObjectContext *coreDataContext;
@end

@implementation CoreDataStack

- (instancetype)initStack {
    self = [super init];
    if (self) {
        [self setupCoreData];
    }
    return self;
}

+ (instancetype)stack {
    return [[CoreDataStack alloc] initStack];
}

- (void)setupCoreData {
    
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    NSManagedObjectModel *coreDataModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:path];
    
    NSPersistentStoreCoordinator *coreDataPSC = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:coreDataModel];
    
    NSError *err = nil;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationSupportFolder = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject;
//    NSString *pathToFile = [NSString stringWithFormat:@"%@/db/", applicationSupportFolder];
    
    if (![fileManager fileExistsAtPath:applicationSupportFolder.path]) {
        [fileManager createDirectoryAtPath:applicationSupportFolder.path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSURL *url = [applicationSupportFolder URLByAppendingPathComponent:@"db.sqlite"];
    
    [coreDataPSC addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&err];
    
    self.coreDataContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    _coreDataContext.persistentStoreCoordinator = coreDataPSC;
    
    
}

- (void)save {
    NSError *error = nil;
    if (_coreDataContext.hasChanges) {
        [_coreDataContext save:&error];
    }
    if (error){
        NSLog(@"Error occures");
    }
}

@end
