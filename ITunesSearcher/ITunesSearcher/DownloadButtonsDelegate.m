//
//  DownloadButtonsDelegate.m
//  ITunesSearcher
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "DownloadButtonsDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ISSearchViewController.h"
#import "ISTrack.h"
#import "ISDownload.h"
#import "DownloadHelper.h"
#import "ImageDownloader.h"

@interface DownloadButtonsDelegate ()

@property (nonatomic, weak) ISSearchViewController *searchViewController;

@end

@implementation DownloadButtonsDelegate

- (instancetype)initWithSearchViewController:(ISSearchViewController *)searchViewController {
    self = [super init];
    if (self) {
        self.searchViewController = searchViewController;
    }
    return self;
}

#pragma mark Download methods

// Called when the Download button for a track is tapped
- (void)startDownload:(ISTrack *)track {
    NSURL *url = [NSURL URLWithString:track.previewURL];
    ISDownload *download = [[ISDownload alloc] initWithURL:url];
    download.downloadTask = [self.searchViewController.downloadsSession downloadTaskWithURL:url];
    [download.downloadTask resume];
    download.isDownloading = YES;
    self.searchViewController.activeDownloads[download.url.absoluteString] = download;
}

// Called when the Pause button for a track is tapped
- (void)pauseDownload:(ISTrack *)track {
    NSString *urlString = track.previewURL;
    __block ISDownload *download = self.searchViewController.activeDownloads[urlString];
    if (download.isDownloading) {
        [download.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            if (resumeData != nil) {
                download.resumeData = resumeData;
            }
        }];
        download.isDownloading = NO;
    }
}

// Called when the Cancel button for a track is tapped
- (void)cancelDownload:(ISTrack *)track {
    NSString *urlString = track.previewURL;
    ISDownload *download = self.searchViewController.activeDownloads[urlString];
    [download.downloadTask cancel];
    self.searchViewController.activeDownloads[urlString] = nil;
}

// Called when the Resume button for a track is tapped
- (void)resumeDownload:(ISTrack *)track {
    NSString *urlString = track.previewURL;
    ISDownload *download = self.searchViewController.activeDownloads[urlString];
    NSData *resumeData = download.resumeData;
    if (resumeData != nil) {
        download.downloadTask = [self.searchViewController.downloadsSession downloadTaskWithResumeData:resumeData];
        [download.downloadTask resume];
        download.isDownloading = YES;
    } else {
        NSURL *url = download.url;
        download.downloadTask = [self.searchViewController.downloadsSession downloadTaskWithURL:url];
        [download.downloadTask resume];
        download.isDownloading = YES;
    }
}

// This method attempts to play the local file (if it exists) when the cell is tapped
- (void)playDownload:(ISTrack *)track {
    if ([track.previewURL  compare:@""] != NSOrderedSame) {
        NSURL *url = [DownloadHelper localFilePathForUrl:track.previewURL];
        AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
        [self.searchViewController.navigationController presentViewController:controller animated:YES completion:nil];
        AVPlayer *player = [AVPlayer playerWithURL:url];
        controller.player = player;
        [ImageDownloader downloadImageAtURL:[NSURL URLWithString:track.artworkUrl100] intoAVPlayerViewController:controller];
        [player play];
    }
}

@end
