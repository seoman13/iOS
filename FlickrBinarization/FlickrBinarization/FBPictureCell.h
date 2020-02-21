//
//  FBPictureCell.h
//  FlickrBinarization
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FBImageItem;
@class FBPictureCellDelegate;

extern NSString *const pictureCellIdentifier;

typedef NS_ENUM(NSInteger, ButtonState) {
    ButtonStateColorful,
    ButtonStateBinarized
};

@protocol FBPictureCellDelegate <NSObject>

@required
- (void)binarizationButtonClicked:(UIButton *)sender forImageUrlString:(NSString *)urlString;

@end

@interface FBPictureCell : UITableViewCell

@property (nonatomic, strong) FBImageItem *imageItem;
@property (strong, nonatomic) NSString *urlString;

// views the cell has
@property (nonatomic, strong) UIActivityIndicatorView *actitivityIndicator;
@property (nonatomic, strong) UIImageView *myImageView;
@property (nonatomic, strong) UIButton *binarizationButton;

// FBPictureCellDelegate
@property (nonatomic, strong) id<FBPictureCellDelegate> delegate;

@end
