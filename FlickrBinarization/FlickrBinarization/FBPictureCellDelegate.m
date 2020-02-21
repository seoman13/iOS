//
//  FBPictureCellDelegate.m
//  FlickrBinarization
//
//  Created by Admin on 19.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "FBPictureCellDelegate.h"
#import "FBSearchViewController.h"

@interface FBPictureCellDelegate ()

@property (weak, nonatomic) FBSearchViewController *searchViewController;

@end

@implementation FBPictureCellDelegate

- (instancetype)initWithSearchViewController:(FBSearchViewController *)searchViewController {
    self = [super init];
    if (self) {
        _searchViewController = searchViewController;
    }
    return self;
}

- (void)binarizationButtonClicked:sender forImageUrlString:urlString {
    NSNumber *state = self.searchViewController.buttonStates[urlString];
    if (state == nil || [state isEqualToNumber:@NO]) {
        self.searchViewController.buttonStates[urlString] = @YES;
        [self.searchViewController.tableView reloadData];
    } else {
        self.searchViewController.buttonStates[urlString] = @NO;
        [self.searchViewController.tableView reloadData];
    }
}

@end
