//
//  FBSearchViewController.h
//  FlickrBinarization
//
//  Created by Admin on 17.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FBImageItem;
@class NSFetchedResultsController;
@class FBPictureCellDelegate;
#import "FBPictureCell.h"

@interface FBSearchViewController : UIViewController
// Visual
@property (strong, nonatomic, readonly) UISearchBar *searchBar;
// TableView
@property (nonatomic, strong) UITableView *tableView;

// NSURLSession and current NSURLSessionDataTask
@property (nonatomic, strong) NSURLSession *defaultSession;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

// Containers and Cache
//@property (nonatomic, strong) NSMutableArray *searchResults;
@property (strong, nonatomic) NSMutableDictionary <NSString *, NSNumber *> *buttonStates;
//@property (nonatomic, strong) NSCache *colorfulPicturesCache;
//@property (nonatomic, strong) NSCache *binarizedPicturesCache;
@property (strong, nonatomic) NSMutableDictionary *colorfulPicturesCache;
@property (nonatomic, strong) NSMutableDictionary *binarizedPicturesCache;

// FetchedResultsController
@property (nonatomic, strong, readonly) NSFetchedResultsController *fetchedResultsController;

// TableCell's delegate
@property (nonatomic, strong) id <FBPictureCellDelegate> pictureCellDelegate;

- (void)dismissKeyboard;
- (void)addImageItem:(NSDictionary *)info;
- (void)addMultipleImageItems:(NSMutableArray <NSDictionary *> *) items;
- (void)removeAllImageItems;

@end
