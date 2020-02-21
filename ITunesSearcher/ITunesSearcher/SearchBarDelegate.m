//
//  SearchBarDelegate.m
//  ITunesSearcher
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "SearchBarDelegate.h"
#import "ISSearchViewController.h"
#import "DataLoader.h"

@interface SearchBarDelegate ()

@property (nonatomic, weak) ISSearchViewController *searchViewController;

@end

@implementation SearchBarDelegate

- (instancetype)initWithSearchViewController:(ISSearchViewController *)viewController {
    self = [super init];
    if (self) {
        self.searchViewController = viewController;
    }
    return self;
}

#pragma mark UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchViewController.cachedArtwork removeAllObjects];
    // Dimiss the keyboard
    [self.searchViewController dismissKeyboard];
    // Load Data into Search View Controller
    [DataLoader loadDataByTerm:searchBar.text intoSearchViewController:self.searchViewController];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.searchViewController.view addGestureRecognizer:self.searchViewController.tapRecognizer];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.searchViewController.view removeGestureRecognizer:self.searchViewController.tapRecognizer];
}

@end
