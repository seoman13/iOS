//
//  SearchTableDelegate.m
//  ITunesSearcher
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "SearchTableDelegate.h"
#import "ISSearchViewController.h"
#import "ISTrack.h"
#import "DownloadHelper.h"

@interface SearchTableDelegate ()

@property (nonatomic, weak) ISSearchViewController *searchViewController;

@end

@implementation SearchTableDelegate

- (instancetype)initWithSearchViewController:(ISSearchViewController *)viewController {
    self = [super init];
    if (self) {
        self.searchViewController = viewController;
    }
    return self;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 62.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ISTrack *track = self.searchViewController.searchResults[indexPath.row];
    if ([DownloadHelper localFileExistsForTrack:track]) {
        [self.searchViewController playDownload:track];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == [self.searchViewController.searchResults count]) {
//        
//    }
//}

@end
