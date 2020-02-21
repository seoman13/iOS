//
//  ISDownload.h
//  ITunesSearcher
//
//  Created by Admin on 12.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISDownload : NSObject

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, assign) BOOL isDownloading;
@property (nonatomic, strong) NSNumber *progress;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSData *resumeData;

- (instancetype)initWithURL:(NSURL *)url;

@end
