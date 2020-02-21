//
//  FBSearchPanelViewController.h
//  FlickrBrowser
//
//  Created by iOS-School-1 on 27.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@interface FBSearchPanelViewController : UIViewController

// CoreData
@property (strong, nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;

// CollectionView
@property (strong, nonatomic, readonly) UICollectionView *collectionView;
@property (strong, nonatomic, readonly) UISearchBar *searchBar;

- (void)addPictureItem:(NSDictionary *)pictureItem;
- (void)addMultiplePictureItems:(NSArray <NSDictionary *> *)pictureItems;
- (void)deleteAllPictureItems;

- (void)dismissKeyboard;
- (void)reloadCollectionView;

@end
