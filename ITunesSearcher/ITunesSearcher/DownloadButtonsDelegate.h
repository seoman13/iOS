//
//  DownloadButtonsDelegate.h
//  ITunesSearcher
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ISSearchViewController;
@class ISTrack;

@interface DownloadButtonsDelegate : NSObject

- (instancetype)initWithSearchViewController:(ISSearchViewController *)searchViewController;

// Methods when buttons tapped
- (void)startDownload:(ISTrack *)track;
- (void)pauseDownload:(ISTrack *)track;
- (void)cancelDownload:(ISTrack *)track;
- (void)resumeDownload:(ISTrack *)track;
- (void)playDownload:(ISTrack *)track;

@end
