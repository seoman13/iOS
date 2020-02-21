//
//  UrlSessionDownloadDelegate.h
//  ITunesSearcher
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ISSearchViewController;

@interface UrlSessionDownloadDelegate : NSObject <NSURLSessionDownloadDelegate, NSURLSessionDelegate>

- (instancetype)initWithSearchViewController:(ISSearchViewController *)searchViewController;

@end
