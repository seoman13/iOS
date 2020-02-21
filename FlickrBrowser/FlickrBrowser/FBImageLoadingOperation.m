//
//  FBImageLoadingOperation.m
//  FlickrBrowser
//
//  Created by Admin on 26.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "FBImageLoadingOperation.h"
#import <UIKit/UIKit.h>
#import "FBImageCropper.h"
#import "FBImageManager.h"

@interface FBImageLoadingOperation ()

@property (strong, nonatomic) NSURL *imageURL;
@property (weak, nonatomic) UIImageView *imageView;
@property (nonatomic) FBPictureItemImageSize desiredSize;
@property (nonatomic) FBImageHandler handler;

@end

@implementation FBImageLoadingOperation

- (instancetype)initWithImageURL:(NSURL *)imageURL desiredSize:(FBPictureItemImageSize)desiredSize forImageView:(UIImageView *)imageView handler:(FBImageHandler)handler {
    self = [super init];
    if (self) {
        _imageURL = imageURL;
        _imageView = imageView;
        _desiredSize = desiredSize;
        _handler = handler;
    }
    return self;
}

- (void)main {
    NSURLSessionDataTask *dataTask = [[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]] dataTaskWithURL:self.imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                if (data) {
                    UIImage *image = [UIImage imageWithData:data];
                    if (image) {
                        image = [FBImageCropper cropImage:image];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[FBImageManager sharedManager] addImage:image toCacheForURL:self.imageURL];
                            if (!self.isCancelled && self.imageView.image == nil) {
//                                self.imageView.image = image;
                                self.handler();
                            }
                        });
                    } else {
                        NSLog(@"Couldn't parse image from data");
                    }
                } else {
                    NSLog(@"Recieved no data");
                }
            } else {
                NSLog(@"Server error: %lu", httpResponse.statusCode);
            }
        } else {
            NSLog(@"Couldn't load image data: %@", error.localizedDescription);
        }
    }];
    [dataTask resume];
}

@end
