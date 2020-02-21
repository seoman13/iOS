//
//  FBSearchPanelViewController.m
//  FlickrBrowser
//
//  Created by iOS-School-1 on 27.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "FBSearchPanelViewController.h"
#import "FBSettingsViewController.h"

#import <Masonry/Masonry.h>
#import <UIKit/UIKit.h>

#import "FBSearchBarDelegate.h"
#import "FBCollectionViewDelegate.h"
#import "FBCustomCollectionViewLayout.h"
#import "FBPictureCell.h"

#import "FBDatabaseManager.h"
#import "FBPictureItem.h"

@interface FBSearchPanelViewController () <NSFetchedResultsControllerDelegate>

// Visual interface
@property (strong, nonatomic, readwrite) UISearchBar *searchBar;
@property (strong, nonatomic, readwrite) UICollectionView *collectionView;
@property (strong, nonatomic) UIButton *settingsButton;

// Containers
@property (strong, nonatomic) NSMutableDictionary<NSString *, UIImage *> *picturesCache;

// CoreData
@property (strong, nonatomic) FBDatabaseManager *databaseManager;
@property (strong, nonatomic, readwrite) NSFetchedResultsController *fetchedResultsController;

// Delegates
@property (strong, nonatomic) FBSearchBarDelegate *searchBarDelegate;
@property (strong, nonatomic) FBCollectionViewDelegate *collectionViewDelegate;

@end

@implementation FBSearchPanelViewController

#pragma mark - Properties overriding
- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController) return _fetchedResultsController;
    
    NSManagedObjectContext *moc = _databaseManager.mainThreadManagedObjectContext;
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:[self fetchPictureItems] managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController = frc;
    _fetchedResultsController.delegate = self;
    
    NSError *error = nil;
    NSAssert([_fetchedResultsController performFetch:&error], @"Unresolved error: %@\n%@", error.localizedDescription, error.userInfo);
    
    return _fetchedResultsController;
}

#pragma mark - Initialization
- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"icFeed"];
        self.title = @"";
        self.tabBarItem.title = @"Лента";
        [self initializeContainers];
    }
    return self;
}

- (void)initializeContainers {
    _picturesCache = [NSMutableDictionary new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Setup CoreData Stack
    self.databaseManager = [[FBDatabaseManager alloc] initWithModelName:@"Model"];
    [self.databaseManager setupCoreDataStackWithCompletionHandler:^(BOOL succeeded, NSError *error) {
        if (!succeeded) {
            NSLog(@"Couldn't Setup CoreData Stack. Error: %@", error.localizedDescription);
        } else {
            [self fetchedResultsController];
            NSError *err = nil;
            [self.fetchedResultsController performFetch:&err];
            if (err) {
                NSLog(@"Couldn't fetch data after new launch of the app. Error: %@", err.localizedDescription);
            }
        }
    }];
    
    // Setup SearchBar
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"rectangle121"] forState:UIControlStateNormal];
    [self.searchBar sizeToFit];
    self.navigationItem.titleView = self.searchBar;
    self.searchBarDelegate = [[FBSearchBarDelegate alloc] initWithSearchPanelViewController:self];
    self.searchBar.delegate = self.searchBarDelegate;
    
    UITextField *searchTextField = [self.searchBar valueForKey:@"_searchField"];
    searchTextField.font = [UIFont fontWithName:@"SFUIText-Regular" size:14.0];
    [searchTextField setBackgroundColor:[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0]];
    [searchTextField setTextAlignment:NSTextAlignmentLeft];
    NSMutableAttributedString *attPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"Поиск"];
    [attPlaceholder addAttribute:NSKernAttributeName value:@(-0.3) range:NSMakeRange(0, 5)];
    [searchTextField setAttributedPlaceholder:attPlaceholder];
    [searchTextField setTextColor:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]];
    
    // Setup rightBarButtonItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icSettings"] style:UIBarButtonItemStylePlain target:self action:@selector(settingsButtonClicked:)];
    
    // Setup observer to monitor device's orientation
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
    
    // Setup UICollectionView
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 10, 10, 10);
    flowLayout.itemSize = CGSizeMake(124, 124);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    // Custom UICollectionViewLoayout
    FBCustomCollectionViewLayout *customLayout = [[FBCustomCollectionViewLayout alloc] init];
    
//    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:customLayout];
    self.collectionViewDelegate = [[FBCollectionViewDelegate alloc] initWithSearchPanelViewController:self];
    self.collectionView.delegate = self.collectionViewDelegate;
    self.collectionView.dataSource = self.collectionViewDelegate;
    [self.collectionView registerClass:[FBPictureCell class] forCellWithReuseIdentifier:pictureCellIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(1, 1, 1, 1);
    [self.view addSubview:self.collectionView];
}

- (void)viewDidAppear:(BOOL)animated {
    UITextField *textFieldInsideSearchBar = [self.searchBar valueForKey:@"_searchField"];
    CGFloat textFieldHeight = CGRectGetHeight(textFieldInsideSearchBar.frame);
    textFieldInsideSearchBar.borderStyle = UITextBorderStyleRoundedRect;
    textFieldInsideSearchBar.layer.cornerRadius = textFieldHeight / 2;
    textFieldInsideSearchBar.clipsToBounds = YES;
    [super viewDidAppear:animated];
}

