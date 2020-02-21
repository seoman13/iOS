//
//  FBImageLoader.m
//  FlickrBinarization
//
//  Created by Admin on 17.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "FBImageLoader.h"
#import "FBSearchViewController.h"
#import "ImageLoadingOperation.h"

@implementation FBImageLoader

+ (void)loadImageAtURL:(NSString *)urlString IntoSearchViewController:(FBSearchViewController *)searchViewController atIndexPath:(NSIndexPath *)indexPath {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    ImageLoadingOperation *loadingOperation = [[ImageLoadingOperation alloc] initWithURLString:urlString searchViewController:searchViewController indexPath:indexPath];
    [queue addOperation:loadingOperation];
}

@end
