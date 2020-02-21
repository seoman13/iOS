//
//  ImageLoadingOperation.m
//  FlickrBinarization
//
//  Created by Admin on 21.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "ImageLoadingOperation.h"
#import "FBSearchViewController.h"
#import <UIKit/UIKit.h>
#import "FBPictureCell.h"
#import "FBImageCropper.h"

@interface ImageLoadingOperation ()

@property (copy, nonatomic) NSString *urlString;
@property (weak, nonatomic) FBSearchViewController *searchViewController;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end

@implementation ImageLoadingOperation

- (instancetype)initWithURLString:(NSString *)urlString searchViewController:(FBSearchViewController *)searchViewController indexPath:(NSIndexPath *)indexPath {
    self = [super init];
    if (self) {
        _urlString = urlString;
        _searchViewController = searchViewController;
        _indexPath = indexPath;
    }
    return self;
}

- (void)main {
    NSURLSessionDataTask *dataTask = [[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]] dataTaskWithURL:[NSURL URLWithString:self.urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                if (data) {
                    UIImage *image = [UIImage imageWithData:data];
                    if (image) {
                        image = [FBImageCropper cropImage:image];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.searchViewController.colorfulPicturesCache setValue:image forKey:self.urlString];
                            FBPictureCell *cell = [self.searchViewController.tableView cellForRowAtIndexPath:self.indexPath];
                            cell.myImageView.image = image;
                            cell.binarizationButton.hidden = NO;
                            [cell.actitivityIndicator stopAnimating];
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
