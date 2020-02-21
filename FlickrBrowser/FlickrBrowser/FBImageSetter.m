//
//  FBImageSetter.m
//  FlickrBrowser
//
//  Created by Admin on 26.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "FBImageSetter.h"
#import <UIKit/UIKit.h>
#import "FBImageManager.h"

@interface FBImageSetter ()

@property (weak, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) FBImageLoader *imageLoader;

@end

@implementation FBImageSetter

- (instancetype)init {
    self = [super init];
    if (self) {
        _imageLoader = [[FBImageLoader alloc] init];
    }
    return self;
}

- (void)setImageFromAddress:(NSString *)baseImageURL desiredSize:(FBPictureItemImageSize)desiredSize forImageView:(UIImageView *)imageView handler:(FBImageHandler)handler{
    NSURL *imageURL = [NSURL URLWithString:baseImageURL];
    self.imageView = imageView;
    FBImageManager *imageManager = [FBImageManager sharedManager];
    if ([imageManager cachedImageExistsForURL:imageURL]) {
        self.imageView.image = [imageManager cachedImageForURL:imageURL];
    } else {
        [self.imageLoader loadImageAtAddress:imageURL desiredSize:desiredSize forImageView:self.imageView handler:handler];
    }
}

@end
