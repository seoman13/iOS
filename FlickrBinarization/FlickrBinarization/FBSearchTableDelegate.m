//
//  SearchTableDelegate.m
//  FlickrBinarization
//
//  Created by Admin on 17.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "FBSearchTableDelegate.h"
#import "FBSearchViewController.h"
#import "FBDataLoader.h"
@import CoreData;

@interface FBSearchTableDelegate ()

@property (nonatomic, weak) FBSearchViewController *searchViewController;

@end

@implementation FBSearchTableDelegate

- (instancetype)initWithFBSearchViewController:(FBSearchViewController *)searchViewController {
    self = [super init];
    if (self) {
        self.searchViewController = searchViewController;
    }
    return self;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetWidth([UIScreen mainScreen].bounds);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == [self.searchViewController.searchResults count] - 1) {
//        NSNumber *page = [NSNumber numberWithLong:[self.searchViewController.searchResults count] / 20 + 1];
//        [FBDataLoader loadDataByTerm:self.searchViewController.searchBar.text andPageNumber:page intoFBSearchViewController:self.searchViewController];
//    }
    if ((indexPath.row == [self.searchViewController.fetchedResultsController.fetchedObjects count] - 2) && ![self.searchViewController.searchBar.text isEqualToString:@""]) {
        NSNumber *page = [NSNumber numberWithLong:[self.searchViewController.fetchedResultsController.fetchedObjects count] / 20 + 1];
        [FBDataLoader loadDataByTerm:self.searchViewController.searchBar.text andPageNumber:page intoFBSearchViewController:self.searchViewController];
        NSLog(@"%lu", [self.searchViewController.fetchedResultsController.fetchedObjects count]);
        NSLog(@"Page: %@", page);
    }
}

@end
