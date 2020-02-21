//
//  FBSearchViewController.m
//  FlickrBinarization
//
//  Created by Admin on 17.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

// Libraries, Frameworks, Modules
#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
@import CoreData;
// Model
#import "FBSearchViewController.h"
#import "FBPictureCell.h"
#import "FBDatabaseManager.h"
#import "FBImageItem.h"
// Delegates
#import "FBSearchBarDelegate.h"
#import "FBSearchTableDelegate.h"
#import "FBSearchTableDataSource.h"
#import "FBPictureCellDelegate.h"

@interface FBSearchViewController () <NSFetchedResultsControllerDelegate>

// Visual Controls
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

// Delegates
@property (nonatomic, strong) FBSearchBarDelegate *searchBarDelegate;
@property (nonatomic, strong) FBSearchTableDelegate *searchTableDelegate;
@property (nonatomic, strong) FBSearchTableDataSource *searchTableDataSource;

// Core Data
@property (strong, nonatomic) FBDatabaseManager *databaseManager;
@property (strong, nonatomic, readwrite) NSFetchedResultsController *fetchedResultsController;

@end

@implementation FBSearchViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initializeContainers];
    }
    return self;
}

#pragma mark - Property Overrides
- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
//    NSManagedObjectContext *moc = self.databaseManager.mainThreadManagedObjectContext;
//    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:[self fetchRequestForImageItems] managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil];
//    self.fetchedResultsController = frc;
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:[self fetchRequestForImageItems] managedObjectContext:_databaseManager.mainThreadManagedObjectContext sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate = self;
    
    NSError *error = nil;
    NSAssert([_fetchedResultsController performFetch:&error], @"Unresolved error %@\n%@", [error localizedDescription], [error userInfo]);
    return _fetchedResultsController;
}

#pragma mark - Method Overrides
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup Search Bar
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.showsCancelButton = YES;
    self.searchBar.placeholder = @"Find pictures";
    self.navigationItem.titleView = self.searchBar;
    self.searchBarDelegate = [[FBSearchBarDelegate alloc] initWithFBSearchViewController:self];
    self.searchBar.delegate = self.searchBarDelegate;
    
    // Setup TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.searchTableDataSource = [[FBSearchTableDataSource alloc] initWithFBSearchViewController:self];
    self.tableView.dataSource = self.searchTableDataSource;
    self.searchTableDelegate = [[FBSearchTableDelegate alloc] initWithFBSearchViewController:self];
    self.tableView.delegate = self.searchTableDelegate;
    [self.tableView registerClass:[FBPictureCell class] forCellReuseIdentifier:pictureCellIdentifier];
    [self.view addSubview:self.tableView];
    
    // Setup PictureCell's delegate
    self.pictureCellDelegate = [[FBPictureCellDelegate alloc] initWithSearchViewController:self];
    
    // Setup Gesture Recognizer
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:self.tapRecognizer];
    
    // Initialize databaseManager
    self.databaseManager = [[FBDatabaseManager alloc] init];
    [self.databaseManager setupCoreDataStackWithCompletionHandler:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
//            [self fetchedResultsController];
            [self.fetchedResultsController performFetch:nil];
            [self.tableView reloadData];
        } else {
            NSLog(@"Core Data stack setup failed: %@", error.localizedDescription);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initializing containers, Cache and NSURLSession with dataTask
- (void)initializeContainers {
    // Initialize NSURLSession
    self.defaultSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    // Initialize caches for colorful and binarized pictures
    self.colorfulPicturesCache = [[NSMutableDictionary alloc] init];
    self.binarizedPicturesCache = [[NSMutableDictionary alloc] init];
//    self.searchResults = [NSMutableArray new];
    self.buttonStates = [NSMutableDictionary new];
}

#pragma mark - Dismiss keyboard
- (void)dismissKeyboard {
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
    }
}

