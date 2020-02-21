//
//  ISTrackCell.h
//  ITunesSearcher
//
//  Created by Admin on 11.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ISTrackCell;

extern NSString *const trackCellIdentifier;

@protocol ISTrackCellDelegate <NSObject>

- (void)pauseTapped:(ISTrackCell *)cell;
- (void)resumeTapped:(ISTrackCell *)cell;
- (void)cancelTapped:(ISTrackCell *)cell;
- (void)downloadTapped:(ISTrackCell *)cell;

@end

@interface ISTrackCell : UITableViewCell

@property (nonatomic, weak) id<ISTrackCellDelegate> delegate;
@property (nonatomic, strong) UIImageView *myImageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *artistLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UIButton *pauseButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *downloadButton;
@property (nonatomic, strong) UIButton *playButton;

@end
