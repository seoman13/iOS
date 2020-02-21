//
//  ImageCropper.m
//  ITunesSearcher
//
//  Created by Admin on 16.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "ImageCropper.h"

@implementation ImageCropper

+ (UIImage *)cropImage:(UIImage *)baseImage {
    CGFloat width = baseImage.size.width;
    CGFloat height = baseImage.size.height;
    CGRect croppedRect;
    UIImage *croppedImage = baseImage;
    
    if (width > height) {
        CGFloat diff = width - height;
        croppedRect = CGRectMake(diff / 2, 0, width - diff, height);
        CGImageRef imageRef = CGImageCreateWithImageInRect([baseImage CGImage], croppedRect);
        croppedImage = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
    } else if (height > width) {
        CGFloat diff = height - width;
        croppedRect = CGRectMake(0, diff / 2, width, height - diff);
        CGImageRef imageRef = CGImageCreateWithImageInRect([baseImage CGImage], croppedRect);
        croppedImage = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
    }
    return croppedImage;
}

@end