#pragma mark - User Interactions
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.searchBar isFirstResponder] && [touch view] != self.searchBar) {
        [self.searchBar resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)settingsButtonClicked:(UIBarButtonItem *)button {
    FBSettingsViewController *vc = [FBSettingsViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dismissKeyboard {
    if ([_searchBar isFirstResponder]) {
        [_searchBar resignFirstResponder];
    }
}

- (void)reloadCollectionView {
    [self.collectionView reloadData];
}

#pragma mark - CoreData Logic
- (void)addPictureItem:(NSDictionary *)pictureItem {
    NSDictionary *info = pictureItem;
    NSManagedObject *itemMO = [[NSManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:@"FBPictureItem" inManagedObjectContext:self.databaseManager.mainThreadManagedObjectContext] insertIntoManagedObjectContext:self.databaseManager.mainThreadManagedObjectContext];
    [itemMO setValue:info[@"avatarUrlString"] forKey:@"avatarUrlString"];
//    [itemMO setValue:info[@"numOfFavs"] forKey:@"numOfFavs"];
    [itemMO setValue:info[@"pictureId"] forKey:@"pictureId"];
    [itemMO setValue:info[@"pictureDescription"] forKey:@"pictureDescription"];
    [itemMO setValue:info[@"pictureUrlString"] forKey:@"pictureUrlString"];
    [itemMO setValue:info[@"placeId"] forKey:@"placeId"];
    [itemMO setValue:info[@"sortNumber"] forKey:@"sortNumber"];
    [itemMO setValue:info[@"userName"] forKey:@"userName"];
    [itemMO setValue:info[@"views"] forKey:@"views"];
    
    // Save changes all the way to the store
    [self.databaseManager saveDataWithCompletionHandler:^(BOOL succeeded, NSError *error) {
        if (!succeeded) {
            NSLog(@"Couldn't save batchAddContext changes to the store, %@ %@", error.localizedDescription, error.userInfo);
        } else {
            if (![self.fetchedResultsController performFetch:&error]) {
                NSLog(@"Error fetching after removing all data %@", error.localizedDescription);
            }
        }
    }];
}

- (void)addMultiplePictureItems:(NSArray <NSDictionary *> *)pictureItems {
    NSManagedObjectContext *batchAddContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [batchAddContext setParentContext:self.databaseManager.mainThreadManagedObjectContext];
    [batchAddContext performBlock:^{
        for (NSInteger i = 0; i < [pictureItems count]; i++) {
            NSDictionary *info = pictureItems[i];
            NSManagedObject *itemMO = [[NSManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:@"FBPictureItem" inManagedObjectContext:batchAddContext] insertIntoManagedObjectContext:batchAddContext];
            [itemMO setValue:info[@"avatarUrlString"] forKey:@"avatarUrlString"];
//            [itemMO setValue:info[@"numOfFavs"] forKey:@"numOfFavs"];
            [itemMO setValue:info[@"pictureId"] forKey:@"pictureId"];
            [itemMO setValue:info[@"pictureDescription"] forKey:@"pictureDescription"];
            [itemMO setValue:info[@"pictureUrlString"] forKey:@"pictureUrlString"];
            [itemMO setValue:info[@"placeId"] forKey:@"placeId"];
            [itemMO setValue:info[@"sortNumber"] forKey:@"sortNumber"];
            [itemMO setValue:info[@"userName"] forKey:@"userName"];
            [itemMO setValue:info[@"views"] forKey:@"views"];
        }
        // Save batchAddContext
        NSError *error = nil;
        if (![batchAddContext save:&error]) {
            NSLog(@"Unable to save batchAddContext %@", error.localizedDescription);
            return;
        };
        
        // Save changes all the way to the store
        [self.databaseManager saveDataWithCompletionHandler:^(BOOL succeeded, NSError *error) {
            if (!succeeded) {
                NSLog(@"Couldn't save batchAddContext changes to the store, %@ %@", error.localizedDescription, error.userInfo);
            } else {
                if (![self.fetchedResultsController performFetch:&error]) {
                    NSLog(@"Error fetching after removing all data %@", error.localizedDescription);
                } else {
                    [self reloadCollectionView];
                }
            }
        }];
    }];
}

- (void)deleteAllPictureItems {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FBPictureItem"];
    NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    NSError *error = nil;
    [self.databaseManager.mainThreadManagedObjectContext executeRequest:deleteRequest error:&error];
    if (error) {
        NSLog(@"Couldn't remove picture items from context");
        return;
    }
    
    [self.databaseManager saveDataWithCompletionHandler:^(BOOL succeeded, NSError *error) {
        if (!succeeded) {
            NSLog(@"Couldn't save data to main context. Error: %@", error.localizedDescription);
        } else {
            NSError *err = nil;
            [self.fetchedResultsController performFetch:&err];
            if (err) {
                NSLog(@"Couldn't fetch data after deleting all picture items");
            }
        }
    }];
}

- (NSFetchRequest *)fetchPictureItems {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FBPictureItem"];
    request.predicate = [NSPredicate predicateWithFormat:@"sortNumber >= 0"];
    request.fetchBatchSize = 20;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"sortNumber" ascending:YES]];
    return request;
}

#pragma mark - DeviceOrientationObserver
- (void)orientationChanged:(NSNotification *)note {
    UIDevice *device = note.object;
    switch(device.orientation) {
        case UIDeviceOrientationPortrait:
            self.searchBar.layer.cornerRadius = CGRectGetHeight(self.searchBar.bounds) / 2;
            break;
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
            self.searchBar.layer.cornerRadius = CGRectGetHeight(self.searchBar.bounds) / 2;
            break;
        default:
            break;
    }
}

@end
