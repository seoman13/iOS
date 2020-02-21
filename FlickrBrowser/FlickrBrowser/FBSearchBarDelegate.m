//
//  FBSearchBarDelegate.m
//  FlickrBrowser
//
//  Created by Admin on 23.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "FBSearchBarDelegate.h"
#import "FBSearchPanelViewController.h"
#import "FBDataLoaderFromFlickr.h"
#import "FBImageManager.h"
#import "FBRouter.h"
#import "FBDataParser.h"

@interface FBSearchBarDelegate ()

@property (weak, nonatomic) FBSearchPanelViewController *searchPanelViewController;

@end

@implementation FBSearchBarDelegate

- (instancetype)initWithSearchPanelViewController:(FBSearchPanelViewController *)searchPanelViewController {
    self = [super init];
    if (self) {
        _searchPanelViewController = searchPanelViewController;
    }
    return self;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchPanelViewController dismissKeyboard];
    [self.searchPanelViewController deleteAllPictureItems];
    [self.searchPanelViewController.collectionView reloadData];
    [[FBImageManager sharedManager] removeAllImagesFromCache];
    [self searchNewPicturesWithQuery:searchBar.text];
}

- (void)searchNewPicturesWithQuery:(NSString *)query {
    NSURLRequest *newSearchRequest = [FBRouter newPicturesSearchRequestWithQuery:query atPage:1];
    [FBDataLoaderFromFlickr getDataWithRequest:newSearchRequest andPage:1 success:^(NSData *data, NSInteger page) {
        [FBDataParser parsePicturesSearchFromData:data page:page success:^(NSArray<NSDictionary *> *infoArray) {
            [self.searchPanelViewController addMultiplePictureItems:infoArray];
        } failure:^(NSError *err) {
            NSLog(@"Couldn't parse search data. Error: %@", err.localizedDescription);
        }];
    } failure:^(NSError *error) {
        NSLog(@"Couldn't load data. Error: %@", error.localizedDescription);
    }];
}

@end
