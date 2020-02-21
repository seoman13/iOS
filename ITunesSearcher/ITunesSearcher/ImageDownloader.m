//
//  ImageDownloader.m
//  ITunesSearcher
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "ImageDownloader.h"
#import "ISSearchViewController.h"
#import "ISTrackCell.h"
#import "ImageCropper.h"
#import <AVKit/AVKit.h>
#import <Masonry/Masonry.h>

@implementation ImageDownloader

+ (void)downloadImageAtURL:(NSURL *)imageURL intoSearchViewController:(ISSearchViewController *)searchViewController atIndexPath:(NSIndexPath *)indexPath {
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode != 200) {
                NSLog(@"Server error");
            }
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    // Crop Image in case it has different width and height
                    image = [ImageCropper cropImage:image];
                    dispatch_async(dispatch_get_main_queue(), ^{
//                        searchViewController.cachedArtwork[imageURL.absoluteString] = image;
                        [searchViewController.cachedArtwork setObject:image forKey:imageURL.absoluteString];
                        ISTrackCell *trackCell = (id)[searchViewController.tableView cellForRowAtIndexPath:indexPath];
                        if (trackCell) {
//                            [UIView animateWithDuration:.3 animations:^{
//                                trackCell.myImageView.alpha = 0.0;
//                            }];
                            trackCell.myImageView.image = image;
                            if ([trackCell.activityIndicator isAnimating]) {
                                [trackCell.activityIndicator stopAnimating];
                            }
                            [UIView animateWithDuration:.5 animations:^{
                                trackCell.myImageView.alpha = 1.0;
                            }];
                        }
                    });
                } else {
                    NSLog(@"Couldn't parse NSData into image file");
                }
            } else {
                NSLog(@"No Data received");
            }
        } else {
            NSLog(@"Error Downloading image: %@", error);
        }
    }];
    [task resume];
}

+ (void)downloadImageAtURL:(NSURL *)imageURL intoAVPlayerViewController:(AVPlayerViewController *)playerViewController {
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode != 200) {
                NSLog(@"Server error");
            }
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    // Crop Image in case it has different width and height
                    image = [ImageCropper cropImage:image];
                    dispatch_async(dispatch_get_main_queue(), ^{
                         // Show Artwork
                         UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
                         playerViewController.contentOverlayView.backgroundColor = [UIColor blackColor];
                         [playerViewController.contentOverlayView addSubview:imageView];
                         [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.centerX.equalTo(playerViewController.contentOverlayView.mas_centerX);
                            make.centerY.equalTo(playerViewController.contentOverlayView.mas_centerY);
                        }];
                    });
                } else {
                    NSLog(@"Couldn't parse NSData into image file");
                }
            } else {
                NSLog(@"No Data received");
            }
        } else {
            NSLog(@"Error Downloading image: %@", error);
        }
    }];
    [task resume];
}

@end
