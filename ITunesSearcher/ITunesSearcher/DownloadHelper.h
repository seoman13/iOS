//
//  DownloadHelper.h
//  ITunesSearcher
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ISSearchViewController;
@class ISTrack;

@interface DownloadHelper : NSObject

+ (nullable NSURL *)localFilePathForUrl:(nonnull NSString *)previewUrl;
+ (BOOL)localFileExistsForTrack:(nonnull ISTrack *)track;
+ (nullable NSNumber *)trackIndexForDownloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask forSearchViewController:(nonnull ISSearchViewController *)searchViewController;

@end
