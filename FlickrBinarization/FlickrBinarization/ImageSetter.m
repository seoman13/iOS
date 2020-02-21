//
//  ImageSetter.m
//  FlickrBinarization
//
//  Created by Admin on 21.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "ImageSetter.h"
#import "FBSearchViewController.h"
#import "FBPictureCell.h"
#import "FBImageLoader.h"
#import "FBImageFilter.h"

@implementation ImageSetter

+ (void)setColorfulImage:(NSString *)imageUrlString inSearchViewController:(FBSearchViewController *)searchViewController forCell:(FBPictureCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if ([searchViewController.colorfulPicturesCache objectForKey:imageUrlString]) {
        cell.myImageView.image = [searchViewController.colorfulPicturesCache objectForKey:imageUrlString];
        cell.hidden = NO;
    } else {
        [cell.actitivityIndicator startAnimating];
        [FBImageLoader loadImageAtURL:imageUrlString IntoSearchViewController:searchViewController atIndexPath:indexPath];
    }
}

+ (void)setBinarizedImage:(NSString *)imageUrlString inSearchViewController:(FBSearchViewController *)searchViewController forCell:(FBPictureCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if ([searchViewController.binarizedPicturesCache objectForKey:imageUrlString]) {
        cell.myImageView.image = [searchViewController.binarizedPicturesCache objectForKey:imageUrlString];
    } else {
        [cell.actitivityIndicator startAnimating];
        UIImage *img = searchViewController.colorfulPicturesCache[cell.urlString];
        [FBImageFilter binarizeImage:img inSearchViewController:searchViewController atIndexPath:indexPath];
//        cell.myImageView.image = nil;
    }
}

@end
