//
//  FBPictureCell.h
//  FlickrBrowser
//
//  Created by Admin on 26.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FBImageSetter;

extern NSString * const pictureCellIdentifier;

typedef NS_ENUM(NSInteger, FBPictureCellSize) {
    FBPictureCellSizeSmall,
    FBPictureCellSizeMedium
};

@interface FBPictureCell : UICollectionViewCell

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UIImageView *imageView;
@property (nonatomic) FBPictureCellSize size;

@end
