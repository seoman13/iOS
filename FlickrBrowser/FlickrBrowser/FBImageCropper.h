//
//  FBImageCropper.h
//  FlickrBrowser
//
//  Created by Admin on 26.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;

@interface FBImageCropper : NSObject

+ (UIImage *)cropImage:(UIImage *)baseImage;

@end
