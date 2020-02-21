//
//  FBSearchBarDelegate.m
//  FlickrBinarization
//
//  Created by Admin on 17.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "FBSearchBarDelegate.h"
#import "FBSearchViewController.h"
#import "FBDataLoader.h"

@interface FBSearchBarDelegate ()

@property (nonatomic, weak) FBSearchViewController *searchViewController;

@end

@implementation FBSearchBarDelegate

- (instancetype)initWithFBSearchViewController:(FBSearchViewController *)searchViewController {
    self = [super init];
    if (self) {
        self.searchViewController = searchViewController;
    }
    return self;
}

// Search button clicked
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchViewController dismissKeyboard];
//    [self.searchViewController.searchResults removeAllObjects];
    [self.searchViewController removeAllImageItems];
    [self.searchViewController.buttonStates removeAllObjects];
    [FBDataLoader loadDataByTerm:searchBar.text andPageNumber:[NSNumber numberWithInt:1] intoFBSearchViewController:self.searchViewController];
}

// Cancel button clicked
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchViewController dismissKeyboard];
}

@end
