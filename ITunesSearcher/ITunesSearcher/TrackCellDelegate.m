//
//  TrackCellDelegate.m
//  ITunesSearcher
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "TrackCellDelegate.h"
#import "ISSearchViewController.h"

@interface TrackCellDelegate ()

@property (nonatomic, weak) ISSearchViewController *searchViewController;

@end

@implementation TrackCellDelegate

- (instancetype)initWithSearchViewController:(ISSearchViewController *)searchViewController {
    self = [super init];
    if (self) {
        self.searchViewController = searchViewController;
    }
    return self;
}

#pragma mark TrackCellDelegate

- (void)pauseTapped:(ISTrackCell *)cell {
    @try {
        NSIndexPath *indexPath = [self.searchViewController.tableView indexPathForCell:cell];
        ISTrack *track = self.searchViewController.searchResults[indexPath.row];
        [self.searchViewController pauseDownload:track];
        [self.searchViewController.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } @catch(NSException *exception) {
        NSLog(@"Couldn't find indexPath of the tapped cell");
    }
}

- (void)resumeTapped:(ISTrackCell *)cell {
    @try {
        NSIndexPath *indexPath = [self.searchViewController.tableView indexPathForCell:cell];
        ISTrack *track = self.searchViewController.searchResults[indexPath.row];
        [self.searchViewController resumeDownload:track];
        [self.searchViewController.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } @catch(NSException *exception) {
        NSLog(@"Couldn't find indexPath of the tapped cell");
    }
}

- (void)cancelTapped:(ISTrackCell *)cell {
    @try {
        NSIndexPath *indexPath = [self.searchViewController.tableView indexPathForCell:cell];
        ISTrack *track = self.searchViewController.searchResults[indexPath.row];
        [self.searchViewController cancelDownload:track];
        [self.searchViewController.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } @catch(NSException *exception) {
        NSLog(@"Couldn't find indexPath of the tapped cell");
    }
}

- (void)downloadTapped:(ISTrackCell *)cell {
    @try {
        NSIndexPath *indexPath = [self.searchViewController.tableView indexPathForCell:cell];
        ISTrack *track = self.searchViewController.searchResults[indexPath.row];
        [self.searchViewController startDownload:track];
        [self.searchViewController.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } @catch(NSException *exception) {
        NSLog(@"Couldn't find indexPath of the tapped cell");
    }
}


@end
