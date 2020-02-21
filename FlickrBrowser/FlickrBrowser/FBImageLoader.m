//
//  FBImageLoader.m
//  FlickrBrowser
//
//  Created by Admin on 26.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "FBImageLoader.h"
#import "FBImageLoadingOperation.h"
#import <UIKit/UIKit.h>

@interface FBImageLoader()

@property (strong, nonatomic) NSURL *baseImageURL;
@property (weak, nonatomic) UIImageView *imageView;
@property (nonatomic) FBPictureItemImageSize desiredSize;
@property (nonatomic, readwrite) BOOL isDownloading;
@property (strong, nonatomic) FBImageLoadingOperation *imageLoadingOperation;
@property (strong, nonatomic) NSOperationQueue *imageDownloadingQueue;

@end

@implementation FBImageLoader

- (instancetype)init {
    self = [super init];
    if (self) {
        _imageDownloadingQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)loadImageAtAddress:(NSURL *)baseImageURL desiredSize:(FBPictureItemImageSize)desiredSize forImageView:(UIImageView *)imageView handler:(FBImageHandler)handler {
    
    self.baseImageURL = baseImageURL;
    self.imageView = imageView;
    self.desiredSize = desiredSize;
    
    self.imageLoadingOperation = [[FBImageLoadingOperation alloc] initWithImageURL:self.baseImageURL desiredSize:self.desiredSize forImageView:self.imageView handler:^{
        self.isDownloading = NO;
        handler();
    }];
    self.isDownloading = YES;
    [self.imageDownloadingQueue addOperation:self.imageLoadingOperation];
}

- (void)loadImageAtAddress:(NSURL *)baseImageURL desiredSize:(FBPictureItemImageSize)desiredSize handler:(FBImageHandlerWithImage)handler {
    NSURL *fullUrl = [self getFullUrlForUrl:baseImageURL desiredSize:desiredSize];
    // TESTING
    NSURLSessionDataTask *dataTask = [[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]] dataTaskWithURL:fullUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                if (data) {
                    UIImage *image = [UIImage imageWithData:data];
                    if (image) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            handler(image);
                        });
                    } else {
                        NSLog(@"Couldn't parse image from data");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            handler(nil);
                        });
                    }
                } else {
                    NSLog(@"Recieved no data");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        handler(nil);
                    });
                }
            } else {
                NSLog(@"Server error: %lu", httpResponse.statusCode);
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(nil);
                });
            }
        } else {
            NSLog(@"Couldn't load image data: %@", error.localizedDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(nil);
            });
        }
    }];
    [dataTask resume];
}

- (NSURL *)getFullUrlForUrl:(NSURL *)url desiredSize:(FBPictureItemImageSize)desiredSize {
    NSString *baseString = url.absoluteString;
    NSString *extension = [baseString pathExtension];
    NSString *urlStringWithoutExt = [baseString stringByDeletingPathExtension];
    NSString *fullString;
    switch (desiredSize) {
        case FBPictureItemImageSizeLarge:
            fullString = [urlStringWithoutExt stringByAppendingString:@""];
            break;
        case FBPictureItemImageSizeMedium:
            fullString = [urlStringWithoutExt stringByAppendingString:@""];
            break;
        case FBPictureItemImageSizeSmall:
            fullString = [urlStringWithoutExt stringByAppendingString:@"_q"];
            break;
        case FBPictureItemImageSizeAvatar:
            fullString = [urlStringWithoutExt stringByAppendingString:@""];
            break;
    }
    fullString = [fullString stringByAppendingPathExtension:extension];
    NSURL *fullUrl = [NSURL URLWithString:fullString];
    return fullUrl;
}
@end
