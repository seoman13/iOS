//
//  ImageDownloader.h
//  ITunesSearcher
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ISSearchViewController;
@class AVPlayerViewController;

@interface ImageDownloader : NSObject

+ (void)downloadImageAtURL:(NSURL *)url intoSearchViewController:(ISSearchViewController *)searchViewController atIndexPath:(NSIndexPath *)indexPath;
+ (void)downloadImageAtURL:(NSURL *)imageURL intoAVPlayerViewController:(AVPlayerViewController *)playerViewController;


@end