#pragma mark - Logic
- (void)addImageItem:(NSDictionary *)info {
    NSManagedObject *moImageItem = [[NSManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:@"FBImageItem" inManagedObjectContext:self.databaseManager.mainThreadManagedObjectContext] insertIntoManagedObjectContext:self.databaseManager.mainThreadManagedObjectContext];
    [moImageItem setValue:info[@"numberWhenAdded"] forKey:@"numberWhenAdded"];
    [moImageItem setValue:info[@"pictureId"] forKey:@"pictureId"];
    [moImageItem setValue:info[@"secret"] forKey:@"secret"];
    [moImageItem setValue:info[@"server"] forKey:@"server"];
    [moImageItem setValue:info[@"farm"] forKey:@"farm"];
    [moImageItem setValue:info[@"urlString"] forKey:@"urlString"];
    [self.databaseManager saveDataWithCompletionHandler:^(BOOL succeeded, NSError *error) {
        if (!succeeded) {
            NSLog(@"Core Data save failed");
        }
    }];
}

- (void)addMultipleImageItems:(NSArray <NSDictionary *>*)items {
    NSManagedObjectContext *batchAddContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [batchAddContext setParentContext:self.databaseManager.mainThreadManagedObjectContext];
    [batchAddContext performBlock:^{
        for (NSInteger i = 0; i < [items count]; i++) {
            NSDictionary *info = items[i];
            NSManagedObject *moItem = [[NSManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:@"FBImageItem" inManagedObjectContext:batchAddContext] insertIntoManagedObjectContext:batchAddContext];
            [moItem setValue:info[@"numberWhenAdded"] forKey:@"numberWhenAdded"];
            [moItem setValue:info[@"pictureId"] forKey:@"pictureId"];
            [moItem setValue:info[@"secret"] forKey:@"secret"];
            [moItem setValue:info[@"server"] forKey:@"server"];
            [moItem setValue:info[@"farm"] forKey:@"farm"];
            [moItem setValue:info[@"urlString"] forKey:@"urlString"];
        }
        // Save batch context which pushes the items onto mainContext
        NSError *error = nil;
        if (![batchAddContext save:&error]) {
            NSLog(@"Unable to save batch added items: %@", [error localizedDescription]);
            return;
        }
        
        // Save main thread context
        [self.databaseManager saveDataWithCompletionHandler:^(BOOL succeeded, NSError *error) {
            if (!succeeded) {
                NSLog(@"Core Data Save failed");
            } else {
                [self.fetchedResultsController performFetch:nil];
            }
        }];
    }];
}

- (void)removeAllImageItems {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FBImageItem"];
    NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    NSError *error = nil;
    [self.databaseManager.mainThreadManagedObjectContext executeRequest:deleteRequest error:&error];
    if (error) {
        NSLog(@"Couldn't delete items from main context");
        return;
    }
    [self.databaseManager saveDataWithCompletionHandler:^(BOOL succeeded, NSError *error) {
        if (!succeeded) {
            NSLog(@"Core Data remove failed");
        } else {
            [self.fetchedResultsController performFetch:nil];
        }
    }];
}

- (NSFetchRequest *)fetchRequestForImageItems {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FBImageItem"];
    request.predicate = [NSPredicate predicateWithFormat:@"numberWhenAdded >= 0"];
    request.fetchBatchSize = 10;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"numberWhenAdded" ascending:YES]];
    return request;
}

#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

//- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
//    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:sectionIndex];
//    switch(type) {
//        case NSFetchedResultsChangeInsert:
//            [[self tableView] insertSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
//            break;
//        case NSFetchedResultsChangeDelete:
//            [[self tableView] deleteSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
//            break;
//        case NSFetchedResultsChangeMove:
//            break;
//        case NSFetchedResultsChangeUpdate:
//            break;
//    }
//}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    NSArray *newArray = nil;
    NSArray *oldArray = nil;
    
    if (newIndexPath) {
        newArray = [NSArray arrayWithObject:newIndexPath];
    }
    
    if (indexPath) {
        oldArray = [NSArray arrayWithObject:indexPath];
    }
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:newArray withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths:oldArray withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
        {
//            FBPictureCell *cell = [[self tableView] cellForRowAtIndexPath:indexPath];
//            NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
//            [[cell textLabel] setText:[object valueForKey:@"FBImageItem"]];
//            cell.urlString = [object valueForKey:@"urlString"];
            NSLog(@"cell did change update");
            break;
        }
        case NSFetchedResultsChangeMove:
//            [[self tableView] deleteRowsAtIndexPaths:oldArray withRowAnimation:UITableViewRowAnimationFade];
//            [[self tableView] insertRowsAtIndexPaths:newArray withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
