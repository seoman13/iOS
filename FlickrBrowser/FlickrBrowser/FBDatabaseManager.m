//
//  FBDatabaseManager.m
//  FlickrBrowser
//
//  Created by Admin on 23.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "FBDatabaseManager.h"
@import CoreData;

static NSString * const kFBDatabaseManagerFileName = @"Model";
static NSString * const kFBDatabaseManagerErrorDomain = @"FBErrorDomain";

typedef NS_ENUM(NSInteger, FBError) {
    FBErrorModelURLNotCreated,
    FBErrorManagedObjectModelNotCreated,
    FBErrorPersistentStoreCoordinatorNotCreated
};

@interface FBDatabaseManager ()

@property (strong, nonatomic, readwrite) NSManagedObjectContext *mainThreadManagedObjectContext;
@property (strong, nonatomic) NSManagedObjectContext *saveManagedObjectContext;
@property (strong, nonatomic) NSString *modelName;

@end

@implementation FBDatabaseManager

- (instancetype)initWithModelName:(NSString *)modelName {
    self = [super init];
    if (self) {
        _modelName = modelName;
    }
    return self;
}

- (instancetype)init {
    return [self initWithModelName:kFBDatabaseManagerFileName];
}

- (void)setupCoreDataStackWithCompletionHandler:(FBDatabaseManagerCompletionHandler)handler {
    // Check if we already have ManagedObjectContext
    if ([self saveManagedObjectContext]) return;
    
    // Create URL for model
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:self.modelName withExtension:@"momd"];
    if (!modelURL) {
        NSError *customError = [self createErrorWithCode:FBErrorManagedObjectModelNotCreated
                                                    desc:NSLocalizedString(@"The Model URL could not be found during setup.", nil)
                                              suggestion:NSLocalizedString(@"Do you want to try setting up the stack again?", nil)
                                                 options:@[@"Try Again", @"Cancel"]];
        handler(NO, customError);
        return;
    }
    
    // Create Model
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    if (!mom) {
        NSError *customError = [self createErrorWithCode:FBErrorManagedObjectModelNotCreated
                                                    desc:NSLocalizedString(@"The Managed Object Model could not be found during setup.", nil)
                                              suggestion:NSLocalizedString(@"Do you want to try setting up the stack again?", nil)
                                                 options:@[@"Try Again", @"Cancel"]];
        handler(NO, customError);
        return;
    }
    
    // Create PersistentStoreCoordinator
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (!psc) {
        NSError *customError = [self createErrorWithCode:FBErrorPersistentStoreCoordinatorNotCreated
                                                    desc:NSLocalizedString(@"The Persistent Store Coordinator could not be found during setup.", nil)
                                              suggestion:NSLocalizedString(@"Do you want to try setting up the stack again?", nil)
                                                 options:@[@"Try Again", @"Cancel"]];
        handler(NO, customError);
        return;
    }
    
    // Create and set managedObjectContexts
    NSManagedObjectContext *saveMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [saveMOC setPersistentStoreCoordinator:psc];
    self.saveManagedObjectContext = saveMOC;
    
    NSManagedObjectContext *mainThreadMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [mainThreadMOC setParentContext:self.saveManagedObjectContext];
    self.mainThreadManagedObjectContext = mainThreadMOC;
    
    // To create a reference to the store can take time, so not to
    // block our main thread we will do it on background thread
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSArray *directoryArray = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        NSURL *storeURL = [directoryArray lastObject];
        
        NSError *error = nil;
        // Try to create directory
        if (![[NSFileManager defaultManager] fileExistsAtPath:storeURL.path]) {
            [[NSFileManager defaultManager] createDirectoryAtURL:storeURL withIntermediateDirectories:NO attributes:nil error:&error];
            NSError *customError = nil;
            
            if (error) {
                customError = [NSError errorWithDomain:kFBDatabaseManagerErrorDomain code:error.code userInfo:error.userInfo];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(NO, customError);
            });
        }
        
        storeURL = [[storeURL URLByAppendingPathComponent:self.modelName] URLByAppendingPathExtension:@"sqlite"];
        NSDictionary *options = @{ NSMigratePersistentStoresAutomaticallyOption: @YES,
                                   NSInferMappingModelAutomaticallyOption: @YES };
        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error];
        // Check if the store was created
        if (!store) {
            NSError *customError = nil;
            
            if (error) {
                customError = [NSError errorWithDomain:kFBDatabaseManagerErrorDomain code:error.code userInfo:error.userInfo];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(NO, customError);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(YES, nil);
            });
        }
    });
}

- (void)saveDataWithCompletionHandler:(FBDatabaseManagerCompletionHandler)handler {
    // Check that we're executing this method from main thread
    if (![NSThread isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self saveDataWithCompletionHandler:handler];
        });
        return;
    }
    
    // Check if any changes were made so that we didn't do any unnecessary work
    if (![self.mainThreadManagedObjectContext hasChanges] && ![self.saveManagedObjectContext hasChanges]) {
        if (handler) {
            handler(YES, nil);
        }
        return;
    }
    
    // If mainThreadManagedObjectContext has any changes
    if ([self.mainThreadManagedObjectContext hasChanges]) {
        NSError *mainThreadSaveError = nil;
        if (![self.mainThreadManagedObjectContext save:&mainThreadSaveError]) {
            if (handler) {
                handler(NO, mainThreadSaveError);
            }
            return;
        }
    }
    
    // Save saveManagedObjectContext to store
    [self.saveManagedObjectContext performBlock:^{
        NSError *saveError = nil;
        if (![self.saveManagedObjectContext save:&saveError]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handler) {
                    handler(NO, saveError);
                }
                return;
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handler) {
                    handler(YES, nil);
                }
            });
        }
    }];
}

- (NSError *)createErrorWithCode:(NSUInteger)code desc:(NSString *)description suggestion:(NSString *)suggestion options:(NSArray *)options
{
    NSParameterAssert(description);
    NSParameterAssert(suggestion);
    NSParameterAssert(options);
    
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : description,
                                NSLocalizedRecoverySuggestionErrorKey : suggestion,
                                NSLocalizedRecoveryOptionsErrorKey : options };
    
    NSError *error = [NSError errorWithDomain:kFBDatabaseManagerErrorDomain code:code userInfo:userInfo];
    
    return error;
}

@end

