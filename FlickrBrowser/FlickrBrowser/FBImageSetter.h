//
//  FBImageSetter.h
//  FlickrBrowser
//
//  Created by Admin on 26.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBImageLoader.h"
@class UIImage;
@class UIImageView;

@interface FBImageSetter : NSObject

- (void)setImageFromAddress:(NSString *)baseImageURL desiredSize:(FBPictureItemImageSize)desiredSize forImageView:(UIImageView *)imageView handler:(FBImageHandler)handler;

@end
