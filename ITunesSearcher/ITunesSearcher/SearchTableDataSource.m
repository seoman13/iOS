//
//  SearchTableDataSource.m
//  ITunesSearcher
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "SearchTableDataSource.h"
#import "ISSearchViewController.h"
#import "ISTrackCell.h"
#import "ISTrack.h"
#import "ISDownload.h"
#import "ImageDownloader.h"
#import "DownloadHelper.h"
#import "TrackCellDelegate.h"

@interface SearchTableDataSource ()

@property (nonatomic, weak) ISSearchViewController *searchViewController;

@end

@implementation SearchTableDataSource

- (instancetype)initWithSearchViewController:(ISSearchViewController *)viewController {
    self = [super init];
    if (self) {
        self.searchViewController = viewController;
    }
    return self;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchViewController.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ISTrackCell *cell = (ISTrackCell *)[self.searchViewController.tableView dequeueReusableCellWithIdentifier:trackCellIdentifier forIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
    
    if (cell == nil) {
        cell = [[ISTrackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:trackCellIdentifier];
    }
    // Delegate cell button tap events
    cell.delegate = self.searchViewController.trackCellDelegate;
    ISTrack *track = self.searchViewController.searchResults[indexPath.row];
    
    // Configure title and artist labels
    cell.titleLabel.text = track.name;
    cell.artistLabel.text = track.artist;
    cell.priceLabel.text = [NSString stringWithFormat:@" %@ ", track.trackPrice];
    
    // Remove current image
    cell.myImageView.image = nil;
    
    // Check if we've already cached this picture, if Yes - set it, if No - load it
    if ([self.searchViewController.cachedArtwork objectForKey:track.artworkUrl60]) {
//        cell.myImageView.image = self.searchViewController.cachedArtwork[track.artworkUrl60];
        cell.myImageView.image = [self.searchViewController.cachedArtwork objectForKey:track.artworkUrl60];
    } else {
        [cell.activityIndicator startAnimating];
        // Download image
        NSURL *imageURL = [NSURL URLWithString:track.artworkUrl60];
        [ImageDownloader downloadImageAtURL:imageURL intoSearchViewController:self.searchViewController atIndexPath:indexPath];
    }
    
    // Check if no artwork is present
    if (cell.myImageView.image == nil) {
        [cell.activityIndicator startAnimating];
    }
    
    // If the track is already downloaded, enable cell selection and hide the Download button
    BOOL downloaded = [DownloadHelper localFileExistsForTrack:track];
    BOOL showDownloadControls = NO;
    
    // Check if current download is downloading
    ISDownload *download = self.searchViewController.activeDownloads[track.previewURL];
    if (download != nil) {
        showDownloadControls = YES;
        cell.progressView.progress = download.progress.doubleValue;
        cell.progressLabel.text = download.isDownloading ? @"Downloading..." : @"Paused";
    }
    // Set buttons and progress
    cell.progressView.hidden = !showDownloadControls;
    cell.progressLabel.hidden = !showDownloadControls;
    cell.selectionStyle = downloaded ? UITableViewCellSelectionStyleGray : UITableViewCellSelectionStyleNone;
    cell.downloadButton.hidden = downloaded || showDownloadControls;
    
    NSString *title = download.isDownloading ? @"Pause" : @"Resume";
    [cell.pauseButton setTitle:title forState:UIControlStateNormal];
    cell.pauseButton.hidden = !showDownloadControls;
    cell.cancelButton.hidden = !showDownloadControls;
//    cell.playButton.hidden = !downloaded;
    
    return cell;
}

@end
