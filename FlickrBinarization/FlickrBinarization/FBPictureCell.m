//
//  FBPictureCell.m
//  FlickrBinarization
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "FBPictureCell.h"
#import <Masonry/Masonry.h>

NSString * const pictureCellIdentifier = @"pictureCellIdentifier";

@implementation FBPictureCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureCell];
    }
    return self;
}

- (void)configureCell {
    // Get Screen width
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    // Setup Activity Indicator
    self.actitivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.actitivityIndicator.color = [UIColor grayColor];
    [self addSubview:self.actitivityIndicator];
    [self.actitivityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    // Setup ImageView
    self.myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width - 4, width - 4)];
    [self addSubview:self.myImageView];
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(width - 4);
        make.height.mas_equalTo(width - 4);
    }];
    
    // Setup Binarization Button
    self.binarizationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.binarizationButton.frame = CGRectMake(0, 0, 30.0, 30.0);
    self.binarizationButton.titleLabel.tag = ButtonStateColorful;
    self.binarizationButton.backgroundColor = [UIColor grayColor];
    self.binarizationButton.layer.cornerRadius = 15.0;
    self.binarizationButton.clipsToBounds = YES;
    [self addSubview:self.binarizationButton];
    [self.binarizationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        make.width.mas_equalTo(30.0);
        make.height.mas_equalTo(30.0);
    }];
    [self.binarizationButton addTarget:self action:@selector(binarizationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)binarizationButtonClicked:(UIButton *)sender {
    [_delegate binarizationButtonClicked:sender forImageUrlString:self.urlString];
}

@end
