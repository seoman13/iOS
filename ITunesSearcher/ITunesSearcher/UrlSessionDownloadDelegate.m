//
//  UrlSessionDownloadDelegate.m
//  ITunesSearcher
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "UrlSessionDownloadDelegate.h"
#import "ISSearchViewController.h"
#import "ISDownload.h"
#import "ISTrackCell.h"
#import "DownloadHelper.h"
//#import "AppDelegate.h"

@interface UrlSessionDownloadDelegate ()

@property (nonatomic, weak) ISSearchViewController *searchViewController;

@end

@implementation UrlSessionDownloadDelegate

- (instancetype)initWithSearchViewController:(ISSearchViewController *)searchViewController {
    self = [super init];
    if (self) {
        self.searchViewController = searchViewController;
    }
    return self;
}

#pragma mark NSURLDownloadSessionDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    // 1
    @try {
        NSString *originalURL = downloadTask.originalRequest.URL.absoluteString;
        if (originalURL != nil) {
            NSURL *destinationURL = [DownloadHelper localFilePathForUrl:originalURL];
            NSLog(@"%@", destinationURL);
            
            // 2
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSError *error = nil;
            @try {
                [fileManager removeItemAtURL:destinationURL error:&error];
            } @catch (NSException *exception) {
                NSLog(@"Couldn't find file to remove");
            }
            @try {
                [fileManager copyItemAtURL:location toURL:destinationURL error:&error];
            } @catch (NSException *exception) {
                NSLog(@"Could not copy file to disk: %@", error);
            }
            NSLog(@"Exists: %i", [fileManager fileExistsAtPath:[destinationURL path]]);
        }
        // 3
        NSString *url = downloadTask.originalRequest.URL.absoluteString;
        if (url != nil) {
            self.searchViewController.activeDownloads[url] = nil;
            
            // 4
            NSNumber *trackIndex = [DownloadHelper trackIndexForDownloadTask:downloadTask forSearchViewController:self.searchViewController];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.searchViewController.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:trackIndex.integerValue inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            });
        }
    } @catch (NSException *exception) {
        NSLog(@"Could not process downloaded file: %@", exception);
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    // Get Download url string and get download from active Downloads
    NSString *downloadURL = downloadTask.originalRequest.URL.absoluteString;
    if (downloadURL != nil) {
        ISDownload *download = self.searchViewController.activeDownloads[downloadURL];
        // 2
        download.progress = [NSNumber numberWithDouble:(Float64)totalBytesWritten / (Float64)totalBytesExpectedToWrite];
        NSString *totalSize = [NSByteCountFormatter stringFromByteCount:totalBytesExpectedToWrite countStyle:NSByteCountFormatterCountStyleBinary];
        
        // 4
        NSNumber *trackIndex = [DownloadHelper trackIndexForDownloadTask:downloadTask forSearchViewController:self.searchViewController];
        __block ISTrackCell *trackCell = [self.searchViewController.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:trackIndex.integerValue inSection:0]];
        
        // 5
        dispatch_async(dispatch_get_main_queue(), ^{
            trackCell.progressView.progress = download.progress.doubleValue;
            trackCell.progressLabel.text = [NSString stringWithFormat:@"%.1f%% of %@", download.progress.doubleValue * 100, totalSize];
        });
    }
}

//- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if (appDelegate != nil) {
//        CompletionHandler completionHandler = appDelegate.backgroundSessionCompletionHandler;
//        if (completionHandler != nil) {
//            appDelegate.backgroundSessionCompletionHandler = nil;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                completionHandler();
//            });
//        }
//    }
//}

@end
