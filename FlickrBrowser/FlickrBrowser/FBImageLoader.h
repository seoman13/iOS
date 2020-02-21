//
//  FBImageLoader.h
//  FlickrBrowser
//
//  Created by Admin on 26.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImageView;
@class UIImage;

typedef void(^FBImageHandler)(void);
typedef void(^FBImageHandlerWithImage)(UIImage *);

typedef NS_ENUM(NSInteger, FBPictureItemImageSize) {
    FBPictureItemImageSizeAvatar,
    FBPictureItemImageSizeSmall,
    FBPictureItemImageSizeMedium,
    FBPictureItemImageSizeLarge
};

@interface FBImageLoader : NSObject

@property (nonatomic, readonly) BOOL isDownloading;

- (void)loadImageAtAddress:(NSURL *)baseImageURL desiredSize:(FBPictureItemImageSize)desiredSize forImageView:(UIImageView *)imageView handler:(FBImageHandler)handler;

- (void)loadImageAtAddress:(NSURL *)baseImageURL desiredSize:(FBPictureItemImageSize)desiredSize handler:(FBImageHandlerWithImage)handler;
@end
